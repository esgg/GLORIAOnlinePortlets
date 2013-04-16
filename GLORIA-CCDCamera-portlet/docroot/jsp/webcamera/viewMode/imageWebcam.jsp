
<div id="<portlet:namespace />outline_CamImg" class="outline_CamImg"> 
	<img id="<portlet:namespace />GLORIAwebcam" 
		src="<%=prefsURL%>" 
		name="GLORIAwebcam" 
		height="<%=prefsHeight %>" 
		width="<%=prefsWidth  %>" /> 

</div>	

<portlet:resourceURL var="imageUrl" id="imageUrl">
	<portlet:param name="control" value="operation"/>
</portlet:resourceURL>



<script>
var <portlet:namespace />firstTime = true;

var <portlet:namespace />imageSurvTimer = setInterval(function(){
		var imgName = "<portlet:namespace />GLORIAwebcam";
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
						if (message.success){
							document.getElementById(imgName).src = message.url;
							<portlet:namespace />clearTimer();
							<portlet:namespace />autoLoadImage();
						}				
					}
				}
			});
		});
	},5000);

function <portlet:namespace />autoLoadImage() {
	 setInterval( function() {
			var imgName = "<portlet:namespace />GLORIAwebcam";
			var imgsrc = document.getElementById(imgName).src; 
			var imgSrcOut;	

			if (<portlet:namespace />firstTime) {
				imgSrcOut = document.getElementById(imgName).src;
			} else {
				imgSrcOut = imgsrc.substring(0, imgsrc.indexOf("?"));
			}
			
			<portlet:namespace />firstTime = false; 
						
			document.getElementById(imgName).src = imgSrcOut + "?d=" + new Date().getTime();	
	    }, 1000 );
};


function <portlet:namespace />clearTimer(){
	clearInterval(<portlet:namespace />imageSurvTimer);
}

</script>