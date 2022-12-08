'use strict';

// let apiUrl = 'https://6100-203-113-147-183.ap.ngrok.io/api/';
let apiUrl = 'http://localhost:8181/api/';

//check user input and call server
$('.sign-in-partner').click(function () {

    //get user input data
    let formPartnerId = $('.partner-id input').val();
    let formCardId = $('.card-id input').val();

    //create json data
    let inputData = '{' + '"partnerId" : "' + formPartnerId + '", ' + '"cardId" : "' + formCardId + '"}';
    console.log(inputData);

    //make ajax call
    $.ajax({
        type: 'POST',
        headers: {
            'Access-Control-Allow-Credentials': 'true',
            'Access-Control-Allow-Origin': '*',
            'Access-Control-Allow-Methods': 'GET,OPTIONS,PATCH,DELETE,POST,PUT',
            'Access-Control-Allow-Headers': 'X-CSRF-Token, X-Requested-With, Accept, Accept-Version, Content-Length, Content-MD5, Content-Type, Date, X-Api-Version',
        },
        url: apiUrl + 'partnerData',
        data: inputData,
        dataType: 'json',
        contentType: 'application/json',
        beforeSend: function () {
            //display loading
            document.getElementById('loader').style.display = 'block';
        },
        success: function (data) {

            //remove loader
            document.getElementById('loader').style.display = 'none';

            //check data for error
            if (data.error) {
                alert(data.error);
                return;
            } else {

                //update heading
                $('.heading').html(function () {
                    let str = '<h2><b> ' + data.name + ' </b></h2>';
                    str = str + '<h2><b> ' + data.id + ' </b></h2>';

                    return str;
                });

                //update dashboard
                $('.dashboards').html(function () {
                    let str = '';
                    str = str + '<h5>Total points allocated to customers: ' + data.pointsGiven + ' </h5>';
                    str = str + '<h5>Total points redeemed by customers: ' + data.pointsCollected + ' </h5>';
                    return str;
                });

                //update earn points transaction
                $('.points-allocated-transactions').html(function () {
                    let str = '';
                    let transactionData = data.earnPointsResults;

                    for (let i = 0; i < transactionData.length; i++) {
                        str = str + '<p>timeStamp: ' + transactionData[i].timestamp + '<br />partner: ' + transactionData[i].partner + '<br />member: ' + transactionData[i].member + '<br />points: ' + transactionData[i].points + '<br />transactionID: ' + transactionData[i].transactionId + '</p><br>';
                    }
                    return str;
                });

                //update use points transaction
                $('.points-redeemed-transactions').html(function () {
                    let str = '';
                    let transactionData = data.usePointsResults;

                    for (let i = 0; i < transactionData.length; i++) {
                        str = str + '<p>timeStamp: ' + transactionData[i].timestamp + '<br />partner: ' + transactionData[i].partner + '<br />member: ' + transactionData[i].member + '<br />points: ' + transactionData[i].points + '<br />transactionID: ' + transactionData[i].transactionId + '</p><br>';
                    }
                    return str;
                });

                //remove login section
                document.getElementById('loginSection').style.display = 'none';
                //display transaction section
                document.getElementById('transactionSection').style.display = 'block';
            }

        },
        error: function (jqXHR, textStatus, errorThrown) {
            //reload on error
            alert('Error: Try again');
            console.log(errorThrown);
            console.log(textStatus);
            console.log(jqXHR);
        }
    });

});
