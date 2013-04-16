<div class="aui-fieldset aui-w100 aui-column aui-field-labels-inline"> 
	<div class="aui-fieldset-bd aui-widget-bd"> 

		<!-- SPEED PANEL -->
		<span class="aui-field aui-field-nested aui-field-last">
			<span class="aui-field-content">
				<label class="aui-field-label" for="textField"> 
					<liferay-ui:message key='checkbox-speed-panel' />: 
					</label>
					<input <% if (showSpeedPanel.compareToIgnoreCase("1") == 0) {%> checked="true" <%}%> 
						   class="aui-field-input aui-field-input-choice aui-field-input-checkbox" 
						   id="checkboxSpeedPanel" 
						   name="checkboxSpeedPanel" 
						   type="checkbox" 
						   value="<%= showSpeedPanel %>">
			</span>
		</span>

		<!-- POINTER PANEL -->
		<span class="aui-field aui-field-nested aui-field-last">
			<span class="aui-field-content">
				<label class="aui-field-label" for="textField"> 
					<liferay-ui:message key='checkbox-pointer-panel' />: 
					</label>
					<input <% if (showPointerPanel.compareToIgnoreCase("1") == 0) {%> checked="true" <%}%> 
						   class="aui-field-input aui-field-input-choice aui-field-input-checkbox" 
						   id="<portlet:namespace />checkboxPointerPanel" 
						   name="checkboxPointerPanel" 
						   type="checkbox" 
						   value="<%= showPointerPanel %>"
						   onChange="<portlet:namespace />showPointerControls()">
			</span>
		</span>
		
		<span id="<portlet:namespace />pointerSpan">
			<!-- POINTER PANEL -->
			<!-- COORDINATES -->
			<span class="aui-field aui-field-nested aui-field-last"
				id="<portlet:namespace />coordiantesPanel">
				<span class="aui-field-content">
					<label class="next-level" for="textField"> 
						<liferay-ui:message key='checkbox-coordinates-panel' />: 
						</label>
						<input <% if (showRaDecPanel.compareToIgnoreCase("1") == 0) {%> checked="true" <%}%> 
							   class="aui-field-input aui-field-input-choice aui-field-input-checkbox up-level" 
							   id="checkboxRaDecPanel" 
							   name="checkboxRaDecPanel" 
							   type="checkbox" 
							   value="<%= showRaDecPanel %>">
				</span>
			</span>
	
			<!-- POINTER PANEL -->
			<!-- EPOCH -->
			<span class="aui-field aui-field-nested aui-field-last">
				<span class="aui-field-content">
					<label class="next-level" for="textField"> 
						<liferay-ui:message key='checkbox-epoch-panel' />: 
						</label>
						<input <% if (showEpochPanel.compareToIgnoreCase("1") == 0) {%> checked="true" <%}%> 
							   class="aui-field-input aui-field-input-choice aui-field-input-checkbox up-level" 
							   id="checkboxEpochPanel" 
							   name="checkboxEpochPanel" 
							   type="checkbox" 
							   value="<%= showEpochPanel %>">
				</span>
			</span>
	
			<!-- POINTER PANEL -->
			<!-- OBJECT -->
			<span class="aui-field aui-field-nested aui-field-last">
				<span class="aui-field-content">
					<label class="next-level" for="textField"> 
						<liferay-ui:message key='checkbox-object-panel' />: 
						</label>
						<input <% if (showObjectPanel.compareToIgnoreCase("1") == 0) {%> checked="true" <%}%> 
							   class="aui-field-input aui-field-input-choice aui-field-input-checkbox up-level" 
							   id="checkboxObjectPanel" 
							   name="checkboxObjectPanel" 
							   type="checkbox" 
							   value="<%= showObjectPanel %>">
				</span>
			</span>
	
			<!-- POINTER PANEL -->
			<!-- MODE -->
			<span class="aui-field aui-field-nested aui-field-last">
				<span class="aui-field-content">
					<label class="next-level" for="textField"> 
						<liferay-ui:message key='checkbox-mode-panel' />: 
						</label>
						<input <% if (showModePanel.compareToIgnoreCase("1") == 0) {%> checked="true" <%}%> 
							   class="aui-field-input aui-field-input-choice aui-field-input-checkbox up-level" 
							   id="checkboxModePanel" 
							   name="checkboxModePanel" 
							   type="checkbox" 
							   value="<%= showModePanel %>">
				</span>
			</span>
		</span>
		<!-- INFORMATION PANEL -->
		<span class="aui-field aui-field-nested aui-field-last">
			<span class="aui-field-content">
				<label class="aui-field-label" for="textField"> 
					<liferay-ui:message key='checkbox-information-panel' />: 
					</label>
					<input <% if (showInfoPanel.compareToIgnoreCase("1") == 0) {%> checked="true" <%}%> 
						   class="aui-field-input aui-field-input-choice aui-field-input-checkbox" 
						   id="checkboxInformationPanel" 
						   name="checkboxInformationPanel" 
						   type="checkbox" 
						   value="<%= showInfoPanel %>">
			</span>
		</span>
	</div>
</div>

<script>
<portlet:namespace />showPointerControls();

function <portlet:namespace />showPointerControls() {
	var pointerSpan				= document.getElementById("<portlet:namespace />pointerSpan");
	var checkboxPointerPanel	= document.getElementById("<portlet:namespace />checkboxPointerPanel");
	
	if (checkboxPointerPanel.checked)
		pointerSpan.style.display="block";
	else
		pointerSpan.style.display="none";
	
}
</script>