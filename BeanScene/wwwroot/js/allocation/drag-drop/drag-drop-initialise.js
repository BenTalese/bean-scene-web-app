function enableAllDraggables() {
    $('.booking-unassigned, .booking-assigned').each(function () {
        enableDraggable($(this).attr('id'));

        bookingsOnAccordionList.push({ bookingId: $(this).attr('id'), guests: $(this).find('#guestNum').text().split(' ')[1] });
    });
}


function enableAllDropBoxes() {
    $('.table').each(function () {
        enableDroppable($(this).attr('id'));
    });
}

$('.flex-container').hide();    // initially hide tables on page load
$('.area-details').on('click', function () {
    let tableArea = $(this).next();
    if (tableArea.is(':hidden')) {
        tableArea.show();
    } else {
        tableArea.hide();
    }
});


function enableBookingHover() {
    $('.droppable, .tableReservation-confirmed-box, .timeline-booking').hover(function () {
        if ($(this).children().length > 0) {
            let bookingId = getBookingIdFromIcon($(this).children().first());
            $(`#${bookingId}`).addClass('booking-highlight');
            $(`#${bookingId}-timeline`).parent().addClass('timeline-booking-highlight');
        }
    }, function () {
        if ($(this).children().length > 0) {
            let bookingId = getBookingIdFromIcon($(this).children().first());
            $(`#${bookingId}`).removeClass('booking-highlight');
            $(`#${bookingId}-timeline`).parent().removeClass('timeline-booking-highlight');
        }
    });

    $('#unassigned > div, #assigned > div').hover(function () {
        let bookingId = $(this).attr('id');
        if (!$(this).hasClass('booking-unassigned')) {
            $('.droppable, .tableReservation-confirmed-box').each(function () {
                if ($(this).children().length > 0 && getBookingIdFromIcon($(this).children().first()) == bookingId) {
                    $(this).addClass('booking-highlight');
                }
            })
            $('.timeline-booking').each(function () {
                if ($(this).children().length > 0 && getBookingIdFromIcon($(this).children().first()) == bookingId) {
                    $(this).addClass('timeline-booking-highlight');
                }
            })
        }
    }, function () {
        $('.droppable, .tableReservation-confirmed-box, .timeline-booking').each(function () {
            $(this).removeClass('booking-highlight');
            $(this).removeClass('timeline-booking-highlight');
        })
    });
}

function enableDraggable(bookingId) {
    $(`#${bookingId}`).draggable({
        cursor: 'grabbing',
        cursorAt: { top: 15, left: 15 },
        refreshPositions: true,
        revert: 'invalid',
        revertDuration: 300,
        helper: function (event) {
            let parentText = $(this).attr('id');
            let initials = parentText.split('-')[0];
            let bookingId = parentText.split('-')[1];
            return $(`<div id='${initials}-${bookingId}-icon' class='draggable draggable-helper-dragging'>${initials}</div>`);
        }
    });
}


function enableDroppable(tableId) {
    $(`#${tableId}`).find('#dropBox').droppable({
        accept: '.draggable',
        hoverClass: 'ui-state-hover',
        drop: function (event, ui) {
            let helperClone = createHelperClone(ui);
            $(this).append(helperClone);
            $(this).droppable('disable');

            let bookingIdFromIcon = getBookingIdFromIcon(helperClone);
            let tableId = $(this).parent().attr('id');

            let tableReservation = createTableReservationObject(bookingIdFromIcon, tableId);

            assignTableReservation(bookingIdFromIcon, tableId);  // keep track of newly assigned bookings

            let seatedGuests = seatGuests(bookingIdFromIcon, tableId);
            updateAreaDetails();

            if (isModified(tableReservation)) {
                confirmTableAssignment(tableId);
            } else {
                if (enoughSeatsOnTable(bookingIdFromIcon, tableId)) {
                    assignBookingOnAccordionList(bookingIdFromIcon);
                } else {
                    partiallyAssignBookingOnAccordionList(bookingIdFromIcon, seatedGuests);
                    appendUniqueIconId(bookingIdFromIcon);
                }
            }

            initialiseTimeTable();

            $(this).on("click", function () {
                onAssignedIconClick(bookingIdFromIcon, tableId);
            })
        }
    });
}

function onAssignedIconClick(bookingId, tableId) {
    let unseatedGuests = getGuestsAtTable(tableId);
    if (isPartialBooking(bookingId)) {
        partiallyUnassignBookingOnAccordionList(bookingId, unseatedGuests)
    } else {
        unassignBookingOnAccordionList(bookingId);
    }
    $(`#${tableId}`).find('#dropBox').empty();  // remove booking icon from table
    unassignTableReservation(bookingId, tableId);
    unseatGuests(tableId);
    updateAreaDetails();
    resetTakenSeatNumber(tableId);
    enableDraggable(bookingId);
    enableDroppable(tableId);
    initialiseTimeTable();
    $(`#${tableId}`).find('#dropBox').droppable('enable');
    $(`#${bookingId}`).removeClass('booking-highlight'); // fixes hover animation getting stuck when reservation icon is deleted off table
}