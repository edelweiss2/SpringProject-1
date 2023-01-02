<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

    <title>게시판 샘플 프로젝트</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- TAILWIND CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
    
    <script>
        document.addEventListener("alpine:init", () => {
            Alpine.data("layout", () => ({
                profileOpen: false,
                asideOpen: true,
            }));
        });
    </script>