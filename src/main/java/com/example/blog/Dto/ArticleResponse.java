package com.example.blog.Dto;

import lombok.Data;

@Data
public class ArticleResponse {
    private Integer id;
    private String url;
    private String title;
    private String content;

    // 构造方法
    public ArticleResponse(String title, String content,String url) {
        this.title = title;
        this.content = content;
        this.url=url;
    }
    public ArticleResponse(String title, String content) {
        this.title = title;
        this.content = content;
    }
    public ArticleResponse(String url) {
        this.url=url;
    }
    // Getter 和 Setter
    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }
}
