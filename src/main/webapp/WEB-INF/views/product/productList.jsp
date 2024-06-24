<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Board List</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css"> 
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
  <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
  <style>
    i {
      cursor: pointer;
    }
    #product-group {
      cursor: pointer;
    } 
  </style>
</head>
<body>
  <div class="container-fluid">
    <div class="main h-100">
      <h1 class="text-center">상품 목록</h1>

      <div class="row justify-content-center">
        <div class="col-10 text-center">
          <table class="table table-striped">
            <tr>
              <th>상품 번호</th>
              <th colspan="3">상품명</th>
              <th>재고 수량</th>
              <th>등록일</th>
            </tr> 

            <c:forEach var="product" items="${ products }" varStatus="status">
              <tr id="product-group" onclick="javascript:location.href='/products/${ product.id }'">
                <td>${ product.id }</td>
                <td colspan="3">${ product.name }</td>
                <td>${ product.stock }</td>
                <td>
                  <fmt:timeZone value="Seoul">
                    <fmt:parseDate value="${ product.createdAt }" pattern="yyyy-MM-dd'T'HH:mm:ss" var="createdAt" type="both" />
                  </fmt:timeZone>
                  <fmt:formatDate value="${ createdAt }" pattern="yy-MM-dd HH:mm" />
                </td>
              </tr>
            </c:forEach>

            <c:set var="curPage" value="${ page.number + 1 }" />
            <c:set var="maxPage" value="${ page.totalPages }" />
            <c:set var="startPage" value="${ page.startPage }" />
            <c:set var="endPage" value="${ page.endPage }" />

            <tr>
              <td colspan="6">
                <ul class="pagination justify-content-center m-0">
                  <li class="page-item">
                    <i class="page-link bi bi-chevron-double-left" onclick="javascript:location.href='/products?page=0'"></i>
                  </li> 
                  <c:if test="${ curPage > 5 }">
                    <li class="page-item">
                      <i class="page-link bi bi-chevron-left" onclick="javascript:location.href='/products?page=${ curPage - 6 }'"></i>
                    </li>
                  </c:if>

                  <c:forEach var="pageable" begin="${ startPage }" end="${ endPage }">
                    <c:choose>
                      <c:when test="${ pageable eq curPage}">
                        <li class="page-item">
                          <span class="page-link active">${ pageable }</span>
                        </li>
                      </c:when>
                      <c:otherwise>
                        <li class="page-item">
                          <a class="page-link" href="/products?page=${ pageable - 1 }">${ pageable }</a>
                        </li>
                      </c:otherwise>
                    </c:choose>
                  </c:forEach>

                  <c:if test="${ curPage < maxPage - 5 }">
                    <li class="page-item">
                      <i class="page-link bi bi-chevron-right" onclick="javascript:location.href='/products?page=${ curPage + 4 }'"></i>
                    </li>
                  </c:if>
                  <li class="page-item">
                    <i class="page-link bi bi-chevron-double-right" onclick="javascript:location.href='/products?page=${ maxPage - 1 }'"></i>
                  </li>
                </ul>
              </td>
            </tr>
          </table>
        </div>
      </div>
      <div class="row justify-content-end">
        <div class="col-3">
          <button type="button" class="btn btn-outline-primary" onclick="location.href='/board/write'">글 작성하기</button>
        </div> 
      </div>
    </div>
  </div>
</body>
</html>