<%@ include file="/jsp/mount/constants.jsp" %>

<table 
	<% if (!showRaDecPanel.equalsIgnoreCase("1")) {%> style="display:none" <%}%>
	>
	<tr>
		<td>
			<label class="aui-field-label raLabel" for="raWrapper"> <liferay-ui:message key="label-ra"/>: </label> 
		</td>
		<td></td>
		<td>
			<aui:select name="raHSelect" id="raHSelect" label=""  inlineField="true" suffix="label-hour">
			<%
				for(int i=0; i <= hours; i++) {
			%>
					<aui:option label="<%=i%>" value="<%= i%>" />
			<%}%>
			</aui:select>
		</td>
		<td>
			<aui:select name="raMinSelect" id="raMinSelect" label="" inlineField="true" suffix="label-minute">
			<%
				for(int i=0; i <= minutes; i++) {
			%>
					<aui:option label="<%=i%>" value="<%= i%>" />
			<%}%>
			</aui:select>
		</td>
		<td>
			<aui:select name="raSecSelect" id="raSecSelect" label="" inlineField="true" suffix="label-second">
			<%
				for(int i=0; i <= seconds; i++) {
			%>
					<aui:option label="<%=i%>" value="<%= i%>" />
			<%}%>
			</aui:select>
		</td>
	</tr>
	<tr>
		<td>
			<label class="aui-field-label decLabel" for="decWrapper"> <liferay-ui:message key="label-dec"/>: </label> 
		</td>
		<td>
			<aui:select name="symbolSelect" id="symbolSelect" label=""  inlineField="true">
				<aui:option label="+" value="+" />
				<aui:option label="-" value="-" />
			</aui:select>	
		</td>
		<td>
			<aui:select name="decDegressSelect" id="decDegressSelect" label=""  inlineField="true" suffix="label-degrees">
			<%
				for(int i=0; i <= degress; i++) {
			%>
					<aui:option label="<%=i%>" value="<%= i%>" />
			<%}%>
			</aui:select>
		</td>
		<td>
			<aui:select name="decMinSelect" id="decMinSelect" label="" inlineField="true" suffix="label-minute2">
			<%
				for(int i=0; i <= minutes; i++) {
			%>
					<aui:option label="<%=i%>" value="<%= i%>" />
			<%}%>
			</aui:select>			
		</td>
		<td>
			<aui:select name="decSecSelect" id="decSecSelect" label="" inlineField="true" suffix="label-second2">
			<%
				for(int i=0; i <= seconds; i++) {
			%>
					<aui:option label="<%=i%>" value="<%= i%>" />
			<%}%>
			</aui:select>
		</td>
	</tr>
</table>
<div id="epoch" 
	<% if (!showEpochPanel.equalsIgnoreCase("1")) {%> style="display:none" <%}%>
	>
	<label class="eraLabel" for="eraWrapper"> <liferay-ui:message key="label-era"/>: </label>
	<span>
		<input class="" 
			id="<portlet:namespace />radio1a" 
			name="<portlet:namespace />radioEpoch" 
			type="radio" 
			value="Current" 
			<% if (!prefsEpoch.equals("J2000")) { %>checked="checked" <% } %>
			>
		<label class="" for="<portlet:namespace />radio1a"> <liferay-ui:message key="radio-actual"/> </label>
	</span>
	<span>
		<input class="" 
			id="<portlet:namespace />radio2a" 
			name="<portlet:namespace />radioEpoch" 
			type="radio" 
			value="J2000" 
			<% if (prefsEpoch.equals("J2000")) { %>checked="checked" <% } %>
		>
		<label class="" for="<portlet:namespace />radio2a"> J2000 </label>
	</span>
</div>
