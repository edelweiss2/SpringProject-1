<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

    <!DOCTYPE html>
    <html lang="ko">

    <head>
        <%@ include file="../common/heading.jsp" %>
    </head>

    <body>
        <%@ include file="../common/top.jsp" %>

            <%@ include file="../common/aside.jsp" %>

                <!-- =================== main =================== -->

                <script src="https://cdn.tailwindcss.com"></script>
                <script defer src="https://unpkg.com/alpinejs@3.x.x/dist/cdn.min.js"></script>

                <!-- MAIN CONTENT -->
                <div
                    class="container-fluid bg-gray-200 w-full min-h-screen flex items-center justify-center overflow-hidden">
                    <div class="lg:flex items-center space-x-16">
                        <div class="xl:w-[500px] 2xl:w-[550px] mx-auto px-16 py-8 rounded-lg">
                            <h1 class="text-center text-3xl font-bold tracking-wide text-gray-800">Sign In</h1>
                            <p class="text-center text-sm text-gray-600 mt-2">
                                Forgot your password?
                                <a href="#" class="text-blue-600 hover:text-blue-700 hover:underline"
                                    title="Sign In">Find Password In Here</a>
                            </p>

                            <!-- 입력창 -->
                            <form class="my-8 text-sm" action="/user/login" method="post">
                                <!-- 아이디 -->
                                <div class="flex flex-col my-4">
                                    <label for="uid">ID</label>
                                    <input type="text" name="uid" id="uid"
                                        class="form-control mt-2 p-2 border border-gray-300 focus:outline-none focus:ring-0 focus:border-gray-300 rounded text-sm text-gray-900"
                                        placeholder="Enter your ID">
                                </div>

                                <!-- 비밀번호 -->
                                <div class="flex flex-col my-4">
                                    <label for="name">Password</label>
                                    <div x-data="{ show: false }" class="relative flex items-center mt-2">
                                        <input :type=" show ? 'text': 'password' " name="pwd" id="pwd"
                                            class="form-control flex-1 p-2 border pr-10 border-gray-300 focus:outline-none focus:ring-0 focus:border-gray-300 rounded text-sm text-gray-900"
                                            placeholder="Enter your password" type="password">
                                        <!-- 비밀번호 Show & Hide 버튼 -->
                                        <button @click="show = !show" type="button"
                                            class="absolute right-2 bg-transparent flex items-center justify-center text-gray-700">
                                            <!-- 비밀번호 안보이게 -->
                                            <svg x-show="!show" class="w-5 h-5" fill="none" stroke="currentColor"
                                                viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                    d="M13.875 18.825A10.05 10.05 0 0112 19c-4.478 0-8.268-2.943-9.543-7a9.97 9.97 0 011.563-3.029m5.858.908a3 3 0 114.243 4.243M9.878 9.878l4.242 4.242M9.88 9.88l-3.29-3.29m7.532 7.532l3.29 3.29M3 3l3.59 3.59m0 0A9.953 9.953 0 0112 5c4.478 0 8.268 2.943 9.543 7a10.025 10.025 0 01-4.132 5.411m0 0L21 21">
                                                </path>
                                            </svg>
                                            <!-- 비밀번호 보이게 -->
                                            <svg x-show="show" class="w-5 h-5" fill="none" stroke="currentColor"
                                                viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"
                                                style="display: none;">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                    d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"></path>
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                    d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z">
                                                </path>
                                            </svg>
                                        </button>
                                    </div>
                                </div>

                                <!-- 로그인 버튼 -->
                                <div class="my-4 flex w-full items-center justify-center space-x-4">
                                    <button
                                        class="bg-blue-600 hover:bg-blue-700 rounded-lg px-8 py-2 text-gray-100 hover:shadow-xl transition duration-150 uppercase"
                                        type="submit">
                                        <!-- 아이콘 -->
                                        <div class="flex flex-row items-center justify-center">
                                            <div class="mr-2">
                                                <svg class="w-6 h-6" fill="none" stroke="currentColor"
                                                    viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                                                    <path stroke-linecap="round" stroke-linejoin="round"
                                                        stroke-width="1"
                                                        d="M11 16l-4-4m0 0l4-4m-4 4h14m-5 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h7a3 3 0 013 3v1">
                                                    </path>
                                                </svg>
                                            </div>
                                            Sign In
                                        </div>
                                    </button>

                                </div>

                                <!-- 리셋 & 회원가입 버튼 -->
                                <div class="flex w-full items-center justify-center space-x-4">
                                    <input class="w-full text-center font-medium text-gray-500 bg-gray-200" type="reset"
                                        value="Reset">
                                    <input
                                        class="w-full text-center font-medium text-gray-500 bg-gray-200 focus:outline-none"
                                        onclick="location.href='/user/register'" value="Sign Up">
                                </div>
                            </form>

                        </div>
                    </div>
                </div>
                <!-- =================== main =================== -->

                <%@ include file="../common/bottom.jsp" %>

    </body>

    </html>