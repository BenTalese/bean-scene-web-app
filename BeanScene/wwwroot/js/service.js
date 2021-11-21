const availableUri = '/api/sitting/day/';
const existingUri = '/api/service/';
let availableSittings = [];
let existingServices = [];

$(() => {
    $("#datepicker").datepicker({
        dateFormat: 'dd/mm/yy',
        defaultDate: new Date(),
        minDate: new Date(),
        onSelect: populateSittingSelector
    });

    function populateSittingSelector(selectedDate) {
        console.log(selectedDate);
        let day = selectedDate.substr(0, 2);
        let month = selectedDate.substr(3, 2);
        let year = selectedDate.substr(6, 4);
        let date = new Date(year, (month - 1), day);
        console.log(date);
        let dayOfWeek = date.getDay();
        console.log(dayOfWeek);

        fetchSittings(dayOfWeek, day, month, year)
    }

    function fetchSittings(dayOfWeek, day, month, year) {
        fetch(availableUri + dayOfWeek)
            .then(response => response.json())
            .then(data => Array.from(data))
            .then((sittings) => fetchServices(day, month, year,sittings))
            .catch(error => console.error('Unable to get list of services.', error))
    }

    function fetchServices(day, month, year, sittings) {
        fetch(existingUri + day + " / " + month + "/" + year)
            .then(response => response.json())
            .then(data => Array.from(data))
            .then((services) => loadSelect(sittings, services))
            .catch(error => console.error('Unable to get list of services.', error))
    }




    function loadSelect(sittings, services) {

        let select = $("#Sitting");
        // clear options each time a new date is selected
        select.children('option:not(:first)').remove();

        var found = false;
        for (let i = 0; i < sittings.length; i++) {
            for (let j = 0; j < services.length; j++) {
                if (services[j].sitting.id == sittings[i].id) {
                    found = true;
                }
            }
            if (found == true) {
                found = false;
            }
            else {
                let option = $(`<option value="${sittings[i].id}">${sittings[i].mealType}</option>`);
                select.append(option);
                found = false;
            }
        }
    }


})