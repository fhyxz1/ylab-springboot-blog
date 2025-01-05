package com.example.blog.Service;

import com.example.blog.Dto.barrge;
import com.example.blog.Entity.Guestbook;
import com.example.blog.Mapper.GuestbookMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class GuestbookService {
    @Autowired
    private GuestbookMapper guestbookMapper;
    public List<Guestbook> getAllguestbook(){
        return guestbookMapper.getAllguestbook();
    }
    public  int deleteguestbook(Integer id){
        return guestbookMapper.deleteguestbook(id);
    }
    public int setreject(Integer id){
        return guestbookMapper.rejectguestbook(id);
    }

    public int setapprove(Integer id) {
        return guestbookMapper.approveguestbook(id);
    }
    public Guestbook addguestbook(Guestbook guestbook){
        if (guestbookMapper.insertguestbook(guestbook)>0){
            Integer id=guestbook.getId();
            return guestbookMapper.getguestbookbyid(id);
        }
        return null;
    }
}
