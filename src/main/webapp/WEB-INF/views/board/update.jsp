<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>${ board.id } Update Page</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
  <script src="https://cdn.ckeditor.com/ckeditor5/41.4.2/classic/ckeditor.js"></script>
</head>
<body>
  <div class="container-fluid">
    <form action="/board/update/${ board.id }" method="post">
      <div class="table">
        <div class="row justify-content-center mb-3">
          <div class="col-6">
            <div class="form-floating">
              <input type="text" class="form-control" id="input_title"
                name="title" value="${ board.title }">
              <label for="input_title">title</label>
            </div>
          </div>
        </div>
        <div class="row justify-content-center mb-3">
          <div class="col-6">
            <textarea name="content" id="input_content">${ board.content }</textarea>
          </div>
        </div>
        <div class="row justify-content-center">
          <div class="col-6">
            <input type="submit" class="btn btn-outline-primary w-100" value="수정하기">
          </div>
        </div>
      </div>
    </form>
  </div>

  <script>
    ClassicEditor.create(
      document.querySelector('#input_content')
    ).catch(error => {
      console.log(error)
    });
  </script>
</body>
</html>