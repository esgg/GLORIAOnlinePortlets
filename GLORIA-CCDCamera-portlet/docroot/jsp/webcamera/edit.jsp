<%@ include file="/jsp/webcamera/init.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<portlet:actionURL name="settingsForm" var="ccdForm">
	<portlet:param name="jspPage" value="/edit.jsp"/>
</portlet:actionURL>

<liferay-ui:success key="success" message="msg-success" />
<liferay-ui:error key="not-save"  message="msg-error-not-save" />
<liferay-ui:error key="not-observatory"  message="msg-error-not-observatory" />
<liferay-ui:error key="not-telescope"  message="msg-error-not-telescope" />
<liferay-ui:error key="not-camara"  message="msg-error-not-mount" />

<form class="aui-layout-content aui-form" 
		id="<portlet:namespace />CCDControlForm" 
		name="<portlet:namespace />CCDControlForm" 
		action="<%=ccdForm %>" 
		method="post" 
		> 
	
	
	
		<div class="aui-fieldset aui-w100 aui-column aui-field-labels-inline"> 
			<div class="aui-fieldset-content aui-column-content"> 
				<div class="aui-fieldset-bd aui-widget-bd"> 
			
		
					<!-- BRIGHTNESS -->
					<span class="aui-field aui-field-nested aui-field-last">
						<span class="aui-field-content">
							<label class="aui-field-label" for="textField"> <liferay-ui:message key='label-brightness' />: </label>
								<input <% if (checkboxBrightness.compareToIgnoreCase("1") == 0) {%> checked="true" <%}%> 
									   class="aui-field-input aui-field-input-choice aui-field-input-checkbox" 
									   id="checkboxBrightness" 
									   name="checkboxBrightness" 
									   type="checkbox" 
									   value="<%=checkboxBrightness %>">
						</span>
					</span>
			
					<!-- GAIN -->
					<span class="aui-field aui-field-nested aui-field-last">
						<span class="aui-field-content">
							<label class="aui-field-label" for="textField"><liferay-ui:message key='label-gain' />: </label>
								<input <% if (checkboxGain.compareToIgnoreCase("1") == 0) {%> checked="true" <%}%> 
									   class="aui-field-input aui-field-input-choice aui-field-input-checkbox" 
									   id="checkboxGain" 
									   name="checkboxGain" 
									   type="checkbox" 
									   value="<%=checkboxGain %>">
						</span>
					</span>
			
					<!-- EXPOSURE -->
					<span class="aui-field aui-field-nested aui-field-last">
						<span class="aui-field-content">
							<label class="aui-field-label" for="textField"><liferay-ui:message key='label-exposure-time' />: </label>
								<input <% if (checkboxExposure.compareToIgnoreCase("1") == 0) {%> checked="true" <%}%> 
									   class="aui-field-input aui-field-input-choice aui-field-input-checkbox" 
									   id="checkboxExposure" 
									   name="checkboxExposure" 
									   type="checkbox" 
									   value="<%=checkboxExposure %>">
						</span>
					</span>
			
					<!-- CONTRAST -->
					<span class="aui-field aui-field-nested aui-field-last">
						<span class="aui-field-content">
							<label class="aui-field-label" for="textField"><liferay-ui:message key='label-contrast' />: </label>
								<input <% if (checkboxContrast.compareToIgnoreCase("1") == 0) {%> checked="true" <%}%> 
									   class="aui-field-input aui-field-input-choice aui-field-input-checkbox" 
									   id="checkboxContrast" 
									   name="checkboxContrast" 
									   type="checkbox" 
									   value="<%=checkboxContrast %>">
						</span>			
					</span>
			
					<!-- TAKE -->
					<span class="aui-field aui-field-nested aui-field-last">
						<span class="aui-field-content">
							<label class="aui-field-label" for="textField"><liferay-ui:message key='label-take_image' />: </label>
								<input <% if (checkboxTake.compareToIgnoreCase("1") == 0) {%> checked="true" <%}%> 
									   class="aui-field-input aui-field-input-choice aui-field-input-checkbox" 
									   id="checkboxTake" 
									   name="checkboxTake" 
									   type="checkbox" 
									   value="<%=checkboxTake %>">
						</span>
						<span class="aui-field-hint"> 
							<span>(<liferay-ui:message key='label-only-ccd-camera' />)</span> 
						</span> 
					</span>
			
					<!-- CONTINUOUS MODE -->
					<span class="aui-field aui-field-nested aui-field-last">
						<span class="aui-field-content">
							<label class="aui-field-label" for="textField"><liferay-ui:message key='label-continuous-mode' />: </label>
								<input <% if (checkboxCont.compareToIgnoreCase("1") == 0) {%> checked="true" <%}%> 
									   class="aui-field-input aui-field-input-choice aui-field-input-checkbox" 
									   id="checkboxCont" 
									   name="checkboxCont" 
									   type="checkbox" 
									   value="<%=checkboxCont %>">
						</span>
					</span>
			
			
				</div> 
			</div> 

		</div>
	
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

