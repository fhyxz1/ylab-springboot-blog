package com.example.blog.Mapper;

import com.example.blog.Entity.Post;
import org.apache.ibatis.annotations.Mapper;
import java.util.List;

@Mapper
public interface PostMapper {

    // 根据 postId 获取文章
    Post getPostById(Integer postId);

    // 获取所有文章
    List<Post> getAllPosts();

    // 根据标题模糊查询文章
    List<Post> getPostsByTitle(String title);

    // 插入新文章
    int addPost(Post post);

    // 更新文章内容
    int updatePost(Post post);

    // 根据 postId 删除文章
    int deletePost(Integer postId);
}
