<%@ include file="/init.jsp" %>
<%@ include file="/jsp/constants.jsp" %>

<aui:form action="<%= coordinates.toString() %>" name="coordinatesForm" method="post">
	<fieldset class="aui-fieldset"> 
		<div class="aui-fieldset-content"> 
			<div class="aui-field aui-field-wrapper aui-field-inline "> 
				<label class="aui-field-label raLabel" for="raWrapper"> <liferay-ui:message key="label-ra"/>: </label> 
				<aui:select name="raHSelect" id="raHSelect" label=""  inlineField="true" suffix="label-hour">
					<%
						for(int i=0; i <= hours; i++) {
					%>
							<aui:option label="<%=i%>" value="<%= i%>" />
					<%}%>
				</aui:select>
				<aui:select name="raMinSelect" id="raMinSelect" label="" inlineField="true" suffix="label-minute">
					<%
						for(int i=0; i <= minutes; i++) {
					%>
							<aui:option label="<%=i%>" value="<%= i%>" />
					<%}%>
				</aui:select>
				<aui:select name="raSecSelect" id="raSecSelect" label="" inlineField="true" suffix="label-second">
					<%
						for(int i=0; i <= seconds; i++) {
					%>
							<aui:option label="<%=i%>" value="<%= i%>" />
					<%}%>
				</aui:select>
			</div> 
		</div>
	</fieldset>
	<fieldset class="aui-fieldset"> 
		<div class="aui-fieldset-content"> 
			<div class="aui-field aui-field-wrapper aui-field-inline"> 
				<label class="aui-field-label decLabel" for="decWrapper"> <liferay-ui:message key="label-dec"/>: </label> 
				<aui:select name="symbolSelect" id="symbolSelect" label=""  inlineField="true">
					<aui:option label="+" value="+" />
					<aui:option label="-" value="-" />
				</aui:select>
				<aui:select name="decDegressSelect" id="decDegressSelect" label=""  inlineField="true" suffix="label-degrees">
					<%
						for(int i=0; i <= degress; i++) {
					%>
							<aui:option label="<%=i%>" value="<%= i%>" />
					<%}%>
				</aui:select>
				<aui:select name="decMinSelect" id="decMinSelect" label="" inlineField="true" suffix="label-minute2">
					<%
						for(int i=0; i <= minutes; i++) {
					%>
							<aui:option label="<%=i%>" value="<%= i%>" />
					<%}%>
				</aui:select>
				<aui:select name="decSecSelect" id="decSecSelect" label="" inlineField="true" suffix="label-second2">
					<%
						for(int i=0; i <= seconds; i++) {
					%>
							<aui:option label="<%=i%>" value="<%= i%>" />
					<%}%>
				</aui:select>
			</div> 
		</div>
	</fieldset>
</aui:form>