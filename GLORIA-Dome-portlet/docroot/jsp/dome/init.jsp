<%@ taglib uri="http://java.sun.com/portlet_2_0" prefix="portlet" %>
<%@ taglib uri="http://liferay.com/tld/aui" prefix="aui"%>
<%@ taglib uri="http://liferay.com/tld/ui" prefix="liferay-ui" %>

<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Arrays" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ResourceBundle" %>

<portlet:defineObjects />

<jsp:useBean id="configured" class="java.lang.String" scope="request" />
<jsp:useBean id="dome" class="java.lang.String" scope="request"/>

<jsp:useBean id="showControlPanel" class="java.lang.String" scope="request"/>
<jsp:useBean id="showOpenButton" class="java.lang.String" scope="request"/>
<jsp:useBean id="showCloseButton" class="java.lang.String" scope="request"/>