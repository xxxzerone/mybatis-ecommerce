<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Seller Register</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
  <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
  <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body>
  <div class="container-fluid">
    <div class="main h-100">
      <form action="/users/register" method="post">
        <div class="row justify-content-center">
          <div class="col-4">
            <label for="email">이메일</label>
            <input type="email"
              name="email"
              id="email"
              class="form-control"
              oninput="disableButton()"
              required
            >
            <a class="btn btn-outline-primary" onclick="validateUsername()">중복확인</a>
          </div> 
        </div> 
        <div class="row justify-content-center">
          <div class="col-4">
            <label for="password">비밀번호</label>
            <input type="password" name="password" id="password" class="form-control" required>
          </div> 
        </div> 
        <div class="row justify-content-center">
          <div class="col-4">
            <label for="username">이름</label>
            <input type="text" name="username" id="username" class="form-control" required>
          </div> 
        </div> 
        <div class="row justify-content-center">
          <div class="col-4">
            <label for="phone">핸드폰</label>
            <input type="tel" id="phone" name="phone" class="form-control" placeholder="01012345678" pattern="[0-9]{3}[0-9]{3,4}[0-9]{4}" required>
          </div>
        </div>
        <div class="row justify-content-center">
          <div class="col-4">
            <input type='radio' name='userType' id="buyer" disabled value='B' />일반 회원
            <input type='radio' name='userType' id="seller" checked disabled value='S' />판매 회원
          </div>
        </div>
        <div class="row justify-content-center">
          <div class="col-4">
            <label for="address">주소</label>
            <input type="text" id="address" name="address" class="form-control" required>
          </div>
        </div> 
        <div class="row justify-content-center">
          <div class="col-2 text-center">
            <input type="submit" id="btnSubmit"
              class="btn btn-outline-primary"
              value="회원가입"
              disabled
            >
          </div> 
        </div> 
      </form>
    </div>
  </div>

  <script>
    function validateUsername() {
      const email = $('#email').val();
      $.ajax({
        url: '/users/validateUser',
        type: 'post',
        data: { email },
        success: (result) => {
          if (result.result === 'success') {
            Swal.fire({
              'title': '가입 가능한 아이디입니다.',
              'icon': 'success'
            }).then(() => {
              $('#btnSubmit').removeAttr('disabled');
            });
          } else {
            Swal.fire({
              'title': '중복된 아이디입니다.',
              'icon': 'warning'
            });
          }
        }
      });
    }

    function disableButton() {
      $('#btnSubmit').attr('disabled', 'true');
    }
  </script>
</body>
</html>