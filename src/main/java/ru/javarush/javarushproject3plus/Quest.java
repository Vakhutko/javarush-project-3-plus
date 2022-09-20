package ru.javarush.javarushproject3plus;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class Quest {
    private int id;
    private String text;
    private boolean isDone;

    public Quest(String text) {
        this.text = text;
    }
}
