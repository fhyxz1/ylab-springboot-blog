package com.example.blog.Service;

import com.example.blog.Dto.ArticleResponse;
import com.example.blog.Entity.Post;
import com.example.blog.Mapper.PostMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
@Slf4j
public class PostsService {

    @Autowired
    private PostMapper postsMapper;

    // 根据文章 ID 获取 HTML 内容

    public ArticleResponse getArticleHtmlById(Integer postId) {
        Post post = postsMapper.getPostById(postId);
        if (post != null) {
            return new ArticleResponse(post.getImgUrl());
            // 直接返回已渲染的 HTML 内容
        } else {

            return new ArticleResponse("文章未找到");
        }
    }
}
