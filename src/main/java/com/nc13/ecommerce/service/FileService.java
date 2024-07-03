package com.nc13.ecommerce.service;

import com.nc13.ecommerce.dto.FileDTO;
import com.nc13.ecommerce.repository.FileRepository;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class FileService {

    private static final Logger log = LoggerFactory.getLogger(FileService.class);

    private final FileRepository fileRepository;

    @Value("${file.upload-dir}")
    private String uploadDir;

    public int uploads(Long productId, List<MultipartFile> uploadFiles) {
        List<FileDTO> files = new ArrayList<>();

        String absolutePath = new File(uploadDir).getAbsolutePath();

        for (MultipartFile uploadFile : uploadFiles) {
            if (!Objects.requireNonNull(uploadFile.getContentType()).startsWith("image")) {
                log.warn("This file is not image type");
            }

            String originFileName = uploadFile.getOriginalFilename();
            String fileName = originFileName.substring(0, originFileName.lastIndexOf("."));
            String ext = originFileName.substring(originFileName.lastIndexOf(".") + 1);
            long fileSize = uploadFile.getSize();

            String uuid = UUID.randomUUID().toString();
            String saveName = uuid + "." + ext;
            File file = new File(absolutePath, saveName);

            try {
                if (!file.exists()) {
                    file.getParentFile().mkdirs();
                    file.createNewFile();
                }

                uploadFile.transferTo(file);

                files.add(FileDTO.builder()
                        .fileName(uuid)
                        .fileOriginName(fileName)
                        .fileExt(ext)
                        .fileSize(fileSize)
                        .productId(productId)
                        .build());
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

        int result = 0;
        for (FileDTO file : files) {
            result = fileRepository.insert(file);
            if (result != 1) {
                log.info("insert file doesn't");
                return result;
            }
        }

        return result;
    }

    public List<FileDTO> findByProductId(int productId) {
        return fileRepository.findByProductId(productId);
    }
}
