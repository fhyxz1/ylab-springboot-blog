package com.example.blog.Service;

import com.example.blog.Entity.Announcement;
import com.example.blog.Mapper.AnnouncementMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class AnnouncementService {

    @Autowired
    private AnnouncementMapper announcementMapper;

    // 发布公告
    public Announcement createAnnouncement(String title, String content) {
        Announcement announcement = new Announcement();
        announcement.setTitle(title);
        announcement.setContent(content);
        announcement.setCreatedAt(LocalDateTime.now());
        announcement.setUpdatedAt(LocalDateTime.now());
        announcement.setIsActive(1);

        announcementMapper.insertAnnouncement(announcement);
        return announcement;
    }

    // 更新公告
    public boolean updateAnnouncement(Announcement announcement) {
        if (announcement == null || announcement.getId() == null) {
            throw new IllegalArgumentException("信息不能为空");
        }
 return announcementMapper.updateAnnouncement(announcement)>0;
    }

    // 禁用公告
    public void disableAnnouncement(Integer id) {
        announcementMapper.deleteAnnouncement(id);
    }

    // 获取所有启用中的公告
    public List<Announcement> getActiveAnnouncements() {
        return announcementMapper.selectAllAnnouncement();
    }
    //获取用户可见列表
    public List<Announcement> getUserAnnouncements(){return announcementMapper.selectAllUActiveAnnouncement();}
    // 获取所有禁用的公告
    public List<Announcement> getInactiveAnnouncements() {
        return announcementMapper.selectInactiveAnnouncements();
    }

    public Announcement getActiveAnnouncementById(Integer id) {
        return announcementMapper.selectInactiveAnnouncementById(id);
    }
    public Announcement getAnnouncementById(Integer id){
        return announcementMapper.selectAnnouncementById(id);
    }
}
