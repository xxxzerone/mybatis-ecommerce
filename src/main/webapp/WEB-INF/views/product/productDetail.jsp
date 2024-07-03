<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>${ product.id } Product Detail</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
  <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
  <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
</head>
<body>
  <div class="container-fluid">
    <div class="row justify-content-center">
      <div class="col-10">
        <table class="table table-striped">
          <tr>
            <th>상품 번호</th>
            <td>${ product.id }</td>
          </tr> 
          <tr>
            <th>상품명</th>
            <td>${ product.name }</td>
          </tr> 
          <tr>
            <th>재고</th>
            <td>${ product.stock }</td>
          </tr> 
          <tr>
            <th>작성자</th>
            <td>${ logIn.username }</td>
          </tr>
          <tr>
            <th>등록일</th>
            <td>
                <fmt:timeZone value="Seoul">
                  <fmt:parseDate value="${ product.createdAt }" pattern="yyyy-MM-dd'T'HH:mm:ss" var="createdAt" type="both" />
                </fmt:timeZone>
                <fmt:formatDate value="${ createdAt }" pattern="yy-MM-dd HH:mm" />
            </td>
          </tr> 
          <tr>
            <th>수정일</th>
            <td>
                <fmt:timeZone value="Seoul">
                  <fmt:parseDate value="${ product.updatedAt }" pattern="yyyy-MM-dd'T'HH:mm:ss" var="updatedAt" type="both" />
                </fmt:timeZone>
                <fmt:formatDate value="${ updatedAt }" pattern="yy-MM-dd HH:mm" />
            </td>
          </tr> 
          <tr>
            <th colspan="2" class="text-center">내용</th>
          </tr>
          <tr>
            <td colspan="2">${ product.info }</td>
          </tr>
          <tr>
            <th colspan="2" class="text-center">이미지</th>
          </tr>
          <tr>
            <td colspan="2">
              <c:forEach var="file" items="${ files }">
                <img src='/uploads/${ file.fileName }.${ file.fileExt }' width='100' />
              </c:forEach>
            </td>
          </tr>
          <tr>
            <th>수량</th>
            <td>
              <input type="number" class="w-25" name="quantity" id="quantity" min="1" max="${ product.stock }" value="1"> 
              <button type="button" class="btn btn-outline-success" onclick="addCart()">장바구니 등록</button> 
            </td>
          </tr>
          <%-- <c:if test="${ board.writerId eq logIn.id }">
            <tr class="text-center">
              <td class="text-center" colspan="3">
                <button type="button" class="btn btn-outline-success" onclick="javascript:location.href='/board/update/${ board.id }'">수정</button>
                <button type="button" class="btn btn-outline-danger" onclick="remove(${ board.id })">삭제</button>
              </td>
            </tr> 
          </c:if> --%>
          <tr class="text-center">
            <td class="text-center" colspan="3">
              <a href="/products" class="btn btn-outline-secondary">목록</a>
            </td>
          </tr> 
        </table> 

        <%-- <table class="table table-striped">
          <tr class="text-center">
            <td colspan="6">댓글</td> 
          </tr> 
          <c:forEach var="reply" items="${ replys }">
            <tr>
              <td>${ reply.id }</td>
              <td>${ reply.nickname }</td>
              
              <c:choose>
                <c:when test="${ reply.writerId eq logIn.id }">
                  <form action="/reply/update/${ reply.id }" method="post">
                    <td>
                      <input type="text" class="form-control text-truncate" name="content" value="${ reply.content }">
                    </td>
                    <td>
                      <span class="d-flex justify-content-center">
                        <fmt:timeZone value="Seoul">
                          <fmt:parseDate value="${ board.modifyDate }" pattern="yyyy-MM-dd'T'HH:mm:ss" var="modifyDate" type="both" />
                        </fmt:timeZone>
                        <fmt:formatDate value="${ modifyDate }" pattern="yy-MM-dd HH:mm" />
                      </span>
                    </td>

                    <td style="width: 25px;">
                      <input type="submit" class="btn btn-outline-primary" value="수정">
                    </td>
                    <td style="width: 25px;">
                      <a href="/reply/delete/${ reply.id }" class="btn btn-outline-warning">삭제</a> 
                    </td>
                  </form> 
                </c:when>

                <c:otherwise>
                  <td colspan="2">
                    <input type="text" class="form-control text-truncate" name="content" value="${ reply.content }">
                  </td>
                  <td colspan="2">
                    <span class="d-flex justify-content-center">
                      <fmt:timeZone value="Seoul">
                        <fmt:parseDate value="${ board.modifyDate }" pattern="yyyy-MM-dd'T'HH:mm:ss" var="modifyDate" type="both" />
                      </fmt:timeZone>
                      <fmt:formatDate value="${ modifyDate }" pattern="yy-MM-dd HH:mm" />
                    </span>
                  </td>
                </c:otherwise>
              </c:choose>
            </tr>
          </c:forEach>
          <tr>
            <form action="/reply/insert/${ board.id }" method="post">
              <td colspan="5">
                <input type="text" name="content" class="form-control" placeholder="댓글" />
              </td>
              <td>
                <input type="submit" class="btn btn-outline-success" value="작성하기" />
              </td>
            </form> 
          </tr>
        </table> --%>
      </div> 
    </div>
  </div> 

  <script>
    function remove(id) {
      Swal.fire({
        title: "정말로 삭제하시겠습니까?",
        text: "Really Really Really?!",
        icon: "question",
        showCancelButton: true,
        confirmButtonText: '삭제',
        cancelButtonText: '취소'
      }).then(result => {
        if (result.isConfirmed) {
          Swal.fire({
            title: '삭제되었습니다.'
          }).then(result => {
            location.href = '/board/delete/' + id;
          });
        }
      });
    } 

    function addCart() {
      const quantity = $('#quantity').val();
      const data = {
        'productId': ${ product.id },
        'quantity': quantity
      };

      $.ajax({
        url: `/carts/${ logIn.id }`,
        type: 'post',
        data: JSON.stringify(data),
        contentType: 'application/json;charset=utf-8',
        success: (res) => {
          if (res.result === 'success') {
            location.href = `/carts/${ logIn.id }`;
          }
        },
        error: (res) => {
          console.log(res);
        }
      });
    }
  </script>
</body>
</html>