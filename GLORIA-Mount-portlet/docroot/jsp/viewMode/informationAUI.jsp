<%@ include file="/init.jsp" %>

<jsp:useBean id="raInfo" class="java.lang.String" scope="request" />
<jsp:useBean id="decInfo" class="java.lang.String" scope="request" />
<jsp:useBean id="azInfo" class="java.lang.String" scope="request" />
<jsp:useBean id="altInfo" class="java.lang.String" scope="request" />

<aui:input name="raInfo" label="label-ra" inlineField="true" disabled="true" cssClass="infoField" value="<%= raInfo %>"/>
<aui:input name="decInfo" label="label-dec"  inlineField="true" disabled="true" cssClass="infoField" value="<%= decInfo %>"/>
<aui:input name="azInfo" label="label-az" inlineField="true" disabled="true" cssClass="infoField" value="<%= azInfo %>"/>
<aui:input name="altInfo" label="label-alt" inlineField="true" disabled="true" cssClass="infoField" value="<%= altInfo %>"/>