<!--  PopUp  -->
<jsp:useBean id="popupImgURL" class="java.lang.String" scope="request" />
<jsp:useBean id="popupImgFits" class="java.lang.String" scope="request" />
<jsp:useBean id="errorImage" class="java.lang.String" scope="request" />
<HTML>
<HEAD>
</HEAD>
<BODY>

<div class="imgView">
	<% if (!errorImage.equals("error")){%>
		<img src="<%=popupImgURL %>" width="800px" height="600px"/>
	<% } else {%>
		<img src="<%=popupImgURL %>" width="200x" height="125px"/>
	<% } %>
	 
</div> 
<% if (!errorImage.equals("error")){%>
	<div>
	<a href="<%=popupImgFits%>"><img width="64px" height="64px" src="<%=request.getContextPath()%>/images/download.png"></img></a>
	</div>
<% } %>	
</BODY>
</HTML>