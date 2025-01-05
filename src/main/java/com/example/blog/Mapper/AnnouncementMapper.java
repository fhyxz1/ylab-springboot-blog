package com.example.blog.Mapper;

import com.example.blog.Entity.Announcement;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Optional;

@Mapper
public interface AnnouncementMapper {

    // 插入公告
    int insertAnnouncement(Announcement announcement);

    // 更新公告
    int updateAnnouncement(Announcement announcement);

    // 删除公告
    int deleteAnnouncement(Integer id);

    // 查询所有公告
    List<Announcement> selectAllAnnouncement();
    List<Announcement> selectAllUActiveAnnouncement();

    // 查询所有禁用的公告
    List<Announcement> selectInactiveAnnouncements();

    // 根据ID查询启用中的公告
    Optional<Announcement> selectActiveAnnouncementById(Integer id);

    // 根据ID查询禁用中的公告
    Announcement selectInactiveAnnouncementById(Integer id);
    Optional<Announcement> selectAnnouncementByTitle(String title);
    Announcement selectAnnouncementById(Integer id);
}
