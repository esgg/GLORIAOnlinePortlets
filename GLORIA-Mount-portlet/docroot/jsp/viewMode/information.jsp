<fieldset Class="infoField">
	<legend><span><liferay-ui:message key="legend-information"/></span></legend>
	<%@ include file="/jsp/mount/viewMode/status.jsp" %>
	<table>
		<tr>
			<td><label class="aui-field-label infolabel"> <liferay-ui:message key="label-ra"/>: </label> </td>
			<td><label class="infolabel2" id="<portlet:namespace />raLabel"> <liferay-ui:message key="status-loading"/></label> </td>
			<td><label class="aui-field-label infolabel"> <liferay-ui:message key="label-dec"/>: </label> </td>
			<td><label class="infolabel2" id="<portlet:namespace />decLabel"> <liferay-ui:message key="status-loading"/></label> </td>
		</tr>
		<tr>
			<td><label class="aui-field-label infolabel"> <liferay-ui:message key="label-az"/>: </label> </td>
			<td><label class="infolabel2" id="<portlet:namespace />azLabel"> <liferay-ui:message key="status-loading"/></label> </td>
			<td><label class="aui-field-label infolabel"> <liferay-ui:message key="label-alt"/>: </label> </td>
			<td><label class="infolabel2" id="<portlet:namespace />altLabel"> <liferay-ui:message key="status-loading"/> </label> </td>
		</tr>
	</table>
</fieldset>

<script>

var <portlet:namespace/>time = 5000;
var <portlet:namespace/>timerGetCoordinates=setInterval( 
		function(){<portlet:namespace/>getCoordinates();},
		<portlet:namespace/>time 
	);

function <portlet:namespace/>getCoordinates() {
	var status	= document.getElementById("<portlet:namespace />status");
	var ra		= document.getElementById("<portlet:namespace />raLabel");
	var dec		= document.getElementById("<portlet:namespace />decLabel");
	var az		= document.getElementById("<portlet:namespace />azLabel");
	var alt		= document.getElementById("<portlet:namespace />altLabel");
	
	AUI().use('aui-io-request', function(A){
		var url = '<%=getCoordinatesRes%>';
		A.io.request(url, {
			method : 'POST',
			data: {
			},
			dataType: 'json',
			on: {
				failure: function() {
					status.innerHTML = '<liferay-ui:message key="msg-error-not-send-command"/>';
					ra.innerHTML	= '<liferay-ui:message key="msg-error"/>';
					dec.innerHTML 	= '<liferay-ui:message key="msg-error"/>';
					az.innerHTML 	= '<liferay-ui:message key="msg-error"/>';
					alt.innerHTML 	= '<liferay-ui:message key="msg-error"/>';
					<portlet:namespace/>stopTimers();
				},
				success: function() {    
					var message = this.get('responseData');
					var error = message.error;
					if (error) {
						status.innerHTML = '<liferay-ui:message key="msg-error-not-communication-device"/>';
						ra.innerHTML	= '<liferay-ui:message key="msg-error"/>';
						dec.innerHTML 	= '<liferay-ui:message key="msg-error"/>';
						az.innerHTML 	= '<liferay-ui:message key="msg-error"/>';
						alt.innerHTML 	= '<liferay-ui:message key="msg-error"/>';
						<portlet:namespace/>stopTimers();
					} else {
						status.innerHTML = '<liferay-ui:message key="label-stop"/>';
						ra.innerHTML	= message.ra;
						dec.innerHTML 	= message.dec;
						az.innerHTML 	= message.az;
						alt.innerHTML 	= message.alt;
					} // else (error)
				} // success
			} // on
		}); //A.io.request
	});		
}

function <portlet:namespace/>stopTimers() {
	clearInterval(<portlet:namespace/>timerGetCoordinates);
}

</script>