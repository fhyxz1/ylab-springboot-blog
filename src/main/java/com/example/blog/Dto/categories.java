package com.example.blog.Dto;

import lombok.Data;

import java.util.List;
@Data
public class categories {
    private String category_name;
    private List<String> tags;
}
