<%@ include file="/jsp/webcamera/init.jsp" %>

<portlet:resourceURL var="setValues" id="setValues">
	<portlet:param name="control" value="setValues"/>
</portlet:resourceURL>

<portlet:resourceURL var="getValues" id="getValues">
	<portlet:param name="control" value="getValues"/>
</portlet:resourceURL>

<portlet:resourceURL id="popup" var="popup">
	<portlet:param name="control" value="popup"/>
</portlet:resourceURL>

<html> 
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/> 
</head>
<body>

<div id="<portlet:namespace />ccdPanel">
	<ul id="listnode">
	    <li><a href="#tab_widefield"><liferay-ui:message key='tab-widefield' /></a></li>
	    <li><a href="#tab_seeker"><liferay-ui:message key='tab-seeker' /></a></li>
	</ul>
	<div id="content">
		<div id="tab_widefield">
			<%@ include file="/jsp/webcamera/viewMode/widefield_image.jsp" %>
		</div>
		<div id="tab_seeker">
			<%@ include file="/jsp/webcamera/viewMode/imageWebcam.jsp" %>
			<%@ include file="/jsp/webcamera/viewMode/statusPanel.jsp" %>
			<%@ include file="/jsp/webcamera/viewMode/controlPanel.jsp" %>
		</div>
	</div>
</div>

</body>
<script>
YUI({filter:'raw'}).use("yui", "tabview", function(Y) {    
	var tabview = new Y.TabView({
		srcNode:'#<portlet:namespace />ccdPanel'
	});    
	tabview.render();
});
</script>
</html>