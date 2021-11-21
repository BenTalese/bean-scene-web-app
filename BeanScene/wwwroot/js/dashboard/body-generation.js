function generateTableBody(table) {
    let tbody = document.createElement('tbody');
    for (let i = 0; i < areas.length; i++) {
        let areaRow = createAreaRow(areas[i].name, timeTableMinimised);
        tbody.appendChild(areaRow);
        for (let j = 0; j < areas[i].tables.length; j++) {
            let tableRow = createTableRow(areas[i].name, areas[i].tables[j], areas[i].areaTablesExpanded);
            tbody.appendChild(tableRow);
        }
    }
    tbody.appendChild(createBottomArrow(timeTableMinimised));
    table.appendChild(tbody);
}


function createBottomArrow(isMinimised) {
    let bottomRow = document.createElement('tr');
    let bottomArrow = document.createElement('th');
    bottomArrow.id = 'arrow-collapse';
    bottomArrow.classList.add('arrow-container', 'table-dark', 'align-middle');
    bottomArrow.setAttribute('colspan', fullColSpan);
    bottomArrow.setAttribute('role', 'button');
    if (isMinimised) {
        bottomArrow.innerHTML = '<span><i class="arrow down"></i></span>';
    } else {
        bottomArrow.innerHTML = '<span><i class="arrow up"></i></span>';
    }
    bottomRow.appendChild(bottomArrow);
    return bottomRow;
}


function createAreaRow(areaName, timeTableMinimised) {
    let areaRow = document.createElement("tr");
    areaRow.id = `${areaName}-btn`;
    if (!timeTableMinimised) {
        areaRow.classList.add('areaBtn', 'collapse.show', 'table-dark');
    } else {
        areaRow.classList.add('areaBtn', 'collapse', 'table-dark');
    }
    areaRow.setAttribute('role', 'button');
    let th = document.createElement("th");
    th.setAttribute('colspan', fullColSpan);
    th.appendChild(document.createTextNode(areaName));
    areaRow.appendChild(th);
    return areaRow;
}


function createTableRow(areaName, tableName, areaTablesExpanded) {
    let tableRow = document.createElement('tr');
    tableRow.id = `${areaName}`;        // used for setting areaName to areas array
    if (areaTablesExpanded) {
        tableRow.classList.add(`${areaName}`, 'collapse.show');
    } else {
        tableRow.classList.add(`${areaName}`, 'collapse');
    }
    createTableRowHeader(tableName, tableRow);           // header cell
    let currentCellTime = new Date(leftCellBoundary);       // left cell boundary rotates with arrow buttons
    let bookingsOnTable = getBookingsOnTable(tableName);
    let bookingsOnTableRendered = [];
    bookingsOnTable.forEach(() => bookingsOnTableRendered.push(false));     // tracker for each booking being rendered (avoid repeat rendering)
    for (let i = 0; i < visibleColCount; i++) {
        let bookingExistsInCell = false;
        for (let j = 0; j < bookingsOnTable.length; j++) {
            let bookingStart = new Date(bookingsOnTable[j].startTime);
            let bookingEnd = new Date(bookingsOnTable[j].endTime);
            let cellDuration = getCellDuration(bookingsOnTable[j], bookingStart, bookingEnd, i);
            if (isVisibleOnTable(bookingStart, bookingEnd) && !bookingsOnTableRendered[j] && bookingStart <= currentCellTime) {
                createBookingCell(bookingsOnTable[j], cellDuration, tableRow, tableName);
                bookingsOnTableRendered[j] = true;
            }
            if (bookingStart <= currentCellTime && bookingEnd > currentCellTime) {    // missing table contains booking check
                bookingExistsInCell = true;
            }
        }
        if (!bookingExistsInCell) {
            createEmptyCell(currentCellTime, tableRow);
        }
        currentCellTime.setMinutes(currentCellTime.getMinutes() + timeInterval);
    }
    let rowEndCell = document.createElement('th');      // end cell
    rowEndCell.classList.add('table-dark');
    tableRow.appendChild(rowEndCell);
    return tableRow;
}


function isVisibleOnTable(bookingStart, bookingEnd) {
    if (bookingStart < rightCellBoundary && bookingStart > leftCellBoundary) {
        return true;
    }
    if (bookingEnd > leftCellBoundary && bookingEnd < rightCellBoundary) {
        return true;
    }
    return false;
}


function getCellDuration(booking, bookingStart, bookingEnd, currentCellIndex) {
    let cellDuration = booking.duration / timeInterval;
    if (bookingEnd >= rightCellBoundary) {  // off to the right
        let diff = (currentCellIndex + cellDuration) - visibleColCount;
        cellDuration -= diff;
    }
    if (bookingStart < leftCellBoundary) {  // off to the left
        let time1 = moment(leftCellBoundary);
        let time2 = moment(bookingStart);
        var duration = moment.duration(time1.diff(time2));
        var diff = parseInt(duration.asMinutes()) / timeInterval;
        cellDuration -= diff;
    }
    return cellDuration;
}


function createBookingCell(booking, cellDuration, tableRow, tableName) {
    let firstName = booking.customer.firstName;
    let lastName = booking.customer.lastName;
    let bookingName = firstName.substring(0, 1) + lastName.substring(0, 1) + "-" + booking.id;
    let timelineBookingId = bookingName + "-timeline";
    let tableReservation = createTableReservationObject(bookingName, tableName);

    let td = document.createElement('td');
    td.classList.add('timeline-booking');
    if (isAssignedNotConfirmed(tableReservation)) {
        td.classList.add('timeline-booking-assigned');
    } else {
        td.classList.add('timeline-booking-confirmed');
    }
    td.setAttribute('colspan', cellDuration);
    td.innerHTML = `<span id="${timelineBookingId}">${firstName} ${lastName} | Guests: ${booking.guests}</span>`;
    tableRow.appendChild(td);
}


function createEmptyCell(currentCellTime, tableRow) {
    let td = document.createElement('td');
    let now = new Date();
    let nextCellTime = new Date(currentCellTime);
    nextCellTime.setMinutes(currentCellTime.getMinutes() + timeInterval);
    if (nextCellTime <= now) {
        td.classList.add('time-cell-past');
    } else if (currentCellTime <= now && nextCellTime > now) {
        td.classList.add('time-cell-now');
    }
    td.classList.add('time-cell-empty');
    tableRow.appendChild(td);
}


function createTableRowHeader(tableName, tableRow) {
    let th = document.createElement('th');
    th.classList.add('table-dark');
    th.appendChild(document.createTextNode(tableName));
    tableRow.appendChild(th);
}