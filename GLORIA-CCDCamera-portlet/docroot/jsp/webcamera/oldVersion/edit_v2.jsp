<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/init.jsp" %>


<%--  include file="/tabs/tab1.jsp"  --%>
<%--  include file="/tabs/tab2.jsp"  --%>


<div id="settingWebcamera2"></div>

<div id="<portlet:namespace />settingWebcamera">
    <ul id="listnode">
        <li><a href="#tab1"><liferay-ui:message key='General_settings' /></a></li>
        <li><a href="#tab2"><liferay-ui:message key='Visibility_options' /></a></li>
    </ul>
    <div id="content">
        <div id="tab1">
			<%@ include file="/tabs/tab1.jsp" %>
        </div>
        <div id="tab2">
			<%@ include file="/tabs/tab2.jsp" %>
        </div>
    </div>
</div>

<!-- 

<script>/*<![CDATA[*/
	// ALLOW UI
	AUI().ready('aui-tabs', function(A) { 
		var tabs = new A.TabView( { 
			boundingBox: '#settingWebcamera', 
			items: [ 
				{ 
					contentNode: '#divFormCamera',
					label: 'General settings', 
				}, 
				{ 
					contentNode: '#divVisibilityeCam',
					label: 'Visibility options' 
				}, 
				{ 
					content: 'This my content 3',
					label: 'Tab 3' 
				}
			] 
		} ) .render(); 
	});
/*]]>*/</script>
 -->

<script>/*<![CDATA[*/
    // YAHOO UI
	YUI({filter:'raw'}).use("yui", "tabview", function(Y) {    
		var tabview = new Y.TabView({
			srcNode:'#<portlet:namespace />settingWebcamera'
		});    
		tabview.render();
	});
/*]]>*/</script>


