package ru.javarush.javarushproject3plus;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

@WebServlet(name = "hit", value = "/hit")
public class HitServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        User user = (User) req.getSession().getAttribute("user");
        if (user.getRooms() != null) {
            for (Room r : user.getRooms()) {
                if (r.getNpcs() != null) {
                    for (Npc npc : r.getNpcs()) {
                        if (npc.getName().equals(user.getOpponent().getName())) {
                            int npcHealth = npc.getHealth();
                            int npcHealthAfterHit = npcHealth - new Random().nextInt(user.getStrength() / 2);
                            if (npcHealthAfterHit <= 0) {
//                                user.setOpponent(null);
                                List<Npc> npcList = new ArrayList<>(r.getNpcs());
                                npcList.remove(npc);
                                r.setNpcs(npcList);
                                resp.sendRedirect("room");
                            } else {
                                npc.setHealth(npcHealthAfterHit);
                                user.setOpponent(npc);
                                resp.sendRedirect("fight");
                            }
                            break;
                        }
                    }
                }
            }
        }
    }
}