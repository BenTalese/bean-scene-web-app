// Hide contact section on load
if ($("#enableContact").prop("checked")) {
    $("#contactInputs").show();
} else {
    $("#contactInputs").hide();
}

$("#enableContact").on("change", function (e) {
    if ($("#enableContact").prop("checked")) {
        $("#contactInputs").show("slow");
    } else {
        $("#contactInputs").hide("slow");
    }
});

$(".star").on("click", function () {
    document.getElementById("rating").value = $(this).val();
});