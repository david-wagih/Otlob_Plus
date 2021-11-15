$(document).ready(function() {
    var counter = 1;
    var trHTML = $("#marcoresponsivetable");
    $.ajax({
        type: "GET",
        dataType: "json",
        url: "https://localhost:44398/api/UserController/Orders",
        data: "",
        Origin: "same-origin",
        contentType: "application/json",
        headers: {
            "Content-Type": "application/json; charset: utf-8",
            "Access-Control-Allow-Origin": "*",
            "Access-Control-Allow-Headers": "*",
            "Access-Control-Allow-Methods": "*",
        },
        cache: "false",
        crossDomain: true,
        success: function(response) {
            $.each(response, function(i, item) {
                trHTML +=
                    "<tr><td>" +
                    counter++ +
                    "</td><td>" +
                    item.UserID +
                    "</td><td>" +
                    item.RestaurantName +
                    "</td><td>" +
                    item.itemName +
                    "</td><td>" +
                    item.itemPrice +
                    "</td><td>" +
                    item.OrderPrice +
                    "</td><td>" +
                    item.CreationDate +
                    "</td><td>" +
                    item.ModifiedDate +
                    "</td><td>" +
                    item.status +
                    "</td><td>" +
                    "<button  id = 'Edit' onclick='updateOrder(" +
                    item.OrderID +
                    ")'  data-IdOfRow = '" +
                    item.OrderID +
                    "'  class='btn btn-primary' style='margin-right:5px'>Update</button>" +
                    "</td></tr>";
            });
            $("#marcoresponsivetable").append(trHTML);
        },
        error: function(e) {
            $("#txtHint").html(e.responseText);
        },
    });
});

function updateOrder(OrderID) {
    $.ajax({
        type: "PUT",
        dataType: "json",
        url: "https://localhost:44398/api/UserController/UpdateStatusby",
        data: JSON.stringify({
            OrderID: OrdersID,
            Status: $("#Status").val(),
        }),
        Origin: "same-origin",
        contentType: "application/x-www-form-urlencoded",
        headers: {
            "Content-Type": "application/json; charset: utf-8",
            "Access-Control-Allow-Origin": "*",
            "Access-Control-Allow-Headers": "*",
            "Access-Control-Allow-Methods": "*",
        },
        crossDomain: true,
        success: function() {
            alert("success");
        },
        error: function() {
            alert("Error");
        },
    });
}

$(document).ready(function() {
    $("#myInput").on("keyup", function() {
        var value = $(this).val().toLowerCase();
        $("#emptable tr").filter(function() {
            $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1);
        });
    });
});

function filterRows() {
    var from = $("#datefilterfrom").val();
    var to = $("#datefilterto").val();

    if (!from && !to) {
        // no value for from and to
        return;
    }

    from = from || "1970-01-01"; // default from to a old date if it is not set
    to = to || "2999-12-31";

    var dateFrom = moment(from);
    var dateTo = moment(to);

    $("#marcoresponsivetable tr").each(function(i, tr) {
        var val = $(tr).find("td:nth-child(7)").text();
        var dateVal = moment(val, "DD/MM/YYYY");
        var visible = dateVal.isBetween(dateFrom, dateTo, null, []) ? "" : "none"; // [] for inclusive
        $(tr).css("display", visible);
    });
}

$("#datefilterfrom").on("change", filterRows);
$("#datefilterto").on("change", filterRows);