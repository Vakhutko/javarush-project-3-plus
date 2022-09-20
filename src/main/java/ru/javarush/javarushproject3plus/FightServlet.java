package ru.javarush.javarushproject3plus;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "fight", value = "/fight")
public class FightServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = (User) req.getSession().getAttribute("user");
        String npcName = req.getParameter("npc");
        if (user.getRooms() != null) {
            for (Room r : user.getRooms()) {
                if (r.getNpcs() != null) {
                    for (Npc npc : r.getNpcs()) {
                        if (npc.getName().equals(npcName)) {
                            user.setOpponent(npc);
                            break;
                        }
                    }
                }
            }
        }
        req.setAttribute("user", user);
        req.getRequestDispatcher("/WEB-INF/jsp/fight.jsp").forward(req, resp);
    }
}
