<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="sections/head.jsp" />
</head>
<body>
	<div class="container">
		<jsp:include page="sections/header.jsp" />
		<%-- TODO if user has ADMIN -> Show all orders of all users and let change state and delivery date --%>
		<sec:authorize access="hasRole('ADMIN')">
			<table
				class="table table-striped table-bordered table-condensed table-responsive small">
				<thead>
					<tr>
						<th><spring:message code="orders.client" /></th>
						<th><spring:message code="orders.reference" /></th>
						<th><spring:message code="orders.deliveryAddress" /></th>
						<th><spring:message code="orders.startDate" /></th>
						<th><spring:message code="orders.state" /></th>
						<th><spring:message code="orders.deliveryDate" /></th>
						<th><spring:message code="orders.details" /></th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="order" items="${orders}">
						<tr>
							<td><c:set var="ref" value="0" scope="page"/> 
							<c:forEach var="i" begin="1" end="${8 - fn:length(order.reference.toString())}">
								<c:set var="ref" value="${ref}0" scope="page"/>
								</c:forEach> 
								<c:set var="ref" value="${ref}${order.reference }" scope="page" /> ${ref}</td>

							<td>${order.client.firstName}<br />
								${order.client.lastName}
							</td>
							<td>${order.deliveryAddress.address}<br />
								${order.deliveryAddress.zipCode} ${order.deliveryAddress.city}<br />
								${order.deliveryAddress.state}<br />
								${fn:toUpperCase(order.deliveryAddress.country)}
							</td>
							<td><fmt:formatDate pattern="dd MMM. yyyy" value="${order.startDate}"/></td>
							<td><form action="/orders/admin/orders/setState" method="POST">
									<div class="form-group">
										<select name="state" class="form-control input-sm" onchange="$(this).closest('form').submit();">
											<option value="0" selected="selected">Pending shipping</option>

											<option value="1">In transit</option>

											<option value="2">Delivery</option>

											<option value="3">Recipient absent</option>

											<option value="4">Pending collection</option>

											<option value="5">Returned</option>

										</select>
									</div>
									<input type="hidden" name="reference" value="1"/>
								</form></td>

							<td><form action="/orders/admin/orders/setDeliveryDate" method="POST">
									<div class="form-group ">

										<input type="date" name="deliveryDate" class="form-control input-sm" value="" 
											min="Thu Jan 12 17:42:45 CET 2023"
											onchange="$(this).closest('form').submit();"/> 
										<input type="hidden" name="reference" value="1"/>
									</div>
								</form></td>
							<td>
								<div class="table-responsive">
									<table class="table table-bordered table-condensed">
										<thead>
											<tr>
												<th><spring:message code="orders.reference"/></th>
												<th><spring:message code="orders.item"/></th>
												<th><spring:message code="orders.price"/></th>
												<th><spring:message code="orders.quantity"/></th>
												<th><spring:message code="orders.amount"/></th>
											</tr>
										</thead>
										<tbody>
											<c:forEach items="${order.items}" var="itemMap">
												<c:set var="item" value="${itemMap.key}"/>
												<c:set var="cant" value="${itemMap.value}"/>
												<tr>
													<td>${item.reference }</td>
													<td>${item.name }</td>
													<td>${item.price }<spring:message code="currency.symbol"/></td>
													<td>${cant}</td>
													<td><fmt:formatNumber value="${(item.price * cant)}" />
														<spring:message code="currency.symbol" /></td>
												</tr>

											</c:forEach>
											<tr>
												<th colspan="3" style="text-align: right">
												<spring:message code="orders.total" /></th>
												<th>${order.totalQuantity }</th>
												<th>${order.totalAmount }<spring:message code="currency.symbol"/></th>
											</tr>
										</tbody>
									</table>
								</div>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</sec:authorize>
		<%-- TODO if user has USER -> Show all orders of the user --%>
		<sec:authorize access="hasRole('USER')">
			<table
				class="table table-striped table-bordered table-condensed table-responsive small">
				<thead>
					<tr>
						<th><spring:message code="orders.client" /></th>
						<th><spring:message code="orders.reference" /></th>
						<th><spring:message code="orders.deliveryAddress" /></th>
						<th><spring:message code="orders.startDate" /></th>
						<th><spring:message code="orders.state" /></th>
						<th><spring:message code="orders.deliveryDate" /></th>
						<th><spring:message code="orders.details" /></th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${userOrders}" var="order">
						<tr>
							<td><c:set var="ref" value="0" scope="page"/> 
								<c:forEach var="i" begin="1" end="${8 - fn:length(order.reference.toString())}">
									<c:set var="ref" value="${ref}0" scope="page"/>
								</c:forEach> <c:set var="ref" value="${ref}${order.reference }" scope="page"/> ${ref}</td>
							<td>${order.client.firstName}<br />
								${order.client.lastName}
							</td>
							<td>${order.deliveryAddress.address}<br />
								${order.deliveryAddress.zipCode} ${order.deliveryAddress.city}<br />
								${order.deliveryAddress.state}<br />
								${fn:toUpperCase(order.deliveryAddress.country)}
							</td>
							<td><fmt:formatDate
									pattern="dd MMM. yyyy"
									value="${order.startDate}"
								/></td>

							<td><spring:message code="${orderStates[order.state]}" /></td>
							<td><fmt:formatDate pattern="dd MMM. yyyy" value="${order.deliveryDate}"/></td>
							<td>
								<div class="table-responsive">
									<table class="table table-bordered table-condensed ">
										<thead>
											<tr>
												<th><spring:message code="orders.reference" /></th>
												<th><spring:message code="orders.item" /></th>
												<th><spring:message code="orders.price" /></th>
												<th><spring:message code="orders.quantity" /></th>
												<th><spring:message code="orders.amount" /></th>
											</tr>
										</thead>
										<tbody>
											<c:forEach items="${order.items}" var="itemMap">
												<c:set var="item" value="${itemMap.key}"/>
												<c:set var="cant" value="${itemMap.value}"/>
												<tr>
													<td>${item.reference }</td>
													<td>${item.name }</td>
													<td>${item.price }<spring:message code="currency.symbol"/></td>
													<td>${cant }</td>
													<td><fmt:formatNumber value="${(item.price * cant)}" />
														<spring:message code="currency.symbol" /></td>
												</tr>

											</c:forEach>
											<tr>
												<th colspan="3" style="text-align: right">
													<spring:message code="orders.total" /></th>
												<th>${order.totalQuantity }</th>
												<th>${order.totalAmount }<spring:message code="currency.symbol"/></th>
											</tr>
										</tbody>
									</table>
								</div>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</sec:authorize>
	</div>
</body>
</html>
