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
  <style>
    i {
      cursor: pointer;
    }
    #board-group {
      cursor: pointer;
    } 
  </style>
</head>
<body>
  <div class="container-fluid">
    <div class="main h-100">
      <h1 class="text-center">게시판</h1>

      <div class="row justify-content-center">
        <div class="col-10 text-center">
          <table class="table table-striped">
            <tr>
              <th>글 번호</th>
              <th colspan="3">제목</th>
              <th>작성자</th>
              <th>작성일</th>
            </tr> 

            <c:forEach var="board" items="${ boards }" varStatus="status">
              <tr id="board-group" onclick="javascript:location.href='/board/showOne/${ board.id }'">
                <td>${ board.id }</td>
                <td colspan="3">${ board.title }</td>
                <td>${ board.nickname }</td>
                <td>
                  <fmt:timeZone value="Seoul">
                    <fmt:parseDate value="${ board.entryDate }" pattern="yyyy-MM-dd'T'HH:mm:ss" var="entryDate" type="both" />
                  </fmt:timeZone>
                  <fmt:formatDate value="${ entryDate }" pattern="yy-MM-dd HH:mm" />
                </td>
              </tr>
            </c:forEach>

            <tr>
              <td colspan="6">
                <ul class="pagination justify-content-center m-0">
                  <li class="page-item">
                    <i class="page-link bi bi-chevron-double-left" onclick="javascript:location.href='/board/showAll/1'"></i>
                  </li> 
                  <c:if test="${ curPage > 5 }">
                    <li class="page-item">
                      <i class="page-link bi bi-chevron-left" onclick="javascript:location.href='/board/showAll/${ curPage - 5 }'"></i>
                    </li>
                  </c:if>

                  <c:forEach var="page" begin="${ startPage }" end="${ endPage }">
                    <c:choose>
                      <c:when test="${ page eq curPage}">
                        <li class="page-item">
                          <span class="page-link active">${ page }</span>
                        </li>
                      </c:when>
                      <c:otherwise>
                        <li class="page-item">
                          <a class="page-link" href="/board/showAll/${ page }">${ page }</a>
                        </li>
                      </c:otherwise>
                    </c:choose>
                  </c:forEach>

                  <c:if test="${ curPage < maxPage - 5 }">
                    <li class="page-item">
                      <i class="page-link bi bi-chevron-right" onclick="javascript:location.href='/board/showAll/${ curPage + 5 }'"></i>
                    </li>
                  </c:if>
                  <li class="page-item">
                    <i class="page-link bi bi-chevron-double-right" onclick="javascript:location.href='/board/showAll/${ maxPage }'"></i>
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