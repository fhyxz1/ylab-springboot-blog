package com.example.blog.Controller;

import com.example.blog.Dto.ArticleResponse;
import com.example.blog.Service.PostsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.CrossOrigin;

@RestController
@CrossOrigin(origins = "*")  // 允许所有域访问，若需要限制，可以指定域名，如 "http://localhost:8080"
public class ArticleController {

    @Autowired
    private PostsService postsService;

    // 获取指定 ID 的文章内容，直接返回 HTML 格式
    @GetMapping("/api/articles/{id}")
    public ArticleResponse getArticleById(@PathVariable Integer id) {
        return postsService.getArticleHtmlById(id);
    }
}
