<fieldset Class="coordField">
	<legend><span><liferay-ui:message key="legend-pointer"/></span></legend>
	<%@ include file="/jsp/mount/viewMode/coordinatesTable.jsp" %>
	
	<% if (showObjectPanel.equalsIgnoreCase("1")) {%> 
		<%@ include file="/jsp/mount/viewMode/objectPointer.jsp" %>
	<%}%>
	
	<%@ include file="/jsp/mount/viewMode/modePointer.jsp" %>
	
	<%@ include file="/jsp/mount/viewMode/buttonsPanel.jsp" %>
</fieldset>