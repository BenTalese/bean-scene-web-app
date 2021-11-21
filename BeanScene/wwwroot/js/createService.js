const uri = 'api/sittings/disabled';
let availableSittings = [];

fetchSittings();

function fetchServices() {
    fetch(uri)
        .then(response => response.json())
        .then(data => findAvailableSittingsForDate(data))
        .catch(error => console.error('Unable to get list of services.', error))
}

function findAvailableSittingsForDate(data) {
    let sittings = Array.from(data);

    sittings.forEach(sitting => {
        if (sitting.DayOfWeek == "Open" && service.sitting.isActive) {
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
    defaultDate: new Date(),
    minDate: new Date(),
    onSelect: populateMealTypeSelector,
});


function populateMealTypeSelector(selectedDate) {
    let mealTypeSelector = document.getElementById("mealTypeSelector");
    removeOptions(mealTypeSelector);   // clear options each time a new date is selected
    addOption(mealTypeSelector, " -- Please select a sitting type-- ");

    for (let i = 0; i < availableSittings.length; i++) {
        if (availableSittings.DayOfWeek == 1 && selectedDate.DayOfWeek == 'Monday') {
            addOption(mealTypeSelector, availableSittings[i].mealType);
        }
    }
}

$("#mealTypeSelector").on('input', function () {
    let selectedDate = document.getElementById("datepicker").value;
    let selectedMealType = document.getElementById("mealTypeSelector").value;

    let startEndTimes = getServiceStartEndTimes(selectedDate, selectedMealType);

    populateTimeSelector(startEndTimes[0], startEndTimes[1]);

    if (selectedMealType == " -- Please select a meal type-- ") {
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