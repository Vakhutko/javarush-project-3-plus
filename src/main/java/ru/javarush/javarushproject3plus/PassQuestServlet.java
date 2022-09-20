package ru.javarush.javarushproject3plus;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "pass_quest", value = "/pass_quest")
public class PassQuestServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        User user = (User) req.getSession().getAttribute("user");
        String remove = "";
        for (Quest q : user.getQuests()) {
            if (q.getText().contains("to " + req.getParameter("npc"))) {
                for (String item : user.getItems()) {
                    String[] itemParts = item.split(" ");
                    if (q.getText().contains(itemParts[0] + " " + itemParts[1])) {
                        q.setDone(true);
                        remove = item;
                        if (item.startsWith("Armor")) {
                            int adroitness = user.getAdroitness();
                            user.setAdroitness(adroitness - Integer.parseInt(item.split(" ")[2]));
                        } else if (item.startsWith("Weapon")) {
                            int strength = user.getStrength();
                            user.setStrength(strength + Integer.parseInt(item.split(" ")[2]));
                        }
                        break;
                    }
                }
            }
        }
        user.getItems().remove(remove);
        req.setAttribute("user", user);
        resp.sendRedirect("room");
    }
}
