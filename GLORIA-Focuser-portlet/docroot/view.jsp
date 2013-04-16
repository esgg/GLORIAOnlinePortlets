<%
/**
 * Copyright (c) 2000-2011 Liferay, Inc. All rights reserved.
 *
 * This library is free software; you can redistribute it and/or modify it under
 * the terms of the GNU Lesser General Public License as published by the Free
 * Software Foundation; either version 2.1 of the License, or (at your option)
 * any later version.
 *
 * This library is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more
 * details.
 */
%>
<%@ include file="/jsp/init.jsp" %>

<portlet:resourceURL var="operationFocuser" id="operationFocuser">
	<portlet:param name="control" value="operation"/>
</portlet:resourceURL>

<html>
<head>
<title>focuser control</title>
</head>
<body>
<fieldset Class="infoField">
	<legend><span><liferay-ui:message key="legend-status"/></span></legend>
	<span class="status-span">
		<label class="status-label"> <liferay-ui:message key="label-status"/>: </label>
		<label class="status-field status-field-ok" id="<portlet:namespace />status"><liferay-ui:message key="label-ready"/> </label>
	</span>
	<span class="status-span">
		<input class="aui-button-input"
				id="<portlet:namespace />moveOut" 
				name="moveOut"  
				type="button" 
				value="<liferay-ui:message key='button-moveOut' />" 
				onClick="<portlet:namespace />move('out')"
				/>
		<input class="aui-button-input"
				id="<portlet:namespace />moveIn"
				name="moveOut"  
				type="button" 
				value="<liferay-ui:message key='button-moveIn' />"
				onClick="<portlet:namespace />move('in')"
				/>
	</span>
</fieldset>
</body>
<script>
function <portlet:namespace />move(direction){
	
	var status = document.getElementById("<portlet:namespace />status");
	
	//check if is a number
	
	
		AUI().use('aui-io-request', function(A){
			var url = '<%=operationFocuser%>';
			status.innerHTML='<liferay-ui:message key="label-status-moving"/>';
			A.io.request(url, {
				method : 'POST',
				data:{
					'operation':'move',
					'direction':direction,
				},
				dataType: 'json',
				on: {
					failure: function() {
						
					},
					success: function() {
						var response = this.get('responseData');
						if (response.success == true){
							status.innerHTML=response.message;
						} else {
							status.innerHTML=response.message;
						}
					}
				}//on
			});//A.io
		});
	
}
</script>
</html>