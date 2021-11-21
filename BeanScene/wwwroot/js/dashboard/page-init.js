let newTableReservations = []; // e.g. [ {6,7}, {5,6} ]
let modifiedTableReservations = [];
let confirmedBookings = [];
let bookingsOnAccordionList = [];   // these two are the same
let servicesOnDate = [];
let bookingsOnDate = [];
let areas = [];
let today = new Date();


fetchServicesOnDate();

function initialisePage() {
    if (servicesOnDate.length > 0) {
        setInitialValues();
        initialiseTimeTable();
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
    servicesOnDate[0].areas.forEach(area => {
        let tablesInArea = [];
        area.tables.forEach(table => {
            tablesInArea.push(table.name);
        });
        areas.push({
            name: area.name,
            tables: tablesInArea,
            areaTablesExpanded: true
        });
    });
    return areas;
}