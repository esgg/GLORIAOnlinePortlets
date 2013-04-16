<div id="webcamView" class="yui3-skin-capsule">

	<% if (checkboxBrightness.equalsIgnoreCase("1")) {%>
	<span>
		<label class="aui-field-label" for="<portlet:namespace />brightness_value"><liferay-ui:message key='label-brightness' />: </label>
		<input id="<portlet:namespace />brightness_value" 
			name="brightness_value" 
			value="<%=brightness_value%>"
			/>
		<span class="<portlet:namespace />brightness_slider"></span>
	</span>
	<%} %>

	<% if (checkboxGain.equalsIgnoreCase("1")) {%>
	<span>
		<label class="aui-field-label" for="<portlet:namespace />gain_value"><liferay-ui:message key='label-gain' />: </label>
		<input id="<portlet:namespace />gain_value" 
			name="gain_value" 
			value="<%=gain_value%>"
			/>
		<span class="<portlet:namespace />gain_slider"></span>
	</span>	
	<%} %>

	<% if (checkboxExposure.equalsIgnoreCase("1")) {%>
	<span>
		<label class="aui-field-label" for="<portlet:namespace />expT_value"><liferay-ui:message key='label-exposure-time' />: </label> 
   		<input id="<portlet:namespace />expT_value" 
   			name="expT_value" 
   			value="<%=expT_value%>"
   			/>
		<span class="<portlet:namespace />expT_slider"></span>
	</span>	
	<%} %>

	<% if (checkboxCont.equalsIgnoreCase("1")) {%>
	<span class="aui-field-content">
		<label for="<portlet:namespace />checkboxContView"><liferay-ui:message key='label-continuous-mode' />: </label>
		<input checked="true"
   			class="aui-field-input aui-field-input-checkbox" 
   			id="<portlet:namespace />checkboxContView" 
   			name="checkboxContView" 
			type="checkbox" 
			value="<%=checkboxContView %>"
			/>
	</span>
	<%} %>
</div>

<script>

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

	