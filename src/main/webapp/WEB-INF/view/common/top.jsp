<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

    <!-- page -->
    <main class="min-h-screen w-full bg-gray-200 text-gray-700" x-data="layout">

        <!-- header page -->
        <header class="flex w-full items-center justify-between border-b-2 border-gray-200 bg-white p-2">
            <!-- logo -->
            <div class="flex items-center space-x-2">
                <button type="button" class="text-3xl" @click="asideOpen = !asideOpen"><i
                        class="bx bx-menu"></i></button>
                <div>중고장터</div>
            </div>

            <!-- button profile -->
            <div>
                <button type="button" @click="profileOpen = !profileOpen" @click.outside="profileOpen = false"
                    class="overflow-hidden mr-2">
<%--                 <c:if test="${not empty sessionUid}"> --%>
                    <span>Hello <b>${sessionUid}</b> 🥰</span>
<%--                 </c:if> --%>
                </button>
                <!-- dropdown profile -->
                <div class="absolute right-2 mt-1 w-32 divide-y z-50 divide-gray-200 rounded-md border border-gray-200 bg-white shadow-md"
                    x-show="profileOpen" x-transition>
                  <c:if test="${not empty sessionUid}">
                    <div class="flex items-center space-x-2 p-2">
                        <div class="font-medium">
                          <span>${sessionUid}</span>
                        </div>
                    </div>
                    </c:if>
                    <div class="flex flex-col space-y-3 p-2 text-sm">
                        <c:if test="${(sessionUid ne 'admin') and (not empty sessionUid)}">
                        <a href="/user/update/${sessionUid}" class="transition hover:text-blue-600 ${(menu eq 'user') ? 'active' : 'null'}">Edit Profile</a>
                        <a href="/board/myList" class="transition hover:text-blue-600">My Shop</a>
                        <a href="/board/likeList" class="transition hover:text-blue-600">Like Products</a>
		                    </div>
                        </c:if>
                        <c:if test="${empty sessionUid}">
                        <a href="/user/register" class="transition hover:text-blue-600">Join</a>
		                    </div>
                        </c:if>
                    <div class="p-2">
                    <c:if test="${empty sessionUid}">
                    <button class="flex items-center space-x-2 transition hover:text-blue-600"
                            onclick="location.href='/user/login'">
                    	<svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                    		<path stroke-linecap="round" stroke-linejoin="round" d="M11 16l-4-4m0 0l4-4m-4 4h14m-5 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h7a3 3 0 013 3v1" />
                      </svg>
                      <span>Login</span>
                    </button>
                    </c:if>
                      <c:if test="${not empty sessionUid}">
                        <button class="flex items-center space-x-2 transition hover:text-blue-600"
                            onclick="location.href='/user/logout'">
                            <svg class="h-4 w-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"
                                xmlns="http://www.w3.org/2000/svg">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                    d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1">
                                </path>
                            </svg>
                            <div>Log Out</div>
                        </button>
                      </c:if>
                    </div>
                </div>
            </div>
        </header>