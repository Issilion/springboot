let result = [];
let Main = {


    load : function () {
        $.ajax({
            url: 'https://tickets.fifa.com/API/WCachedL1/ru/BasicCodes/GetBasicCodesAvailavilityDemmand?currencyId=USD',
            success: function(data){
                console.log(data);
                alert('Load was performed.');
            }
        });
        // https://tickets.fifa.com/API/WCachedL1/ru/BasicCodes/GetBasicCodesAvailavilityDemmand?currencyId=USD
    }
}