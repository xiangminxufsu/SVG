 

   <CFQUERY NAME="FindID" DATASOURCE="FNAI_biotics"> 
	  SELECT * FROM CountySumryTableNew WHERE 0=0 
      <CFIF #myID# is not "">
				 AND ID = #myID#
	  <cfelse>
	  			AND ID = 1
      </CFIF>
    </CFQUERY>
    <CFQUERY NAME="AllCounties" DATASOURCE="FNAI_counties"> 
	  SELECT * FROM Counties
    </CFQUERY>


	<cfset TotalCounties = #AllCounties.RecordCount#>

<html>
<head>
<title>Florida SVG</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<script language="JavaScript" src="data.js"></script>

	
<script language="JavaScript">
var PreviousCounty='0';
function myload() {
	var svgobj;
	var svgstyle;
	var svgdoc = document.theMap.getSVGDocument();
	displayCounty();
}
var iCounty = 0;
var Counties=[
			'','','','','','','','','','','','','','','',
			'','','','','','','','','','','','','','','',
			'','','','','','','','','','','','','','','',
			'','','','','','','','','','','','','','','',
			'','','','','','','','','','','','','','',''
			];


function searchCounty(name) {
	var i = 0;
	while (i < nCounties){
		if (mData[i] == name) {
			Counties[iCounty] = i;
			iCounty++;
			i=nCounties;
		}
		i++;
	}
}

function displayCounty() {
	for (i=0; i<iCounty; i++) {
		svgdoc = document.theMap.getSVGDocument();
		obj='Flacounties'+Counties[i];
		svgobj = svgdoc.getElementById(obj);
		svgstyle = svgobj.getStyle();

	//	color='#ccffcc';
		color='#FFFF00';
		svgstyle.setProperty('fill',color);
		
	}
}

function id(theme,id) {
}

function showLabel (evt,info) {
}




function switchColor (evt,property,newcolor){
	var target = get_target(evt);
	var svgdoc = target.getOwnerDocument();
	target.getStyle().setProperty (property, newcolor);
}

function get_target (evt) {
	var target = evt.getTarget();
	while (target && !target.getAttribute('id'))
	target = target.getParentNode();
	return target;
}



// theme not used in here. just ignore.
function over(evt,id,what) {
//	showLabel(evt,mData[id]);

    	var mytext = document.getElementById("text");
//alert(mytext.style.color);
	mytext.style.color = "336600";


//alert(mytext.style.background-color);

//	mytext.style.background-color="336600";
	mytext.firstChild.nodeValue=mData[id];
	for(i = 0; i < nCounties; i++)
	{
		if(Counties[i] == id)
		{
			mytext.style.color = "red";
//			mytext.style.background-color="yellow";
			break;
		}
	}

//alert(mytext.width);
//alert(mytext.firstChild.nodeValue);

}

function out(theme,id,what) 
{
	var mytext = document.getElementById("text");
	mytext.firstChild.nodeValue="";
}

</script>

<body bgcolor="#ffffff" text="#000000" onload="myload();">	


<div id="instruc" style="top:0;left:0;z-index:1;width:99;font-size:7pt;font-family:verdana;">
Zoom In<br>(Ctrl + click)<br><br>
Zoom Out<br>(Ctrl-Shift + click)
<br><br>Pan (Alt + drag)
</div>

</td><td>

<div id="flamap" style="position:absolute;top:0;left:110;z-index:0;">
  <EMBED WIDTH="200" HEIGHT="180" SRC="FlMap2.svg" NAME="theMap" type="image/svg-xml"> 
</div>

<div id="thelabel" style="position:absolute;top:140;left:10;z-index:1;
font-family:verdana;font-size:10pt;">
County:</div>

<div id="text" style="position:absolute;top:155;left:10;z-index:1;background-color:white;font-weight:bold;
font-family:verdana;font-size:14px;color:#336600">
&nbsp;
</div>



</td></tr></table>



<cfset i = 1>
<cfset MyCount = ArrayNew(1)>
<cfoutput query="AllCounties">
	<cfset MyCount[#i#] = #Name#>
	<cfset i = i + 1>
</cfoutput>

<cfloop index="i" from=1 to=#TotalCounties# step=1>
  <cfset tmp = MyCount[#i#]>
  <cfoutput query="FindID">
  	<cfif Evaluate(#tmp#) eq 1>
		<script language="JavaScript">

			searchCounty("#tmp#");
		</script>
	</cfif>
  </cfoutput>
</cfloop>
</body>
</html>

    