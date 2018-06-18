<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html lang="en">
<head>

	<!-- Access the bootstrap Css like this,
		Spring boot will handle the resource mapping automcatically -->
	<%--<link rel="stylesheet" type="text/css" href="webjars/bootstrap/3.3.7/css/bootstrap.min.css" />--%>

	<!--
	<%--<spring:url value="/css/main.css" var="springCss" />--%>
	<%--<link href="${springCss}" rel="stylesheet" />--%>
	 -->
	<%--<c:url value="/css/main.css" var="jstlCss" />--%>
	<%--<link href="${jstlCss}" rel="stylesheet" />--%>

</head>
<body>

	<div class="container">

	</div>
    <script src="https://code.jquery.com/jquery-3.3.1.min.js"
            integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
            crossorigin="anonymous"></script>

	<script type="text/javascript" src="webjars/bootstrap/3.3.7/js/bootstrap.min.js"></script>

    <script type="text/javascript">
        let result = [];
        let need = ['IMT15', 'IMT19', 'IMT23', 'IMT29', 'IMT30' ,'IMT37' ,'IMT41' ,'IMT51' ,'IMT52', 'IMT56' , 'IMT57'
            ,'IMT62'
            ,'IMT64'];
        let Main = {


            load : function () {
                $.ajax({
                    url: '/get-data',
                    dataType: 'jsonp',
                    success: function(data){
                        console.log(data.DATA   );
                        alert('Load was performed.');
                    }
                });
                // https://tickets.fifa.com/API/WCachedL1/ru/BasicCodes/GetBasicCodesAvailavilityDemmand?currencyId=USD
            }
        }
        Main.load()
       </script>

</body>

</html>