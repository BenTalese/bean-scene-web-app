function unseatGuests(tableId) {
    $(`#${tableId}`).children('.seatIcon-unavailable').removeClass('seatIcon-unavailable');
    $(`#${tableId}`).children('#seat').each(function () {
        if (!$(this).hasClass('seatIcon-available')) {
            $(this).addClass('seatIcon-available');
        }
    });
}

function resetTakenSeatNumber(tableId) {
    $(`#${tableId}`).children('#takenSeatTotal').empty();
    let tableCapcity = $(`#${tableId}`).children('#seat').length;
    $(`#${tableId}`).children('#takenSeatTotal').text(`0/${tableCapcity}`);
}

function seatGuests(bookingId, tableId) {
    let guestsToSeat = getGuestsToSeat(bookingId);
    let tableCapcity = getTableCapacity(tableId);
    let seatedGuests = 0;

    $(`#${tableId}`).children('#seat').each(function () {
        if (seatedGuests < guestsToSeat && seatedGuests < tableCapcity) {
            $(this).removeClass('seatIcon-available');
            $(this).addClass('seatIcon-unavailable');
            seatedGuests++;
        }
        $(`#${tableId}`).find('#takenSeatTotal').empty().text(`${seatedGuests}/${tableCapcity}`);
    })

    return seatedGuests;
}