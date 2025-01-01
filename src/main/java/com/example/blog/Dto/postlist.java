package com.example.blog.Dto;

import lombok.Data;

@Data
public class postlist {
    private Integer postId;
    private String ImgUrl;
    private String title;
    private String summary ;

    private String author;
    private String category;
    private String tags;
}
