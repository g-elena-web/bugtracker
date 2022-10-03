<html>

    <cfinclude template="head.cfm">

    <style>
        html {
            background-color: #07cbd0;
        }
    </style>

    <body>

        <main class="login-page">
            <div class="form">
            <cfform class="login-form" onSuccess="index.cfm?sort=id" method="post">

                <h1>Вход</h1>

                <label for="userID">ID:</label>
                <input name="j_username" type="text">
         
                <label for="password">Пароль:</label>
                <input name="j_password" type="password">

                <button type="submit" class="button">Войти</button>

            </cfform>
            </div>

        </main>

    </body>

</html>