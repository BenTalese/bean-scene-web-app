function enableConfirmedCick() {    // TODO: terrible function name
    $('.tableReservation-confirmed').each(function () {
        let bookingIdFromIcon = getBookingIdFromIcon(this);
        let guestNum = getGuestsToSeat(bookingIdFromIcon);
        $(`#${bookingIdFromIcon}`).draggable('disable');
        confirmedBookings.push({ bookingId: bookingIdFromIcon, guests: guestNum });   // TODO: ISSUE...this will push for every time selected

        $(this).on('click', function () {
            let tableId = $(this).parent().parent().attr('id');
            resetConfirmedBooking(tableId, getBookingIdFromIcon(this));
            modifyExistingTableReservation(getBookingIdFromIcon(this), tableId);
        });
    });
}


function resetConfirmedBooking(tableId, bookingId) {
    $(`#${tableId}`).find('.tableReservation-confirmed').removeClass('tableReservation-confirmed');
    $(`#${tableId}`).find('#dropBox').removeClass('tableReservation-confirmed-box');
    $(`#${tableId}`).find('#dropBox').addClass('droppable-box');
    $(`#${tableId}`).find('#dropBox').addClass('droppable');  // might be duplicating?? (imagine saving bookings and not being taken away from page...unless when saved, all those dropboxes with bookings attached are disabled)
    onAssignedIconClick(bookingId, tableId);
}