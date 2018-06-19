<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html lang="ru">
<head>
	<%@ page contentType="text/html; charset=WINDOWS-1251" pageEncoding="WINDOWS-1251" %>
	<!-- Access the bootstrap Css like this,
		Spring boot will handle the resource mapping automcatically -->
	<link rel="stylesheet" type="text/css" href="webjars/bootstrap/3.3.7/css/bootstrap.min.css" />
	<!--
	<%--<spring:url value="/css/main.css" var="springCss" />--%>
	<%--<link href="${springCss}" rel="stylesheet" />--%>
	 -->
	<%--<c:url value="/css/main.css" var="jstlCss" />--%>
	<%--<link href="${jstlCss}" rel="stylesheet" />--%>

</head>
<body>

	<div class="container">
        <span id="updatedOn"></span>
        <table class="table bordered">
            <thead>
                <tr>
                    <td>ДАТА</td>
                    <td>MATCH</td>
                    <td>CATEGORY</td>
					<td>Был доступен последний раз</td>
                </tr>
            </thead>
            <tbody>

            </tbody>
        </table>
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
        let needAlarm = false;
		let sound =  new Audio("http://www.superluigibros.com/downloads/sounds/GAMECUBE/SUPERMARIOSUNSHINE/WAV/shineget.wav");
		let lastCacheDate;
		let Main = {


            load : function () {
				needAlarm = false;
                $.ajax({
                    url: '/get-data',
                    type: 'GET',
                    success: function(data){
                    	if (lastCacheDate > new Date(data.CachedOn)) {
                    		return false;
						} else {
							lastCacheDate = new Date(data.CachedOn);
						}

                        let newData = data.Data.Availability.filter(av => {
                            return need.find(n => n == av.p) && av.a
								&& (av.p !== "IMT23" && av.c !== 56)
								&& (av.c === 16 || av.c === 17 || av.c === 56)
                        });

                        newData.forEach(dat => {
                        	let findInResult = result.find(r =>  r.p === dat.p && r.c === dat.c);

                            if (findInResult) {
								if (!findInResult.available) {
									needAlarm = true;
								}
								findInResult.lastAvailable = new Date(data.CachedOn);
								findInResult.available = true;
								findInResult.isNew = false;
                            } else {
								needAlarm = true;
								dat.lastAvailable = new Date(data.CachedOn);
								findInResult = dat;
								findInResult.isNew = true;
								findInResult.available = true;
								result.push(findInResult);
							}
                        });

                        result.forEach((res, index) => {
							let findInNewDat = newData.find(r =>  r.p === res.p && r.c === res.c);
							if (!findInNewDat) {
								if (new Date(data.CachedOn) - res.lastAvailable > 3600000) {
									result.splice(index, 1);
								}

								res.available = false;
							}
						});



                        $('table').find('tbody').empty();

                        result.forEach(res => {
                            let match =  data.Data.PRODUCTIMT.find(prod => prod.ProductId == res.p);
                            let category =  data.Data.CATEGORIES.find(cat => cat.CategoryId == res.c);

                            let tr =
                                "<tr" + (res.available ? ' class =\"success\"' : ' class =\"danger\"') + ">" +
                                    '<td>' +
                                        match.MatchDate +
                                    '</td>' +
                                    '<td>' +
                                        match.ProductPublicName +
                                    '</td>' +
                                    '<td>' +
                                        category.CategoryNameOnTicket +
                                    '</td>' +
									'<td>' +
										res.lastAvailable +
									'</td>' +
                                '</tr>';


                            $('table').find('tbody').append(tr);
                        });

						$('#updatedOn').text("Updated on: " + lastCacheDate);
						if (needAlarm) {
							sound.play();
						}
                    }
                });
                // https://tickets.fifa.com/API/WCachedL1/ru/BasicCodes/GetBasicCodesAvailavilityDemmand?currencyId=USD
            }
        }

        setInterval(function(){ console.log("Hello"); Main.load() }, 2000);


       </script>

</body>

</html>