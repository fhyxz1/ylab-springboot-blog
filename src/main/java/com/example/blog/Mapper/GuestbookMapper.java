package com.example.blog.Mapper;

import com.example.blog.Entity.Guestbook;
import org.apache.ibatis.annotations.Mapper;
import java.util.List;
@Mapper
public interface GuestbookMapper {
    //拒绝留言
    int rejectguestbook(Integer id);
    //通过留言
    int approveguestbook(Integer id);
    //插入留言接口
    int insertguestbook(Guestbook guestbook);
    //根据id删除留言
    int deleteguestbook(Integer id);
    //查询所有留言
    List<Guestbook>getAllguestbook();
    //根据id获取留言
    Guestbook getguestbookbyid(Integer id);

    Guestbook getguestbookbyusername();
}
