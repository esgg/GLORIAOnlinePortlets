<%@ include file="/jsp/init.jsp" %>

<portlet:actionURL name="settingsForm" var="mountForm">
	<portlet:param name="jspPage" value="/edit.jsp"/>
</portlet:actionURL>

<portlet:resourceURL var="getTelescRes">
	<portlet:param name="control" value="edit"/>
</portlet:resourceURL>

<liferay-ui:success key="success" message="msg-success" />
<liferay-ui:error key="not-save"  message="msg-error-not-save" />
<liferay-ui:error key="not-observatory"  message="msg-error-not-observatory" />
<liferay-ui:error key="not-telescope"  message="msg-error-not-telescope" />
<liferay-ui:error key="not-mount"  message="msg-error-not-mount" />


<html>
<head>
<title>mount control</title>
</head>

<body>

<div id="container_edit-control">
	<form class="aui-layout-content aui-form" 
			id="<portlet:namespace />TeleControlForm" 
			name="<portlet:namespace />TeleControlForm" 
			action="<%=mountForm %>" 
			method="post">
		
		<%@ include file="/jsp/editMode/showControls.jsp" %>
		
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