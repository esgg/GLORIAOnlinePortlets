<%@ include file="/jsp/init.jsp" %>

<portlet:resourceURL var="setValues" id="setValues">
	<portlet:param name="control" value="setValues"/>
</portlet:resourceURL>

<portlet:resourceURL var="getValues" id="getValues">
	<portlet:param name="control" value="getValues"/>
</portlet:resourceURL>

<portlet:resourceURL id="popup" var="popup">
	<portlet:param name="control" value="popup"/>
</portlet:resourceURL>
<html> 
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/> 
</head>
<body>
<div id="<portlet:namespace />outline_ccdImg" class="outline_CamImg"> 
	<img id="<portlet:namespace />GLORIAccd" 
		src="<%=prefsURL%>" 
		name="GLORIAccd" 
		height="<%=prefsHeight %>" 
		width="<%=prefsWidth  %>" />

</div>	

<portlet:resourceURL var="imageUrl" id="imageUrl">
	<portlet:param name="control" value="operation"/>
</portlet:resourceURL>
</body>
<script>

var <portlet:namespace />imageTimer = setInterval(function(){
	var imgName = "<portlet:namespace />GLORIAccd";
	AUI().use('aui-io-request', function(A){
		var url = '<%=imageUrl%>';
		A.io.request(url, {
			method : 'POST',
			data: {
				"action":"res"
			},
			dataType: 'json',
			on: {
				success: function() {    
					var message = this.get('responseData');
					if (message.error == "false"){
						document.getElementById(imgName).src = message.url;
						<portlet:namespace />clearTimer();
					}
				}
			}
		});
	});
},5000);

function <portlet:namespace />clearTimer(){
	clearInterval(<portlet:namespace />imageTimer);
}

</script>
</html>