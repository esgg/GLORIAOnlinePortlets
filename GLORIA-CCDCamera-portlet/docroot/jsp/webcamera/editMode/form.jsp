<form class="aui-layout-content aui-form" 
		id="<portlet:namespace />CameraFormTab1" 
		name="<portlet:namespace />CameraFormTab1" 
		action="<%=saveFormTab1 %>" 
		method="post" 
		> 
	<%@ include file="/jsp/webcamera/editMode/selectCamera.jsp" %>
	<%@ include file="/jsp/webcamera/editMode/extraInfoCamera.jsp" %>
		
	<br>
	<span class="aui-button-row aui-helper-clearfix"> 
		<span class="aui-button aui-button-submit aui-state-positive aui-priority-primary"> 
			<span class="aui-button-content"> 
				<input class="aui-button-input aui-button-input-submit" 
						type="submit" 
						id="submitTab1" 
						name="submitTab1" 
						value="<liferay-ui:message key='Submit' />"
						> 
			</span> 
		</span>  
	</span> 
</form>


<script type="text/javascript">	

	function <portlet:namespace />getTelescopes(){	
		var obsSelectID = document.getElementById("<portlet:namespace />obsSelectField");
		var telSpanID = document.getElementById("<portlet:namespace />telescopeSpan");
		var cameraSpanID = document.getElementById("<portlet:namespace />cameraSpan");
		var extraInfoSpanID = document.getElementById("<portlet:namespace />extraInfoSpan");
		
		if (obsSelectID.value != "<liferay-ui:message key='label-none'/>") {
			telSpanID.style.display = "";
			cameraSpanID.style.display = "none";
			extraInfoSpanID.style.display = "none";
			var newTelescopeSelect= ClearOptionsFast("<portlet:namespace />telSelectField");
			newTelescopeSelect.add(new Option("<liferay-ui:message key='label-none'/>", 
												"<liferay-ui:message key='label-none'/>", true, false));
			
			AUI().use('aui-io-request', function(A){
				var url = '<%=getCameraRes%>';
				A.io.request(url, {
					method : 'POST',
					data: {
						observatory: obsSelectID.value
					},
					dataType: 'json',
					on: {
						failure: function() {
							alert("<liferay-ui:message key='msg-error-not-available-server'/>");
						},
						success: function() {
							var message = this.get('responseData');
							var telsString = message.telsList;
							
							if (telsString) {
								var elemParsed = telsString.substr(1,telsString.length-2);
								var elemSplit = elemParsed.split(",");
	
								for(i = 0; i < elemSplit.length; i++){ 
									newTelescopeSelect.add(new Option(elemSplit[i], elemSplit[i], true, false));
								}
							}
						}   
					} 
				});
			});
		} else {
			telSpanID.style.display = "none";
			cameraSpanID.style.display = "none";
			extraInfoSpanID.style.display = "none";
		}
	}
	
	function <portlet:namespace />getCddCamera(){	
		var obsSelectID = document.getElementById("<portlet:namespace />obsSelectField");
		var telSelectID = document.getElementById("<portlet:namespace />telSelectField");
		var cameraSpanID = document.getElementById("<portlet:namespace />cameraSpan");
		var extraInfoSpanID = document.getElementById("<portlet:namespace />extraInfoSpan");
		
		if (telSelectID.value != "<liferay-ui:message key='label-none'/>") {
			cameraSpanID.style.display = "";
			extraInfoSpanID.style.display = "";
			var newCcdSelect= ClearOptionsFast("<portlet:namespace />ccdSelectField");
			newCcdSelect.add(new Option("<liferay-ui:message key='label-none'/>", 
										"<liferay-ui:message key='label-none'/>", true, false));
			
			AUI().use('aui-io-request', function(A){
				var url = '<%=getCameraRes%>';
				A.io.request(url, {
					method : 'POST',
					data: {
						observatory: obsSelectID.value,
						telescope: telSelectID.value
					},
					dataType: 'json',
					on: {
						failure: function() {
							alert("<liferay-ui:message key='msg-error-not-available-server'/>");
						},
						success: function() {
							var message = this.get('responseData');
							var ccdString = message.ccdsList;
							
							if (ccdString) {
								var elemParsed = ccdString.substr(1,ccdString.length-2);
								var elemSplit = elemParsed.split(",");
	
								for(i = 0; i < elemSplit.length; i++){ 
									newCcdSelect.add(new Option(elemSplit[i], elemSplit[i], true, false));
								}
							}
						}   
					} 
				});
			});
		} else {
			cameraSpanID.style.display = "none";
			extraInfoSpanID.style.display = "none";
		}
	}
	
	function <portlet:namespace />getSurvCamera(){	
		var obsSelectID = document.getElementById("<portlet:namespace />obsSelectField");
		var telSelectID = document.getElementById("<portlet:namespace />telSelectField");
		var cameraSpanID = document.getElementById("<portlet:namespace />cameraSpan");
		var extraInfoSpanID = document.getElementById("<portlet:namespace />extraInfoSpan");
		
		if (telSelectID.value != "<liferay-ui:message key='label-none'/>") {
			cameraSpanID.style.display = "";
			extraInfoSpanID.style.display = "";
			var newSurvSelect= ClearOptionsFast("<portlet:namespace />survSelectField");
			newSurvSelect.add(new Option("<liferay-ui:message key='label-none'/>", 
										"<liferay-ui:message key='label-none'/>", true, false));
			
			AUI().use('aui-io-request', function(A){
				var url = '<%=getCameraRes%>';
				A.io.request(url, {
					method : 'POST',
					data: {
						observatory: obsSelectID.value,
						telescope: telSelectID.value
					},
					dataType: 'json',
					on: {
						failure: function() {
							alert("<liferay-ui:message key='msg-error-not-available-server'/>");
						},
						success: function() {
							var message = this.get('responseData');
							var survString = message.survsList;
							
							if (survString) {
								var elemParsed = survString.substr(1,survString.length-2);
								var elemSplit = elemParsed.split(",");
	
								for(i = 0; i < elemSplit.length; i++){ 
									newSurvSelect.add(new Option(elemSplit[i], elemSplit[i], true, false));
								}
							}
						}   
					} 
				});
			});
		} else {
			cameraSpanID.style.display = "none";
			extraInfoSpanID.style.display = "none";
		}
	}
	
	function <portlet:namespace />getCCDInfo() {
		var obsSelectID = document.getElementById("<portlet:namespace />obsSelectField");
		var telSelectID = document.getElementById("<portlet:namespace />telSelectField");
		var ccdSelectID = document.getElementById("<portlet:namespace />ccdSelectField");
		var urlImageID = document.getElementById("<portlet:namespace />urlCamField");
		var locationID = document.getElementById("<portlet:namespace />locCamField" );
		 		
		var editBrightnessID 	= document.getElementById("<portlet:namespace />editBrightness" );
		var editGainID 			= document.getElementById("<portlet:namespace />editGain" );
		var editExposureID 		= document.getElementById("<portlet:namespace />editExposure" );
		var editContrastID 		= document.getElementById("<portlet:namespace />editContrast" );
		
		AUI().use('aui-io-request', function(A){
			var url = '<%=getCameraRes%>';
			A.io.request(url, {
				method : 'POST',
				data: {
					observatory: obsSelectID.value,
					telescope: telSelectID.value,
					ccd: ccdSelectID.value
				},
				dataType: 'json',
				on: {
					start: function() {
						urlImageID.value = "<liferay-ui:message key='label-loading'/>";
						locationID.value = "<liferay-ui:message key='label-loading'/>";
					},
					failure: function() {
						urlImageID.value = "<liferay-ui:message key='msg-error'/>";
						locationID.value = "<liferay-ui:message key='msg-error'/>";
					},
					success: function() {
						var message = this.get('responseData');
						
						var error = message.error;
						if (error) {
						}
						
						var brightness = message.brightness;
						if (brightness) {
							editBrightnessID.value = brightness;
						}
						
						var gain = message.gain;
						if (gain) {
							editGainID.value = gain;
						}
						
						var contrast = message.contrast;
						if (contrast) {
							editContrastID.value = contrast;
						}
						
						var exposure = message.exposure;
						if (exposure) {
							editExposureID.value = exposure;
						}
						
						var urlImage = message.url;
						if (urlImage) {
							urlImageID.value = urlImage;
						}
						
						var location = message.location;
						if (location) {
							locationID.value = location;
						}
					}   
				} 
			});
		});
		
	}
	
	function <portlet:namespace />getSurvInfo() {
		var obsSelectID = document.getElementById("<portlet:namespace />obsSelectField");
		var telSelectID = document.getElementById("<portlet:namespace />telSelectField");
		var survSelectID = document.getElementById("<portlet:namespace />survSelectField");
		var urlImageID = document.getElementById("<portlet:namespace />urlCamField");
		var locationID = document.getElementById("<portlet:namespace />locCamField" );
		
		AUI().use('aui-io-request', function(A){
			var url = '<%=getCameraRes%>';
			A.io.request(url, {
				method : 'POST',
				data: {
					observatory: obsSelectID.value,
					telescope: telSelectID.value,
					surveillance: survSelectID.value
				},
				dataType: 'json',
				on: {
					start: function(){
						urlImageID.value = "<liferay-ui:message key='label-loading'/>";
						locationID.value = "<liferay-ui:message key='label-loading'/>";
					},
					failure: function() {
						urlImageID.value = "<liferay-ui:message key='msg-error'/>";
						locationID.value = "<liferay-ui:message key='msg-error'/>";
					},
					success: function() {
						var message = this.get('responseData');
						
						var error = message.error;
						if (error) {
						}
						
						var brightness = message.brightness;
						if (brightness) {
							editBrightnessID.value = brightness;
						}
						
						var gain = message.gain;
						if (gain) {
							editGainID.value = gain;
						}
						
						var contrast = message.contrast;
						if (contrast) {
							editContrastID.value = contrast;
						}
						
						var exposure = message.exposure;
						if (exposure) {
							editExposureID.value = exposure;
						}
						
						var urlImage = message.url;
						if (urlImage) {
							urlImageID.value = urlImage;
						}
						
						var location = message.location;
						if (location) {
							locationID.value= location;
						}
					}   
				} 
			});
		});
		
	}
	
	function <portlet:namespace />saveSettings() {
		var obsSelectID = document.getElementById("<portlet:namespace />obsSelectField");
		var telSelectID = document.getElementById("<portlet:namespace />telSelectField");
		var ccdSelectID = document.getElementById("<portlet:namespace />ccdSelectField");
		var survSelectID = document.getElementById("<portlet:namespace />survSelectField");
		
		if (mntSelectID.value != "<liferay-ui:message key='label-none'/>") {
			AUI().use('aui-io-request', function(A){
				var url = '<%=getCameraRes%>';
				A.io.request(url, {
					method : 'POST',
					data: {
						observatory: obsSelectID.value,
						telescope: telSelectID.value,
						ccd: ccdSelectID.value,
						surveillance: survSelectID.value
					},
					dataType: 'json',
					on: {
						failure: function() {
							alert("<liferay-ui:message key='msg-error-not-available-server'/>");
						},
						success: function() {
							var message = this.get('responseData');
							//alert("<liferay-ui:message key='msg-success'/>");
							document.getElementById("<portlet:namespace />CameraFormTab1").submit();
						}   
					} 
				});
			});
		}
	}	
</script>