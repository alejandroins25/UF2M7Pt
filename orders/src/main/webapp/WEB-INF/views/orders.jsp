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
		<%-- TODO if user has ROLE_ADMIN -> Show all orders of all users and let change state and delivery date --%>
		<sec:authorize access="hasRole('ROLE_ADMIN')">
        </sec:authorize>
		<%-- TODO if user has ROLE_USER -> Show all orders of the user --%>
		<sec:authorize access="hasRole('ROLE_USER')">
        </sec:authorize>
	</div>
</body>
</html>
