<div class="field-block "> 
	<input class="aui-button-input"
			id="<portlet:namespace />setCoordinates" 
			name="setCoordinates"  
			type="button" 
			value="<liferay-ui:message key='button-point' />" 
			onClick="<portlet:namespace />setCoordinates()"
			/>
	
	<input class="aui-button-input"
			id="<portlet:namespace />park"
			name="park"  
			type="button" 
			value="<liferay-ui:message key='button-park' />"
			onClick="<portlet:namespace />park()"
			/>
</div>		
			
<script>
	<portlet:namespace />hidePointButton();

	function <portlet:namespace />hidePointButton() {
		var pointButton		= document.getElementById("<portlet:namespace />setCoordinates");
		if (<%=showRaDecPanel%> == "0" && 
			<%=showEpochPanel%> == "0" && 
			<%=showObjectPanel%> == "0" && 
			<%=showModePanel%> == "0") {
			pointButton.style.display="none";
		} else {
			pointButton.style.display="";
		}
	}

	function <portlet:namespace />setCoordinates() {
		
		var status	= document.getElementById("<portlet:namespace />status");
		var raH		= document.getElementById("<portlet:namespace />raHSelect");
		var raM		= document.getElementById("<portlet:namespace />raMinSelect");
		var raS 	= document.getElementById("<portlet:namespace />raSecSelect");
		var sign 	= document.getElementById("<portlet:namespace />symbolSelect");
		var decG 	= document.getElementById("<portlet:namespace />decDegressSelect");
		var decM 	= document.getElementById("<portlet:namespace />decMinSelect");
		var decS 	= document.getElementById("<portlet:namespace />decSecSelect");
		var currentEpoch = document.getElementById("<portlet:namespace />radio1a");
		//var j2000Epoch = document.getElementById("<portlet:namespace />radio2a");
		var mode 	= document.getElementById("<portlet:namespace />modeSelect");
		
		var RA = ""+raH.value+":"+raM.value+":"+raS.value;
		var DEC = sign.value+decG.value+":"+decM.value+":"+decS.value;
		var epoch;
		if (currentEpoch.checked) epoch="current"; else epoch="J2000";  
		
		status.innerHTML = '<liferay-ui:message key="label-pointing"/>';
		
		AUI().use('aui-io-request', function(A){
			var url = '<%=setCoordinatesRes%>';
			A.io.request(url, {
				method : 'POST',
				data: {
					"ra":RA,
					"dec":DEC,
					"epoch":epoch,
					"mode":mode.value
				},
				dataType: 'json',
				on: {
					failure: function() {
						status.innerHTML = '<liferay-ui:message key="msg-error-not-send-command"/>';
					},
					success: function() {    
						var message = this.get('responseData');
						var error = message.error;
						if (error) {
							status.innerHTML = '<liferay-ui:message key="msg-error-not-communication-device"/>';
						} else {
							status.innerHTML = '<liferay-ui:message key="label-stop"/>';
							
							
						} // else (error)
					}   // success
				} // on
			}); //A.io.request
		});	
	}
	function <portlet:namespace />park() {
		var status = document.getElementById("<portlet:namespace />status");
		status.innerHTML = '<liferay-ui:message key="label-parking"/>';
		
		AUI().use('aui-io-request', function(A){
			var url = '<%=parkRes%>';
			A.io.request(url, {
				method : 'POST',
				data: {
				},
				dataType: 'json',
				on: {
					failure: function() {
						status.innerHTML = '<liferay-ui:message key="msg-error-not-send-command"/>';
					},
					success: function() {    
						var message = this.get('responseData');
						var error = message.error;
						if (error) {
							status.innerHTML = '<liferay-ui:message key="msg-error-not-communication-device"/>';
						} else {
							status.innerHTML = '<liferay-ui:message key="label-stop"/>';
							
							
						} // else (error)
					}   // success
				} // on
			}); //A.io.request
		});	
	}
</script>