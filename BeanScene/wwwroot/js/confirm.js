const uri = 'api/booking/';
const bookingId = null;
const sittingDay = "";
const sittingType = "";

getNumberOut();
fetchBooking();

function getNumberOut() {
    let numberHeading = document.getElementById("bookingId").innerText;
    var bookingId = numberHeading.match(/(\d+)/);
}

function fetchBooking() {
    fetch(uri + bookingId)
        .then(response => response.json())
        .then(data => findDayAndType(data))
        .catch(error => console.error('Unable to retrieve booking.', error))
}

function findDayAndType(booking) {
    sittingDay = booking.Service.Sitting.DayOfWeek;
    sittingType = booking.Service.Sitting.MealType;
    document.getElementById("dayOfWeek").innerText = sittingDay;
    document.getElementById("mealType").innerText = sittingDay;
}
