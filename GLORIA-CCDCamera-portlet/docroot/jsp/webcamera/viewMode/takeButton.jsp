<div>
	<span class="aui-button aui-button-cancel aui-state-negative"> 
		<span class="aui-button-content"> 
			<input class="aui-button-input aui-button-input-cancel" 
				type="button" 
				id="takeImage" 
				name="takeImage" 
				value="<liferay-ui:message key='button-take_image' />" 
				onclick="<portlet:namespace />showPopup()"/>
		</span>
	</span>
</div>

<script>
function <portlet:namespace />showPopup() {
	var exposure = document.getElementById("<portlet:namespace />expT_value");

	AUI().use('aui-dialog', 'aui-io', 'event', 'event-custom', function(A) {
	    
	    var dialog = new A.Dialog({
	            title: 'DBx 41Au02.AS',
	            centered: false,
	            draggable: true,
	            modal: true,
	            destroyOnClose: true,
	            position: 'absolute',
	            x: '0',
	            y:'0',
	            points: [ 'tl', 'tr' ],
	            message: '<div class="loading-animation" />'
	        }).plug(
	        	A.Plugin.IO, {
	        		uri: '<%= popup %>',
	        		data: {
	        			"exposure": exposure.value
	        		}
	        	}
	        ).render();
	        
	        dialog.show();		        
	});
} 
</script>