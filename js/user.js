$(document).ready(function() {
    var counter = 1;
    var trHTML = $("#emptable");
    var data2 = JSON.stringify({
        UserID: localStorage.getItem("UserIDs"),
    });
    $.ajax({
        type: "POST",
        dataType: "json",
        url: "https://localhost:44350/api/User/OrderbyID",
        data: data2,
        contentType: "application/json",
        headers: {
            "Content-Type": "application/json",
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
                    item.UserID +
                    "</td><td>" +
                    item.OrderID +
                    "</td><td>" +
                    item.RestaurantName +
                    "</td><td>" +
                    item.ItemName +
                    "</td><td>" +
                    item.Quantity +
                    "</td><td>" +
                    item.CreationDate +
                    "</td><td>" +
                    item.OrderPrice +
                    "</td><td>" +
                    item.Fees +
                    "</td></tr>";
            });
            $("#emptable").append(trHTML);
        },
        error: function(e) {
            $("#txtHint").html(e.responseText);
        },
    });
});

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