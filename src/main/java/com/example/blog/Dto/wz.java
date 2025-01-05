package com.example.blog.Dto;

import lombok.Data;

import java.time.LocalDateTime;
@Data
public class wz {
    private Integer postId;
    private String title;
    private LocalDateTime fbDate;
    private String author;
}
