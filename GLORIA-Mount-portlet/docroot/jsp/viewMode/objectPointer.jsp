<%--

--%>
<div>
	<div class="aui-field-inline" style="margin: -2px;"> 
		<label class="aui-field-label infolabel"> <liferay-ui:message key="label-object"/>: </label>
		<select class="aui-field-input aui-field-input-select" 
					id="<portlet:namespace />objectSelect" 
					name="objectSelect"
					onChange="<portlet:namespace />setObject();"> 
		
			<aui:option label="label-none" value="-1" />
			<% try { %> 
				<jsp:useBean id="astronomicalObject" scope="request" class="eu.gloria.website.liferay.portlets.experiment.online.objects.AstronomicalObjects"/>
			<%	
				for (String name : astronomicalObject.getListAO()) {
			%>
					<aui:option label="<%=name%>" 
								value="<%=name%>" 
								selected="<%= name.equalsIgnoreCase(prefsObject) %>" />
				<%}
			} catch (Exception e) {
			}
			%>
		</select>
	</div>
</div>

<script>
function <portlet:namespace />setObject() {
	
	var status	= document.getElementById("<portlet:namespace />status");
	var object	= document.getElementById("<portlet:namespace />objectSelect");
	
	//status.innerHTML = '<liferay-ui:message key="label-pointing"/>';
	
	AUI().use('aui-io-request', function(A){
		var url = '<%=objectRes%>';
		A.io.request(url, {
			method : 'POST',
			data: {
				"object":object.value
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