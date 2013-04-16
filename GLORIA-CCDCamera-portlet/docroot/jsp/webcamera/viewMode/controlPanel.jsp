<% 
Boolean showsValues = checkboxBrightness.equalsIgnoreCase("1") || checkboxGain.equalsIgnoreCase("1") ||
					  checkboxExposure.equalsIgnoreCase("1")  ||  checkboxCont.equalsIgnoreCase("1"); 

if (showsValues || checkboxTake.equalsIgnoreCase("1")) {
%>

<fieldset Class="coordField">
	<legend><span><liferay-ui:message key="legend-control-panel"/></span></legend>
	<%@ include file="/jsp/webcamera/viewMode/slidesWebcam.jsp" %>
	
	<table>
		<tr>
			<td>
		<% if (showsValues) {%>
			<%@ include file="/jsp/webcamera/viewMode/getSetButtons.jsp" %>
		<% } %>
			</td><td>
		<% if (checkboxTake.equalsIgnoreCase("1")) {%>
			<%@ include file="/jsp/webcamera/viewMode/takeButton.jsp" %>
		<% } %>
			</td>
		</tr>
	</table>
</fieldset>
<% } %>