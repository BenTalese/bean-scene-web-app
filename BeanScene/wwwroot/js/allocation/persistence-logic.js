function unassignTableReservation(bookingId, tableId) {
    let tableIdNumOnly = tableId.split('-')[1];
    let bookingIdNumOnly = bookingId.split('-')[1];
    let idxToDelete = newTableReservations.indexOf({ bookingId: bookingIdNumOnly, tableId: tableIdNumOnly });
    newTableReservations.splice(idxToDelete, 1);
    submitCheck();
}

function assignTableReservation(bookingId, tableId) {
    let tableIdNumOnly = tableId.split('-')[1];   // e.g. 21
    let bookingIdNumOnly = bookingId.split('-')[1];  // e.g. 6
    let tableReservation = { bookingId: bookingIdNumOnly, tableId: tableIdNumOnly };
    if (isModified(tableReservation)) {
        reconfirmBooking(bookingId, tableId);
    } else {
        newTableReservations.push(tableReservation);
    }
    submitCheck();
}

function undoChanges() {
    clearTableReservations();
    initialiseBookingList();
    initialiseTimeTable();
    enableAllDropBoxes();
    enableAllDraggables();
    enableConfirmedCick()
    showHideBookingsOnList();
    showHideBookingsOnTables();
}

function clearTableReservations() {
    newTableReservations = [];
    modifiedTableReservations = [];
}

function modifyExistingTableReservation(bookingId, tableId) {
    let tableIdNumOnly = tableId.split('-')[1];
    let bookingIdNumOnly = bookingId.split('-')[1];
    let tableReservation = { bookingId: bookingIdNumOnly, tableId: tableIdNumOnly };
    modifiedTableReservations.push(tableReservation);
    submitCheck();
}

function reconfirmBooking(bookingId, tableId) {
    let tableIdNumOnly = tableId.split('-')[1];   // e.g. 21
    let bookingIdNumOnly = bookingId.split('-')[1];  // e.g. 6
    let idxToDelete = modifiedTableReservations.indexOf({ bookingId: bookingIdNumOnly, tableId: tableIdNumOnly });
    modifiedTableReservations.splice(idxToDelete, 1);
    submitCheck();

    $(`#${tableId}`).find(`#${bookingId}-icon`).addClass('tableReservation-confirmed');
    $(`#${tableId}`).find('#dropBox').addClass('tableReservation-confirmed-box');
}

function submitCheck() {
    if (newTableReservations.length == 0 && modifiedTableReservations.length == 0) {
        $('#submitBtn').prop('disabled', true);
    } else {
        $('#submitBtn').prop('disabled', false);
    }
}

function submitTableReservations() {
    if (modifiedTableReservations.length > 0) {
        unconfirmTableReservations();   // remove old table reservations before pushing new ones to DB
    } else {
        confirmTableReservations();
    }
}