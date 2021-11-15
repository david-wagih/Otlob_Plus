// const ID = document.getElementById("usertext");
// const password = document.getElementById("keytext");
// const button = document.getElementById("btnLogin");
// button.addEventListener("click", (e) => {
//     debugger;
//     let message = [];
//     if (
//         ID.value == null ||
//         ID.value == 0 ||
//         password.value == null ||
//         password.value == 0
//     ) {
//         message.push("Please Fill Your Data Correctly");
//         alert(message);
//         button.style.borderColor = "red";
//     } else {
//         let message = [];
//         message.push("Done");
//         alert(message);
//         button.style.borderColor = "green";
//     }
// });

// ID.addEventListener("blur", (e) => {
//     debugger;
//     if (ID.value == "" || ID.value == 0 || ID.value <= 0) {
//         var validationID = document.getElementById("parag1");
//         validationID.innerText = "Please Enter Your UserID";
//         ID.style.borderColor = "red";
//         validationID.style.color = "red";
//     } else {
//         var validationID = document.getElementById("parag1");
//         validationID.innerText = "Correct";
//         ID.style.borderColor = "green";
//         validationID.style.color = "green";
//     }
// });
// // Select your input element.
// // Listen for input event on numInput.
// ID.onkeydown = function(e) {
//     if (!(
//             (e.keyCode > 95 && e.keyCode < 106) ||
//             (e.keyCode > 47 && e.keyCode < 58) ||
//             e.keyCode == 8
//         )) {
//         return false;
//     }
// };

// password.addEventListener("blur", (e) => {
//     debugger;
//     if (
//         password.value == "" ||
//         password.value <= 0 ||
//         password.value.length <= 5
//     ) {
//         var validationID = document.getElementById("parag2");
//         validationID.innerText = "Please Enter Your Passwrod Correctly";
//         validationID.style.color = "red";
//         password.style.borderColor = "red";
//     } else {
//         var validationID = document.getElementById("parag2");
//         validationID.innerText = "Correct";
//         validationID.style.color = "green";
//         password.style.borderColor = "green";
//     }
// });

$("#btnLogin").click(() => {
    var dataTobeSenttologin = JSON.stringify({
        UserID: $("#usertext").val(),
        Password: $("#keytext").val(),
    });
    var dataTobeSenttocheckadmin = JSON.stringify({
        UserID: $("#usertext").val(),
    });
    $.ajax({
        type: "POST",
        dataType: "json",
        url: "https://localhost:44350/api/User/loginuser",
        data: dataTobeSenttologin,
        contentType: "application/x-www-form-urlencoded",
        headers: {
            "Content-Type": "application/json",
            "Access-Control-Allow-Origin": "*",
            "Access-Control-Allow-Headers": "*",
            "Access-Control-Allow-Methods": "*",
        },
        crossDomain: true,
        success: function(response) {
            if (response) {
                localStorage.setItem("UserIDs", $("#usertext").val());
                welcome();
            } else {
                alert("error plz enter correct password!");
            }
        },
        error: function(error) {
            console.log("kda 8alat yasta");
            window.location = "../html/submitpage.html";
            return false;
        },
    });
});

function welcome() {
    var dataTobeSenttologin = JSON.stringify({
        UserID: $("#usertext").val(),
    });
    $.ajax({
        type: "POST",
        dataType: "json",
        url: "https://localhost:44350/api/User/returnUser",
        data: dataTobeSenttologin,
        contentType: "application/x-www-form-urlencoded",
        headers: {
            "Content-Type": "application/json",
            "Access-Control-Allow-Origin": "*",
            "Access-Control-Allow-Headers": "*",
            "Access-Control-Allow-Methods": "*",
        },
        crossDomain: true,
        success: function(response) {
            var arr = Object.values(response);
            username = arr[1];
            localStorage.setItem("UserName", username);
            window.location = "../html/index.html";
        },
        error: function(error) {
            console.log("mesh eshta 3aleek yasta");
            return false;
        },
    });
}

//if (true) {
//     $.ajax({
//         type: "POST",
//         dataType: "json",
//         url: "https://localhost:44350/api/User/checkAdmin",
//         data: dataTobeSenttocheckadmin,
//         Origin: "same-origin",
//         contentType: "application/x-www-form-urlencoded",
//         headers: {
//             "Content-Type": "application/json",
//             "Access-Control-Allow-Origin": "*",
//             "Access-Control-Allow-Headers": "*",
//             "Access-Control-Allow-Methods": "*",
//         },
//         crossDomain: true,
//         success: function() {
//             if (true) {
//                 window.location = "../html/Admin.html";
//             } else {
//                 window.location = "../html/index.html";
//             }
//         },
//         error: function(error) {
//             alert("wrong userID and Password");
//             return false;
//         },
//     });
// } else {
//     alert("your request didn't reach server");
// }