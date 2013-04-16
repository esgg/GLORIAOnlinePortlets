<div class="aui-fieldset aui-w100 aui-column aui-field-labels-inline"> 
			
	<!-- SELECT OBSERVATORY -->
	<span class="aui-field aui-field-menu aui-field-select"> 
		<span class="aui-field-content"> 
			<label class="aui-field-label" for="obsSelectField"><liferay-ui:message key='label-select-observatory' />: </label>  
			<select class="aui-field-input aui-field-input-select" id="<portlet:namespace />obsSelectField"	name="obsSelectField" onChange="<portlet:namespace />getTelescopes();"> 
				<aui:option label="label-none" value="<%=rb.getString(\"label-none\") %>" />
				<%
				try {
					//for (String name : deviceObject.getObsevatoriesList()) {
					for (String name : obsevatoriesList) {
				%>
					<aui:option label="<%=name%>" 
								value="<%=name%>"  
								selected="<%= name.equalsIgnoreCase(prefsObservatory) %>" 
								/>
				<%
					} 
				} catch (Exception e) {}
				%>
			</select>
			<span class="aui-field-hint"> 
				<span><liferay-ui:message key='label-select-an-observatory' />.</span> 
			</span> 
		</span> 
	</span>	

	<!-- SELECT TELESCOPE -->
	<span class="aui-field aui-field-menu aui-field-select" id="<portlet:namespace />telescopeSpan" 
		<% if (!showTelescopeField) {%>
			style="display:none;"
		<% } %>
		>
		<span class="aui-field-content">
			<label class="aui-field-label" for="telSelectField"><liferay-ui:message key='label-select-telescope' />: </label>  
			<select class="aui-field-input aui-field-input-select" 
				id="<portlet:namespace />telSelectField" 
				name="telSelectField" 
				onChange="<portlet:namespace />getCddCamera();  <portlet:namespace />getSurvCamera();"> 		
				
				<aui:option label="label-none" value="<%=rb.getString(\"label-none\") %>" />
				<%
				if (showTelescopeField)
					try {
						for (String name : deviceObject.getTelescopesList(prefsObservatory)) {
				%>
					<aui:option label="<%=name%>" 
						value="<%=name%>"  
						selected="<%= name.equalsIgnoreCase(prefsTelescope) %>" 
						/>
				<%
						}
					} catch (Exception e) {}
				%>
			</select>
			<span class="aui-field-hint"> 
				<span><liferay-ui:message key='label-select-a-telescope' />.</span> 
			</span> 
		</span> 
	</span>
			
	<!-- SELECT CAMERA -->
	<span id="<portlet:namespace />cameraSpan"
		<% if (!showCameraField) {%>
			style="display:none;"
		<% } %>
		>
		<!-- SELECT CCD CAMERA -->
		<span class="aui-field aui-field-menu aui-field-select">
			<!-- SELECT CCD CAMERA -->
			<span class="aui-field aui-field-menu aui-field-select"> 
				<span class="aui-field-content"> 
					<label class="aui-field-label" for="ccdSelectField"><liferay-ui:message key='label-select-ccd-camera' />: </label>  
					<select class="aui-field-input aui-field-input-select" 
						id="<portlet:namespace />ccdSelectField" 
						name="ccdSelectField" 
						onChange="desactiveSelect('<portlet:namespace />survSelectField'); <portlet:namespace />getCCDInfo();"> 						
					
						<aui:option label="label-none" value="<%=rb.getString(\"label-none\") %>" />
						<%
						try {
							for (String name : deviceObject.getCCDList(prefsTelescope)) {
						%>
							<aui:option label="<%=name%>" 
								value="<%=name%>"  
								selected="<%= name.equalsIgnoreCase(prefsCcdCamera) %>" 
								/>
						<%
							}
						} catch (Exception e) {}
						%>
					</select>
					<span class="aui-field-hint"> 
						<span><liferay-ui:message key='label-select-a-ccd-camera' />.</span> 
					</span> 
				</span> 
			</span>
		</span>	
		<!-- SELECT SURVEILLANCE CAMERA -->
		<span class="aui-field aui-field-menu aui-field-select" id="<portlet:namespace />survSpan" >
			<span class="aui-field aui-field-menu aui-field-select"> 
				<span class="aui-field-content"> 
					<label class="aui-field-label" for="survSelectField"><liferay-ui:message key='label-select-surveillance-camera' />: </label>  
					<select class="aui-field-input aui-field-input-select" 
						id="<portlet:namespace />survSelectField" 
						name="survSelectField" 
						onChange="desactiveSelect('<portlet:namespace />ccdSelectField'); <portlet:namespace />getSurvInfo();"> 							
					
						<aui:option label="label-none" value="<%=rb.getString(\"label-none\") %>" />
						<%
						try {
							for (String name : deviceObject.getSurveillanceList(prefsTelescope)) {
						%>
							<aui:option label="<%=name%>" 
								value="<%=name%>"  
								selected="<%= name.equalsIgnoreCase(prefsSurvCamera) %>" 
								/>
						<%
							}
						} catch (Exception e) {}
						%>
					</select>
					<span class="aui-field-hint"> 
						<span><liferay-ui:message key='label-select-a-surveillance-camera' />.</span> 
					</span> 
				</span> 
			</span>
		</span>	
	</span>
</div>