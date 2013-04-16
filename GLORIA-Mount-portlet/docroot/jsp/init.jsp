<%@ taglib uri="http://java.sun.com/portlet_2_0" prefix="portlet" %>
<%@ taglib uri="http://liferay.com/tld/aui" prefix="aui"%>
<%@ taglib uri="http://liferay.com/tld/ui" prefix="liferay-ui" %>

<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Arrays" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ResourceBundle" %>

<%--
<jsp:useBean id="deviceObject" scope="request" class="eu.gloria.website.liferay.portlets.experiment.online.objects.DevicesObject"/>
<jsp:useBean id="astronomicalObject" scope="request" class="eu.gloria.website.liferay.portlets.experiment.online.objects.AstronomicalObjects"/>
<jsp:useBean id="mountServices" scope="request" class="eu.gloria.website.liferay.portlets.experiment.services.MountServices"/>
 --%>
 
<portlet:defineObjects />

<jsp:useBean id="configured" class="java.lang.String" scope="request" />

<jsp:useBean id="prefsMode" class="java.lang.String" scope="request" />
<jsp:useBean id="prefsEpoch" class="java.lang.String" scope="request" />
<jsp:useBean id="prefsObject" class="java.lang.String" scope="request" />

<jsp:useBean id="showSpeedPanel" class="java.lang.String" scope="request"/>
<jsp:useBean id="showPointerPanel" class="java.lang.String" scope="request"/>
<jsp:useBean id="showInfoPanel" class="java.lang.String" scope="request"/>
<jsp:useBean id="showRaDecPanel" class="java.lang.String" scope="request"/>
<jsp:useBean id="showEpochPanel" class="java.lang.String" scope="request"/>
<jsp:useBean id="showObjectPanel" class="java.lang.String" scope="request"/>
<jsp:useBean id="showModePanel" class="java.lang.String" scope="request"/>

<jsp:useBean id="raInfo" class="java.lang.String" scope="request" />
<jsp:useBean id="decInfo" class="java.lang.String" scope="request" />
<jsp:useBean id="azInfo" class="java.lang.String" scope="request" />
<jsp:useBean id="altInfo" class="java.lang.String" scope="request" />

<!-- Remaining movements -->
<jsp:useBean id="remainingRight" class="java.lang.String" scope="request"/>
<jsp:useBean id="remainingLeft" class="java.lang.String" scope="request"/>
<jsp:useBean id="remainingUp" class="java.lang.String" scope="request"/>
<jsp:useBean id="remainingDown" class="java.lang.String" scope="request"/>


<%	
	ResourceBundle rb =  ResourceBundle.getBundle("content.mount.Language"); 
%>