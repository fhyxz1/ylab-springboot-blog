package com.example.blog.Dto;


public class AnnouncementRequest {

    private String title;
    private String content;
    private Integer isActive;
    private String code;

    // Getters and Setters
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

    public int isActive() {
        return isActive;
    }

    public void setActive(Integer isActive) {
        this.isActive = isActive;
    }
}

