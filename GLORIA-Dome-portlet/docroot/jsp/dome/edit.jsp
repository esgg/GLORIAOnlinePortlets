<%@ include file="/jsp/dome/init.jsp" %>

<portlet:actionURL name="saveSettings" var="domeForm">
	<portlet:param name="jspPage" value="/edit.jsp"/>
</portlet:actionURL>

<liferay-ui:success key="success" message="msg-success" />
<liferay-ui:error key="not-save"  message="msg-error-not-save" />
<liferay-ui:error key="not-observatory"  message="msg-error-not-observatory" />
<liferay-ui:error key="not-telescope"  message="msg-error-not-telescope" />
<liferay-ui:error key="not-dome"  message="msg-error-not-dome" />

<html>
<head>
<title>Dome control</title>
</head>
<body>
<div id="container_edit-control">
	<form class="aui-layout-content aui-form" 
			id="<portlet:namespace />TeleControlForm" 
			name="<portlet:namespace />TeleControlForm" 
			action="<%=domeForm %>" 
			method="post">

<!-- SHOW CONTROLS -->			
	<div class="aui-fieldset aui-w100 aui-column aui-field-labels-inline"> 
	<div class="aui-fieldset-bd aui-widget-bd"> 

		<!-- BUTTON PANEL -->
		<span class="aui-field aui-field-nested aui-field-last">
			<span class="aui-field-content">
				<label class="aui-field-label" for="textField"> 
					<liferay-ui:message key='checkbox-panel-control' />: 
					</label>
					<input <% if (showControlPanel.compareToIgnoreCase("1") == 0) {%> checked="true" <%}%> 
						   class="aui-field-input aui-field-input-choice aui-field-input-checkbox" 
						   id="<portlet:namespace />checkboxControlPanel" 
						   name="checkboxControlPanel" 
						   type="checkbox" 
						   value="<%= showControlPanel %>"
						   onChange="<portlet:namespace />showControlPanel()"
						   >
			</span>
		</span>

		<span id="<portlet:namespace />controlSpan">
			<!-- CONTROL PANEL -->
			<!-- OPEN BUTTON -->
			<span class="aui-field aui-field-nested aui-field-last"
				id="<portlet:namespace />openButtonSpan">
				<span class="aui-field-content">
					<label class="next-level" for="textField"> 
						<liferay-ui:message key='checkbox-button-open' />: 
						</label>
						<input <% if (showOpenButton.compareToIgnoreCase("1") == 0) {%> checked="true" <%}%> 
							   class="aui-field-input aui-field-input-choice aui-field-input-checkbox up-level" 
							   id="checkboxOpenButton" 
							   name="checkboxOpenButton" 
							   type="checkbox" 
							   value="<%= showOpenButton %>">
				</span>
			</span>
			
			<!-- CONTROL PANEL -->
			<!-- CLOSE BUTTON -->
			<span class="aui-field aui-field-nested aui-field-last"
				id="<portlet:namespace />closeButtonSpan">
				<span class="aui-field-content">
					<label class="next-level" for="textField"> 
						<liferay-ui:message key='checkbox-button-close' />: 
						</label>
						<input <% if (showCloseButton.compareToIgnoreCase("1") == 0) {%> checked="true" <%}%> 
							   class="aui-field-input aui-field-input-choice aui-field-input-checkbox up-level" 
							   id="checkboxCloseButton" 
							   name="checkboxCloseButton" 
							   type="checkbox" 
							   value="<%= showCloseButton %>">
				</span>
			</span>
		</span>
	</div>
</div>
<!-- END SHOW CONTROLS -->	

		<!-- RESERVATION FIELD -->
		<span class="aui-field aui-field-nested aui-field-last">
			<span class="aui-field-content">
				<label class="aui-field-label" for="textField"> 
					<liferay-ui:message key='label-reservation' />: 
					</label>
					<input id="<portlet:namespace />reservationId" 
						   name="reservationId" 
						   size="4">
			</span>
		</span>

		<div class="aui-fieldset aui-w100 aui-column aui-field-labels-inline">
			<span class="aui-button-row aui-helper-clearfix"> 
				<span class="aui-button aui-button-submit aui-state-positive aui-priority-primary"> 
					<span class="aui-button-content"> 
						<input class="aui-button-input aui-button-input-submit" 
								type="submit" 
								value="<liferay-ui:message key='button-save' />"> 
					</span> 
				</span>  
			</span> 
		</div>
	</form> 
</div>
</body>
</html>