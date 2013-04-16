<%@ include file="/init.jsp" %>

<portlet:defineObjects />

<portlet:actionURL var="webCamURL">
    <portlet:param name="jspPage" value="/view.jsp" />
</portlet:actionURL>

<portlet:actionURL var="setSettings">
    <portlet:param name="jspPage" value="/view.jsp" />
</portlet:actionURL>

<portlet:resourceURL id="popup" var="popup">
	<portlet:param name="control" value="popup"/>
	<portlet:param name="jspPage" value="/popup.jsp"/>
	<portlet:param name="expT_value" value="<%=expT_value%>"/>
</portlet:resourceURL>

<portlet:resourceURL var="setValues" id="setValues">
	<portlet:param name="control" value="setValues"/>
</portlet:resourceURL>

<portlet:resourceURL var="getValues" id="getValues">
	<portlet:param name="control" value="getValues"/>
</portlet:resourceURL>

<html> 
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/> 

<script>

var <portlet:namespace />firstTime = true;
var getting_URL = false;

function <portlet:namespace />autoLoadImage() {
	var imgName = "<portlet:namespace />GLORIAwebcam";
	var imgsrc = document.getElementById(imgName).src; 
	var imgSrcOut;	
	var buffer = new Image();

	if (<portlet:namespace />firstTime) {
		imgSrcOut = document.getElementById(imgName).src;
	} else {
		imgSrcOut = imgsrc.substring(0, imgsrc.indexOf("?"));
	}
	
	<portlet:namespace />firstTime = false; 
	//console.log("getting_URL= "+getting_URL);
	//console.log("URL= "+imgsrc);
	
	if (!getting_URL) {
		setTimeout(function() {
			buffer.src = imgSrcOut + "?d=" + new Date().getTime();
		},1000);
		
		buffer.onload = function() {
			document.getElementById(imgName).src = buffer.src;
		};
			
		buffer.onerror = setTimeout(function() {
			buffer.src = imgSrcOut + "?d=" + new Date().getTime();
		},1000); 
	}
		
	delete buffer;		
}
</script>


</head>
<body>


<% if (configured.equalsIgnoreCase("false") || configured==null) { %>
		<liferay-ui:message key='config_msg' />
<% } else { %>
	<b><%=titleCamField %></b>
	<br>	
	<div id="<portlet:namespace />outline_CamImg" class="outline_CamImg"> 
		<img id="<portlet:namespace />GLORIAwebcam" src="<%=urlCamField%>" 
			alt="<%=titleCamField%>" name="GLORIAwebcam" 
			height="<%=heightCamField %>" width="<%=widthCamField  %>"  
			onload="<portlet:namespace />autoLoadImage();" /> 
	</div>	
	<form id="<portlet:namespace />WebcamForm" name="<portlet:namespace />WebcamForm" action="<%=setSettings %>" method="post"> 
		<div id="webcamView" class="yui3-skin-capsule">
			<% if (checkboxBrightness.equalsIgnoreCase("1")) {%>
			<span>
				<label class="aui-field-label" for="<portlet:namespace />brightness_value"><liferay-ui:message key='Brightness' />: </label>
    			<input id="<portlet:namespace />brightness_value" name="brightness_value" value="<%=brightness_value%>"/>
    			<span class="<portlet:namespace />brightness_slider"></span>
			</span>
			<%} %>
			<% if (checkboxGain.equalsIgnoreCase("1")) {%>
			<span>
				<label class="aui-field-label" for="<portlet:namespace />gain_value"><liferay-ui:message key='Gain' />: </label>
    			<input id="<portlet:namespace />gain_value" name="gain_value" value="<%=gain_value%>"/>
    			<span class="<portlet:namespace />gain_slider"></span>
			</span>	
			<%} %>
			<% if (checkboxExposure.equalsIgnoreCase("1")) {%>
			<span>
				<label class="aui-field-label" for="<portlet:namespace />expT_value"><liferay-ui:message key='Exposure_time' />: </label> 
    			<input id="<portlet:namespace />expT_value" name="expT_value" value="<%=expT_value%>"/>
    			<span class="<portlet:namespace />expT_slider"></span>
			</span>	
			<%} %>
			<% if (checkboxContrast.equalsIgnoreCase("1")) {%>
			<span>
				<label class="aui-field-label" for="<portlet:namespace />contrast_value"><liferay-ui:message key='Contrast' />: </label> 
   				<input id="<portlet:namespace />contrast_value" name="contrast_value" value="<%=contrast_value%>"/> 
   				<span class="<portlet:namespace />contrast_slider"></span>
			</span>
			<%} %>
			<% if (checkboxCont.equalsIgnoreCase("1")) {%>
			<span class="aui-field-content">
				<label for="<portlet:namespace />checkboxContView"><liferay-ui:message key='Continuous_mode' />: </label>
				<input checked="true"
		   			class="aui-field-input aui-field-input-checkbox" 
		   			id="<portlet:namespace />checkboxContView" 
		   			name="checkboxContView" 
	   				type="checkbox" 
	   				value="<%=checkboxContView %>"/>
			</span>
			<%} %>
			 
			<% if (checkboxBrightness.equalsIgnoreCase("1") || checkboxGain.equalsIgnoreCase("1") ||
				   checkboxExposure.equalsIgnoreCase("1")  ||  checkboxCont.equalsIgnoreCase("1")) {%>
				<div>
					<span class="aui-button-content">
						<input type="button" id="submitSetParams" name="submitSetParams" onClick="<portlet:namespace />setValues()" value="<liferay-ui:message key='Submit' />" />
						<input type="button" id="submitGetParams" name="submitGetParams" onClick="<portlet:namespace />getValues()" value="<liferay-ui:message key='Refresh' />" />
					</span>
				</div>
			<%} %>
			
			<% if (checkboxTake.equalsIgnoreCase("1")) {%>
			<div>
				<span class="aui-button aui-button-cancel aui-state-negative"> 
					<span class="aui-button-content"> 
						<input class="aui-button-input aui-button-input-cancel" type="button" id="takeImage" name="takeImage" 
						value="<liferay-ui:message key='Take_Image' />" onclick="<portlet:namespace />showPopup()"/>
					</span>
				</span>
			</div>
			<%} %>
			</div>
			<input type="hidden" id="urlImageTaken" name="urlImageTaken" value=""/>
			<input type="hidden" id="viewMode" name="viewMode" value="viewMode"/>		
	</form>
	
	<form id="<portlet:namespace />WebSizeForm" name="<portlet:namespace />WebSizeForm" action="<%=webCamURL %>" method="post">
	 	<input type="hidden" id="viewModeSize" name="viewModeSize" value="viewModeSize"/>
		<input type="hidden" id="heightCamField" name="heightCamField" value="<%=heightCamField  %>"/>
		<input type="hidden" id="widthCamField" name="widthCamField" value="<%=widthCamField  %>"/>
	</form>
<% } %>
		
					
<script>

	function <portlet:namespace />setValues(){	
		var brightness;
		var gain;
		var exposure;
		var contrast;
		
		<% if (checkboxBrightness.equalsIgnoreCase("1") && !brightness_value.equalsIgnoreCase("error")) { %>
			brightness = document.getElementById("<portlet:namespace />brightness_value").value;
		<% } else {%>
			brightness = "null";
		<% } %>
		<% if (checkboxGain.equalsIgnoreCase("1") && !gain_value.equalsIgnoreCase("error")) {%>
			gain = document.getElementById("<portlet:namespace />gain_value").value;
		<% } else {%>
		gain = "null";
		<% } %>
		<% if (checkboxExposure.equalsIgnoreCase("1") && !expT_value.equalsIgnoreCase("error")) {%>
			exposure = document.getElementById("<portlet:namespace />expT_value").value;
		<% } else {%>
		exposure = "null";
		<% } %>
		<% if (checkboxContrast.equalsIgnoreCase("1") && !contrast_value.equalsIgnoreCase("error")) {%>
			contrast = document.getElementById("<portlet:namespace />contrast_value").value;
		<% } else {%>
		contrast = "null";
		<% } %>
		
		AUI().use('aui-io-request', function(A){
			var url = '<%=setValues%>';
			A.io.request(url, {
				method : 'POST',
				data: {
					'brightness': brightness,
					'gain': gain,
					'exposure': exposure,
					'contrast': contrast
				},
				dataType: 'json',
				on: {
					failure: function() {
					},
					success: function() {    
					}   
				} 
			});
		});
	}
	
	function <portlet:namespace />getValues(){	
		var brightness_field = document.getElementById("<portlet:namespace />brightness_value");
		var gain_field = document.getElementById("<portlet:namespace />gain_value");
		var exposure_field = document.getElementById("<portlet:namespace />expT_value");
		var contrast_field = document.getElementById("<portlet:namespace />contrast_value");
		
		getting_URL=true;
		
		AUI().use('aui-io-request', function(A){
			var url = '<%=getValues%>';
			A.io.request(url, {
				method : 'POST',
				data: {
				},
				dataType: 'json',
				on: {
					failure: function() {
						getting_URL=false;
					},
					success: function() {
						var message = this.get('responseData');
						try {
							getting_URL=false;
							document.getElementById("<portlet:namespace />GLORIAwebcam").src = +message.urlCamField;
						} catch (err) {
							document.getElementById("<portlet:namespace />GLORIAwebcam").src = "<%=request.getContextPath()%>/images/not_available.png";
						}
						document.location.reload();
						//<portlet:namespace />autoLoadImage();
						<% if (checkboxBrightness.equalsIgnoreCase("1") && !brightness_value.equalsIgnoreCase("error")) { %>
						try {
							document.getElementById("<portlet:namespace />brightness_value").value = message.brightness;
						} catch (err) {
							document.getElementById("<portlet:namespace />brightness_value").value = "error";
						}
						<% } %>
						<% if (checkboxGain.equalsIgnoreCase("1") && !gain_value.equalsIgnoreCase("error")) {%>
						try {
							document.getElementById("<portlet:namespace />gain_value").value = message.gain;
						} catch (err) {
							document.getElementById("<portlet:namespace />gain_value").value = "error";
						}
						<% } %>
						<% if (checkboxExposure.equalsIgnoreCase("1") && !expT_value.equalsIgnoreCase("error")) {%>
						try {
							document.getElementById("<portlet:namespace />expT_value").value = message.exposure;
						} catch (err) {
							document.getElementById("<portlet:namespace />expT_value").value = "error";
						}
						<% } %>
						<% if (checkboxContrast.equalsIgnoreCase("1") && !contrast_value.equalsIgnoreCase("error")) {%>
						try {
							document.getElementById("<portlet:namespace />contrast_value").value = message.contrast;
						} catch (err) {
							document.getElementById("<portlet:namespace />contrast_value").value = "error";
						}
						<% } %>
					}   
				} 
			});
		});
	}
	
	
	<% if (checkboxTake.equalsIgnoreCase("1")) {%>
	function <portlet:namespace />showPopup() {
		AUI().use('aui-dialog', 'aui-io', 'event', 'event-custom', function(A) {
		    
		    var dialog = new A.Dialog({
		            title: 'Image taken',
		            centered: true,
		            draggable: true,
		            modal: true,
		            destroyOnClose: true,
		            points: [ 'tl', 'tr' ],
		            message: '<div class="loading-animation" />'
		        }).plug(
		        	A.Plugin.IO, {
		        		uri: '<%= popup %>'
		        	}
		        ).render();
		        
		        dialog.show();		        
		});
	} 
	<%} %>

	function <portlet:namespace />setCookie() {
		var expireDate = new Date();
		expireDate.setMonth(expireDate.getMonth()+6);
		
		document.cookie = "<portlet:namespace />width="+document.getElementById("<portlet:namespace />GLORIAwebcam").width+";expires="+expireDate.toUTCString();
		document.cookie = "<portlet:namespace />height="+document.getElementById("<portlet:namespace />GLORIAwebcam").height+";expires="+expireDate.toUTCString();
	}
	
	<% if (!configured.equalsIgnoreCase("false") && configured!=null) { %>
	YUI().ready('resize', function(A) {
		var img = new A.Resize( { 
			node: '#<portlet:namespace />GLORIAwebcam',
			handles: 'r, br, b',
			on: {
				end: function(event) {
					<portlet:namespace />setCookie();
					//document.<portlet:namespace />WebSizeForm.widthCamField.value= document.getElementById("<portlet:namespace />GLORIAwebcam").width;
					//document.<portlet:namespace />WebSizeForm.heightCamField.value= document.getElementById("<portlet:namespace />GLORIAwebcam").height;
					//document.getElementById("<portlet:namespace />WebSizeForm").submit();
				}
			}
		} );
		img.plug(Y.Plugin.ResizeConstrained, {
			minHeight: 50,
			minWidth: 100,
			constrain: '#<portlet:namespace />outline_CamImg',
			preserveRatio: true
		});
	});
	<% } %>
			
	//Create a YUI instance and request the slider module and its dependencies
	YUI().use("slider", function (Y) {

		var brightness_input,
			gain_input,
			expT_input,
			contrast_input; 


		// Function to pass input value back to the Slider
		function updateSlider( e ) {
		   	var data   = this.getData(),
		       	slider = data.slider,
		       	value  = parseFloat( this.get("value"));
	
		   	if (value == NaN) value = 0;
		   	
		   	if ( data.wait ) {
		       	data.wait.cancel();
		   	}
	
		   	// Update the Slider on a delay to allow time for typing
		   	data.wait = Y.later( 200, slider, function () {
		       	data.wait = null;
		       	//this.set( "value", value );
		   	} );
		}

		// Function to update the input value from the Slider value
		function updateInput( e ) {
	   		this.set( "value", e.newVal );
		}

		<% if (checkboxBrightness.equalsIgnoreCase("1") && !brightness_value.equalsIgnoreCase("error")) { %>
		//Create the BRIGHTNESS Slider.
		brightness_input = Y.one( "#<portlet:namespace />brightness_value" );
		brightness_input.setData( "slider", new Y.Slider({
	           axis: 'x',
	           min   : 0,      // min is the value at the top
	           max   : 63,     // max is the value at the bottom
	           value : <%=brightness_value%>,       // initial value
	          // length: '201px',  // rail extended to afford all values

	           // construction-time event subscription
	           after : {
	               valueChange: Y.bind( updateInput, brightness_input )
	           }
	       }).render( ".<portlet:namespace />brightness_slider" ) // render returns the Slider
	   	)                               // set( "data", ... ) returns the Node
		.on( "keyup", updateSlider );   // chain the keyup subscription
		<% } %>
		<% if (checkboxGain.equalsIgnoreCase("1") && !gain_value.equalsIgnoreCase("error")) {%>
		// Create the GAIN Slider.
		gain_input = Y.one( "#<portlet:namespace />gain_value" );
		gain_input.setData( "slider", new Y.Slider({
	           axis: 'x',
	           min   : 260,      // min is the value at the top
	           max   : 1023,     // max is the value at the bottom
	           value : <%=gain_value%>,       // initial value
	          // length: '201px',  // rail extended to afford all values
	          //thumbUrl: Y.config.base + '/slider-base/assets/skins/capsule/thumb-x-line.png',

	           // construction-time event subscription
	           after : {
	               valueChange: Y.bind( updateInput, gain_input )
	           }
	       }).render('.<portlet:namespace />gain_slider' ) // render returns the Slider
	   	)                               // set( "data", ... ) returns the Node
	   	.on( "keyup", updateSlider );   // chain the keyup subscription
		<% } %>
		<% if (checkboxExposure.equalsIgnoreCase("1") && !expT_value.equalsIgnoreCase("error")) {%>
	   	// Create the EXPOSURE TIME Slider.
		expT_input = Y.one( "#<portlet:namespace />expT_value");
		expT_input.setData( "slider", new Y.Slider({
	           axis: 'x',
	           min   : 0.0001,      // min is the value at the top
	           max   : 3600,     // max is the value at the bottom
	           value : <%=expT_value%>,       // initial value
	          // length: '201px',  // rail extended to afford all values

	          // construction-time event subscription
	            after : {
	               valueChange: Y.bind( updateInput, expT_input )
	           }
	       }).render( ".<portlet:namespace />expT_slider" ) // render returns the Slider
	   	)                               // set( "data", ... ) returns the Node
	   	.on( "keyup", updateSlider );   // chain the keyup subscription
	   	<% } %>
	   	<% if (checkboxContrast.equalsIgnoreCase("1") && !contrast_value.equalsIgnoreCase("error")) {%>
	   	// Create the CONTRAST Slider.
		contrast_input = Y.one( "#<portlet:namespace />contrast_value");
		contrast_input.setData( "slider", new Y.Slider({
	           axis: 'x',
	           min   : 0,      // min is the value at the top
	           max   : 100,     // max is the value at the bottom
	           value : <%=contrast_value%>,       // initial value
	          // length: '201px',  // rail extended to afford all values

	           // construction-time event subscription
	           after : {
	               valueChange: Y.bind( updateInput, contrast_input )
	           }
	       }).render( ".<portlet:namespace />contrast_slider" ) // render returns the Slider
	   	)                               // set( "data", ... ) returns the Node
	   	.on( "keyup", updateSlider );   // chain the keyup subscription
	   	<% } %>
	});
	
</script>	

</body>
</html>