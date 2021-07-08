<%@ page import="com.example.csgo_dataApp.model.CsgoAppDB" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Csgo Data Results</title>
    <link rel="stylesheet" type="text/css" media="screen" href="css/csgoStyle.css" />
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Audiowide&family=Roboto&display=swap" rel="stylesheet">
</head>
<body class="response">
<div class="titulo"> Resultados de su consulta </div>
<div class="consult">
    <% String nombrePlayer = (String) request.getAttribute("nombrePlayer");
    out.println(nombrePlayer);
    try{
        CsgoAppDB csgoAppDB = new CsgoAppDB();
        ResultSet rs = csgoAppDB.getLooserTeam(nombrePlayer);
        while (rs.next()){
            int wins = rs.getInt("wins");
            String team = rs.getString("team_2");
            String div = "<div class='ans' > Este jugador vencio al equipo %s en %d ocasiones </div>";
            div = String.format(div,team,wins);
            out.println(div);
        }
    } catch (SQLException e){
        System.out.println(e);
    }
    %>
</div>
</body>
</html>
