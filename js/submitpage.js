function validateForm() {
    let name1 = $("#Fname").val();
    let name2 = $("#Lname").val();
    let date = $("#dob").val();
    let pass = $("#Password").val();
    let cpass = $("#CPassword").val();
    let isValide = true;
    if (name1 == "" || name1 == null) {
        $("#Fnameval").show().css("color", "red");
        isValide = false;
    }
    if (name2 == "" || name2 == null) {
        $("#Lnameval").show().css("color", "red");
        isValide = false;
    }
    if (date == null || date == "") {
        $("#dobval").show().css("color", "red");
        isValide = false;
    }

    if (pass == null || pass == "") {
        $("#passval").show().css("color", "red");
        isValide = false;
    }
    if (cpass == null || cpass == "") {
        $("#Cpassval").show().css("color", "red");
        isValide = false;
    }
    return isValide;
}
/////////////////////////////////////////////////////////////////////////

$("#Password").blur(function() {
    if ($("#Password").val() == null || $("#Password").val() == "") {
        $("#passval").show().css("color", "red");
    } else {
        $("#passval").hide();
    }
});

$("#CPassword").blur(function() {
    if ($("#CPassword").val() == null || $("#CPassword").val() == "") {
        $("#Cpassval").show().css("color", "red");
    } else {
        $("#Cpassval").hide();
    }
});

$("#Fname").blur(function() {
    var NameVal;
    var letters = /^[A-Za-z]+$/;
    if ($("#Fname").val().match(letters)) {
        $("#Fnameval").hide();
        NameVal = true;
    } else if ($(this).val() == null || $(this).val() == "") {
        $("#Fnameval").show().css("color", "red");
    } else {
        alert("Name Can't take numbers");
        $("#Fnameval").show().css("color", "red");

        return false;
    }
});

$("#Lname").blur(function() {
    var NameVal;
    var letters = /^[A-Za-z]+$/;
    if ($("#Lname").val().match(letters)) {
        $("#Lnameval").hide();
        NameVal = true;
    } else if ($(this).val() == null || $(this).val() == "") {
        $("#Lnameval").show().css("color", "red");
    } else {
        alert("Name Can't take numbers");
        $("#Lnameval").show().css("color", "red");

        return false;
    }
});

var dobValidation;
$("#dob").blur(function() {
    var mydate = new Date($(this).val());
    var birthyear = mydate.getFullYear();
    var today = new Date();
    var yearnow = today.getFullYear();
    if ($(this).val() == "") {
        $("#dobvalidation").show().css("color", "red");
    } else {
        $("#dobvalidation").hide();
        dobValidation = true;
    }
});

$("#submit").click(function() {
    if (validateForm()) {
        var dataTobeSent = JSON.stringify({
            FirstName: $("#Fname").val(),
            LastName: $("#Lname").val(),
            dateOfBirth: $("#dob").val(),
            Password: $("#Password").val(),
        });
        var datatobesentlogin = JSON.stringify({
            Password: $("#Password").val(),
        });
        $.ajax({
            type: "POST",
            dataType: "json",
            url: "https://localhost:44350/api/User/createuser",
            data: dataTobeSent,
            contentType: "application/x-www-form-urlencoded",
            headers: {
                "Content-Type": "application/json",
                "Access-Control-Allow-Origin": "*",
                "Access-Control-Allow-Headers": "*",
                "Access-Control-Allow-Methods": "*",
            },
            crossDomain: true,
            success: function(response) {
                console.log("eshta 3aleek yasta");
                $.ajax({
                    type: "POST",
                    dataType: "json",
                    url: "https://localhost:44350/api/User/getyourID",
                    data: datatobesentlogin,
                    contentType: "application/x-www-form-urlencoded",
                    headers: {
                        "Content-Type": "application/json",
                        "Access-Control-Allow-Origin": "*",
                        "Access-Control-Allow-Headers": "*",
                        "Access-Control-Allow-Methods": "*",
                    },
                    crossDomain: true,
                    success: function(response) {
                        alert("your UserId is " + response);
                        window.location = "../html/login.html";
                    },
                    error: function(error) {
                        console.log("mesh eshta 3aleek yasta");
                        return false;
                    },
                });
            },
            error: function(error) {
                console.log("mesh eshta 3aleek yasta");
                alert("submit correctly please!");
                return false;
            },
        });
    }
});