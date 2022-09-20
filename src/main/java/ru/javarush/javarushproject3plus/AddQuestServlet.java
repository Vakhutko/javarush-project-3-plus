package ru.javarush.javarushproject3plus;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.net.URL;
import java.nio.file.Files;
import java.util.List;
import java.util.Random;

@WebServlet(name = "add_quest", value = "/add_quest")
public class AddQuestServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        User user = (User) req.getSession().getAttribute("user");
        boolean isQuestContain = false;
        for (Quest q : user.getQuests()) {
            if (q.getText().contains("to " + req.getParameter("npc"))) {
                isQuestContain = true;
            }
        }
        if (!isQuestContain) {
            user.getQuests().add(new Quest("Bring " + getRandomItemName(user.getQuests()) + " to " + req.getParameter("npc")));
        }
        req.setAttribute("user", user);
        resp.sendRedirect("room");
    }

    public String getRandomItemName(List<Quest> quests) throws IOException {

        URL url = this.getClass()
                .getClassLoader()
                .getResource("item_names.txt");

        if (url == null) {
            throw new IllegalArgumentException("item_names.txt" + " is not found 1");
        }

        File file = new File(url.getFile());
        List<String> list = Files.readAllLines(file.toPath());

        boolean flag;

        do {
            flag = false;
            String result = list.get(new Random().nextInt(list.size()));
            for (Quest q : quests) {
                if (q.getText().contains(result)) {
                    flag = true;
                    break;
                }
            }
        } while (flag);

        return list.get(new Random().nextInt(list.size()));
    }
}
