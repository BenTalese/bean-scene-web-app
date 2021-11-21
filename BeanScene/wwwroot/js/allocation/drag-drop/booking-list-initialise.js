let unassignedSection = document.getElementById('unassigned');
let assignedSection = document.getElementById('assigned');

function initialiseBookingList() {
    $('#unassigned, #assigned').empty();
    bookingsOnDate.forEach(booking => {
        let accordionBooking = createAccordionBooking(booking);
        appendToAccordion(booking, accordionBooking);
        let bookingName = booking.customer.firstName.substring(0, 1) + booking.customer.lastName.substring(0, 1) + "-" + booking.id;    // TODO: this should be a getter
        enableShowAllSwitch(bookingName);
    });
}

function showHideBookingsOnList() {
    bookingsOnDate.forEach(booking => {
        let bookingName = booking.customer.firstName.substring(0, 1) + booking.customer.lastName.substring(0, 1) + "-" + booking.id;    // TODO: this should be a getter
        if ($('#showAll').is(":checked")) {
            if (timeHasBooking(selectedTime, booking)) {
                $(`#${bookingName}`).draggable('enable');
                $(`#${bookingName}`).removeClass('booking-disabled');
            } else {
                $(`#${bookingName}`).draggable('disable');
                $(`#${bookingName}`).addClass('booking-disabled');
            }
            $(`#${bookingName}`).show();
        } else {
            if (timeHasBooking(selectedTime, booking)) {
                $(`#${bookingName}`).show();
                $(`#${bookingName}`).draggable('enable');
                $(`#${bookingName}`).removeClass('booking-disabled');
            } else if (timeIsWithinBookingTimes(selectedTime, booking)) {
                $(`#${bookingName}`).show();
                $(`#${bookingName}`).draggable('disable');
                $(`#${bookingName}`).addClass('booking-disabled');
            } else {
                $(`#${bookingName}`).hide();
                $(`#${bookingName}`).draggable('disable');
                $(`#${bookingName}`).addClass('booking-disabled');
            }
        }
    });
}

function enableShowAllSwitch(bookingName) {
    $('#showAll').on('change', function () {
        if ($(this).is(":checked")) {
            bookingsOnDate.forEach(() => $(`#${bookingName}`).show());
        } else {
            showHideBookingsOnList();
        }
    });
}

function createAccordionBooking(booking) {
    let bookingDIV = document.createElement('div');
    bookingDIV.id = booking.customer.firstName.substring(0, 1) + booking.customer.lastName.substring(0, 1) + "-" + booking.id;
    bookingDIV.classList.add('draggable', 'text-center', 'border', 'border-1', 'p-1', 'm-2');

    let customerP = document.createElement('p');
    customerP.innerText = booking.customer.firstName + " " + booking.customer.lastName;
    bookingDIV.appendChild(customerP);

    let details = document.createElement('p');
    let startTime = new Date(booking.startTime);
    let timeAsString = startTime.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });
    details.innerHTML = `<span>${timeAsString} | </span><span id="guestNum">Guests: ${booking.guests}</span>`;
    bookingDIV.appendChild(details);

    return bookingDIV;
}

function appendToAccordion(booking, accordionElement) {
    if (booking.status == "Pending") {
        accordionElement.classList.add('booking-unassigned');
        unassignedSection.appendChild(accordionElement);
    }
    if (booking.status != "Pending" && booking.status != "Cancelled") {
        accordionElement.classList.add('booking-assigned');
        assignedSection.appendChild(accordionElement);
    }
}