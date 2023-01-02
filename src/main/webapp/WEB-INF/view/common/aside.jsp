<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

    <script defer src="https://unpkg.com/alpinejs@3.10.2/dist/cdn.min.js"></script>
    <link rel="stylesheet" href="https://unpkg.com/boxicons@2.0.7/css/boxicons.min.css" />

    <!-- aside & Main -->
    <div class="flex overflow-x-hidden">

        <!-- aside -->
        <aside class="flex w-44 flex-col space-y-2 border-r-2 border-gray-200 bg-white p-2" style="min-height: 90.5vh;"
            x-show="asideOpen">
            <a href="/board/list?p=1&f=&q=" class="flex items-center space-x-1 rounded-md px-2 py-3 hover:bg-gray-100 hover:text-blue-600">
                <span class="text-2xl"><i class="bx bx-home"></i></span>
                <span>HOME</span>
            </a>
            <a href="/board/list?p=1&f=&q="
                class="flex items-center space-x-1 rounded-md px-2 py-3 hover:bg-gray-100 hover:text-blue-600 ${(menu eq 'board') ? 'active' : 'null'}">
                <span class="text-2xl"><i class="bx bx-folder"></i></span>
                <span>BOARD</span>
            </a>
            <c:if test="${sessionUid eq 'admin'}">
            <a href="/user/list/0"
                class="flex items-center space-x-1 rounded-md px-2 py-3 hover:bg-gray-100 hover:text-blue-600 ${(menu eq 'user') ? 'active' : 'null'}">
                <span class="text-2xl"><i class="bx bx-user"></i></span>
                <span>USER</span>
            </a>
            </c:if>
        </aside>
     