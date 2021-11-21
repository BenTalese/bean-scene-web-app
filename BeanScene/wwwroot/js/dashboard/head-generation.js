function generateTableHead(table) {
    let thead = table.createTHead();
    let row = thead.insertRow();
    row.classList.add('table-dark');
    row.appendChild(createLeftArrow());
    populateTimeCells(row);
    row.appendChild(createRightArrow());
}

function populateTimeCells(row) {
    let currentCellTime = new Date(leftCellBoundary);
    for (i = 0; i < visibleColCount; i++) {
        let th = document.createElement("th");
        th.classList.add('p-3');
        th.setAttribute('role', 'button');
        let timeAsString = currentCellTime.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });
        th.appendChild(document.createTextNode(timeAsString));
        row.appendChild(th);
        currentCellTime.setMinutes(currentCellTime.getMinutes() + timeInterval);
    }
}

function createLeftArrow() {
    let leftArrow = document.createElement('th');
    leftArrow.id = 'arrow-scroll-left';
    leftArrow.classList.add('arrow-container', 'align-middle', 'px-4');
    if (leftCellBoundary.getTime() != minTime.getTime()) {
        leftArrow.setAttribute('role', 'button');
        leftArrow.innerHTML = '<span><i class="arrow left"></i></span>';
    }
    return leftArrow;
}

function createRightArrow() {
    let rightArrow = document.createElement('th');
    rightArrow.id = 'arrow-scroll-right';
    rightArrow.classList.add('arrow-container', 'align-middle', 'px-4');
    if (rightCellBoundary.getTime() <= maxTime.getTime()) {
        rightArrow.setAttribute('role', 'button');
        rightArrow.innerHTML = '<span><i class="arrow right"></i></span>';
    }
    return rightArrow;
}