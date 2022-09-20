package ru.javarush.javarushproject3plus;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class Npc {
    private String name;
    private String img;
    private int health;
    private int strength;
    private int adroitness;
}
