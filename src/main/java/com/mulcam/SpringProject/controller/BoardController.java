package com.mulcam.SpringProject.controller;

import java.io.File;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.mulcam.SpringProject.entity.Board;
import com.mulcam.SpringProject.entity.Reply;
import com.mulcam.SpringProject.service.BoardService;
import com.mulcam.SpringProject.session.UserSession;

@Controller
@RequestMapping("/board")
public class BoardController {
	@Autowired
	private UserSession userSession;
	
	@Autowired
	private BoardService service;
	
	// 게시판 리스트
	@RequestMapping("/list")
	public String list(HttpServletRequest req,Model model, HttpSession session) {
		int currentBoardPage = (req.getParameter("p")==null || req.getParameter("p")=="") ? 1 : Integer.parseInt(req.getParameter("p"));
		String field = (req.getParameter("f")==null || req.getParameter("f")=="") ? "b.title" : req.getParameter("f");
		String query = "%" +  ((req.getParameter("q")==null || req.getParameter("q")=="") ? "" : req.getParameter("q")) + "%";
		String state = "%" + ((req.getParameter("state")==null || req.getParameter("state")=="") ? "" : req.getParameter("state")) + "%";
		String category ="%" +  ((req.getParameter("category")==null || req.getParameter("category")=="") ? "" : req.getParameter("category")) + "%";
		int offset = (currentBoardPage-1)*10;
		List<Board> list = service.getList(field, query, state, category, offset);
		
		// pagenation
		int totalBoardNum = service.getBoardCount(field, query);
		int totalPages = (int)Math.ceil(totalBoardNum/10.);
		int startPage = (int)Math.ceil((currentBoardPage-0.5)/10. -1 )*10 +1;
		int endPage = Math.min(totalPages, startPage+9);
		List<String> pageList = new ArrayList<>();
		for (int i=startPage; i<=endPage; i++)
			pageList.add(String.valueOf(i));
		model.addAttribute("pageList", pageList);
		model.addAttribute("startPage", startPage);
		model.addAttribute("endPage", endPage);
		model.addAttribute("totalPages", totalPages);
		
		String today = LocalDate.now().toString();
		model.addAttribute("today", today);
		
		model.addAttribute("boardList", list);
		session.setAttribute("currentBoardPage", currentBoardPage);
		return "board/list";
	}
	
	@RequestMapping("/likeList")
	public String likeList(HttpServletRequest req,Model model, HttpSession session) {
		int currentBoardPage = (req.getParameter("p")==null || req.getParameter("p")=="") ? 1 : Integer.parseInt(req.getParameter("p"));
		int offset = (currentBoardPage-1)*10;
		List<Board> list = service.getLikeList(userSession.getUid() ,offset);
		// pagenation
		int totalBoardNum = service.getLikeCount(userSession.getUid());
		int totalPages = (int)Math.ceil(totalBoardNum/10.);
		int startPage = (int)Math.ceil((currentBoardPage-0.5)/10. -1 )*10 +1;
		int endPage = Math.min(totalPages, startPage+9);
		List<String> pageList = new ArrayList<>();
		for (int i=startPage; i<=endPage; i++)
			pageList.add(String.valueOf(i));
		model.addAttribute("pageList", pageList);
		model.addAttribute("startPage", startPage);
		model.addAttribute("endPage", endPage);
		model.addAttribute("totalPages", totalPages);
		
		String today = LocalDate.now().toString();
		model.addAttribute("today", today);
		System.out.println("현재날짜" + today);
		
		model.addAttribute("boardList", list);
		session.setAttribute("currentBoardPage", currentBoardPage);
		return "board/likeList";
	}
	
	// 게시글 작성
	@GetMapping("/write")
	public String writeForm(Model model) {
		model.addAttribute("uid", userSession.getUid());
		return "board/write";
	}
	@PostMapping("/write")
	public String write(HttpServletRequest req, Model model) {
		String uid = req.getParameter("uid").strip();
		String title = req.getParameter("title");
		String content = req.getParameter("content");
		String category = req.getParameter("category");
		int price = Integer.parseInt(req.getParameter("price"));
		String state = req.getParameter("state");
		String files = req.getParameter("files");
		
		Board b = new Board(uid, title, content, category, price, state, files);
		service.write(b);
		
		return "redirect:/board/list";
	}
	
	// 게시글보기
	@GetMapping("/detail")
	public String detail(HttpServletRequest req, Model model, HttpSession session) {
		int bid = Integer.parseInt((String)req.getParameter("bid"));
		String uid = req.getParameter("uid");
		int count = 1;
		if (req.getParameter("option")==null && (!uid.equals(userSession.getUid()))) 
			service.increaseViewCount(bid, count);
		
		Board board = service.getBoardDetail(bid);
		// 해당유저가 찜을 눌렀는지 안눌렀는지 판단
		int likeExist = service.getLikeExist(bid,userSession.getUid());
		
		//리플
		List<Reply> replyList = service.replyList(bid);
		
		model.addAttribute("replyList", replyList);
		model.addAttribute("likeExist",likeExist);
		model.addAttribute("board", board);
		model.addAttribute("uid",userSession.getUid());
		return "board/detail";
	}
	
	// 찜버튼 눌르기	
	@GetMapping("/likeCount")
	public String likeCount(HttpServletRequest req,Model model, RedirectAttributes redirect) {
		// love파라메터가 1이면 likecount도 +1 ,  -1면 likeCount도 -1
		int bid = Integer.parseInt((String)req.getParameter("bid"));
		int love = Integer.parseInt(req.getParameter("love"));
		String pre = req.getParameter("pre");
		service.likeCountChange(bid, love);
		
		// love파라메터가 1이면 likeProduct에 추가 ,  -1이면 likeproduct에서 제거
		if (love ==1)
			service.addLikeBoard(userSession.getUid(), bid);
		else
			service.removeLikeBoard(userSession.getUid(), bid);
		
		
		if (pre.equals("detail")) {		// 디테일에서 눌렀을떄
			redirect.addAttribute("bid", bid);
			redirect.addAttribute("uid", req.getParameter("uid"));
			return "redirect:/board/detail";
		} else {						// 찜목록에서 불렀을때
			return "redirect:/board/likeList";
		}
	}
	
	// 댓글 등록
	@PostMapping("/reply")
	public String reply(HttpServletRequest req, Model model, HttpSession session) {
		String content = req.getParameter("content");
		int bid = Integer.parseInt(req.getParameter("bid"));
		String uid = req.getParameter("uid"); // 게시글의 uid
		int count=1;
		
		// 게시글의 uid와 댓글을 쓰려고 하는 사람의 uid가 같으면 isMine이 1
		String sessionUid = (String) session.getAttribute("sessionUid");
		int isMine = (uid.equals(sessionUid)) ? 1 : 0;
		
		Reply reply = new Reply(content, isMine, sessionUid, bid);
		service.insertReply(reply);
		service.increaseReplyCount(bid, count);
		return "redirect:/board/detail?bid=" + bid + "&uid=" + uid + "&option=DNI";	// Do Not Increase
	}
	
	// 댓글수정
	@PostMapping("/replyUpdate")
	public String replyUpdate(HttpServletRequest req, Model model, HttpSession session) {
		String content = req.getParameter("content");
		int bid = Integer.parseInt(req.getParameter("bid"));
		String uid = req.getParameter("uid"); // 게시글의 uid
		int rid = Integer.parseInt(req.getParameter("rid"));
		
		// 게시글의 uid와 댓글을 쓰려고 하는 사람의 uid가 같으면 isMine이 1
		
		Reply reply = new Reply(rid, content);
		service.updateReply(reply);
		return "redirect:/board/detail?bid=" + bid + "&uid=" + uid + "&option=DNI";	// Do Not Increase
	}
	
	//댓글 삭제
	@GetMapping("/reply/delete")
	public String replyDelete(HttpServletRequest req, Model model) {
		String uid = req.getParameter("uid");
		int rid = Integer.parseInt(req.getParameter("rid"));
		int bid = Integer.parseInt(req.getParameter("bid"));
		
		int count = -1;
		service.deleteReply(rid);
		service.increaseReplyCount(bid, count);
		return "redirect:/board/detail?bid=" + bid + "&uid=" + uid + "&option=DNI";
	}
	
	// test
	@GetMapping("/test")
	public String test(Model model) {
		model.addAttribute("bid", 30);
		return "board/test";
	}
	// 게시물 삭제
	@GetMapping("/delete")
	public String deleteBoard(HttpServletRequest req ) {
		int bid = Integer.parseInt(req.getParameter("bid"));
		service.deleteBoard(bid);
		return "redirect:/board/list";
	}
	
	
	

	
}
