<cflayout type="vbox">
<html>

    <cfset type = #url.type# />

    <cfif #type# EQ 'edit'>

        <cfquery name="qAuthUser" dataSource="golovlevadb">
            SELECT first_name, last_name, password
            FROM users
            WHERE id = #GetAuthUser()#
        </cfquery>

    </cfif>

    <cfinclude template="head.cfm">

    <body>

        <cfinclude template="menu.cfm">

        <main>
            <div class="form">

            <cfif #type# EQ 'new'>
                <h1>Добавление нового пользователя</h1>
            <cfelseif #type# EQ 'edit'>
                <h1>Редактирование пользователя #<cfoutput>#GetAuthUser()#</cfoutput></h1>
            </cfif>

            <cfform action="user-action.cfm" method="post" onSuccess="window.location='user-list.cfm?sort=id'">

                <label for="first_name">Имя:</label>
                <input name="first_name" type="text" maxlength="30" pattern="^\S+"
                    <cfif #type# EQ 'edit'><cfoutput>value="#qAuthUser.first_name#"</cfoutput></cfif> required autofocus>

                <label for="last_name">Фамилия:</label>
                <input name="last_name" type="text" maxlength="30" pattern="^\S+"
                    <cfif #type# EQ 'edit'><cfoutput>value="#qAuthUser.last_name#"</cfoutput></cfif> required>

                <label for="password">Пароль:</label>
                <input name="password" type="text" minlength="4" maxlength="30"
                    <cfif #type# EQ 'edit'><cfoutput>value="#qAuthUser.password#"</cfoutput></cfif> required>
                
                <input name="type" type="hidden" <cfoutput>value="#type#"</cfoutput> >

                <br><button type="submit" class="button">Сохранить</button>

            </cfform>
            </div>

        </main>

    </body>

</html>
</cflayout>