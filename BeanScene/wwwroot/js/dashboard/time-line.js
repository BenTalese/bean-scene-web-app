// 15min increments for each cell
// get % of 15min the current time is
// translate that to % of cell width
// 5:28 => 28%15 => 1 remainder 13 => 13min elapsed from 0 to 15
// 13/15*100 => 86.666%
// cell width: 228.359375
// 228.359375 * 0.86 => 196.3890625
// 5:28:32 => 32/59 => 54% (get seconds into %)
// cell width / 15min gives 60sec pixel value
// (228.359375 / 15) * 0.54 => 8.2209

var vline = $('#time-line');
let timeCellChanged = false;     // prevent table initialisation every 50ms if on 15min mark (stops button interactivity) 
let timeLineTop, timeLineLeft, cellWidth, tableHeight, tableTop;

setInterval(function () {
    let now = new Date();
    if (now > leftCellBoundary && now <= rightCellBoundary && areas.some(area => area.areaTablesExpanded == true)) {
        let minutesNow = new Date().getMinutes();
        let secondsNow = new Date().getSeconds();
        let minutePercent = (minutesNow % 15) / 15;
        let secondPercent = secondsNow / 59;
        let minutePos = cellWidth * minutePercent;
        let secondPos = (cellWidth / 15) * secondPercent;
        getDimensions();
        $('#time-line').css({
            'height': `${tableHeight - tableHeight * 0.09}px`,
            'top': `${timeLineTop - tableTop + tableHeight*0.1}px`,
            'left': `${timeLineLeft + minutePos + secondPos}px`,
            'display': 'block'
        });
        if (minutesNow % 15 == 0 && !timeCellChanged) {
            timeCellChanged = true;
            initialiseTimeTable();  // move time-cell-now forward
        } else if (minutesNow % 15 == 1) {
            timeCellChanged = false;
        }
    } else {
        $('#time-line').css({ 'display': 'none' });
    }
}, 100);


function getDimensions() {
    let topShownCellNow = getTopShownCellNow().getBoundingClientRect();
    timeLineLeft = topShownCellNow.left;
    timeLineTop = topShownCellNow.top;
    cellWidth = topShownCellNow.width;
    tableHeight = document.getElementsByTagName('table')[0].getBoundingClientRect().height;
    tableTop = document.getElementsByTagName('table')[0].getBoundingClientRect().top;
}


function getTopShownCellNow() {
    let cellsNow = document.getElementsByClassName('time-cell-now');
    for (let i = 0; i < cellsNow.length; i++) {
        if (window.getComputedStyle(cellsNow[i].parentElement, null).display != "none") {   // .parent because the row is hidden, not the cells
            return cellsNow[i];
        }
    }
}