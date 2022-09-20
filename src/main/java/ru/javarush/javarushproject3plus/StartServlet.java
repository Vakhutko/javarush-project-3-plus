package ru.javarush.javarushproject3plus;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "startServlet", value = "/start-servlet")
public class StartServlet extends HttpServlet {
    private User user;
    private List<Room> rooms;
    private List<Quest> quests;
    private List<String> items;

    @Override
    public void init(ServletConfig servletConfig) throws ServletException {
        super.init(servletConfig);
        String path = servletConfig.getServletContext().getRealPath("/item_names.txt");
        System.out.println(path);
        user = new User();
        rooms = new ArrayList<>();
        quests = new ArrayList<>();
        items = new ArrayList<>();
        user.setRooms(rooms);
        user.setQuests(quests);
        user.setItems(items);
        user.setHealth(100);
        user.setStrength(100);
        user.setAdroitness(100);
    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse resp) throws IOException {
        HttpSession session = request.getSession();
        user.setUsername(request.getParameter("username"));
        session.setAttribute("user", user);
        resp.sendRedirect("room");
    }
}