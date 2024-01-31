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

		<form action="/orders/login" method="post">
			<div class="row">
				<div class="col-md-4 col-md-offset-4">
					<div class="panel panel-default">
						<div class="panel-heading">
							<h4 class="panel-title">
								<spring:message code="login.give.credentials"/>
							</h4>
						</div>

						<div class="panel-body">
							
							<div class="input-group">
								<span class="input-group-addon"><i
									class="glyphicon glyphicon-user"></i></span> <input class="form-control"
									placeholder='<spring:message code="login.username"/>' name='username'
									type="text">
							</div>
							<div class="input-group">
								<span class="input-group-addon"><i
									class="glyphicon glyphicon-lock"></i></span> <input class="form-control"
									placeholder="<spring:message code="login.password"/>" name='password'
									type="password">
							</div>
						</div>
						<div class="panel-footer">
							<input class="btn btn-default btn-block" type="submit"
								value="<spring:message code="login.login"/>">
						</div>
					</div>
				</div>
			</div>
		</form>
	</div>
</body>
</html>