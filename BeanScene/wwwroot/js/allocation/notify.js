var dialog;

function notifySuccess() {
    $('#heading').empty().text('Changes confirmed!');
    $('#message').empty().text('Do you wish to continue editing?');
    dialog.dialog("open");
}

function notifyError() {
    $('#heading').empty().text('Unexpected error.');
    $('#message').empty().text('Try again?');
    dialog.dialog("open");
}

$(function () {
    function refreshPage() {
        dialog.dialog("close");
        // TODO: Need to re-code this whole page from the ground up...did it the wrong way from the beginning. (need to use and pass around booking object instead of tableRes object)
        // TODO: Need to update bookingsOnDate as that's what's used to render the page
        clearTableReservations();
    }

    dialog = $("#dialog").dialog({
        autoOpen: false,
        modal: true,
        buttons: {
            "Keep editing": refreshPage,
            "Dashboard": function () {
                window.location.href = "/Admin/Home";
                dialog.dialog("close");
            }
        }
    });
});