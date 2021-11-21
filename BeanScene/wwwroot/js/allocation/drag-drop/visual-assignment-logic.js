function unassignBookingOnAccordionList(bookingId) {
    $(`#${bookingId}`)
        .detach()
        .appendTo(`#unassigned`)
        .addClass('booking-unassigned')
        .draggable('enable')
        .removeClass('booking-assigned');
}

function assignBookingOnAccordionList(bookingId) {
    $(`#${bookingId}`)
        .detach()
        .appendTo(`#assigned`)
        .removeClass('booking-unassigned')
        .removeClass('booking-partiallyAssigned')
        .draggable('disable')
        .addClass('booking-assigned');

    updateGuestNum(bookingId, getOriginalGuestNum(bookingId));  // make sure the original amount of guests is shown (partial bookings)
}

function partiallyAssignBookingOnAccordionList(bookingId, seatedGuests) {
    $(`#${bookingId}`)
        .addClass('booking-partiallyAssigned')
        .removeClass('booking-unassigned');

    let guestsToSeat = getGuestsToSeat(bookingId);
    let remainingGuestsToSeat = guestsToSeat - seatedGuests;
    $(`#${bookingId}`).find('#guestNum').text("Guests: " + remainingGuestsToSeat);
}

function partiallyUnassignBookingOnAccordionList(bookingId, unseatedGuests) {
    let guestNum = 0;
    if (!$(`#${bookingId}`).hasClass('booking-assigned')) {
        guestNum = getGuestsToSeat(bookingId);
    }

    let remainingGuestsToSeat = parseInt(guestNum) + parseInt(unseatedGuests);
    $(`#${bookingId}`).find('#guestNum').text("Guests: " + remainingGuestsToSeat);

    if (!$(`#${bookingId}`).hasClass('booking-partiallyAssigned')) {
        $(`#${bookingId}`).addClass('booking-partiallyAssigned');
    }

    if (remainingGuestsToSeat == getOriginalGuestNum(bookingId)) {
        $(`#${bookingId}`)
            .addClass('booking-unassigned')
            .removeClass('booking-partiallyAssigned');
    }

    if ($(`#${bookingId}`).hasClass('booking-assigned')) {
        $(`#${bookingId}`)
            .detach()
            .appendTo(`#unassigned`)
            .removeClass('booking-assigned')
            .draggable('enable');
    }
}

function confirmTableAssignment(tableName) {
    $(`#${tableName}`).find('#dropBox').addClass('tableReservation-confirmed-box');
    $(`#${tableName}`).find('#dropBox').removeClass('droppable-box');
    $(`#${tableName}`).find('#dropBox').children().first().addClass('tableReservation-confirmed');
    $(`#${tableName}`).find('#dropBox').children().first().removeClass('draggable-helper-dropped');
}


function createHelperClone(ui) {
    return $(ui.helper).clone(false)
        .removeClass('ui-draggable-dragging')
        .removeClass('draggable')
        .removeClass('draggable-helper-dragging')
        .addClass('draggable-helper-dropped')
        .css({ position: 'relative', left: 0, top: 0, padding: 10 });
}