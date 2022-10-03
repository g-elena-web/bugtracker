<!DOCTYPE HTML>
<html>

    <cfparam name="url.sort" default="id">

    <cfquery name="qUsers" datasource="golovlevadb">
        SELECT id, first_name, last_name FROM users ORDER BY #url.sort#;
    </cfquery>

    <cfinclude template="head.cfm">

    <body>
    
        <cfinclude template="menu.cfm">

        <main>
            <div class="table">
            <table class="user-list">
                <caption>Список пользователей</caption>
                <tr>
                    <th><a href="?sort=id"><i class="fa-solid fa-sort-down"></i> ID</a></th>
                    <th><a href="?sort=first_name"><i class="fa-solid fa-sort-down"></i> Имя</a></th>
                    <th><a href="?sort=last_name"><i class="fa-solid fa-sort-down"></i> Фамилия</a></th>
                </tr>
                <cfoutput query="qUsers">
                    <tr>
                        <td>#id#</td>
                        <td>#first_name#</td>
                        <td>#last_name#</td>
                    </tr>
                </cfoutput>
            </table>
            </div>

        </main>

    </body>

</html>