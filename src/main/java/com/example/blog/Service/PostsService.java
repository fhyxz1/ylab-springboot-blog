package com.example.blog.Service;

import com.example.blog.Dto.ArticleResponse;
import com.example.blog.Dto.categories;
import com.example.blog.Dto.postlist;
import com.example.blog.Dto.wz;
import com.example.blog.Entity.Post;
import com.example.blog.Mapper.PostMapper;
import javafx.geometry.Pos;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
@Slf4j
public class PostsService {

    @Autowired
    private PostMapper postsMapper;

    // 根据文章 ID 获取 HTML 内容
    public ArticleResponse getArticleHtmlById(Integer postId) {
        Post post = postsMapper.getPostById(postId);
        if (post != null) {
            return new ArticleResponse(post.getTitle(),post.getContent());
            // 直接返回已渲染的 HTML 内容
        } else {
            return new ArticleResponse("文章未找到");
        }
    }

    public List<postlist> getpostlist() {
        return postsMapper.getAllPosts();
    }
    public List<wz> getwz() {
        return postsMapper.getwz();
    }
    // 获取分类及其标签
    public List<categories> getCategories() {
        // 获取所有分类和标签信息
        System.out.println(postsMapper.getCategories());
        return postsMapper.getCategories();

    }
}


