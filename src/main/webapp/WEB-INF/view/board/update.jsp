<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<%@ include file="../common/heading.jsp" %>
    <style>
        th, td { text-align: center; }
        .images { height: 100px; width: 100px; }
    </style>
</head>

<body>
   	<%@ include file="../common/top.jsp" %>
    <div class="container" style="margin-top: 80px;">
        <div class="row">
        	<%@ include file="../common/aside.jsp" %>
            <!-- 나머지는 공통이니까 main부분만 고치면됨 -->
            <!-- =============================main=========================== -->
            <div class="col-sm-9">
            <h3><strong>게시글쓰기</strong></h3>
            <hr>
                <div class="row">
			        <div class="col-1"></div>
			        <div class="col-10">
			        	<!-- enctype="multipart/form-data"는 첨부파일 인코딩을 위해서 넣어주어야함 -->
			            <form action="/board/update" method="post" enctype="multipart/form-data">
			            	<input type="hidden" name="uid" value="${uid}">
			            	<input type="hidden" name="bid" value="${board.bid}">
			                <table class="table table-borderless">
			                    <tr>
			                        <td><label for="title">제목</label></td>
			                        <td colspan="2"><input class="form-control" type="text" name="title" id="title" value="${board.title}"></td>
			                    </tr>
			                    <tr>
			                        <td><label for="title">가격</label></td>
			                        <td colspan="2"><input class="form-control" type="number" name="price" id="price" value="${board.price}"></td>
			                    </tr>
			                    <tr>
			                        <td><label for="category">카테고리</label></td>
			                        <td style="text-align: left">
			                        <input class="ms-2" type="radio" name="category" value="디지털/가전">디지털/가전
			                        <input class="ms-2" type="radio" name="category" value="의류">의류
			                        <input class="ms-2" type="radio" name="category" value="식품">식품</td>
			                    </tr>
			                    <tr>
			                        <td><label for="state">판매/구매</label></td>
			                        <td style="text-align: left" >
			                        <input class="ms-2" type="radio" name="state" value="판매">판매
			                        <input class="ms-2" type="radio" name="state" value="구매">구매</td>
			                    </tr>
			                    <tr>
			                    	<!-- TODO: 나중에 첨부파일수정  -->
			                        <td><label for="files">첨부파일</label></td>
			                        <c:forEach var="file" items="${fileList}">
			                        	<td><img style="height: 200px; width: 200px" src="/file/display?fileName=${file}"></td>
			                        </c:forEach>
			                    </tr>
			                    <tr>
			                        <td><label for="content">내용</label></td>
			                        <td colspan="2">
			                        	<textarea class="form-control" name="content" id="content" rows="10">${board.content}</textarea>
			                        </td>
			                    </tr>
			                    <tr>
			                        <td colspan="3" style="text-align: center;">
			                            <input class="btn btn-primary" type="submit" value="제출">
			                            <input class="btn btn-secondary" type="reset" value="취소">
			                        </td>
			                    </tr>
			                </table>
			            </form>
			        </div>
			        <div class="col-3"></div>
			    </div>
            </div>
            <!-- ================main========================= -->
        </div>
        <div id="multiple-container"></div>
    </div>
	<%@ include file="../common/bottom.jsp" %>
	
	<script>
	function readMultipleImage(input) {
	    const multipleContainer = document.getElementById("multiple-container")
	    
	    // 인풋 태그에 파일들이 있는 경우
	    if(input.files) {
	        // 이미지 파일 검사 (생략)
	        console.log(input.files)
	        // 유사배열을 배열로 변환 (forEach문으로 처리하기 위해)
	        const fileArr = Array.from(input.files)
	        const $colDiv1 = document.createElement("td")
	        $colDiv1.classList.add("row")
	        fileArr.forEach((file, index) => {
	            const reader = new FileReader()
	            /* const $imgDiv = document.createElement("div")  */  
	            const $img = document.createElement("img")
	            $img.classList.add("images")
	            const $label = document.createElement("label")
	            $label.classList.add("image-label")
	            /* $label.textContent = file.name */
/* 	            $img.appendChild($img) */
	            $img.appendChild($label)
	            reader.onload = e => {
	                $img.src = e.target.result
	              /*   $imgDiv.style.width = ($img.naturalWidth) * 0.2 + "px"
	                $imgDiv.style.height = ($img.naturalHeight) * 0.2 + "px" */
	                $img.style.width = "200px"
	                $img.style.height = "200px"
	            }
	            
	            console.log(file.name)
	            $colDiv1.appendChild($img)
	            reader.readAsDataURL(file)
	        })
	        multipleContainer.appendChild($colDiv1)
	    }
	}
	const inputMultipleImage = document.getElementById("input-multiple-image")
	inputMultipleImage.addEventListener("change", e => {
	    readMultipleImage(e.target)
	})
	</script>
</body>
</html>