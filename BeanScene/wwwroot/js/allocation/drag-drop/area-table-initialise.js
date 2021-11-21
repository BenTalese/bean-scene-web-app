function showHideBookingsOnTables() {
    var guestsToSeat = {};    // dictionary with key/value pairs
    bookingsOnDate.forEach(booking => {
        if (booking.state != "Pending" && booking.state != "Cancelled") {
            guestsToSeat[`${booking.id}`] = booking.guests;
        }
    });

    $('.table').each(function () {
        let tableName = $(this).attr('id');
        let bookingsOnTable = getBookingsOnTable(tableName);
        let takenSeats = 0;
        let tableCapacity = $(this).find('#takenSeatTotal').text().split('/')[1];

        resetTable(tableName);

        bookingsOnTable.forEach(booking => {
            if (timeIsWithinBookingTimes(selectedTime, booking)) {
                if (guestsToSeat[`${booking.id}`] > tableCapacity) {
                    takenSeats = tableCapacity;
                } else {
                    takenSeats = guestsToSeat[`${booking.id}`];
                }
                guestsToSeat[`${booking.id}`] -= takenSeats;

                let bookingIcon = document.createElement('div');
                bookingIcon.id = booking.customer.firstName.substring(0, 1) + booking.customer.lastName.substring(0, 1) + "-" + booking.id + "-icon";
                bookingIcon.innerHTML = `<p class="p-1">${booking.customer.firstName.substring(0, 1) + booking.customer.lastName.substring(0, 1)}</p>`;

                let dropBox = $(this).find('#dropBox');
                dropBox.append(bookingIcon);
                dropBox.droppable('disable');

                let bookingId = booking.customer.firstName.substring(0, 1) + booking.customer.lastName.substring(0, 1) + "-" + booking.id;
                let tableReservation = createTableReservationObject(bookingId, tableName);
                if (isAssignedNotConfirmed(tableReservation)) {
                    bookingIcon.classList.add('draggable-helper-dropped');
                } else {
                    dropBox.addClass('tableReservation-confirmed-box');
                    dropBox.removeClass('droppable-box');
                    bookingIcon.classList.add('align-items-center', 'tableReservation-confirmed');
                }

                $(this).find('#takenSeatTotal').text(`${takenSeats}/${tableCapacity}`);

                let seatCount = 0;
                $(this).find('.seat').each(function() {
                    if (seatCount < takenSeats) {
                        $(this).removeClass('seatIcon-available').addClass('seatIcon-unavailable');
                    }
                    seatCount++;
                });
            }
        });
    });

    updateAreaDetails();
    enableConfirmedCick();
}

function resetTable(tableName) {
    let table = $(`#${tableName}`);
    let tableCapacity = table.find('#takenSeatTotal').text().split('/')[1];
    table.find('#dropBox')
        .empty()
        .removeClass('tableReservation-confirmed-box')
        .addClass('droppable-box')
        .droppable('enable');
    table.find('#takenSeatTotal').text(`0/${tableCapacity}`);
    table.filter('.seatIcon-unavailable')
        .removeClass('seatIcon-unavailable')
        .addClass('seatIcon-available');
    table.find('.seat').each(function () {
        $(this).removeClass('seatIcon-unavailable').addClass('seatIcon-available');
    });
}

function updateAreaDetails() {
    $('.area').each(function () {
        let availableTables = 0, tableCount = 0, availableSeats = 0, unavailableSeats = 0;
        $(this).children('div').children('.table').each(function () {
            if ($(this).find('#dropBox').children().length == 0) {
                availableTables++;
            }
            availableSeats += $(this).children('.seatIcon-available').length;
            unavailableSeats += $(this).children('.seatIcon-unavailable').length;
            tableCount++;
        });
        let details = `Free Seats: ${availableSeats}/${availableSeats + unavailableSeats} | Free Tables: ${availableTables}/${tableCount}`;
        $(this).find('.h5').text(details);
    });
}