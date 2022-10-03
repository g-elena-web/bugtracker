<!DOCTYPE HTML>
<html>
    <cfparam name="url.sort" default="id">
    <cfparam name="url.order" default="ASC">

    <cfquery name="qIssues" datasource="golovlevadb">
        SELECT 
            issues.id AS id,
            to_char(issues.created_on, 'DD.MM.YYYY') AS date,
            to_char(issues.created_on, 'HH24:MI') AS time,
            issues.summary AS summary,
            issues.description AS description,
            CONCAT(users.first_name, ' ', users.last_name) AS name,
            issues.status AS status,
            issues.urgency AS urgency,
            issues.severity AS severity
        FROM issues 
        INNER JOIN users
        ON issues.user_id = users.id
        ORDER BY #url.sort# #url.order#;
    </cfquery>

    <cfinclude template="head.cfm">

    <body>

        <cfinclude template="menu.cfm">

        <main>
            <div class="table">
            <table class="issue-list">
                <caption>Список ошибок</caption>
                <tr>
                    <th><a href="?sort=id"><i class="fa-solid fa-sort-down"></i> ID</a></th>
                    <th style="width:250px"><a href="?sort=summary"><i class="fa-solid fa-sort-down"></i> Короткое описание</a></th>
                    <th><a href="?sort=status"><i class="fa-solid fa-sort-down"></i> Статус</a></th>
                    <th><a href="?sort=urgency"><i class="fa-solid fa-sort-down"></i> Срочность</a></th>
                    <th><a href="?sort=severity"><i class="fa-solid fa-sort-down"></i> Критичность</a></th>
                    <th><a href="?sort=user_id"><i class="fa-solid fa-sort-down"></i> Пользователь</a></th>
                    <th><a href="?sort=created_on"><i class="fa-solid fa-sort-down"></i> Дата ввода</a></th>
                    <th><a href="?sort=time"><i class="fa-solid fa-sort-down"></i> Время</a></th>
                </tr>
                <cfoutput query="qIssues">
                    <tr onClick="window.location='edit-issue.cfm?type=edit&id=#id#'">
                        <td>#id#</td>
                        <td class="summary">#summary#</td>
                        <td><span class="badge" data-status="#status#">#status#</span></td>
                        <td>#urgency#</td>
                        <td>#severity#</td>
                        <td>#name#</td>
                        <td>#date#</td>
                        <td>#time#</td>
                    </tr>
                </cfoutput>
            </table>
            </div>

            <a href="edit-issue.cfm?type=new" class="button">Добавить</a>

        </main>

    </body>

</html>
