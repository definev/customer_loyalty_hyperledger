'use strict';

let apiUrl = 'https://6100-203-113-147-183.ap.ngrok.io/api/';

console.log('at register.js');

//check user input and call server to create dataset
$('.register-member').click(function () {

    //get user input data
    let formAccountNum = $('.account-number input').val();
    let formCardId = $('.card-id input').val();
    let formFirstName = $('.first-name input').val();
    let formLastName = $('.last-name input').val();
    let formEmail = $('.email input').val();
    let formPhoneNumber = $('.phone-number input').val();

    //create json data
    let inputData = '{' + '"firstname" : "' + formFirstName + '", ' + '"lastname" : "' + formLastName + '", ' + '"email" : "' + formEmail + '", ' + '"phoneNumber" : "' + formPhoneNumber + '", ' + '"accountNumber" : "' + formAccountNum + '", ' + '"cardId" : "' + formCardId + '"}';
    console.log(inputData);

    //make ajax call to add the dataset
    $.ajax({
        type: 'POST',
        crossDomain: true,
        url: apiUrl + 'registerMember',
        headers: {
            'Access-Control-Allow-Credentials': 'true',
            'Access-Control-Allow-Origin': '*',
            'Access-Control-Allow-Methods': 'GET,OPTIONS,PATCH,DELETE,POST,PUT',
            'Access-Control-Allow-Headers': 'X-CSRF-Token, X-Requested-With, Accept, Accept-Version, Content-Length, Content-MD5, Content-Type, Date, X-Api-Version',
        },
        data: inputData,
        dataType: 'json',
        contentType: 'application/json',
        beforeSend: function () {
            //display loading
            document.getElementById('registration').style.display = 'none';
            document.getElementById('loader').style.display = 'block';
        },
        success: function (data) {

            //remove loader
            document.getElementById('loader').style.display = 'none';

            //check data for error
            if (data.error) {
                document.getElementById('registration').style.display = 'block';
                alert(data.error);
                return;
            } else {
                //notify successful registration
                document.getElementById('successful-registration').style.display = 'block';
                document.getElementById('registration-info').style.display = 'none';
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


//check user input and call server to create dataset
$('.register-partner').click(function () {

    //get user input data
    let formName = $('.name input').val();
    let formPartnerId = $('.partner-id input').val();
    let formCardId = $('.card-id input').val();

    //create json data
    let inputData = '{' + '"name" : "' + formName + '", ' + '"partnerId" : "' + formPartnerId + '", ' + '"cardId" : "' + formCardId + '"}';
    console.log(inputData);

    //make ajax call to add the dataset
    $.ajax({
        type: 'POST',
        url: apiUrl + 'registerPartner',
        data: inputData,
        dataType: 'json',
        contentType: 'application/json',
        beforeSend: function () {
            //display loading
            document.getElementById('registration').style.display = 'none';
            document.getElementById('loader').style.display = 'block';
        },
        success: function (data) {

            //remove loader
            document.getElementById('loader').style.display = 'none';

            //check data for error
            if (data.error) {
                document.getElementById('registration').style.display = 'block';
                alert(data.error);
                return;
            } else {
                //notify successful registration
                document.getElementById('successful-registration').style.display = 'block';
                document.getElementById('registration-info').style.display = 'none';
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
