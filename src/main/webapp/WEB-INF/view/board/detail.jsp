<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

      <!DOCTYPE html>
      <html lang="ko">

      <head>
      <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
        <%@ include file="../common/heading.jsp" %>
          <link href="https://unpkg.com/tailwindcss@1.2.0/dist/tailwind.min.css" rel="stylesheet">
          <script>
	    	function deleteConfirm(bid, rid) {
				if(confirm("삭제하시겠습니까?")) {
				 	location.href = "/board/reply/delete?bid=" + bid + "&rid=" + rid;
					return true;
				} else {
					return false;
				}
			}
	    	function replyUpdate(oc, replyNum) {
	    		if (oc == "block"){
	    			document.getElementById('reply'+replyNum).className = 'card-body d-none';
	    			document.getElementById('replyUpdate'+replyNum).className = 'form-inline';
	    		} else {
	    			document.getElementById('reply'+replyNum).className = 'card-body';
	    			document.getElementById('replyUpdate'+replyNum).className = 'form-inline d-none';
	    		}
	    	}
    		</script>
      </head>

      <body>
        <%@ include file="../common/top.jsp" %>
          <%@ include file="../common/aside.jsp" %>

            <!-- =================== main =================== -->

            <script>
              function deleteConfirm(bid, rid) {
                if (confirm("삭제하시겠습니까?")) {
                  location.href = "/board/reply/delete?bid=" + bid + "&rid=" + rid;
                  return true;
                } else {
                  return false;
                }
              }
              
              function replyUpdate(oc, replyNum) {
          		if (oc == "block"){
          			document.getElementById('reply'+replyNum).className = 'card-body d-none';
          			document.getElementById('replyUpdate'+replyNum).className = 'form-inline';
          		} else {
          			document.getElementById('reply'+replyNum).className = 'card-body';
          			document.getElementById('replyUpdate'+replyNum).className = 'form-inline d-none';
          		}
          	}
            </script>

            <!-- START -->

            <body style=" background: #edf2f7;">
              <div class="flex antialiased sans-serif bg-gray-200 items-center justify-center">

                <!-- BOX -->
                <div class="w-full p-4 container mx-auto py-6 px-4">


                  <div class="min-h-screen md:px-20 pt-6">
                    <input type="hidden" name="uid" value="${uid}">
                    <div class=" bg-white rounded-md px-6 py-10 max-w-2xl mx-auto">
                      <!-- <h1 class="text-center text-2xl font-bold text-gray-500 mb-10">게시글 상세 조회</h1> -->

                      <a href="/board/list?p=${currentBoardPage}&f=&q=" class="ms-5"><i
                          class="fas fa-list-ul"></i>목록</a>
                      <!-- 본인만 수정,삭제 가능 -->
                      <c:if test="${board.uid eq uid}">
                        <a href="/board/update?bid=${board.bid}" class="ms-3"><i class="far fa-edit"></i> 수정</a>
                        <a href="/board/delete?bid=${board.bid}" class="ms-3"><i class="fas fa-trash-alt"></i> 삭제</a>
                      </c:if>

                      <!-- 본문 -->
                      <div class="mt-4 space-y-4">
                        <h1 class="text-center text-4xl font-bold text-gray-500 mb-10">${board.title}</h1>

                        <div>
                          <label for="title" class="text-lx"><b>글번호: </b>${board.bid}</label>
                        </div>

                        <div>
                          <c:forEach var="file" items="${fileList}">
                            <img class="object-cover w-full rounded-md h-72 xl:h-80"
                              src="/file/display?fileName=${file}">
                          </c:forEach>
                        </div>

                        <div>
                          <c:if test="${(likeExist eq 0) and (not empty sessionUid) and (sessionUid ne board.uid)}">
                            <a href="/board/likeCount?bid=${board.bid}&uid=${board.uid}&love=1&pre=detail">
                            <h1 class="text-center text-4xl font-bold text-gray-500 mb-10">찜 💖</h1>
                            </a>
                          </c:if>
                          <c:if test="${(likeExist eq 1) and (not empty sessionUid) and (sessionUid ne board.uid)}">
                            <a href="/board/likeCount?bid=${board.bid}&uid=${board.uid}&love=-1&pre=detail">
                            <h1 class="text-center text-4xl font-bold text-gray-500 mb-10">찜 💖</h1>
                            </a>
                          </c:if>
                        </div>

                        <div>
                          <label for="likeCount" class="text-lx"><b>찜: </b>${board.likeCount}</label><br>
                          <label for="price" class="text-lx"><b>가격: </b>${board.price}</label><br>
                          <label for="uname" class="text-lx"><b>작성자: </b>${board.uname}</label>
                        </div>

                        <!-- 댓글기능  -->
                        <div class="w-full text-left">
                          <c:if test="${(empty sessionUid) or(sessionUid eq board.uid)}">
                            <b>찜 </b>${board.likeCount}<br>
                          </c:if>
                          <h6><b>조회</b> ${board.viewCount}&nbsp;&nbsp;<b>댓글수</b> ${board.replyCount}</h6>
                        </div>

                        <!-- 게시글 내용 -->
                        <div class="w-full">
                          ${fn:replace(board.content, newline, '<br>')}
                        </div>
                        <hr>

                        <!-- 댓글 -->
                        <div class="w-full">
                          <h6 class="text-center text-2xl font-bold text-gray-500 mb-10">댓글</h6>
                          <c:forEach var="reply" items="${replyList}" varStatus="loop">
                            <div class="card-body" id="reply${loop.count}">		
                                    ${reply.uname}&nbsp;&nbsp;${fn:replace(reply.regDate,'T',' ')}
                                    <c:if test="${reply.uid eq sessionUid}">
                                    <button onclick="replyUpdate('block', ${loop.count})" style="float: right">수정</button>
                                    <button onclick="deleteConfirm(${board.bid}, ${reply.rid})" style="float: right">삭제</button>
                                    </c:if><br>    <!-- uname, regTime-->
                                    ${fn:replace(reply.content, newline, '<br>')}  <!-- content -->
                                </div>
                                <!-- 댓글 수정기능 추가중  -->
		                        <form class="form-inline d-none" action="/board/replyUpdate" id="replyUpdate${loop.count}" method="post">
					                <input type="hidden" name="bid" value="${board.bid}">     <!-- bid -->
					                <input type="hidden" name="uid" value="${board.uid}">     <!-- uid -->
					                <input type="hidden" name="rid" value="${reply.rid}">     <!-- rid -->
					                <table class="table table-borderless mt-2">
					                    <tr class="d-flex">
					                        <td class="col-1 text-end">
					                            
					                        </td>
					                        <td class="col-9">
					                            <textarea class="form-control" id="content" name="content" rows="3">${fn:replace(reply.content, newline, '<br>')}</textarea>
					                        </td>
					                        <td class="col-2">
					                            <button type="submit" class="btn btn-primary">수정</button>
					                            <button onclick="replyUpdate('none', ${loop.count})" class="btn btn-primary">취소</button>
					                        </td>
					                    </tr>
					                </table>
					            </form>
                          </c:forEach>
                          <br>


                          <!-- 댓글 등록 -->
                          <c:if test="${not empty sessionUid}">
                            <form class="form-inline" action="/board/reply" method="post">
                              <div class="w-full">
                                <input type="hidden" name="bid" value="${board.bid}"> <!-- bid -->
                                <input type="hidden" name="uid" value="${board.uid}"> <!-- uid -->
                                <label for="content"><b>댓글 작성</b></label>
                                <textarea id="content" name="content" cols="30" rows="3" placeholder="whrite here.."
                                  class="form-control w-full p-4 text-gray-600 bg-gray-100 outline-none rounded-md"></textarea>
                                <button type="submit" style="float: right"><b>등록</b></button>
                              </div>
                            </form>
                          </c:if>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
                <div class="col-3"></div>
              </div>
              <!-- ================main========================= -->
              <%-- <%@ include file="../common/bottom.jsp" %> --%>
            </body>

      </html>