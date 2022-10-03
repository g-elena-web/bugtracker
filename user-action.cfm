<cfset #type# = '#Form.type#'>

<cfif #type# EQ 'new'>

    <cfquery name="newUser" datasource="golovlevadb">

        INSERT INTO users 
            VALUES (DEFAULT,
                <cfqueryparam cfsqltype="cf_sql_varchar" value='#Form.first_name#' />,
                <cfqueryparam cfsqltype="cf_sql_varchar" value='#Form.last_name#' />, 
                <cfqueryparam cfsqltype="cf_sql_varchar" value='#Form.password#' /> );

    </cfquery>

<cfelseif #type# EQ 'edit'>

    <cfquery name="editAuthUser" datasource="golovlevadb">

        UPDATE users
        SET first_name = <cfqueryparam cfsqltype="cf_sql_varchar" value='#Form.first_name#' />,
            last_name = <cfqueryparam cfsqltype="cf_sql_varchar" value='#Form.last_name#' />,
            password = <cfqueryparam cfsqltype="cf_sql_varchar" value='#Form.password#' />
        WHERE id = #GetAuthUser()#

    </cfquery>

</cfif>

<cflocation  url="user-list.cfm">