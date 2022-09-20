package ru.javarush.javarushproject3plus;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.net.URL;
import java.nio.file.Files;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Random;

@WebServlet(name = "room", value = "/room")
public class RoomServlet extends HttpServlet {

    private Room createRoom(List<Npc> npcs, List<String> items, RoomType... roomType) {
        Room newRoom = new Room(roomType[0]);
        List<RoomType> rooms = new ArrayList<>(Arrays.asList(roomType).subList(1, roomType.length));
        newRoom.setNextRooms(rooms);
        if (npcs != null) {
            newRoom.setNpcs(npcs);
        }
        if (items != null) {
            newRoom.setItems(items);
        }
        if (newRoom.getName() == RoomType.GARDEN) {
            newRoom.setOpen(true);
        }
        newRoom.setImg("/javarush_project_3_plus_war_exploded/img/room/" + roomType[0].name() + ".jpeg");
        return newRoom;
    }

    private void initialize(User user) throws IOException {
        user.setCurrentRoom(RoomType.START);
        List<Room> rooms = user.getRooms();
        Random random = new Random();
        rooms.add(createRoom(null, null, RoomType.START, RoomType.GARDEN));
        rooms.add(createRoom(List.of(
                new Npc(getRandomAbstract(rooms, "npc"), getRandomNpcImg(), random.nextInt(100), random.nextInt(100), random.nextInt(100)),
                        new Npc(getRandomAbstract(rooms, "npc"), getRandomNpcImg(), random.nextInt(100), random.nextInt(100), random.nextInt(100))),
                List.of(getRandomAbstract(rooms, "item"), getRandomAbstract(rooms, "item"), "Key Bathroom"),
                RoomType.GARDEN, RoomType.START, RoomType.BATHROOM, RoomType.HOTEL));
        rooms.add(createRoom(List.of(new Npc(getRandomAbstract(rooms, "npc"), getRandomNpcImg(), random.nextInt(100), random.nextInt(100), random.nextInt(100)),
                        new Npc(getRandomAbstract(rooms, "npc"), getRandomNpcImg(), random.nextInt(100), random.nextInt(100), random.nextInt(100))),
                List.of(getRandomAbstract(rooms, "item"), getRandomAbstract(rooms, "item"), "Key Dungeon"), RoomType.HOTEL, RoomType.GARDEN, RoomType.DUNGEON));
        rooms.add(createRoom(List.of(new Npc(getRandomAbstract(rooms, "npc"), getRandomNpcImg(), random.nextInt(100), random.nextInt(100), random.nextInt(100)),
                        new Npc(getRandomAbstract(rooms, "npc"), getRandomNpcImg(), random.nextInt(100), random.nextInt(100), random.nextInt(100))),
                List.of(getRandomAbstract(rooms, "item"), getRandomAbstract(rooms, "item"), "Key Hotel"), RoomType.BATHROOM, RoomType.GARDEN, RoomType.DUNGEON));
        rooms.add(createRoom(List.of(new Npc(getRandomAbstract(rooms, "npc"), getRandomNpcImg(), random.nextInt(100), random.nextInt(100), random.nextInt(100)),
                        new Npc(getRandomAbstract(rooms, "npc"), getRandomNpcImg(), random.nextInt(100), random.nextInt(100), random.nextInt(100))),
                List.of(getRandomAbstract(rooms, "item"), getRandomAbstract(rooms, "item"), "Key Mines"), RoomType.DUNGEON, RoomType.HOTEL, RoomType.BATHROOM, RoomType.MINES, RoomType.HOSPITAL));
        rooms.add(createRoom(List.of(new Npc(getRandomAbstract(rooms, "npc"), getRandomNpcImg(), random.nextInt(100), random.nextInt(100), random.nextInt(100)),
                        new Npc(getRandomAbstract(rooms, "npc"), getRandomNpcImg(), random.nextInt(100), random.nextInt(100), random.nextInt(100))),
                List.of(getRandomAbstract(rooms, "item"), getRandomAbstract(rooms, "item"), "Key Hospital"), RoomType.MINES, RoomType.DUNGEON, RoomType.TORTURE));
        rooms.add(createRoom(List.of(new Npc(getRandomAbstract(rooms, "npc"), getRandomNpcImg(), random.nextInt(100), random.nextInt(100), random.nextInt(100)),
                        new Npc(getRandomAbstract(rooms, "npc"), getRandomNpcImg(), random.nextInt(100), random.nextInt(100), random.nextInt(100))),
                List.of(getRandomAbstract(rooms, "item"), getRandomAbstract(rooms, "item"), "Key University"), RoomType.TORTURE, RoomType.MINES));
        rooms.add(createRoom(List.of(new Npc(getRandomAbstract(rooms, "npc"), getRandomNpcImg(), random.nextInt(100), random.nextInt(100), random.nextInt(100)),
                        new Npc(getRandomAbstract(rooms, "npc"), getRandomNpcImg(), random.nextInt(100), random.nextInt(100), random.nextInt(100))),
                List.of(getRandomAbstract(rooms, "item"), getRandomAbstract(rooms, "item"), "Key Torture"), RoomType.HOSPITAL, RoomType.DUNGEON, RoomType.UNIVERSITY));
        rooms.add(createRoom(List.of(new Npc(getRandomAbstract(rooms, "npc"), getRandomNpcImg(), random.nextInt(100), random.nextInt(100), random.nextInt(100)),
                        new Npc(getRandomAbstract(rooms, "npc"), getRandomNpcImg(), random.nextInt(100), random.nextInt(100), random.nextInt(100))),
                List.of(getRandomAbstract(rooms, "item"), getRandomAbstract(rooms, "item"), "Key Church"), RoomType.UNIVERSITY, RoomType.HOSPITAL, RoomType.CHURCH));
        rooms.add(createRoom(List.of(new Npc(getRandomAbstract(rooms, "npc"), getRandomNpcImg(), random.nextInt(100), random.nextInt(100), random.nextInt(100)),
                        new Npc(getRandomAbstract(rooms, "npc"), getRandomNpcImg(), random.nextInt(100), random.nextInt(100), random.nextInt(100))),
                List.of(getRandomAbstract(rooms, "item"), getRandomAbstract(rooms, "item")), RoomType.CHURCH, RoomType.UNIVERSITY));
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = (User) req.getSession().getAttribute("user");
        req.setAttribute("user", user);
        String room = req.getParameter("room");
        if (user.getCurrentRoom() == null) {
            initialize(user);
        } else if (room != null) {
            user.setCurrentRoom(RoomType.valueOf(room));
            removeKey(user, room);
        }
        user.getRooms().stream().filter(r -> r.getName() == user.getCurrentRoom()).findFirst().get().setVisited(true);
        checkWin(user);
        req.getRequestDispatcher("/WEB-INF/jsp/room.jsp").forward(req, resp);
    }

    void removeKey(User user, String room) {
        String result = "";
        List<String> list = null;
        boolean needRemove = false;
        for (String s : user.getItems()) {
            if (s.startsWith("Key")) {
                if (s.split(" ")[1].toUpperCase().equals(room)) {
                    result = s;
                    list = new ArrayList<>(user.getItems());
                    needRemove = true;
                }
            }
        }
        if (needRemove) {
            list.remove(result);
            user.setItems(list);
        }
    }

    void checkWin(User user) {
        if (user.getRooms().stream().allMatch(Room::isVisited)) {
            user.setWin(true);
        }
    }

    public String getRandomNpcImg() {
        Random random = new Random();
        int n = random.nextInt(10) + 1;
        return "/javarush_project_3_plus_war_exploded/img/npc/npc" + n + ".jpeg";
    }

    public String getRandomAbstract(List<Room> rooms, String type) throws IOException {
        URL url = this.getClass()
                .getClassLoader()
                .getResource(type + "_names.txt");

        if (url == null) {
            throw new IllegalArgumentException(type + "_names.txt" + " is not found 1");
        }

        File file = new File(url.getFile());
        List<String> list = Files.readAllLines(file.toPath());

        String result;
        boolean flag;

        do {
            flag = false;
            result = list.get(new Random().nextInt(list.size()));
            for (Room r : rooms) {
                if (type.equals("npc")) {
                    if (r.getNpcs() != null) {
                        for (Npc s : r.getNpcs()) {
                            if (s != null && s.getName().equals(result)) {
                                flag = true;
                                break;
                            }
                        }
                    }
                } else if (type.equals("item")) {
                    if (r.getItems() != null) {
                        for (String s : r.getItems()) {
                            if (s != null && s.contains(result)) {
                                flag = true;
                                break;
                            }
                        }
                    }
                }
            }
        } while (flag);
        if (type.equals("item")) {
            return result + " " + (new Random().nextInt(15) + 1);
        }
        return result;
    }
}
