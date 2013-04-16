
<div class="aui-fieldset aui-w100 aui-column aui-field-labels-inline" id="<portlet:namespace />extraInfoSpan"
	<% if (!showCameraField) {%>
			style="display:none;"
	<% } %>
	> 
	<div class="aui-fieldset-content aui-column-content"> 
		<div class="aui-fieldset-bd aui-widget-bd"> 
							
			<!-- URL -->
			<span class="aui-field aui-field-text aui-field-first"> 
				<span class="aui-field-content"> 
					<label class="aui-field-label" for="textField"><liferay-ui:message key='label-url' />: </label>
					<input class="aui-field-input aui-field-input-text" 
							id="<portlet:namespace />urlCamField" 
							name="urlCamField" 
							type="text" 
							value="<%=prefsURL %>">
					<span class="aui-field-hint">
						<span><liferay-ui:message key='label-url-webcam' />.</span>
					</span>
				</span>
			</span>
								
			<!-- LOCATION | COORDINATES -->
			<span class="aui-field aui-field-text aui-field-first"> 
				<span class="aui-field-content"> 
					<label class="aui-field-label" for="textField"><liferay-ui:message key='label-coordinates' />: </label>
					<input class="aui-field-input aui-field-input-text" 
							id="<portlet:namespace />locCamField" 
							name="locCamField" 
							type="text" 
							value="<%=prefsLocation %>">
					<span class="aui-field-hint">
						<span><liferay-ui:message key='label-coordinates-webcam' />.</span>
					</span>
				</span>
			</span>
		
			<!-- WIDTH | HEIGHT -->
			<span class="aui-field aui-field-text aui-field-first"> 
				<span class="aui-field-content"> 
					<label class="aui-field-label" for="widthCamField"><liferay-ui:message key='label-width' />: </label>
					<input class="aui-field-input aui-field-input-text" 
							id="<portlet:namespace />widthCamField" 
							name="widthCamField" 
							type="text" 
							value="<%=prefsWidth %>">
					<span class="aui-field-hint">
						<span><liferay-ui:message key='label-width' />.</span>
					</span>
				</span>
			</span>
				<span class="aui-field aui-field-text aui-field-first"> 
				<span class="aui-field-content"> 
					<label class="aui-field-label" for="heightCamField"><liferay-ui:message key='label-height' />: </label>
					<input class="aui-field-input aui-field-input-text" 
							id="<portlet:namespace />heightCamField" 
							name="heightCamField" 
							type="text" 
							value="<%=prefsHeight %>">
					<span class="aui-field-hint">
						<span><liferay-ui:message key='label-height' />.</span>
					</span>
				</span>
			</span>
	
		</div> 
	</div> 
	
	<input id="<portlet:namespace />editBrightness" 
			name="editBrightness" 
			type="hidden" 
			value="">
	<input id="<portlet:namespace />editGain" 
			name="editGain" 
			type="hidden" 
			value="">
	<input id="<portlet:namespace />editExposure" 
			name="editExposure" 
			type="hidden" 
			value="">
	<input id="<portlet:namespace />editContrast" 
			name="editContrast" 
			type="hidden" 
			value="">
	
</div> 
