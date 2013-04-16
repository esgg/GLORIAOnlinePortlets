<div id="divVisibilityeCam"> 
	<form class="aui-layout-content aui-form" id="visibilityForm" name="visibilityForm" action="<%=saveFormTab2 %>" method="post"> 
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
			
			<br/>  
		
			<span class="aui-button-row aui-helper-clearfix"> 
				<span class="aui-button aui-button-submit aui-state-positive aui-priority-primary"> 
					<span class="aui-button-content"> 
						<input class="aui-button-input aui-button-input-submit" 
								type="submit" 
								id="submitTab2" 
								name="submitTab2" 
								value="<liferay-ui:message key='Submit' />"> 
					</span> 
				</span>  
			</span> 

		</div>
		 
	</form> 
</div>


		