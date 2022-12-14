<cflayout type="vbox">
<html>

    <cfset type = #url.type# />
    <cfparam name="url.sort" default="date">

    <cfif #type# EQ 'edit'>

        <cfset id = #url.id# />

        <cfquery name="qIssue" datasource="golovlevadb">
            SELECT 
                issues.id, 
                to_char(issues.created_on, 'DD.MM.YYYY HH24:MI') as date,
                issues.summary, 
                issues.description, 
                issues.status, 
                issues.urgency, 
                issues.severity,
                CONCAT(users.first_name, ' ', users.last_name) AS name 
            FROM issues 
            INNER JOIN users
            ON issues.user_id = users.id
            WHERE issues.id = <cfqueryparam cfsqltype="cf_sql_integer" value='#id#' />
        </cfquery>
        <cfset record=QueryGetRow(qIssue,1)>

        <cfquery name="qHistory" datasource="golovlevadb">
            SELECT 
                to_char(history.date, 'DD.MM.YYYY') as date, 
                to_char(history.date, 'HH24:MI') AS time,
                history.date AS fulldate,
                history.action AS action, 
                history.comment AS comment, 
                CONCAT(users.first_name, ' ', users.last_name) AS name 
            FROM history 
            INNER JOIN users
            ON history.user_id = users.id
            WHERE issue_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#id#" />
            ORDER BY #url.sort#;
        </cfquery>

        <script>
            function showComment() {
                const oldStatus = <cfoutput>"#record.status#"</cfoutput>;
                const newStatus = document.forms["issueForm"]["status"].value;
                const commentField = document.getElementById("comment");
                if (newStatus != oldStatus) {
                    commentField.style.display = "block";
                    commentField.required="required";
                } else {
                    commentField.style.display = "none";
                    commentField.required="";
                }
            }
        </script>

    </cfif>

    <cfparam name="record.urgency" default="?????????? ????????????">
    <cfparam name="record.severity" default="????????????">

    <cfquery name="qStatus" datasource="golovlevadb">
        SELECT unnest(enum_range(NULL::issue_status))
    </cfquery>

    <cfquery name="qUrgency" datasource="golovlevadb">
        SELECT unnest(enum_range(NULL::issue_urgency))
    </cfquery>

    <cfquery name="qSeverity" datasource="golovlevadb">
        SELECT unnest(enum_range(NULL::issue_severity))
    </cfquery>

    <cfinclude template="head.cfm">

    <body>

        <cfinclude template="menu.cfm">

        <main>

            <div class="form">

            <cfif #type# EQ 'new'>
                <h1>?????????? ????????????</h1>
            <cfelseif #type# EQ 'edit'>
                <h1>???????????? #<cfoutput>#qIssue.id#</cfoutput></h1>
                <div class="issue-info">
                    <p>??????????: <cfoutput>#qIssue.name#</cfoutput><p>
                    <p>???????? ??????????: <cfoutput>#qIssue.date#</cfoutput><p>
                </div>
            </cfif>
            
            <cfform name="issueForm" action="issue-action.cfm" 
                method="post" target="_parent">

                <label for="summary">???????????????? ????????????????:</label>
                <input name="summary" type="text" minlength="5" maxlength="128" pattern=".*\S+.*\S+.*\S+.*\S+.*\S+.*" 
                    <cfif #type# EQ 'edit'><cfoutput>value="#record.summary#"</cfoutput></cfif> 
                    required <cfif #type# EQ 'new'>autofocus</cfif> >

                <label for="description">?????????????????? ????????????????:</label>
                <textarea name="description" maxlength="1024" rows="5"><cfif #type# EQ 'edit'><cfoutput>#record.description#</cfoutput></cfif></textarea><br>

                <cfif #type# EQ 'new'>
                    <input name="status" type="hidden" value="??????????">
                </cfif>

                <div class = "select-field">
                    <label for="urgency">??????????????????</label>
                    <cfselect name="urgency" query="qUrgency" display="unnest" selected="#record.urgency#" required="yes">
                    </cfselect>
                </div>

                <div class = "select-field">
                    <label for="severity">??????????????????????</label>
                    <cfselect name="severity" query="qSeverity" display="unnest" selected="#record.severity#" required="yes">
                    </cfselect>
                </div>
                
                <cfif #type# EQ 'edit'>

                    <input name="issueid" type="hidden" <cfoutput>value="#id#"</cfoutput> >

                    <div class = "select-field">
                    <label for="status">????????????</label>

                        <cfswitch expression = "#record.status#">
                        <cfcase value="??????????">
                            <select id="status" name="status" onChange="showComment()" required>
                                <option value="??????????" selected>??????????</option>
                                <option value="????????????????">????????????????</option>
                            </select>
                        </cfcase>
                        <cfcase value="????????????????">
                            <select id="status" name="status" onChange="showComment()" required>
                                <option value="????????????????" selected>????????????????</option>
                                <option value="????????????????">????????????????</option>
                            </select>
                        </cfcase>
                        <cfcase value="????????????????">
                            <select id="status" name="status" onChange="showComment()" required>
                                <option value="????????????????">????????????????</option>
                                <option value="????????????????" selected>????????????????</option>
                                <option value="????????????????">????????????????</option>
                            </select>
                        </cfcase>
                        <cfcase value="????????????????">
                            <select id="status" disabled>
                                <option value="????????????????" selected>????????????????</option>
                            </select>
                            <input name="status" type="hidden" value="????????????????">
                        </cfcase>
                        </cfswitch>

                    </div>
                    
                    <textarea class="comment" name="comment" id="comment" maxlength="1024" rows="2" style="display:none;" placeholder="???????????????? ?????????????????????? ?????? ?????????????????? ?????????????? ????????????"></textarea>

                </cfif>

                <input name="actiontype" type="hidden" <cfoutput>value="#type#"</cfoutput> >

                <button type="submit" class="button">??????????????????</button>
            </cfform>

            </div>

            <cfif #type# EQ 'edit'>

                <div class="table" id="history">
                <table>
                    <caption>?????????????? ????????????</caption>
                    <tr>
                        <th><a href="?type=edit&id=<cfoutput>#id#</cfoutput>&sort=fulldate#history"><i class="fa-solid fa-sort-down"></i>????????</a></th>
                        <th><a href="?type=edit&id=<cfoutput>#id#</cfoutput>&sort=time#history"><i class="fa-solid fa-sort-down"></i>??????????</a></th>
                        <th><a href="?type=edit&id=<cfoutput>#id#</cfoutput>&sort=action#history"><i class="fa-solid fa-sort-down"></i>????????????????</a></th>
                        <th style="width:400px"><a href="?type=edit&id=<cfoutput>#id#</cfoutput>&sort=comment#history"><i class="fa-solid fa-sort-down"></i>??????????????????????</a></th>
                        <th><a href="?type=edit&id=<cfoutput>#id#</cfoutput>&sort=name#history"><i class="fa-solid fa-sort-down"></i>????????????????????????</a></th>
                    </tr>
                    <cfoutput query="qHistory">
                        <tr>
                            <td>#date#</td>
                            <td>#time#</td>
                            <td>#action#</td>
                            <td>#comment#</td>
                            <td>#name#</td>
                        </tr>
                    </cfoutput>
                </table>
                </div>

            </cfif>

        </main>

    </body>

</html>

</cflayout>