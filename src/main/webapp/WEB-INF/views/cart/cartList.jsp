<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Cart List</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css"> 
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
  <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
  <style>
    i {
      cursor: pointer;
    }
    #cart-group {
      cursor: pointer;
    } 
    .bi-plus-square {
      font-size: 26px;
    }
    .bi-dash-square {
      font-size: 26px;
    }
  </style>
</head>
<body>
  <div class="container-fluid">
    <div class="main h-100">
      <h1 class="text-center">${ logIn.username }님의 장바구니</h1>

      <div class="row justify-content-center">
        <div class="col-10 text-center">
          <table class="table table-striped">
            <tr>
              <th>
                <input type="checkbox" id="chkHead" class="form-check-input" checked>
              </th>
              <th>상품 번호</th>
              <th colspan="3">상품명</th>
              <th>수량</th>
              <th>가격</th>
              <th>등록일</th>
            </tr> 

            <c:forEach var="cart" items="${ carts }" varStatus="status">
              <tr>
                <td>
                  <input type="checkbox" class="form-check-input chk">
                </td>
                <td>${ cart.id }</td>
                <td colspan="3" id="cart-group" onclick="javascript:location.href='/products/${ cart.productId }'">
                  ${ cart.productName }
                </td>
                <td>
                  <i class="bi bi-dash-square" onclick="minusQuantity(${ cart.id }, ${ logIn.id }, ${ cart.quantity })"></i>
                  ${ cart.quantity }
                  <i class="bi bi-plus-square" onclick="plusQuantity(${ cart.id }, ${ logIn.id }, ${ cart.quantity }, ${ cart.stock })"></i>
                </td>
                <td>
                  <div id="totalPrice">
                    <span style="font-weight: bold;" data-value="${ cart.totalPrice }">
                      <fmt:formatNumber value="${ cart.totalPrice }" type="number" />
                    </span>
                    <b>원</b>
                  </div>
                </td>
                <td>
                  <fmt:timeZone value="Seoul">
                    <fmt:parseDate value="${ cart.updatedAt }" pattern="yyyy-MM-dd'T'HH:mm:ss" var="updatedAt" type="both" />
                  </fmt:timeZone>
                  <fmt:formatDate value="${ updatedAt }" pattern="yy-MM-dd HH:mm" />
                </td>
              </tr>
            </c:forEach>

            <%-- <c:set var="curPage" value="${ page.number + 1 }" />
            <c:set var="maxPage" value="${ page.totalPages }" />
            <c:set var="startPage" value="${ page.startPage }" />
            <c:set var="endPage" value="${ page.endPage }" /> --%>

            <%-- <tr>
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
            </tr> --%>
          </table>
          <div class="d-flex justify-content-end">
            <p><b>총 가격</b></p>&nbsp;&nbsp;
            <div>
              <c:set var="cartTotalPrice" value="${ carts[0].cartTotalPrice }" />
              <span id="cartTotPrice" style="font-weight: bold;" data-value="${ cartTotalPrice }">
                <fmt:formatNumber value="${ cartTotalPrice }" type="number" />
              </span>
              <b>원</b>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>

  <script>
    const init = function() {
      const checkboxes = document.querySelectorAll('.chk');
      for (const checkbox of checkboxes) {
        checkbox.checked = true;
      }
    };

    window.onload = function() {
      init();
    };

    const chkHead = document.querySelector('#chkHead');
    chkHead.addEventListener('click', function() {
      const isChecked = chkHead.checked;
      const checkboxes = document.querySelectorAll('.chk');

      if (isChecked) {
        for (const checkbox of checkboxes) {
          checkbox.checked = true;
        }
        $('#cartTotPrice').attr('data-value', ${ cartTotalPrice });
        $('#cartTotPrice')[0].textContent = Number(${ cartTotalPrice }).toLocaleString('ko-KR');
      } else {
        for (const checkbox of checkboxes) {
          checkbox.checked = false;
        }
        $('#cartTotPrice').attr('data-value', 0);
        $('#cartTotPrice')[0].textContent = '0';
      }
    });

    const checkboxes = document.querySelectorAll('.chk');
    for (const checkbox of checkboxes) {
      checkbox.addEventListener('click', function(event) {
        const totalCnt = checkboxes.length;
        const checkedCnt = document.querySelectorAll('.chk:checked').length;
        if (totalCnt == checkedCnt) {
          document.querySelector('#chkHead').checked = true;
        } else {
          document.querySelector('#chkHead').checked = false;
        }

        const row = $(event.target).closest('tr');
        const columns = row.find('td');
        const totalPrice = Number($(columns.find('span')[0]).attr('data-value'));

        let cartTotalAmount = Number($('#cartTotPrice').attr('data-value'));
        const isChecked = checkbox.checked;
        if (isChecked) {
          cartTotalAmount += totalPrice;
        } else {
          cartTotalAmount -= totalPrice;
        }

        $('#cartTotPrice').attr('data-value', cartTotalAmount);
        $('#cartTotPrice')[0].textContent = cartTotalAmount.toLocaleString('ko-KR');
       });
    }

    function plusQuantity(id, userId, quantity, stock) {
      if (quantity >= stock) {
        alert('수량이 최대입니다.');
        return;
      }

      $.ajax({
        url: '/carts/plus/quantity/' + id,
        type: 'get',
      }).done((res) => {
        if (res.result === 'success') {
          location.href = '/carts/' + userId;
        }
      }).fail((xhr, textStatus, errorThrown) => {
        console.log(textStatus);
      });
    }

    function minusQuantity(id, userId, quantity) {
      if (quantity == 1) {
        alert('수량은 최소 1개입니다.');
        return;
      }

      $.ajax({
        url: '/carts/minus/quantity/' + id,
        type: 'get',
      }).done((res) => {
        if (res.result === 'success') {
          location.href = '/carts/' + userId;
        }
      }).fail((xhr, textStatus, errorThrown) => {
        console.log(textStatus);
      });
    }
  </script>
</body>
</html>