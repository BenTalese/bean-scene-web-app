let newTableReservations = []; // e.g. [ {6,7}, {5,6} ]
let modifiedTableReservations = [];
let confirmedBookings = [];
            let bookingsOnAccordionList = [];   // these two are the same
let servicesOnDate = [];
            let bookingsOnDate = [];   // these two are the same
let areas = [];
let currentServiceId = (window.location.href).split("/")[6];


fetchServicesOnDate();
submitCheck();

function initialisePage() {
    if (servicesOnDate.length > 0) {
        setInitialValues();
        initialiseBookingList();
        initialiseTimeTable();
        enableAllDropBoxes();
        enableAllDraggables();
        showHideBookingsOnTables();
        enableConfirmedCick();
        showHideBookingsOnList();
    }
}

function setInitialValues() {
    bookingsOnDate = getBookingsOnDate();
    areas = getAreasWithTables();
    let minMax = getMinMaxTimes();
    minTime = minMax[0];
    maxTime = minMax[1];
    leftCellBoundary = getleftCellBoundary();
    rightCellBoundary = getRightCellBoundary(leftCellBoundary);
    selectedTime = new Date(leftCellBoundary);
}

function getBookingsOnDate() {
    let bookings = [];
    servicesOnDate.forEach(service =>
        service.bookings.forEach(booking =>
            bookings.push(booking)
        )
    );
    return bookings;
}

function getAreasWithTables() {
    let areas = [];
    $('.area').each(function () {
        let tablesInArea = [];

        $(this).children('div').children('.table').each(function () {
            tablesInArea.push($(this).attr('id'));
        });

        areas.push({
            name: $(this).find('.h2').text(),
            tables: tablesInArea,
            areaTablesExpanded: false
        })
    });
    return areas;
}