package com.example.blog.Entity;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class Post {
    private Integer postId;
    private String title;
    private String abstractText;
    private String content;
    private LocalDateTime fbDate;
    private String ImgUrl;
    private String author;
    private Integer category_id;
    private Integer tags_id;

}
