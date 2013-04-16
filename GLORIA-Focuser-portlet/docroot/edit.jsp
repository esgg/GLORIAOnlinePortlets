<%@ include file="/jsp/init.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<portlet:actionURL name="settingsForm" var="focuserForm">
	<portlet:param name="jspPage" value="/edit.jsp"/>
</portlet:actionURL>

<html>
<head>
<title>Focuser Control</title>
</head>

<body>

<form class="aui-layout-content aui-form" 
		id="<portlet:namespace />FocuserControlForm" 
		name="<portlet:namespace />FocuserControlForm" 
		action="<%=focuserForm %>" 
		method="post" 
		> 

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
</body>