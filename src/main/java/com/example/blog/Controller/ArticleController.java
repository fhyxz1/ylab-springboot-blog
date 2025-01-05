package com.example.blog.Controller;

import com.example.blog.Dto.ArticleResponse;
import com.example.blog.Dto.wz;
import com.example.blog.Dto.categories;
import com.example.blog.Dto.postlist;
import com.example.blog.Entity.Post;
import com.example.blog.Service.PostsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.CrossOrigin;

import java.util.List;

@RestController
@CrossOrigin(origins = "*")  // 允许所有域访问，若需要限制，可以指定域名，如 "http://localhost:8080"
public class ArticleController {

    @Autowired
    private PostsService postsService;
    //获取分类
    @GetMapping("/api/categories")
               public List<categories> getCategories(){
        System.out.println(postsService.getCategories());
            return postsService.getCategories();
    }
    //前台获取文章
    @GetMapping("/api/articles")
            public List<postlist> getPostlist(){
        System.out.println(postsService.getpostlist());
                return postsService.getpostlist();
            }

            @GetMapping("/api/article")
    public List<wz> getarticles(){
        System.out.println(postsService.getwz());
        return postsService.getwz();
    }
    // 获取指定 ID 的文章内容，直接返回 HTML 格式
    @GetMapping("/api/articles/{id}")
    public ArticleResponse getArticleById(@PathVariable Integer id) {
        return postsService.getArticleHtmlById(id);
    }
}
