function getGuestsToSeat(bookingId) {
    return $(`#${bookingId}`).find('#guestNum').text().split(' ')[1];
}

function getTableCapacity(tableId) {
    return $(`#${tableId}`).children('#seat').length;
}

function enoughSeatsOnTable(bookingId, tableId) {
    return getGuestsToSeat(bookingId) <= getTableCapacity(tableId);
}

function getGuestsAtTable(tableId) {
    return $(`#${tableId}`).children('.seatIcon-unavailable').length;
}

function appendUniqueIconId(bookingId) {
    let count = getOccurrencesOfBooking(bookingId);
    let uniqueId = bookingId + "-icon-" + count;
    $(`#${bookingId}-icon.draggable-helper-dropped`).attr('id', uniqueId);  // need to target the clone icon, not the original draggable one
}

function updateGuestNum(bookingId, guests) {
    $(`#${bookingId}`).find('#guestNum').text("Guests: " + guests);
}

function getOriginalGuestNum(bookingName) {
    let bookingId = getId(bookingName);
    return bookingsOnDate.find(booking => booking.id == bookingId).guests;
}

function getId(elementName) {
    //return parseInt(element.id.split('-')[1]);  // TODO: update this with regex to get the first number (ignore the unique id for partial bookings)
    return parseInt(elementName.split('-')[1]);
}

function createTableReservationObject(bookingName, tableName) {
    let tableId = tableName.split('-')[1];
    let bookingId = bookingName.split('-')[1];
    let tableReservation = { bookingId: bookingId, tableId: tableId };
    return tableReservation;
}

function timeIsWithinBookingTimes(time, booking) {
    let bookingStart = new Date(booking.startTime);
    let bookingEnd = new Date(booking.endTime);
    if (bookingStart.getTime() <= time.getTime() && bookingEnd.getTime() > time.getTime()) {
        return true;
    }
    return false;
}

function timeHasBooking(time, booking) {
    let bookingStart = new Date(booking.startTime);
    if (bookingStart.getTime() == time.getTime()) {
        return true;
    }
    return false;
}

function isModified(tableReservation) {
    return modifiedTableReservations.some(e => JSON.stringify(tableReservation) === JSON.stringify(e)); // because objects can't be compared directly
}

function isAssignedNotConfirmed(tableReservation) {
    return newTableReservations.some(e => JSON.stringify(tableReservation) === JSON.stringify(e));
}

function hasUnassignedBookings(time) {
    return bookingsOnDate.some(booking =>
        booking.status == "Pending" && new Date(booking.startTime).getTime() == time.getTime()
    );
}

function getBookingsOnTable(tableName) {
    let bookings = [];
    bookingsOnDate.forEach(booking => {
        let tableId = getId(tableName);
        let bookingId = booking.customer.firstName.substring(0, 1) + booking.customer.lastName.substring(0, 1) + "-" + booking.id;
        let tableReservation = createTableReservationObject(bookingId, tableName);

        if (booking.tables.includes(tableId)) {
            if (!isModified(tableReservation)) {
                bookings.push(booking);
            }
        } else if (isAssignedNotConfirmed(tableReservation)) {
            bookings.push(booking);
        }
    });
    return bookings;
}

function getBookingIdFromIcon(iconElement) {
    return $(iconElement).attr('id').match(/^[a-zA-Z]+-[0-9]+/)[0];    // e.g. RS-504 (without "-icon-#")
}

function getOccurrencesOfBooking(bookingId) {
    let newCount = newTableReservations.reduce((n, tableReservation) => n + (tableReservation.bookingId == bookingId.split('-')[1]), 0);
    let confirmedCount = confirmedBookings.reduce((n, tableReservation) => n + (tableReservation.bookingId.split('-')[1] == bookingId.split('-')[1]), 0);
    console.log(confirmedBookings);
    console.log(bookingsOnAccordionList);
    console.log(newCount + confirmedCount);
    return newCount + confirmedCount;
}

function isPartialBooking(bookingId) {
    if ($(`#${bookingId}`).hasClass('booking-partiallyAssigned')) {
        return true;
    }
    if (getOccurrencesOfBooking(bookingId) > 1) {
        return true;
    }
    return false;
}