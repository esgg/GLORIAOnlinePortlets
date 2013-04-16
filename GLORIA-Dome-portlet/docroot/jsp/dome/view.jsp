<%@ include file="/jsp/dome/init.jsp" %>

<portlet:resourceURL var="operationDomeRes" id="operationDomeRes">
	<portlet:param name="control" value="operation"/>
</portlet:resourceURL>

<html>
<head>
<title>dome control</title>
</head>
<body>
<% if (configured.equalsIgnoreCase("false") || configured==null) { %>
		<liferay-ui:message key='msg-config' />
<% } else { %>
<div>
	<% if (showControlPanel.equalsIgnoreCase("1")) {%>
		<%@ include file="/jsp/dome/viewMode/status.jsp" %>
		<%@ include file="/jsp/dome/viewMode/controlPanel.jsp" %>
	<%}%>
</div>
<% } %>
</body>
</html>