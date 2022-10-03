<cfcomponent>
<cfset This.name="bugtrackingapp" />
<cfset This.dsn="golovlevadb">
<cfset This.Sessionmanagement="True"> 
<cfset This.loginstorage="session">

<cffunction name="OnRequestStart"> 
<cfargument name = "request" required="true"/> 
<cfif IsDefined("Form.logout")> 
    <cflogout> 
</cfif> 
<cflogin> 
    <cfif NOT IsDefined("cflogin")> 
        <cfinclude template="login.cfm"> 
    <cfabort> 
    <cfelse> 
        <cfif cflogin.name IS "" OR cflogin.password IS ""> 
        <cfoutput> 
            <p class="alert">Не введен логин или пароль. 
            </p> 
        </cfoutput> 
        <cfinclude template="login.cfm"> 
        <cfabort> 
    <cfelse> 
        <cfquery name="loginQuery" dataSource="golovlevadb"> 
            SELECT id 
            FROM users 
            WHERE 
            id = <cfqueryparam cfsqltype="cf_sql_integer" value='#cflogin.name#' /> 
            AND password = <cfqueryparam cfsqltype="cf_sql_varchar" value='#cflogin.password#' /> 
        </cfquery> 
        <cfif loginQuery.id GT 0> 
            <cfloginuser name="#cflogin.name#" Password = "#cflogin.password#" roles="user">
        <cfelse> 
            <cfoutput> 
            <p class="alert">Неверные данные.<br> 
            Пожалуйста, попробуйте снова.</p> 
            </cfoutput> 
        <cfinclude template="login.cfm"> 
        <cfabort> 
        </cfif> 
    </cfif> 
</cfif> 
</cflogin> 
  
</cffunction> 

</cfcomponent>