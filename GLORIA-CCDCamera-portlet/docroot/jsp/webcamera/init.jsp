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

<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Arrays" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ResourceBundle" %>

<portlet:defineObjects />

<!--  General Settings -->

<jsp:useBean id="prefsURL" class="java.lang.String" scope="request"/>
<jsp:useBean id="widefieldURL" class="java.lang.String" scope="request"/>
<jsp:useBean id="prefsLocation" class="java.lang.String" scope="request"/>
<jsp:useBean id="prefsWidth" class="java.lang.String" scope="request"/>
<jsp:useBean id="prefsHeight" class="java.lang.String" scope="request"/>


<!--  Visibility options  -->
<jsp:useBean id="checkboxBrightness" class="java.lang.String" scope="request"/>
<jsp:useBean id="checkboxGain" class="java.lang.String" scope="request"/>
<jsp:useBean id="checkboxExposure" class="java.lang.String" scope="request"/>
<jsp:useBean id="checkboxTake" class="java.lang.String" scope="request"/>
<jsp:useBean id="checkboxCont" class="java.lang.String" scope="request"/>
<jsp:useBean id="checkboxContrast" class="java.lang.String" scope="request"/>

<!--  View Mode  -->
<jsp:useBean id="configured" class="java.lang.String" scope="request" />

<jsp:useBean id="operation" class="java.lang.String" scope="request" />

<jsp:useBean id="checkboxContView" class="java.lang.String" scope="request"/>
<jsp:useBean id="brightness_value" class="java.lang.String" scope="request" />
<jsp:useBean id="gain_value" class="java.lang.String" scope="request" />
<jsp:useBean id="expT_value" class="java.lang.String" scope="request" />
<jsp:useBean id="contrast_value" class="java.lang.String" scope="request" />

<!--  PopUp  -->
<jsp:useBean id="popupImgURL" class="java.lang.String" scope="request" />
