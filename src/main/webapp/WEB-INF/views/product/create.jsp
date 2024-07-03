<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Product Create</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
  <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
</head>
<body>
  <div class="container-fluid">
    <%-- <form action="/board/write" method="post" enctype="multipart/form-data"> --%>
      <div class="table">
        <div class="row justify-content-center mb-3">
          <div class="col-6">
            <div class="form-floating">
              <input type="text" class="form-control" id="input_name" name="name" placeholder="name">
              <label for="input_name">상품명</label>
            </div>
          </div>
        </div>
        <div class="row justify-content-center mb-3">
          <div class="col-6">
            <div class="form-floating">
              <input type="number" class="form-control" id="input_price" name="price" placeholder="price">
              <label for="input_price">가격</label>
            </div>
          </div>
        </div>
        <div class="row justify-content-center mb-3">
          <div class="col-6">
            <div class="form-floating">
              <input type="number" class="form-control" id="input_stock" name="stock" placeholder="stock">
              <label for="input_stock">재고 수량</label>
            </div>
          </div>
        </div>
        <div class="row justify-content-center mb-3">
          <div class="col-6">
            <div class="form-floating">
              <select class="form-select" id="input_category" name="categoryId">
                <option selected disabled hidden>선택
              </select>
              <label for="input_category">카테고리</label>
            </div>
          </div>
        </div>
        <div class="row justify-content-center mb-3">
          <div class="col-6">
            <textarea name="info" id="input_info" cols="70" rows="10"></textarea>
          </div>
        </div>

        <div class="row justify-content-center">
          <div class="col-6">
            <label for="input_file">첨부파일</label> 
            <input type="file" name="files" id="input_file" class="form-control" accept="image/*" multiple>
          </div> 
        </div>

        <div class="row justify-content-center">
          <div class="col-6">
            <button type="button" class="btn btn-outline-primary w-100" onclick="create()">작성</button>
          </div>
        </div>
      </div>
    <%-- </form> --%>
  </div>

  <script>
    $.ajax({
      url: '/categories',
      type: 'get'
    }).done((data) => {
      for (const obj of data) {
        const option = `<option value='\${ obj.id }\'>\${ obj.name }\</option>`;
        $('#input_category').append(option);
      }
    }).fail((xhr, textStatus, errorThrown) => {
      console.log(xhr, textStatus);
    });

    function create() {
      const name = $('#input_name').val();
      const price = $('#input_price').val();
      const stock = $('#input_stock').val();
      const categoryId = $('#input_category option:selected').val();
      const info = $('#input_info').val();
      const productDTO = {
        name,
        price,
        stock,
        categoryId,
        info
      };
      
      const formData = new FormData();
      formData.append("productDTO", new Blob([JSON.stringify(productDTO)], { type: 'application/json' }));

      const files = $('#input_file')[0].files;
      for (const file of files) {
        formData.append("files", file);
      }

      $.ajax({
        url: '/products/create',
        type: 'post',
        data: formData,
        contentType: false,
        processData: false,
        enctype: 'multipart/form-data'
      }).done((res) => {
        if (res.result === 'success') {
          location.href = '/products';
        }
      }).fail((xhr, textStatus, errorThrown) => {
        console.log(xhr, textStatus);
      });
    }
  </script>
</body>
</html>