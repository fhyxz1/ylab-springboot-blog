package com.example.blog.Controller;

import com.example.blog.Dto.AnnouncementRequest;
import com.example.blog.Entity.Announcement;
import com.example.blog.Entity.User;
import com.example.blog.Service.AnnouncementService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@CrossOrigin(origins = "*")
@RequestMapping("/api/announcements")
public class AnnouncementController {

    @Autowired
    private AnnouncementService announcementService;

    // 获取公告列表
    @GetMapping("/list")
    public ResponseEntity<List<Announcement>> getActiveAnnouncements() {
        List<Announcement> announcements = announcementService.getActiveAnnouncements();
        return ResponseEntity.ok(announcements);
    }
    //获取公告列表，开发给用户的接口
    @GetMapping("/userlist")
    public ResponseEntity<List<Announcement>> getAUserAnnouncements() {
        List<Announcement> announcements = announcementService.getUserAnnouncements();
        return ResponseEntity.ok(announcements);
    }
    // 获取所有禁用的公告
    @GetMapping("/inactive")
    public ResponseEntity<List<Announcement>> getInactiveAnnouncements() {
        List<Announcement> announcements = announcementService.getInactiveAnnouncements();
        return ResponseEntity.ok(announcements);
    }

    // 获取单个公告详情
    @GetMapping("/{id}")
    public ResponseEntity<?> getAnnouncement(@PathVariable Integer id) {
     Announcement announcement = announcementService.getAnnouncementById(id);
        System.out.println(announcement);
        if (announcement!=null) {
            return ResponseEntity.ok(announcement);
        } else {
            return ResponseEntity.status(404).build();
        }
    }

    // 新建公告
    @PostMapping
    public ResponseEntity<Announcement> createAnnouncement(@RequestBody AnnouncementRequest request) {
        Announcement announcement = announcementService.createAnnouncement(request.getTitle(), request.getContent());
        return ResponseEntity.status(HttpStatus.CREATED).body(announcement);
    }

    // 编辑公告
    @PutMapping("/update/{id}")
    public ResponseEntity<?> updateAnnouncement(
            @PathVariable Integer id, @RequestBody Announcement announcement) {
        try{
             announcement.setId(id);
             boolean success=announcementService.updateAnnouncement(announcement);
             System.out.println(announcementService.updateAnnouncement(announcement));
             if (success){
                 return ResponseEntity.ok("更新成功！");
             }else {return ResponseEntity.status(HttpStatus.NOT_FOUND).body("公告不存在");}
    } catch (Exception e) {
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("更新公告失败：" + e.getMessage());
    }
    }

    // 删除公告
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteAnnouncement(@PathVariable Integer id) {
        announcementService.disableAnnouncement(id);
        return ResponseEntity.noContent().build();
    }
}
