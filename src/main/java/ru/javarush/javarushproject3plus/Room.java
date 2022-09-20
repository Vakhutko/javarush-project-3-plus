package ru.javarush.javarushproject3plus;

import lombok.Data;

import java.util.List;

@Data
public class Room {
    private RoomType name;
    private List<RoomType> nextRooms;
    private List<Npc> npcs;
    private List<String> items;
    private String img;
    private boolean visited;
    private boolean open;

    Room(RoomType name) {
        this.name = name;
    }
}
