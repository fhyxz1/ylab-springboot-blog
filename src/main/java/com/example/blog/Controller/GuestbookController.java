package com.example.blog.Controller;

import com.example.blog.Dto.barrge;
import com.example.blog.Entity.Guestbook;
import com.example.blog.Entity.User;
import com.example.blog.Mapper.GuestbookMapper;
import com.example.blog.Service.GuestbookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.persistence.criteria.CriteriaBuilder;
import java.util.List;

@RestController
@CrossOrigin(origins = "*")
@RequestMapping("/api/guestbook")
public class GuestbookController {
    @Autowired
    private GuestbookService guestbookService;
    @GetMapping("/getlist")
    public List<Guestbook> getAllguestbook(){
        return guestbookService.getAllguestbook();
    }
    @GetMapping("/usergetlist")
    public List<Guestbook> UsergetAllguestbook(){
        System.out.println(guestbookService.getAllguestbook());
        return guestbookService.getAllguestbook();
    }

    @DeleteMapping ("/{id}")
    public int Deleteguestbook(@PathVariable Integer id){
        return guestbookService.deleteguestbook(id);
    }
    @PostMapping("/{id}/reject")
    public int rejectguestbook(@PathVariable Integer id){
        return guestbookService.setreject(id);
    }
    @PostMapping("/{id}/approve")
    public int  approveguestbook(@PathVariable Integer id){
        return guestbookService.setapprove(id);
    }
    @PostMapping("/add")
        public Guestbook addguestbook(@RequestBody Guestbook guestbook) {
        System.out.println(guestbookService.addguestbook(guestbook));
               return guestbookService.addguestbook(guestbook);
        }
}
