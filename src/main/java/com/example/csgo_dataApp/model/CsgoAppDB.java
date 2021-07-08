package com.example.csgo_dataApp.model;

import java.sql.Connection;
import java.sql.*;

public class CsgoAppDB {
    private Connection conn;

    public CsgoAppDB() throws ClassNotFoundException,SQLException{
        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost/monkey_flip", "root", "");
            System.out.print("Database Connected\n");
        } catch (ClassNotFoundException | SQLException e){
            System.err.println("ClassNotFoundException: " + e.getMessage());
            System.out.print("Database Not Connected\n");
        }
    }

    public ResultSet getKDA(String player_name) throws SQLException{
        String sql = "SELECT team,AVG(kdaJugador) AS kdaEquipo,kdaJugador \n" +
                "FROM playeradvancedstats\n" +
                "where player_name=?\n" +
                "GROUP BY team,kdaJugador;\n";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1,player_name);
        return stmt.executeQuery();
    }

    public ResultSet getWE(String n_equipo) throws SQLException{
        String sql = "SELECT ev.name,COUNT(m.winner) AS won_matches\n" +
                "FROM events AS ev,matchs as m\n" +
                "WHERE ev.id=m.event_id\n" +
                "AND((m.winner='1' AND m.team_1=?) OR (m.winner='2' AND m.team_2=?))\n" +
                "GROUP BY ev.name;";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1,n_equipo);
        stmt.setString(2,n_equipo);
        return stmt.executeQuery();
    }

    public ResultSet getMeanKills(String player_name) throws SQLException{
        String sql = "SELECT player_name,FLOOR(AVG(mean_kills)) AS alltime_mean_kills\n" +
                "from playeradvancedstats\n" +
                "WHERE player_name=?\n" +
                "GROUP by player_name;";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1,player_name);
        return stmt.executeQuery();
    }

    public ResultSet getLooserTeam(String n_player) throws SQLException{
        String sql = "select player_name, team_2, count(team_2) as wins\n" +
                "from(\n" +
                "  select *\n" +
                "  from PlayerTeamMatches\n" +
                "  where player_name = ?\n" +
                ")p\n" +
                "group by p.player_name,p.team_2\n" +
                "order by wins desc limit 1;";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1,n_player);
        return stmt.executeQuery();
    }

}
