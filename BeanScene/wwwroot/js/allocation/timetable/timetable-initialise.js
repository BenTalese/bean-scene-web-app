let minTime, maxTime, leftCellBoundary, rightCellBoundary, selectedTime;
let timeTableMinimised = true;
let timeTable = document.getElementById("timeTable");
let visibleColCount = 9;
let fullColSpan = visibleColCount + 2;
let timeInterval = 15;

function initialiseTimeTable() {
    timeTable.innerHTML = '';
    generateTableBody(timeTable);
    generateTableHead(timeTable);
    enableTimeTableButtons();
    enableBookingHover();
}

function enableTimeTableButtons() {
    enableAreaAccordion();
    enableArrowHover();
    enableMinimise();
    enableScroll();
    enableTimeSelection();
}

function getMinMaxTimes() {
    let times = [];
    servicesOnDate.forEach(service => {
        let sittingStartTime = new Date(service.sitting.startTime);
        let sittingEndTime = new Date(service.sitting.endTime);
        let serviceDate = new Date(service.date);

        if (service.state == "Open" && service.sitting.isActive) {
            let cleanedStart = getCleanedDateTime(serviceDate, sittingStartTime);
            let cleanedEnd = getCleanedDateTime(serviceDate, sittingEndTime);

            times.push(cleanedStart);
            times.push(cleanedEnd);
        }
    });
    times.sort();

    let minMax = [];
    minMax.push(times[0]);
    minMax.push(times[times.length - 1]);
    return minMax;
}


function getCleanedDateTime(date, time) {
    let cleanedDateTime = new Date();
    cleanedDateTime.setFullYear(
        date.getFullYear(),
        date.getMonth(),
        date.getDate());
    cleanedDateTime.setHours(
        time.getHours(),
        time.getMinutes(),
        0, 0);
    return cleanedDateTime;
}


function getleftCellBoundary() {
    let selectedService = servicesOnDate.find(service => { return service.id == currentServiceId });
    let dateTimeFromSitting = new Date(selectedService.sitting.startTime);    // dodgy date, needs cleaning
    let selectedServiceDate = new Date(selectedService.date);
    return getCleanedDateTime(selectedServiceDate, dateTimeFromSitting);
}


function getRightCellBoundary(leftCellBoundary) {
    let boundary = new Date(leftCellBoundary);
    boundary.setMinutes(boundary.getMinutes() + (timeInterval * visibleColCount));
    return boundary;
}