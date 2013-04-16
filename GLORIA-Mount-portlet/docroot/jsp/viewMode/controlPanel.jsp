<table border="0">
	<tr align="center">
		<td></td>
		<td></td>       
	   <td>
      		<img name="<portlet:namespace />northButton" src="<%=request.getContextPath()%>/images/mount/arrow2_up.png" 
	      		onmouseover="document.<portlet:namespace />northButton.src='<%=request.getContextPath()%>/images/mount/arrow2_up_hover.png';" 
	        	onmouseout="document.<portlet:namespace />northButton.src='<%=request.getContextPath()%>/images/mount/arrow2_up.png';" 
	        	onClick="<portlet:namespace />moveMount('north')"
	      		/>
	      		
	    </td>
	    <td></td>
	    <td></td>       
	</tr>
	<tr align="center">
	<td></td>
	<td></td>
	<td><label id="<portlet:namespace />upLabel" ><liferay-ui:message  key='<%=remainingUp%>' /></label></td>
	<td></td>
	<td></td>
	</tr>
	<tr align="center">
		<td>
   			<img name="<portlet:namespace />westButton" src="<%=request.getContextPath()%>/images/mount/arrow2_left.png" 
		   		onmouseover="document.<portlet:namespace />westButton.src='<%=request.getContextPath()%>/images/mount/arrow2_left_hover.png';" 
		       	onmouseout="document.<portlet:namespace />westButton.src='<%=request.getContextPath()%>/images/mount/arrow2_left.png';"
		       	onClick="<portlet:namespace />moveMount('west')"
		      	/>
		      	
	   </td>
	   <td align="right"><label id="<portlet:namespace />leftLabel"><liferay-ui:message  key='<%=remainingLeft%>' /></label></td>
	   <td></td>
	   <td align="left"><label id="<portlet:namespace />rightLabel"><liferay-ui:message key='<%=remainingRight%>' /></label></td>
	   <td>       
    		<img name="<portlet:namespace />eastButton" src="<%=request.getContextPath()%>/images/mount/arrow2_right.png" 
				onmouseover="document.<portlet:namespace />eastButton.src='<%=request.getContextPath()%>/images/mount/arrow2_right_hover.png';" 
				onmouseout="document.<portlet:namespace />eastButton.src='<%=request.getContextPath()%>/images/mount/arrow2_right.png';"
				onClick="<portlet:namespace />moveMount('east')"
			  />
			  	  
	   </td>
	   </tr>
	   <tr align="center">
	<td></td>
	<td></td>
	<td><label id="<portlet:namespace />downLabel"><liferay-ui:message  key='<%=remainingDown%>' /></label></td>
	<td></td>
	<td></td>
	</tr>
	   <tr align="center">
	   <td></td>
	   <td></td>        
	   <td>
	   		<img name="<portlet:namespace />southButton" src="<%=request.getContextPath()%>/images/mount/arrow2_down.png" 
	   			onmouseover="document.<portlet:namespace />southButton.src='<%=request.getContextPath()%>/images/mount/arrow2_down_hover.png';" 
	   			onmouseout="document.<portlet:namespace />southButton.src='<%=request.getContextPath()%>/images/mount/arrow2_down.png';"
				onClick="<portlet:namespace />moveMount('south')"
	   			/>
	   			
	   	</td>
	   	<td></td> 
	   	<td></td>          
	   </tr>
</table>


<script>
function <portlet:namespace />moveMount(address){
	var status = document.getElementById("<portlet:namespace />status");
	if (address == "north") {
		status.innerHTML = '<liferay-ui:message key="label-moving"/> <liferay-ui:message key="label-north"/>';
	} else if (address == "west") {
		status.innerHTML = '<liferay-ui:message key="label-moving"/> <liferay-ui:message key="label-west"/>';
	} else if (address == "east") {
		status.innerHTML = '<liferay-ui:message key="label-moving"/> <liferay-ui:message key="label-east"/>';
	} else if (address == "south") {
		status.innerHTML = '<liferay-ui:message key="label-moving"/> <liferay-ui:message key="label-south"/>';
	}
	
	AUI().use('aui-io-request', function(A){
		var url = '<%=moveRes%>';
		A.io.request(url, {
			method : 'POST',
			data: {
				move: address
			},
			dataType: 'json',
			on: {
				failure: function() {
					status.innerHTML = '<liferay-ui:message key="msg-error-not-send-command"/>';
				},
				success: function() {
					var data = this.get('responseData');
					var success = data.success;
					
					if (success) {
						status.innerHTML = '<liferay-ui:message key="label-stop"/>';
						document.getElementById("<portlet:namespace />upLabel").innerHTML = data.remainingUp;
						document.getElementById("<portlet:namespace />downLabel").innerHTML = data.remainingDown;
						document.getElementById("<portlet:namespace />rightLabel").innerHTML = data.remainingRight;
						document.getElementById("<portlet:namespace />leftLabel").innerHTML = data.remainingLeft;
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
				}   
			} 
		});
	});
}
</script>
