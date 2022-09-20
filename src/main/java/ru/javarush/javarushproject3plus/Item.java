package ru.javarush.javarushproject3plus;

import lombok.Data;

@Data
public class Item {
    private int id;
    private String name;

    Item(String name) {
        this.name = name;
    }
}
