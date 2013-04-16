<%--
<jsp:useBean id="deviceObject" scope="request" class="eu.gloria.website.liferay.portlets.experiment.online.objects.DevicesObject"/>
--%>

<div class="aui-field-inline"
	<% if (!showModePanel.equalsIgnoreCase("1")) {%> style="display:none; margin:-2px;" <%}%>
> 
	<label class="aui-field-label modelabel"> <liferay-ui:message key="label-mode"/>: </label>
	<aui:select name="modeSelect" id="modeSelect" label=""  inlineField="true">
		<aui:option label="label-none" value="-1" />
		
		<% try { %> 
			<jsp:useBean id="deviceObject" scope="request" class="eu.gloria.website.liferay.portlets.experiment.online.objects.DevicesObject"/>
		<%
			for (String name : deviceObject.getModeList()) {
				String labelName= "option-"+name;
		%>
			<aui:option label="<%=name%>"
					value="<%=name%>"  
					selected="<%= name.equalsIgnoreCase(prefsMode) %>" 
			/>
			<%} %>
		<% } catch (Exception e) { 	%>
		<% } %>				

	</aui:select>
</div>	