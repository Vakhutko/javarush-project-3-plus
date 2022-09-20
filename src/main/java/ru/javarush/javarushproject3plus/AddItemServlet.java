package ru.javarush.javarushproject3plus;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "add_item", value = "/add_item")
public class AddItemServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        User user = (User) req.getSession().getAttribute("user");
        if (!user.getItems().contains(req.getParameter("item"))) {
            user.getItems().add(req.getParameter("item"));
            String s = req.getParameter("item");
            Room r = user.getRooms().stream().filter(o -> o.getName() == user.getCurrentRoom()).findFirst().get();
            List<String> l = new ArrayList<>(r.getItems());
            l.remove(s);
            for (int i = 0; i < user.getRooms().size(); i++) {
                if (s.startsWith("Key")) {
                    if (user.getRooms().get(i).getName() == RoomType.valueOf((s.split(" ")[1].toUpperCase()))) {
                        user.getRooms().get(i).setOpen(true);
                        s = "";
                    }
                } else if (s.startsWith("Weapon")) {
                    int strength = user.getStrength();
                    user.setStrength(strength + Integer.parseInt(s.split(" ")[2]));
                    s = "";
                } else if (s.startsWith("Armor")) {
                    int adroitness = user.getAdroitness();
                    user.setAdroitness(adroitness + Integer.parseInt(s.split(" ")[2]));
                    s = "";
                }
                if (user.getRooms().get(i).getName() == user.getCurrentRoom()) {
                    user.getRooms().get(i).setItems(l);
                }
            }
        }
        req.setAttribute("user", user);
        resp.sendRedirect("room");
    }
}