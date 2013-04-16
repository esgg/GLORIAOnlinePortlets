<%@ include file="/jsp/init.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<portlet:actionURL name="settingsForm" var="surveillanceForm">
	<portlet:param name="jspPage" value="/edit.jsp"/>
</portlet:actionURL>

<liferay-ui:success key="success" message="msg-success" />
<liferay-ui:error key="not-save"  message="msg-error-not-save" />
<liferay-ui:error key="not-observatory"  message="msg-error-not-observatory" />
<liferay-ui:error key="not-telescope"  message="msg-error-not-telescope" />
<liferay-ui:error key="not-mount"  message="msg-error-not-mount" />

<form class="aui-layout-content aui-form" 
		id="<portlet:namespace />SurveillanceControlForm" 
		name="<portlet:namespace />SurveillanceControlForm" 
		action="<%=surveillanceForm %>" 
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
		
	<br>
	<span class="aui-button-row aui-helper-clearfix"> 
		<span class="aui-button aui-button-submit aui-state-positive aui-priority-primary"> 
			<span class="aui-button-content"> 
				<input class="aui-button-input aui-button-input-submit" 
								type="submit" 
								value="<liferay-ui:message key='button-save' />"> 
			</span> 
		</span>  
	</span> 
</form>

