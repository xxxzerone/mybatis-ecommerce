<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>index</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</head>
<body>
  <div class="container-fluid">
    <div class="main h-100">
      <form action="/users/auth" method="post">
        <div class="row justify-content-center">
          <div class="col-4">
            <label for="email">이메일</label>
            <input type="email" name="email" id="email" class="form-control">
          </div> 
        </div> 
        <div class="row justify-content-center">
          <div class="col-4">
            <label for="password">비밀번호</label>
            <input type="password" name="password" id="password" class="form-control">
          </div> 
        </div> 
        <div class="row justify-content-center">
          <div class="col-2 text-center">
            <input type="submit" class="btn btn-outline-primary" value="로그인">
          </div> 
          <div class="col-2 text-center">
            <a href="/users/register" class="btn btn-outline-secondary">회원가입</a>
          </div>
          <div class="col-2 text-center">
            <a href="/users/seller/register" class="btn btn-outline-secondary">판매자 회원가입</a>
          </div>
        </div> 
      </form>
    </div>
  </div>
</body>
</html>