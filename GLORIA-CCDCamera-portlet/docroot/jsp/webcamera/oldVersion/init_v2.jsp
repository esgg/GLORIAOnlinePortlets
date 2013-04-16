<%-- <%@ include file="/html/portlet/init.jsp" --%> 

<%@ taglib uri="http://liferay.com/tld/aui" prefix="aui"%>
<%@ taglib uri="http://liferay.com/tld/ui" prefix="liferay-ui" %>
<%@ taglib uri="http://java.sun.com/portlet_2_0" prefix="portlet" %>

<%@ page import="com.liferay.portal.kernel.util.InfrastructureUtil" %>
<%@ page import="com.liferay.portal.kernel.util.ParamUtil" %>
<%@ page import="com.liferay.portal.kernel.util.Validator" %>
<%@ page import="com.liferay.portlet.PortletPreferencesFactoryUtil" %>
<%@ page import="com.liferay.portlet.PortletURLUtil" %>
<%@ page import="javax.portlet.PortletPreferences" %>
<%@ page import="javax.portlet.RenderRequest" %>
<%@ page import="javax.portlet.PortletURL" %>

<!--  A LITTLE TRICK -->
<%!
	String instanceID;
	String[] portletID;
%>
<%
	portletID = ((String) request.getAttribute("PORTLET_ID")).split("_");
	
	if (portletID.length > 0) {
		instanceID = portletID[portletID.length  -1];
	}
	
%>


<!--  General Settings  -->
<jsp:useBean id="Tab1URL" class="java.lang.String" scope="request" />
<jsp:useBean id="titleCamField" class="java.lang.String" scope="request"/>
<jsp:useBean id="descCamField" class="java.lang.String" scope="request"/>
<jsp:useBean id="urlCamField" class="java.lang.String" scope="request"/>
<jsp:useBean id="locCamField" class="java.lang.String" scope="request"/>
<jsp:useBean id="widthCamField" class="java.lang.String" scope="request"/>
<jsp:useBean id="heightCamField" class="java.lang.String" scope="request"/>
<jsp:useBean id="timeCamField" class="java.lang.String" scope="request"/>
<jsp:useBean id="obsSelected_cam" class="java.lang.String" scope="request" />
<jsp:useBean id="telSelected_cam" class="java.lang.String" scope="request" />

<jsp:useBean id="ListObs" class="java.lang.String" scope="request" />
<jsp:useBean id="ListTels" class="java.lang.String" scope="request" />
<jsp:useBean id="ListCCDCams" class="java.lang.String" scope="request" />
<jsp:useBean id="ListSurvCams" class="java.lang.String" scope="request" />
<jsp:useBean id="Observatory" class="java.lang.String" scope="request" />
<jsp:useBean id="Telescope" class="java.lang.String" scope="request" />
<jsp:useBean id="ccdCamera" class="java.lang.String" scope="request" />
<jsp:useBean id="survCamera" class="java.lang.String" scope="request" />


<!--  Visibility options  -->
<jsp:useBean id="Tab2URL" class="java.lang.String" scope="request" />
<jsp:useBean id="checkboxBrightness" class="java.lang.String" scope="request"/>
<jsp:useBean id="checkboxGain" class="java.lang.String" scope="request"/>
<jsp:useBean id="checkboxExposure" class="java.lang.String" scope="request"/>
<jsp:useBean id="checkboxTake" class="java.lang.String" scope="request"/>
<jsp:useBean id="checkboxCont" class="java.lang.String" scope="request"/>
<jsp:useBean id="checkboxContrast" class="java.lang.String" scope="request"/>

<!--  View Mode  -->
<jsp:useBean id="configured" class="java.lang.String" scope="request" />

<jsp:useBean id="checkboxContView" class="java.lang.String" scope="request"/>
<jsp:useBean id="brightness_value" class="java.lang.String" scope="request" />
<jsp:useBean id="gain_value" class="java.lang.String" scope="request" />
<jsp:useBean id="expT_value" class="java.lang.String" scope="request" />
<jsp:useBean id="contrast_value" class="java.lang.String" scope="request" />

<!--  PopUp  -->
<jsp:useBean id="popupImgURL" class="java.lang.String" scope="request" />
