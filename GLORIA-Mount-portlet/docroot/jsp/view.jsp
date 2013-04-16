<%@ include file="/jsp/init.jsp" %>

<portlet:resourceURL var="moveRes" id="moveRes">
	<portlet:param name="control" value="move"/>
</portlet:resourceURL>

<portlet:resourceURL var="speedRes" id="speedRes">
	<portlet:param name="control" value="speed"/>
</portlet:resourceURL>
 
<portlet:resourceURL var="setCoordinatesRes" id="setCoordinatesRes">
	<portlet:param name="control" value="setCoordinates"/>
</portlet:resourceURL>

<portlet:resourceURL var="getCoordinatesRes" id="getCoordinatesRes">
	<portlet:param name="control" value="getCoordinates"/>
</portlet:resourceURL>

<portlet:resourceURL var="parkRes" id="parkRes">
	<portlet:param name="control" value="park"/>
</portlet:resourceURL>

<portlet:resourceURL var="objectRes" id="objectRes">
	<portlet:param name="control" value="object"/>
</portlet:resourceURL>

<html>
<head>
<title>mount control</title>
</head>

<body>

<div>

	<%@ include file="/jsp/viewMode/status.jsp" %>

	<div id="container-view-control" class="container-view-control">
		<div class="arrow_control">
			<%@ include file="/jsp/viewMode/controlPanel.jsp" %>
		</div>
			
	</div>
	<div align="center">
		<%@ include file="/jsp/viewMode/gotoButton.jsp"%>
		</div>

</div>

</body>
</html>