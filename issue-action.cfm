<cfset type = '#Form.actiontype#'>

<cfif #type# EQ 'new'>

    <cfquery name="newIssue" datasource="golovlevadb">

        WITH a AS (INSERT INTO issues 
            VALUES (
                DEFAULT, 
                DEFAULT,
                <cfqueryparam cfsqltype="cf_sql_varchar" value='#Form.summary#' />,
                <cfqueryparam cfsqltype="cf_sql_varchar" value='#Form.description#' />, 
                #GetAuthUser()#,
                '#Form.status#', 
                '#Form.urgency#', 
                '#Form.severity#'
                ) RETURNING id)
        INSERT INTO history (issue_id, action, user_id) 
            SELECT a.id, 'Ввод', #GetAuthUser()# FROM a;

    </cfquery>

<cfelseif #type# EQ 'edit'>

    <cfquery name="findIssue" datasource="golovlevadb">

        SELECT status
        FROM issues
        WHERE id = <cfqueryparam cfsqltype="cf_sql_integer" value='#Form.issueid#' /> ;

    </cfquery>

    <cfquery name="editIssue" datasource="golovlevadb">

        UPDATE issues SET 
            summary = <cfqueryparam cfsqltype="cf_sql_varchar" value='#Form.summary#' />, 
            description = <cfqueryparam cfsqltype="cf_sql_varchar" value='#Form.description#' />,
            status = '#Form.status#',
            urgency = '#Form.urgency#',
            severity = '#Form.severity#'
        WHERE id = <cfqueryparam cfsqltype="cf_sql_integer" value='#Form.issueid#' /> ;

        <cfif #findIssue.status# NEQ #Form.status#>
            
            <cfswitch expression="#Form.status#">
                <cfcase value="Открытая">
                    <cfset statusChange = "Открытие">
                </cfcase>
                <cfcase value="Решенная">
                    <cfset statusChange = "Решение">
                </cfcase>
                <cfcase value="Закрытая">
                    <cfset statusChange = "Закрытие">
                </cfcase>
            </cfswitch>

            INSERT INTO history (issue_id, action, comment, user_id) 
                VALUES (
                    <cfqueryparam cfsqltype="cf_sql_integer" value='#Form.issueid#' />,
                    '#statusChange#',
                    <cfqueryparam cfsqltype="cf_sql_varchar" value='#Form.comment#' />,
                    #GetAuthUser()#
                )

        </cfif>

    </cfquery>

</cfif>

<cflocation  url="index.cfm">


