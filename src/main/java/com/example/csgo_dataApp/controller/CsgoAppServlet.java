package com.example.csgo_dataApp.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

public class CsgoAppServlet extends HttpServlet {

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException{
        request.setCharacterEncoding("UTF-8");
        String n_jugador = request.getParameter("nombrePlayer");
        String consulta = request.getParameter("consulta");

        request.setAttribute("nombrePlayer", n_jugador);
        request.getRequestDispatcher(consulta).forward(request,response);
    }
}
