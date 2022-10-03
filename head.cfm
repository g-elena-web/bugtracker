<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta
        name="description"
        content="Bugtracking system"
    />
    <script src="https://kit.fontawesome.com/d2494e328b.js" crossorigin="anonymous"></script>
    <title>Bugtracking system</title>

    <cfset teal = "##07cbd0">
    <cfset grey = "##E8E8E8">
    <cfset darkgrey = "##646464">
    
    <style>

    @import url('https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&display=swap');
    
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }

    html {
        background-color: <cfoutput>#grey#</cfoutput>;
    }

    body {
        margin: 0;
        padding: 0;
        font-size: 14px;
        width: 100%;
        font-family: 'Montserrat', sans-serif;
    }

    header {
        position: fixed;
        width: 100%;
        height: 50px;
        padding: 10px;
        display: flex;
        align-items: center;
        justify-content: center;
        background-color: <cfoutput>#teal#</cfoutput>;
    }

    .login-page {
        width: 100%;
        height: 100%;
        display: flex;
        align-items: center;
        justify-content: center;
    }

    .alert {
        position: absolute;
        top: 20%;
        left: 40%;
        color: white;
        text-align: center;
        font-size: 1.2em;
        font-weight: bold;
    }

    .login-form {
        background-color: white;
        padding: 10px 40px;
        border-radius: 20px;
        display: flex;
        align-items: center;
        justify-content: center;
        flex-direction: column;
    }

    .login-form input {
        min-width: 400px;
        width: 400px;
        display: inline-block;
    }

    .login-form label {
        font-size: 1.2em;
    }

    .login-form  button {
        font-size: 1.4em;
        margin-top: 40px;
    }

    a {
        color: black;
        text-decoration: none;
    }

    .user {
        position: fixed;
        right: 15px;
        top: 12px;
        font-weight: bold;
        background-color: white;
        padding: 3px 10px;
        border-radius: 5px;
    }

    .user a {
        text-decoration: none;
    }

    .menu li {
        list-style-type: none;
        display: inline-block;
        padding: 0 20px;
    }
    
    .menu a {
        text-decoration: none;
    }

    .menu i {
        font-size: 20px;
        color: white;
        transition: .5s;
    }

    .menu i:hover {
        transform: scale(1.4);
    }

    .menu button {
        background: none;
        border: none;
        font-size: inherit;
    }

    .menu button:hover {
        cursor: pointer;
    }

    main {
        padding: 70px 30px 30px;
        display: flex;
        justify-content: center;
        align-items: center;
        flex-direction: column;
    }

    input, 
    textarea {
        min-width: 600px;
    }

    input, 
    textarea, 
    select {
        font-size: inherit;
        font-family: inherit;
        padding: 7px;
        border: 1px solid black;
    }

    textarea {
        resize: vertical;
    }

    select {
        border-radius: 20px;
    }

    select::-ms-expand {
        background: transparent;
        outline: none;
        border: none;
        margin-left: 5px;
    }

    select:focus,
    input:focus,
    textarea:focus {
        border: 1px solid <cfoutput>#teal#</cfoutput>;
        outline: 1px solid <cfoutput>#teal#</cfoutput>;
    }

    form label {
        display: block;
        margin: 20px 0 10px;
        width: 100%;
        text-align: left;
        font-weight: bold;
    }

    .form p {
        margin: 5px 0;
    }

    .issue-info {
        background-color: <cfoutput>#teal#</cfoutput>;
        color: white;
        width: auto;
        display: inline-block;
        padding: 5px 10px;
        margin-top: 10px;
        font-weight: bold;
        border-radius: 10px;
    }

    .select-field {
        display: inline-block;
        margin-right: 20px;
    }

    .comment {
        margin-top: 20px;
    }

    .button {
        display: block;
        margin-top: 20px;
        font-size: inherit;
        font-family: inherit;
        background-color: <cfoutput>#teal#</cfoutput>;
        color: white;
        border: none;
        padding: 12px 17px;
        border-radius: 20px;
        font-weight: bold;
        cursor: pointer;
    }

    .button:hover,
    .button:active {
        box-shadow: 0px 0px 13px 8px #D8F9F9;
    }

    .table, .form {
        background-color: white;
        padding-top: 10px;
        border-radius: 15px;
        margin: 20px;
        overflow: hidden;
    }

    .form {
        padding: 30px;
    }

    table {
        font-size: inherit;
        border-collapse: collapse;
        max-width: 100%;
    }

    .user-list {
        min-width: 500px;
        max-width: 100%;
    }

    table caption {
        font-weight: bold;
        font-size: 1.6em;
        margin: 5px 0 15px;
    }

    table a {
        text-decoration: none;
    }

    tr:hover {
        background-color: #D8F9F9;
    }

    .issue-list tr:hover {
        cursor: pointer;
    }

    td, th {
        padding: 15px;
        border-bottom: 1px solid <cfoutput>#grey#</cfoutput>;
        text-align: left;
    }

    th {
        background-color: <cfoutput>#teal#</cfoutput>;
        color: white;
    }

    th a {
        color: white;
    }

    th i {
        margin-right: 5px;
    }

    th:hover {
        background-color: <cfoutput>#darkgrey#</cfoutput>;
    }

    .summary {
        font-weight: bold;
    }

    .badge {
        color: white;
        padding: 4px 10px;
        border-radius: 10px;
        font-weight: bold;
    }

    [data-status="Новая"] {
        background-color: #72BEE4;
    }

    [data-status="Открытая"] {
        background-color: #FE854F;
    }

    [data-status="Решенная"] {
        background-color: #B4D66A;
    }

    [data-status="Закрытая"] {
        background-color: #A2A2A2;
    }

    @media (max-width: 1300px) {
        .issue-list th, td {
            padding: 15px 7px;
        }
    }

    </style>
    
</head>
