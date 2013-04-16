
<fieldset Class="controlField">
	<legend><span><liferay-ui:message key="legend-control-panel"/></span></legend>
	<% if (showOpenButton.equalsIgnoreCase("1")) {%>
		<input class="aui-button-input"
				id="<portlet:namespace />open" 
				name="open"  
				type="button" 
				value="<liferay-ui:message key='button-open' />" 
				onClick="<portlet:namespace />operantionDome('open')"
				/>
	<%}%>	
	<% if (showCloseButton.equalsIgnoreCase("1")) {%>
		<input class="aui-button-input"
				id="<portlet:namespace />close"
				name="close"  
				type="button" 
				value="<liferay-ui:message key='button-close' />"
				onClick="<portlet:namespace />operantionDome('close')"
				/>
	<%}%>	
</fieldset>

<script>
function <portlet:namespace />operantionDome(op){
	var status = document.getElementById("<portlet:namespace />status");
	var openButtonID = document.getElementById("<portlet:namespace />open");
	var closeButtonID = document.getElementById("<portlet:namespace />close");
	
	if (op == "open") {
		status.innerHTML = '<liferay-ui:message key="label-status-opening"/>';
	} else if (op == "close") {
		status.innerHTML = '<liferay-ui:message key="label-status-closing"/>';
	}
	
	AUI().use('aui-io-request', function(A){
		var url = '<%=operationDomeRes%>';
		A.io.request(url, {
			method : 'POST',
			data: {
				"action":op
			},
			dataType: 'json',
			on: {
				failure: function() {
					status.innerHTML = '<liferay-ui:message key="msg-error-not-send-command"/>';
				},
				success: function() {   
					var data = this.get('responseData');
					var success = data.success;
					
					if (success){
						if (op == "open") {
							status.innerHTML = '<liferay-ui:message key="label-status-open"/>';
							
							
						} else if (op == "close") {
							status.innerHTML = '<liferay-ui:message key="label-status-closed"/>';
							
						}
					} else {
						if (data.message == "error_operation"){
							status.innerHTML = '<liferay-ui:message key="msg-error-operation"/>';
						} else if (data.message == "error_execution"){
							status.innerHTML = '<liferay-ui:message key="msg-error-execution"/>';
						} else if (data.message == "error_reservation_not_active"){
							status.innerHTML = '<liferay-ui:message key="msg-error-reservation_not_active"/>';
						} else if (data.message == "error_limit"){
							status.innerHTML = '<liferay-ui:message key="msg-error-limit"/>';
						} else if (data.message == "error_reservation_null"){
							status.innerHTML = '<liferay-ui:message key="msg-error-reservation_null"/>';
						}
					}
					
				}   // success
			} // on
		}); //A.io.request
	});	
}
</script>