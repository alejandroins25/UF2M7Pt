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

		<spring:hasBindErrors name="order">
			<div class="alert alert-danger alert-dismissible">
				<a
					href="#"
					class="close"
					data-dismiss="alert"
					aria-label="close">×</a>
				<c:forEach items="${errors.allErrors}" var="error">
					<c:if test="${fn:contains(error.field, 'deliveryAddress')}">
						<p>
							<c:set
								var="field"
								value="${fn:replace(error.field, 'deliveryAddress.', '')}"/>
							<strong> ${fn:toUpperCase(fn:substring(field, 0, 1))}${fn:substring(field, 1, fn:length(field))}:
							</strong> ${error.defaultMessage}
						</p>
					</c:if>
				</c:forEach>
			</div>
		</spring:hasBindErrors>

		<div class="row">
			<form:form
				modelAttribute="order"
				cssClass="form-horizontal"
			>
				<form:errors path="deliveryAddress.zipCode"></form:errors>
				<fieldset>
					<div class="col-md-12">

						<div class="panel panel-default">
							<div class="panel-heading">
								<h4>
									<span class="glyphicon glyphicon-th-large"></span>
									<spring:message code="finishOrder.order" />
								</h4>
							</div>
							<div class="panel-body">
								<div class="row">
									<div class="col-md-5">
										<h5>
											<span class="glyphicon glyphicon-user"></span>
											<spring:message code="finishOrder.client.data" />
										</h5>
										<div class="form-group">
											<label
												class="col-sm-3 control-label"
												for="firstName"
											> <spring:message code="finishOrder.first.name" />
											</label>
											<div class="col-sm-8">
												<p class="form-control-static">${order.client.firstName }</p>
											</div>
										</div>
										<div class="form-group">
											<label
												class="col-sm-3 control-label"
												for="lastName"
											> <spring:message code="finishOrder.last.name" />
											</label>
											<div class="col-sm-8">
												<p class="form-control-static">${order.client.lastName }</p>
											</div>
										</div>
										<h5>
											<span class="glyphicon glyphicon-envelope"></span>
											<spring:message code="finishOrder.shipment.data" />
										</h5>
										<div class="form-group">
											<div class="form-group">
												<label
													for="deliveryAddress.recipientName"
													class="col-sm-3 control-label"
												> <spring:message code="finishOrder.recipient" />
												</label>
												<div class="col-sm-8">
												<spring:message
														code="finishOrder.recipient.placeholder" var="recipientPlaceholder"/>
													<form:input
														id="recipientName" path="deliveryAddress.recipientName" cssClass="form-control" 
														cssErrorClass="form-control form-control-error" placeholder='${recipientPlaceholder}'/>
												</div>
											</div>
											<div class="form-group">
												<form:label
													for="address" path="deliveryAddress.address"
													cssClass="col-sm-3 control-label" cssErrorClass="col-sm-3 control-label control-label-error">
													<spring:message code="finishOrder.address" />
												</form:label>
												<div class="col-sm-8">
													<spring:message
														code="finishOrder.address.placeholder" var="addressPlaceholder"/>
													<form:input
														id="address" cssClass="form-control" cssErrorClass="form-control form-control-error"
														path="deliveryAddress.address" placeholder='${addressPlaceholder}'/>
												</div>
											</div>
											<div class="form-group">
												<form:label
													for="zipCode" path="deliveryAddress.zipCode"
													cssClass="col-sm-3 control-label" cssErrorClass="col-sm-3 control-label control-label-error">
													<spring:message code="finishOrder.zip.code" />
												</form:label>
												<div class="col-sm-8">
													<spring:message
														code="finishOrder.zip.code.placeholder" var="zipCodePlaceholder"/>
													<form:input
														id="zipCode" cssClass="form-control" cssErrorClass="form-control form-control-error"
														path="deliveryAddress.zipCode" placeholder='${zipCodePlaceholder}'
													/>
												</div>
											</div>
											<div class="form-group">
												<form:label
													for="city" path="deliveryAddress.city"
													cssClass="col-sm-3 control-label" cssErrorClass="col-sm-3 control-label control-label-error">
													<spring:message code="finishOrder.city" />
												</form:label>
												<div class="col-sm-8">
													<spring:message
														code="finishOrder.city.placeholder" var="cityPlaceholder"/>
													<form:input
														id="city" cssClass="form-control" cssErrorClass="form-control form-control-error" 
														path="deliveryAddress.city" placeholder='${cityPlaceholder}'/>
												</div>
											</div>
											<div class="form-group">
												<form:label
													for="state" path="deliveryAddress.state"
													cssClass="col-sm-3 control-label" cssErrorClass="col-sm-3 control-label control-label-error">
													<spring:message code="finishOrder.state.province" />
												</form:label>
												<div class="col-sm-8">
													<spring:message
														code="finishOrder.state.province.placeholder"
														var="statePlaceholder"
													/>
													<form:input
														id="state"
														cssClass="form-control" cssErrorClass="form-control form-control-error"
														path="deliveryAddress.state" placeholder='${statePlaceholder}'/>
												</div>
											</div>
											<div class="form-group">
												<form:label
													for="country" path="deliveryAddress.country"
													cssClass="col-sm-3 control-label" cssErrorClass="col-sm-3 control-label control-label-error">
													<spring:message code="finishOrder.country" />
												</form:label>
												<div class="col-sm-8">
													<spring:message
														code="finishOrder.country.placeholder" var="countryPlaceholder"/>
													<form:input
														id="country"
														cssClass="form-control" cssErrorClass="form-control form-control-error" 
														path="deliveryAddress.country" placeholder='${countryPlaceholder}'/>
												</div>
											</div>
										</div>
									</div>
									<div class="col-md-7">
										<h5>
											<span class="glyphicon glyphicon-list"></span>
											<spring:message code="finishOrder.items" />
										</h5>
										<div class="table-responsive">
											<table
												class="table table-striped table-bordered table-condensed"
											>
												<thead>
													<tr>
														<th><spring:message code="finishOrder.reference" />
														</th>
														<th><spring:message code="finishOrder.item" /></th>
														<th><spring:message code="finishOrder.price" /></th>
														<th><label for="totalQuantity"> <spring:message
																	code="finishOrder.quantity"
																/>
														</label></th>
														<th><spring:message code="finishOrder.amount" /></th>
													</tr>
												</thead>
												<tbody>
													<c:forEach
														items="${sessionScope.order.items}"
														var="itemMap"
													>
														<c:set
															var="item"
															value="${itemMap.key}"
														/>
														<c:set
															var="cant"
															value="${itemMap.value}"
														/>

														<tr>
															<td>${item.reference }</td>
															<td>${item.name }</td>
															<td>${item.price }<spring:message
																	code="currency.symbol"
																/></td>
															<td>${cant }</td>
															<td><fmt:formatNumber value="${(item.price * cant)}" />
																<spring:message code="currency.symbol" /></td>
														</tr>

													</c:forEach>

													<tr>
														<th colspan="3" style="text-align: right">
														<spring:message code="orders.total" /></th>
														<th><label for="totalQuantity">
																${sessionScope.order.totalQuantity }</label></th>
														<th>${sessionScope.order.totalAmount }€</th>
													</tr>
												</tbody>
											</table>
										</div>
									</div>
								</div>
							</div>
							<div class="panel-footer">
								<button type="submit" id="btnAdd" class="btn btn-default btn-block">
									<span class="glyphicon glyphicon-credit-card"></span>
									<spring:message code="finishOrder.purchase" />
								</button>
							</div>
						</div>
					</div>
				</fieldset>
			</form:form>
		</div>
	</div>
</body>
</html>