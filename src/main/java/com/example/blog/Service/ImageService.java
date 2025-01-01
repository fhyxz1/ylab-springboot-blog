package com.example.blog.Service;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.UUID;

@Service
public class ImageService {
    private static final String STATIC_PATH = "src/main/resources/static/image/";

    public String uploadImage(MultipartFile file) throws IOException {
        if (file.isEmpty()) {
            throw new IllegalArgumentException("上传的文件为空");
        }

        String fileName = UUID.randomUUID().toString() + getFileExtension(file.getOriginalFilename());
        Path uploadPath = Paths.get(STATIC_PATH, fileName);

        // 创建目录
        Files.createDirectories(uploadPath.getParent());

        // 保存文件
        Files.copy(file.getInputStream(), uploadPath);

        // 验证文件是否成功保存
        if (!Files.exists(uploadPath)) {
            throw new IOException("文件保存失败");
        }else{
            // 验证文件大小
            if (Files.size(uploadPath) != file.getSize()) {
                Files.delete(uploadPath);  // 删除不完整的文件
                throw new IOException("文件保存不完整");
            }
            else if (Files.size(uploadPath) == file.getSize()){
            try {
                Thread.sleep(5000);  // 等待100毫秒
            } catch (InterruptedException e) {
                Thread.currentThread().interrupt();
            }
            }
        }


        // 等待文件系统同步（可选）


        return "/image/" + fileName;
    }

    private String getFileExtension(String fileName) {
        return fileName.substring(fileName.lastIndexOf("."));
    }

    public void deleteImage(String filePath) {
        try {
            Path path = Paths.get(STATIC_PATH, filePath);
            if (Files.exists(path)) {
                Files.delete(path);
            }
        } catch (IOException e) {
            throw new RuntimeException("删除文件失败: " + e.getMessage());
        }
    }
}