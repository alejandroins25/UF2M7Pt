<%@ page contentType="text/html" pageEncoding="UTF-8"%>

<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%><%@ taglib
	prefix="fn" uri="jakarta.tags.functions"%>

<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="sections/head.jsp" />
</head>
<body>
	<div class="container">
		<jsp:include page="sections/header.jsp" />

		<%-- TODO new order view. Show a list of the items in the order passed as param and a list of available items passed as param --%>
		<div class="row">
			<div class="col-md-6">
				<div class="panel panel-default">
					<div class="panel-heading">
						<h4>
							<span class="glyphicon glyphicon-shopping-cart"></span>
							<spring:message code="newOrder.selected.items" />
							<a href="/orders/users/orders/newOrder/clearItems"
								class="btn btn-default btn-sm"> <span
								class="glyphicon glyphicon-remove"></span> <spring:message
									code="newOrder.clear" />
							</a>
						</h4>
					</div>
					<div class="panel-body">
						<c:forEach items="${sessionScope.order.items}" var="itemMap">
							<c:set var="item" value="${itemMap.key}" />
							<c:set var="cant" value="${itemMap.value}" />
							<div class="media">
								<div class="media-left media-top">
									<img src="/orders/images/${item.image}" class="media-object" style="width: 60px">
								</div>
								<div class="media-body">
									<h4 class="media-heading">
										${item.name } 
										<small> ${cant } x cantidad = <fmt:formatNumber
												value="${(item.price * cant)}" />
												<spring:message code="currency.symbol" />
										</small>
									</h4>
									<p>${item.description }</p>
								</div>
								<div class="media-right media-top">
									<a
										href="/orders/users/orders/newOrder/increaseItem?reference=${item.reference}">
										<span class="glyphicon glyphicon-plus-sign"></span>
									</a> <a
										href="/orders/users/orders/newOrder/decreaseItem?reference=${item.reference}">
										<span class="glyphicon glyphicon-minus-sign"></span>
									</a>
								</div>
							</div>
						</c:forEach>
					</div>
					<div class="panel-footer">
						<c:if test="${!empty sessionScope.order.items}">
							<a href="/orders/users/orders/newOrder/finishOrder" class="btn btn-default btn-block">
								<span class="glyphicon glyphicon-th-large"></span>
								Finish Order
							</a>
						</c:if>
					</div>
				</div>
			</div>
			<div class="col-md-6">
				<div class="panel panel-default">
					<div class="panel-heading">
						<h4>
							<span class="glyphicon glyphicon-list"></span>
							<spring:message code="newOrder.items" />
						</h4>
					</div>
					<div class="panel-body">

						<c:forEach items="${items}" var="item">

							<div class="media">
								<div class="media-left media-top">
									<img src="/orders/images/${item.image }" class="media-object"
										style="width: 60px">
								</div>
								<div class="media-body">
									<h4 class="media-heading">
										${item.name } <small> ${item.price } <spring:message
												code="currency.symbol" />
										</small>
									</h4>
									<p>${item.description }</p>
								</div>
								<div class="media-right media-top">
									<a
										href="/orders/users/orders/newOrder/increaseItem?reference=${item.reference }">
										<span class="glyphicon glyphicon-plus-sign"></span>
									</a>
								</div>
							</div>
						</c:forEach>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
