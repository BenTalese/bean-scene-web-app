// TODO: Please see documentation at https://docs.microsoft.com/aspnet/core/client-side/bundling-and-minification
// for details on configuring this project to bundle and minify static web assets.

const uri = '/api/Service';
let availableServices = [];
let availableDates = [];

fetchServices();

function fetchServices() {
    fetch(uri)
        .then(response => response.json())
        .then(data => findAvailableServicesAndDates(data))
        .catch(error => console.error('Unable to get list of services.', error))
}

function findAvailableServicesAndDates(data) {
    let services = Array.from(data);

    services.forEach(service => {
        if (service.state == "Open"/* && service.sitting.isActive*/) {
            availableServices.push(service);
            let date = new Date(service.date).toLocaleDateString('en-GB');     // convert date into simple date format (dd-mm-yyyy)
            if (!availableDates.includes(date)) {   // avoid duplicate dates
                availableDates.push(date);
            }
        }
    });

    availableDates.sort();
    availableServices.sort(function (a, b) {
        return new Date(a.sitting.startTime) - new Date(b.sitting.startTime);
    });
}

function markAvailableDates(d) {
    let dateToCheck = buildDateToCheck(d);

    if ($.inArray(dateToCheck, availableDates) != -1) {
        return [true, "", "Available"];
    } else {
        return [false, "", "unAvailable"];
    }
}

function buildDateToCheck(d) {
    let dateToCheck = (d.getDate());
    if (d.getDate() < 10) {
        dateToCheck = "0" + dateToCheck;
    }
    dateToCheck += "/";

    if (d.getMonth() < 9) {
        dateToCheck += "0";
    }
    dateToCheck += d.getMonth() + 1 + "/" + d.getFullYear();

    return dateToCheck;
}

$("#datepicker").datepicker({
    dateFormat: 'dd/mm/yy',
    defaultDate: availableDates[0],
    minDate: availableDates[0],
    beforeShowDay: markAvailableDates,
    onSelect: populateMealTypeSelector
});


function populateMealTypeSelector(selectedDate) {
    let mealTypeSelector = document.getElementById("mealTypeSelector");
    removeOptions(mealTypeSelector);   // clear options each time a new date is selected
    addOption(mealTypeSelector, " -- Please select a sitting -- ");
    removeOptions(document.getElementById("timeSelector"));     // reset timeSelector if date is changed

    for (let i = 0; i < availableServices.length; i++) {
        let serviceDate = new Date(availableServices[i].date).toLocaleDateString('en-GB');
        if (serviceDate == selectedDate) {
            addOption(mealTypeSelector, availableServices[i].sitting.mealType);
        }
    }
}

$("#mealTypeSelector").on('input', function () {
    let selectedDate = document.getElementById("datepicker").value;
    let selectedMealType = document.getElementById("mealTypeSelector").value;

    let startEndTimes = getServiceStartEndTimes(selectedDate, selectedMealType);

    populateTimeSelector(startEndTimes[0], startEndTimes[1]);

    if (selectedMealType == " -- Please select a sitting -- ") {
        removeOptions(document.getElementById("timeSelector"));     // if meal type is deselected
    }
});


function getServiceStartEndTimes(selectedDate, selectedMealType) {
    let startEndTimes = [];

    for (let i = 0; i < availableServices.length; i++) {
        let serviceDate = new Date(availableServices[i].date).toLocaleDateString('en-GB');
        let serviceMealType = availableServices[i].sitting.mealType;
        if (serviceDate == selectedDate && serviceMealType == selectedMealType) {
            startEndTimes[0] = new Date(availableServices[i].sitting.startTime);
            startEndTimes[1] = new Date(availableServices[i].sitting.endTime);
        }
    }

    return startEndTimes;
}

function populateTimeSelector(start, end) {
    let timeSelector = document.getElementById("timeSelector");
    removeOptions(timeSelector);
    addOption(timeSelector, " -- Please select a time -- ");

    while (start < end) {
        addOption(timeSelector, start.toLocaleTimeString());
        start.setMinutes(start.getMinutes() + 15);
    }
}


function addOption(selectElement, value) {
    let opt = document.createElement('option');
    opt.value = value;
    opt.innerHTML = value;
    selectElement.appendChild(opt);
}

function removeOptions(selectElement) {
    var i, L = selectElement.options.length - 1;
    for (i = L; i >= 0; i--) {
        selectElement.remove(i);
    }
}