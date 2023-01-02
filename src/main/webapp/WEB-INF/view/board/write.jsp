<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

  <!DOCTYPE html>
  <html lang="ko">

  <head>
    <%@ include file="../common/heading.jsp" %>
      <link href="https://unpkg.com/tailwindcss@1.2.0/dist/tailwind.min.css" rel="stylesheet">
  </head>

  <body>
    <%@ include file="../common/top.jsp" %>
      <%@ include file="../common/aside.jsp" %>

        <!-- =================== main =================== -->

        <!-- START -->

        <body style=" background: #edf2f7;">
          <div class="flex antialiased bg-gray-200 items-center justify-center">

            <!-- BOX -->
            <div class="w-full p-4 container mx-auto py-6 px-4">

              <!-- enctype="multipart/form-data"는 첨부파일 인코딩을 위해서 넣어주어야함 -->
              <form action="/board/write" method="post" enctype="multipart/form-data">
                <div class="min-h-screen md:px-20 pt-6">
                  <input type="hidden" name="uid" value="${uid}">
                  <div class=" bg-white rounded-md px-6 py-10 max-w-2xl mx-auto">
                    <h1 class="text-center text-2xl font-bold text-gray-500 mb-10">게시글 작성</h1>
                    <div class="space-y-4">

                      <div>
                        <label for="title" class="text-lx"><b>제목: </b></label>
                        <input type="text" placeholder="title" id="title" name="title"
                          class="form-control ml-2 outline-none py-1 px-2 text-md border-2 rounded-md" />
                      </div>

                      <div>
                        <label for="price" class="text-lx"><b>가격: </b></label>
                        <input type="number" placeholder="price" id="price" name="price"
                          class="form-control ml-2 outline-none py-1 px-2 text-md border-2 rounded-md" />
                      </div>

                      <div>
                        <label for="category" class="text-lx"><b>카테고리: </b></label>
                        <input type="radio" id="digital" name="category" value="디지털/가전"
                          class="ml-2 outline-none py-1 px-2 text-md border-2 rounded-md">&nbsp;디지털/가전
                        <input type="radio" id="clothes" name="category" value="의류"
                          class="ml-2 outline-none py-1 px-2 text-md border-2 rounded-md">&nbsp;의류
                        <input type="radio" id="food" name="category" value="식품"
                          class="ml-2 outline-none py-1 px-2 text-md border-2 rounded-md">&nbsp;식품
                      </div>

                      <div>
                        <label for="category" class="text-lx"><b>판매/구매: </b></label>
                        <input type="radio" id="sell" name="state" value="판매"
                          class="ml-2 outline-none py-1 px-2 text-md border-2 rounded-md">&nbsp;판매
                        <input type="radio" id="buy" name="state" value="구매"
                          class="ml-2 outline-none py-1 px-2 text-md border-2 rounded-md">&nbsp;구매
                      </div>

                      <div>
                        <label for="content" class="block mb-2 text-lg"><b>내용: </b></label>
                        <textarea id="content" name="content" cols="30" rows="10" placeholder="whrite here.."
                          class="form-control w-full p-4 text-gray-600 bg-gray-200 outline-none rounded-md"></textarea>
                      </div>

                      <div>
                        <label for="files" class="text-lx"><b>첨부파일 :</b></label><br>
                        <input type="file" name="files" id="files"
                          class="form-control mt-2 ml-2 outline-none py-1 px-2 text-md border-2 rounded-md" multiple />
                       
                      </div>

                      <button
                        class="px-6 py-2 mx-auto block rounded-md text-lg font-semibold text-indigo-100 bg-gray-600"
                        type="submit">제출</button>
                      <button
                        class="px-6 py-2 mx-auto block rounded-md text-lg font-semibold text-indigo-100 bg-gray-600"
                        type="reset">취소</button>
                    </div>
                  </div>
                </div>
              </form>
            </div>
            <div class="col-3"></div>
          </div>
          <!-- ================main========================= -->
          <%@ include file="../common/bottom.jsp" %>
        </body>

  </html>