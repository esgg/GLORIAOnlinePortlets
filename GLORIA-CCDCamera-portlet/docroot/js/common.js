function submitform(form) {
	document.getElementById(form).submit();	
}

function desactiveSelect(select) {
	var field = document.getElementById(select);
	field.selectedIndex = "0";
}

function setCookie(namespace, image) {
	var expireDate = new Date();
	expireDate.setMonth(expireDate.getMonth()+6);
	
	document.cookie = namespace+"width="+document.getElementById(namespace+image).width+";expires="+expireDate.toUTCString();
	document.cookie = namespace+"height="+document.getElementById(namespace+image).height+";expires="+expireDate.toUTCString();
}

function ClearOptionsFast(id)
{
	var selectObj = document.getElementById(id);
	var selectParentNode = selectObj.parentNode;
	var newSelectObj = selectObj.cloneNode(false); // Make a shallow copy
	selectParentNode.replaceChild(newSelectObj, selectObj);
	return newSelectObj;
}