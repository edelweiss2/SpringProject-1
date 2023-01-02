<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<!DOCTYPE html>
	<html lang="ko">

	<head>
		<%@ include file="../common/heading.jsp" %>
		<link href="https://unpkg.com/tailwindcss@1.2.0/dist/tailwind.min.css" rel="stylesheet">
	<script>
    	function search() {
    		const field = document.getElementById("field").value;
    		const query = document.getElementById("query").value;
    		const state = document.getElementById("state").value;
    		const category = document.getElementById("category").value;
    		location.href = "/board/list?p=${currentBoardPage}&f=" + field + "&q=" + query + "&state=" + state + "&category=" + category;
    	}
    </script>
	</head>

	<body>
		<%@ include file="../common/top.jsp" %>
		<%@ include file="../common/aside.jsp" %>

        <!-- =================== main =================== -->



        <!-- START -->

        <body style=" background: #edf2f7;">
          <div class="flex antialiased sans-serif bg-gray-200 items-center justify-center">

            <!-- BOX -->
            <div class="w-full p-4 container mx-auto py-6 px-4">
              <h1 class="text-3xl py-4 border-b mb-10">게시글 목록</h1>

              <div class="flex justify-right">
                <c:if test="${not empty sessionUid}">
                  <a href="/board/write">글쓰기</a>
                </c:if>
              </div>

              <section class="form-select bg-white dark:bg-gray-900" id="category">
                <div class="container px-6 py-8 mx-auto">
                  <div class="lg:flex lg:-mx-2">
                    <div class="space-y-3 lg:w-1/5 lg:px-2 lg:space-y-4">
                    
                      <div class="mt-6 lg:mt-0 lg:px-2 lg:w-4/5 ">
                        <div class="flex items-center justify-between text-sm tracking-widest uppercase">
                        	
                          <table>
                          <td class="col-2">
	                        <select class="form-select me-2" name="state" id="state">
	                            <option value="" selected>판매/구매</option>
	                            <option value="판매">판매</option>
	                            <option value="구매">구매</option>
	                        </select>
	                   	  </td>
		                  <td class="col-2">
		                        <select class="form-select me-2" name="category" id="category">
		                            <option value="" selected>전부</option>
		                            <option value="디지털/가전">디지털/가전</option>
		                            <option value="의류">의류</option>
		                            <option value="식품">식품</option>
		                        </select>
		                  </td>
		                  <td class="col-2">
		                        <select class="form-select me-2" name="f" id="field">
		                            <option value="b.title" selected>제목</option>
		                            <option value="b.content">본문</option>
		                            <option value="u.uname">글쓴이</option>
		                        </select>
		                  </td>
	                    <td class="col-3">
	                        <input class="form-control me-2" type="search" placeholder="검색 내용" name="q" id="query">
	                    </td>
	                    <td class="col-1">
	                        <button class="btn btn-outline-primary" onclick="search()">검색</button>
	                    </td>
                          </table>
                         
                        </div>
                        
                        <!-- 상품 리스트 -->
                        <div class="grid grid-cols-1 gap-8 mt-8 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4">
                        <c:forEach var="board" items="${boardList}">
                          <div class="flex flex-col items-center justify-center w-full max-w-lg mx-auto">
                            <img class="object-cover w-full rounded-md h-72 xl:h-80"
                              src="/file/thumbnail?jsonFiles=${board.bid}"                              
                              alt="${board.title}"
                              onclick="location.href='/board/detail?bid=${board.bid}&uid=${board.uid}'">
                            <h4 class="mt-2 text-lg font-medium text-gray-700 dark:text-gray-200" onclick="location.href='/board/detail?bid=${board.bid}&uid=${board.uid}'">${board.title}</h4>
                            <p class="text-gray-700 dark:text-gray-200">${board.category}, ${board.state}</p>
                           
                            <b class="text-gray-700 dark:text-gray-200">${board.price}원</b>
                            <p class="text-gray-700 dark:text-gray-200">${board.uname}</p>
	                        	<c:if test="${board.replyCount ge 0}">
	                        		<span class="text-danger">댓글수 : ${board.replyCount}</span>
	                        	</c:if>
                            <p class="text-gray-700 dark:text-gray-200">조회수 : ${board.viewCount}</p>
                          </div>
                     		</c:forEach>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </section>
              
              <div class="flex items-center justify-center">
			       	<c:if test="${currentBoardPage gt 10}">
			       		<a class="page-link" href="/board/list?p=${startPage-1}&f=${field}&q=${query}">&laquo;</a>
			     		</c:if>
			     		<c:if test="${currentBoardPage le 10}">
			     			<a class="page-link" href="#">&laquo;</a>
			   			</c:if>
			   			<c:forEach var="page" items="${pageList}" varStatus="loop">
			   				<span class="page-item ${(currentBoardPage eq page) ? 'active' : ''}">
			   					<a class="page-link" href="/board/list?p=${page}&f=${field}&q=${query}">&nbsp;${page}&nbsp;</a>
								</span>
							</c:forEach>
							<c:if test="${totalPages gt endPage}">
								<a class="page-link" href="/board/list?p=${endPage-1}&f=${field}&q=${query}">&raquo;</a>
							</c:if>
							<c:if test="${totalPages le endPage}">
								<a class="page-link" href="#">&raquo;</a>
							</c:if>
              </div>
            </div>
          </div>
        </body>
        
  	<%@ include file="../common/bottom.jsp" %>
  	
  </body>

  </html>