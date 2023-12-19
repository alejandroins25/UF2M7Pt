<%@ page contentType="text/html" pageEncoding="UTF-8"%>

<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>
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
		<%-- TODO Login form here --%>

		<form action="<c:url value= "/login"/>" method="post">
	
			<h5 class="card-title">Please, enter your credentials</h5>
			<c:if test="${not empty error}">
				<span>The given credentials are wrong</span>
				<button type="button" data-bs-dismiss="alert"></button>
			</c:if>
			<input placeholder="Username" name="username" type="text">
			<input placeholder="Password" name="password" type="password">
			<input type="submit" value="Login">
		</form>
	</div>
</body>
</html>