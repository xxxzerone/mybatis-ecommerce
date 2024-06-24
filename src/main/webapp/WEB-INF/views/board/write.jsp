<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Board Write</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
  <script src="https://cdn.ckeditor.com/ckeditor5/41.4.2/classic/ckeditor.js"></script>
  <script src="https://ckeditor.com/apps/ckfinder/3.5.0/ckfinder.js"></script>
</head>
<body>
  <div class="container-fluid">
    <form action="/board/write" method="post" enctype="multipart/form-data">
      <div class="table">
        <div class="row justify-content-center mb-3">
          <div class="col-6">
            <div class="form-floating">
              <input type="text" class="form-control" id="input_title" name="title" placeholder="title">
              <label for="input_title">title</label>
            </div>
          </div>
        </div>
        <div class="row justify-content-center mb-3">
          <div class="col-6">
            <textarea name="content" id="input_content"></textarea>
          </div>
        </div>

        <div class="row justify-content-center">
          <div class="col-6">
            <label for="input_file">첨부파일</label> 
            <input type="file" name="file" id="input_file" class="form-control" multiple>
          </div> 
        </div>

        <div class="row justify-content-center">
          <div class="col-6">
            <button type="submit" class="btn btn-outline-primary w-100">작성</button>
          </div>
        </div>
      </div>
    </form>
  </div>

  <script>
    ClassicEditor.create(document.querySelector('#input_content'), {
      ckfinder: {
        uploadUrl: '/board/uploads'
      }
    }).catch(error => {
      console.log(error);
    });
    
    function writeBoard() {
      const data = new FormData();
      data.append('title', $('#input_title').val());
      data.append('content', $('#input_content').val());
      data.append('file', $('#input_file')[0]);

      $.ajax({
        url: '/board/write',
        type: 'post',
        data: data,
        enctype: 'multipart/form-data',
        success: (result) => {
          console.log(result);
        },
        fail: (result) => {
          console.log(result);
        }
      });
    }
  </script>
</body>
</html>