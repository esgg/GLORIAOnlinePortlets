<fieldset Class="infoField">
	<legend><span><liferay-ui:message key="legend-speed"/></span></legend>
	<form>
		<input	class="aui-button-input"  
				id="<portlet:namespace />setGuide" 
				name="setGuide"
				type="button" 
				value="<liferay-ui:message key='button-guide' />"
				onClick = "<portlet:namespace />setSpeed('guide')"  
		/>
		<input	class="aui-button-input" 
				id="<portlet:namespace />setCenter" 
				name="setCenter"
				type="button" 
				value="<liferay-ui:message key='button-center' />"
				onClick = "<portlet:namespace />setSpeed('center')"  
		/>
		<input 	class="aui-button-input"
				id="<portlet:namespace />setFind" 
				name="setFind"
				type="button" 
				value="<liferay-ui:message key='button-find' />"
				onClick = "<portlet:namespace />setSpeed('find')"  
		/>
		<input 	class="aui-button-input"
				id="<portlet:namespace />setMax" 
				name="setMax"
				type="button" 
				value="<liferay-ui:message key='button-max' />"
				onClick = "<portlet:namespace />setSpeed('max')" 
		/>		
	</form>
</fieldset>

<script>
function <portlet:namespace />setSpeed(grade){
	var status = document.getElementById("<portlet:namespace />status");
	var guideButtonID = document.getElementById("<portlet:namespace />setGuide");
	var centerButtonID = document.getElementById("<portlet:namespace />setCenter");
	var findButtonID = document.getElementById("<portlet:namespace />setFind");
	var maxButtonID = document.getElementById("<portlet:namespace />setMax");
	
	if (grade == "guide") {
		status.innerHTML = '<liferay-ui:message key="label-set-speed"/> <liferay-ui:message key="label-guide"/>';
	} else if (grade == "center") {
		status.innerHTML = '<liferay-ui:message key="label-set-speed"/> <liferay-ui:message key="label-center"/>';
	} else if (grade == "find") {
		status.innerHTML = '<liferay-ui:message key="label-set-speed"/> <liferay-ui:message key="label-find"/>';
	} else if (grade == "max") {
		status.innerHTML = '<liferay-ui:message key="label-set-speed"/> <liferay-ui:message key="label-max"/>';
	}
	
	AUI().use('aui-io-request', function(A){
		var url = '<%=speedRes%>';
		A.io.request(url, {
			method : 'POST',
			data: {
				speed: grade
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
						
						if (grade == "guide") {
							guideButtonID.disabled = true;
							centerButtonID.disabled = false;
							findButtonID.disabled = false;
							maxButtonID.disabled = false;
							
							guideButtonID.style.background="#FFFFFF";
							centerButtonID.style.background="";
							findButtonID.style.background="";
							maxButtonID.style.background="";
						} else if (grade == "center") {
							guideButtonID.disabled = false;
							centerButtonID.disabled = true;
							findButtonID.disabled = false;
							maxButtonID.disabled = false;
							
							guideButtonID.style.background="";
							centerButtonID.style.background="#FFFFFF";
							findButtonID.style.background="";
							maxButtonID.style.background="";
						} else if (grade == "find") {
							guideButtonID.disabled = false;
							centerButtonID.disabled = false;
							findButtonID.disabled = true;
							maxButtonID.disabled = false;
							
							guideButtonID.style.background="";
							centerButtonID.style.background="";
							findButtonID.style.background="#FFFFFF";
							maxButtonID.style.background="";
						} else if (grade == "max") {
							guideButtonID.disabled = false;
							centerButtonID.disabled = false;
							findButtonID.disabled = false;
							maxButtonID.disabled = true;
							
							guideButtonID.style.background="";
							centerButtonID.style.background="";
							findButtonID.style.background="";
							maxButtonID.style.background="#FFFFFF";
						}
					} // else (error)
				}   // success
			} // on
		}); //A.io.request
	});
}
</script>