<div class="aui-field-inline" style="margin: 10px;"> 
	<input class="aui-button-input"
				id="<portlet:namespace />gotoSun" 
				name="gotoSun"  
				type="button" 
				value="<liferay-ui:message key='button-sun' />" 
				onClick="<portlet:namespace />gotoSun()"
				/>
</div>
<script>
function <portlet:namespace />gotoSun(){
	var url = '<%=objectRes%>';
	var status	= document.getElementById("<portlet:namespace />status");
	

	status.innerHTML = '<liferay-ui:message key="msg-moving-sun"/>';
	
	AUI().use('aui-io-request', function(A){
		A.io.request(url, {
			method : 'POST',
			data:{
				"object":"SUN"
			},
			dataType: 'json',
			on: {
				failure: function() {
					
				},
				success: function() {
					var data = this.get('responseData');
					var success = data.success;
					
					var remainingUp = document.getElementById("<portlet:namespace />upLabel");
					var remainingDown = document.getElementById("<portlet:namespace />downLabel");
					var remainingLeft = document.getElementById("<portlet:namespace />leftLabel");
					var remainingRight = document.getElementById("<portlet:namespace />rightLabel");
					
					if (success){
						status.innerHTML = '<liferay-ui:message key="label-sun"/>';	
						remainingUp.innerHTML = data.remainingUp;
						remainingDown.innerHTML = data.remainingDown;
						remainingLeft.innerHTML = data.remainingLeft;
						remainingRight.innerHTML = data.remainingRight;
					}
				}
			}//on
		});
	});
}
</script>			