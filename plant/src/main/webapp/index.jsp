<%@ page pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
	<head>
	
		<title>蕨蘱首頁</title>
	<%@ include file = "subviews/header.jsp" %>
	<%@ include file = "subviews/nav.jsp" %>
		<script type="text/javascript" src="jquery.js"></script>
		<script type="text/javascript">
		var myInterval, index=0;
		$(document).ready(init);
		function init(){
			$(".dot").click(dotHandler);//run the same function
			$("#next,#prev").click(nextPrevHanndler);//run the same function
			myInterval = setTimeout(intervalHandler, 3000);//initial timer
		};
		function dotHandler(){
			index=Number($(this).attr("myIndex"));//get index number
			moveHandler();
		}
		function nextPrevHanndler(){
			index+=Number($(this).attr("direction"));//get move direction
			moveHandler();
		}
		function intervalHandler(){
			index++;//move to next or prev
			moveHandler();
		}
		function moveHandler(){
			clearInterval(myInterval);//reset timer
			myInterval = setTimeout(intervalHandler, 3000);//set timeer
			if (index>4) index=0;//last image
			if (index<0) index=4;//first image
			$(".dot").css("backgroundColor","gray");//reset dot color
			$(".dot:eq("+index+")").css("backgroundColor","white");//set dot color
			$("#imgs").stop().animate({"marginLeft":-index*400 + "px"},1000);//image width=735px
			$("#outer").stop().animate({"backgroundPositionX":-index*200+"px"},1000);//map width=1000px/5=200px
		}
	</script>
	<style>
		body{
			background:white;
		}
		#outer{
			position:relative;
			width:400px;/*image width=753 height=357*/
			overflow:hidden;
			background-image:url(map.png);
			background-color:#f3e5d8;
			margin:100px auto;
		}
		#imgs{
			position:relative;
			width:2000px;/*image width=753x5=3765px*/
			display: flex;
		}
		#prev,#next{
			position:absolute;
			width:30px;
			height:40px;
			color: gray;
			cursor:pointer;
			font-size: 3em;
			top: 200px;
			opacity: 0.8;
		}
		#prev{
			left:0px;
		}
		#next{
			right:0px;
		}
		#prev:hover,#next:hover{
			opacity: 0.5;
		}
		#dots{
			width: 130px; /*(16+5x2)x5=130px*/
			margin: auto;
			display: flex;
		}
		.dot{
			width: 16px;
			height: 16px;
			background-color: gray;
			border-radius: 50%;
			margin: 5px;
			cursor: pointer;
			transition: 0.5s all;
		}
		.dot:nth-child(1){
			background-color: white;
		}
	</style>
</head>
<body>
 		
		 <div id="outer">
	        <div id="imgs" >
				<a href=""><img width="400px" height="400px" src="http://doromon01.com/wp-content/uploads/2019/02/Plants-Market.jpg"></a>
				<a href=""><img width="400px" height="400px" src="http://doromon01.com/wp-content/uploads/2019/03/Variegata-01.jpg"></a>
				<a href=""><img width="400px" height="400px" src="http://doromon01.com/wp-content/uploads/2020/06/greenplant.png"></a>
				<a href=""><img width="400px" height="400px" src="http://doromon01.com/wp-content/uploads/2021/02/Monstera2.jpg"></a>
				<a href=""><img width="400px" height="400px" src="http://doromon01.com/wp-content/uploads/2019/12/%E6%8E%9B%E5%B8%83_%E5%B7%A5%E4%BD%9C%E5%8D%80%E5%9F%9F-1%E5%B0%8F.jpg"></a>
				
			</div>
	        <div id="prev" direction="-1">&ltdot;</div>
			<div id="next" direction="1">&gtdot;</div>
			<div id="dots">
				<div class="dot" myIndex="0"></div>
				<div class="dot" myIndex="1"></div>
				<div class="dot" myIndex="2"></div>
				<div class="dot" myIndex="3"></div>
				<div class="dot" myIndex="4"></div>
				
			</div>
	    </div>
<%@ include file = "subviews/footer.jsp" %>
		</body>