<cfif GetAuthUser() NEQ ""> 

<cfquery name="getUserInfo" dataSource="golovlevadb">
    SELECT first_name, last_name
    FROM users
    WHERE id = #GetAuthUser()#
</cfquery>

<header>

    <nav>
        <ul class="menu">
            <li><a href="edit-issue.cfm?type=new" title="Новая ошибка"><i class="fa-solid fa-plus"></i></a></li>
            <li><a href="index.cfm" title="Список ошибок"><i class="fa-solid fa-list-check"></i></a></li>
            <li><a href="edit-user.cfm?type=new" title="Новый пользователь"><i class="fa-solid fa-user-plus"></i></a></li>
            <li><a href="user-list.cfm?sort=id" title="Список пользователей"><i class="fa-solid fa-users"></i></a></li>
            <li><form action="index.cfm" method="Post"> 
                <button type="submit" Name="Logout" title="Выход"><i class="fa-solid fa-arrow-right-from-bracket"></i></input>
            </form></li>
        </ul>
    </nav>
    
    <cfoutput>
    <div class="user">
        <a href="edit-user.cfm?type=edit">#getUserInfo.first_name# #getUserInfo.last_name#</a>
    </div>
    </cfoutput> 

</header>

</cfif>
