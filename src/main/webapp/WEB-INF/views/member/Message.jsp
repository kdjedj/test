<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>
	<c:if test="${fn:length(message) != 0}">
		<script>
			alert("${message}");
		</script>
	</c:if>
	<c:if test="${fn:length(href) != 0}">
		<c:choose>
			<c:when test="${href eq 'back'}">
				<script>
					history.back();
				</script>
			</c:when>
			<c:otherwise>
				<script>
					location.href = '${href}';
				</script>
			</c:otherwise>
		</c:choose>
	</c:if>
</body>
</html>