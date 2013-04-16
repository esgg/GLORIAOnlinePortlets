<div id="<portlet:namespace />outline_CamWideField" class="outline_CamImg"> 
	<img id="<portlet:namespace />GLORIAwideField" 
		src="<%=widefieldURL%>" 
		name="GLORIAwideField" 
		height="<%=prefsHeight %>" 
		width="<%=prefsWidth  %>" /> 

</div>	

<portlet:resourceURL var="imageUrl" id="imageUrl">
	<portlet:param name="control" value="widefieldUrl"/>
</portlet:resourceURL>



<script>
var <portlet:namespace />firstTimeWide = true;

var <portlet:namespace />imageWideSurvTimer = setInterval(function(){
		var imgName = "<portlet:namespace />GLORIAwideField";
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
							<portlet:namespace />clearWideTimer();
							<portlet:namespace />autoLoadImageWide();
						}				
					}
				}
			});
		});
	},5000);

function <portlet:namespace />autoLoadImageWide() {
	 setInterval( function() {
			var imgName = "<portlet:namespace />GLORIAwideField";
			var imgsrc = document.getElementById(imgName).src; 
			var imgSrcOut;	

			if (<portlet:namespace />firstTimeWide) {
				imgSrcOut = document.getElementById(imgName).src;
			} else {
				imgSrcOut = imgsrc.substring(0, imgsrc.indexOf("?"));
			}
			
			<portlet:namespace />firstTimeWide = false; 
						
			document.getElementById(imgName).src = imgSrcOut + "?d=" + new Date().getTime();	
	    }, 1000 );
};


function <portlet:namespace />clearWideTimer(){
	clearInterval(<portlet:namespace />imageWideSurvTimer);
}

</script>