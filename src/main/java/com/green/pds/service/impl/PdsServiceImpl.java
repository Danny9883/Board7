package com.green.pds.service.impl;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.green.pds.dto.FilesDto;
import com.green.pds.dto.PdsDto;
import com.green.pds.mapper.PdsMapper;
import com.green.pds.service.PdsService;

@Service
public class PdsServiceImpl implements PdsService {
	
	// @Value 가 application.properties 에 있는
	// part1.upload-path=D:/dev/springboot/data/
	@Value("${part1.upload-path}")
	private String uploadPath;

	@Autowired
	private   PdsMapper  pdsMapper;

	@Override
	public List<PdsDto> getPdsList(HashMap<String, Object> map) {
		
		List<PdsDto> pdsList =  pdsMapper.getPdsList( map ); 
		return       pdsList;
	}

	@Override
	public void setWrite(HashMap<String, Object> map, MultipartFile[] uploadfiles) {
		// 파일 저장 + DB 저장
		// 1. 파일 저장 : uploadfiles [] -> uploadPath : d:/dev/springboot/data/
		
		// String   uploadPath   = "d:/dev/springboot/data/";
		map.put("uploadPath", uploadPath);
		
		System.out.println("PdsFile 이전 map : " + map );
		
		// 별도 클래스 생성해서 처리 : PdsFile
		PdsFile.save( map, uploadfiles );
		
		System.out.println("PdsFile 이후 map : " + map );
		// { menu_id=MENU01, nowpage=1, title=123, writer=123, content=213, 
		// uploadPath=D:/dev/springboot/data/, 
		// fileList=[
		//    FilesDto(file_num=0, idx=0, filename=favicon.png, fileext=.png, 
		//        sfilename=2026\05\18\2ff4c1ee-19c4-4731-8641-b2a9439ef2f0.favicon.png), 
		//    FilesDto(file_num=0, idx=0, filename=favicon.png, fileext=.png, 
		//        sfilename=2026\05\18\dfbe41cd-9e4c-463a-8402-85793ca3578f.favicon.png)
		//    ]
		// }
		
		// 2. DB 에 저장 : 자료실 글 쓰기  <- map
		//   Board 테이블에 저장
		pdsMapper.setWrite( map );     // insertBoard 
		
		// 3. Files 에 저장
		List<FilesDto> fileList = (List<FilesDto>) map.get("fileList");
		if( fileList.size() > 0 )
			pdsMapper.setFileWriter( map );
		
		
	}

	// map(idx) 에 해당하는 글 조회수 증가
	@Override
	public void setReadCountUpdate(HashMap<String, Object> map) {
		
		pdsMapper.setReadCountUpdate( map );
		
	}

	// 자료실 게시글(Pds) 을 조회한다 : map(idx)
	@Override
	public PdsDto getPds(HashMap<String, Object> map) {
		
		PdsDto  pdsDto  = pdsMapper.getPds( map );
		return  pdsDto;
	}

	@Override
	public List<FilesDto> getFileList(HashMap<String, Object> map) {
		List<FilesDto> fileList = pdsMapper.getFileList( map );
		return fileList;
	}

}







