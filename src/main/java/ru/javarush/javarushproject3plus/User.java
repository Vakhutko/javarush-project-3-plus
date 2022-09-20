package ru.javarush.javarushproject3plus;

import lombok.Data;

import java.io.Serializable;
import java.util.List;

@Data
public class User implements Serializable {
    private String username;
    private Npc opponent;
    private RoomType currentRoom;
    private List<Room> rooms;
    private List<Quest> quests;
    private List<String> items;
    private int health;
    private int strength;
    private int adroitness;
    private boolean win;
}