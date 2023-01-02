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
					<div class="flex antialiased sans-serif bg-gray-200 items-center justify-center">

						<!-- BOX -->
						<div class="w-full p-4 container mx-auto py-6 px-4" x-data="datatables()" x-cloak>
							<h1 class="text-3xl py-4 border-b mb-10">회원 목록</h1>

							<!-- 테이블 상단 메뉴 -->
							<div class="mb-4 flex justify-between items-center">
							</div>

							<!-- 유저 테이블 -->
							<div class="overflow-x-auto bg-white rounded-lg shadow overflow-y-auto relative" style="height: 565px;">
								<table class="border-collapse table-auto w-full whitespace-no-wrap bg-white table-striped relative">

									<!-- THEAD -->
									<thead>
										<tr class="text-left">
											<th class="bg-gray-100 sticky top-0 border-b border-gray-200 px-6 py-2 text-gray-600 font-bold tracking-wider uppercase text-xl">
											ID
											</th>
											<th class="bg-gray-100 sticky top-0 border-b border-gray-200 px-6 py-2 text-gray-600 font-bold tracking-wider uppercase text-xl">
											PASSWORD
											</th>
											<th class="bg-gray-100 sticky top-0 border-b border-gray-200 px-6 py-2 text-gray-600 font-bold tracking-wider uppercase text-xl">
											이름
											</th>
											<th class="bg-gray-100 sticky top-0 border-b border-gray-200 px-6 py-2 text-gray-600 font-bold tracking-wider uppercase text-xl">
											이메일
											</th>
											<th class="bg-gray-100 sticky top-0 border-b border-gray-200 px-6 py-2 text-gray-600 font-bold tracking-wider uppercase text-xl">
											주소
											</th>
											<th class="bg-gray-100 sticky top-0 border-b border-gray-200 px-6 py-2 text-gray-600 font-bold tracking-wider uppercase text-xl">
											전화번호
											</th>
											<th class="bg-gray-100 sticky top-0 border-b border-gray-200 px-6 py-2 text-gray-600 font-bold tracking-wider uppercase text-xl">
											가입일
											</th>
											<th class="bg-gray-100 sticky top-0 border-b border-gray-200 px-6 py-2 text-gray-600 font-bold tracking-wider uppercase text-xl">
											탈퇴 여부
											</th>
											<th class="bg-gray-100 sticky top-0 border-b border-gray-200 px-6 py-2 text-gray-600 font-bold tracking-wider uppercase text-xl">
											탈퇴일
											</th>
											<th class="bg-gray-100 sticky top-0 border-b border-gray-200 px-6 py-2 text-gray-600 font-bold tracking-wider uppercase text-xl">
											액션
											</th>
										</tr>
									</thead>

									<!-- TBODY -->
									<tbody>
										<c:forEach var="user" items="${userList}">
											<tr>
												<td class="border-dashed border-t border-gray-200"><span class="text-gray-700 px-6 py-3 flex items-center">${user.uid}</span></td>
												<td class="border-dashed border-t border-gray-200"><span class="text-gray-700 px-6 py-3 flex items-center">${user.pwd}</span></td>
												<td class="border-dashed border-t border-gray-200"><span class="text-gray-700 px-6 py-3 flex items-center">${user.uname}</span></td>
												<td class="border-dashed border-t border-gray-200"><span class="text-gray-700 px-6 py-3 flex items-center">${user.email}</span></td>
												<td class="border-dashed border-t border-gray-200"><span class="text-gray-700 px-6 py-3 flex items-center">${user.addr}</span></td>
												<td class="border-dashed border-t border-gray-200"><span class="text-gray-700 px-6 py-3 flex items-center">${user.phoneNum}</span></td>
												<td class="border-dashed border-t border-gray-200"><span class="text-gray-700 px-6 py-3 flex items-center">${user.regDate}</span></td>
												<td class="border-dashed border-t border-gray-200"><span class="text-gray-700 px-6 py-3 flex items-center">
													<c:if test="${user.isDeleted == 0}">
													X
													</c:if>
													<c:if test="${user.isDeleted == 1}">
													O
													</c:if>
												</span></td>	
												<td class="border-dashed border-t border-gray-200"><span class="text-gray-700 px-6 py-3 flex items-center">${user.delDate}</span></td>
												<td class="border-dashed border-t border-gray-200 action">
													<!-- ACTION ICON -->
													<div class="flex item-center justify-center text-gray-700">
														<div class="w-4 mr-2 transform hover:text-gray-100 hover:scale-110" onclick="location.href='/user/update/${user.uid}'">
															<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24"
																stroke="currentColor">
																<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
																	d="M15.232 5.232l3.536 3.536m-2.036-5.036a2.5 2.5 0 113.536 3.536L6.5 21.036H3v-3.572L16.732 3.732z" />
															</svg>
														</div>
														<div class="w-4 mr-2 transform hover:text-gray-100 hover:scale-110" onclick="location.href='/user/delete/${user.uid}'">
															<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24"
																stroke="currentColor">
																<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
																	d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16" />
															</svg>
														</div>
													</div>
												</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>

							<!-- Prev & Next -->
							<div class="px-5 py-5 border-t flex flex-col xs:flex-row items-center xs:justify-between">
								<span class="text-xs xs:text-sm text-gray-900">
									Showing 1 to 10 of 50 Entries
								</span>
								<div class="inline-flex mt-3 xs:mt-0">
									<button class="text-sm bg-gray-300 hover:bg-gray-400 text-gray-600 font-semibold py-2 px-4 rounded-l">
										Prev
									</button>
									<button class="text-sm bg-gray-300 hover:bg-gray-400 text-gray-600 font-semibold py-2 px-4 rounded-r">
										Next
									</button>
								</div>
							</div>

						</div>
					</div>

					<!-- =================== main =================== -->

					<%@ include file="../common/bottom.jsp" %>

				</body>

	</html>