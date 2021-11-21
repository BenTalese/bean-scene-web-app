function enableAreaAccordion() {
    $('.areaBtn').on('click', function () {
        let areaName = $(this).next().attr('id');
        let idx = areas.findIndex(area => area.name == $(this).find('th').text());

        if ($(this).next().is(':hidden')) {
            $(`.${areaName}`).show("fast");
            areas[idx].areaTablesExpanded = true;
        } else {
            $(`.${areaName}`).hide("fast");
            areas[idx].areaTablesExpanded = false;
        }
    });
}

function enableArrowHover() {
    $('.arrow-container').hover(function () {
        $(this).find('.arrow').addClass('arrow-hover');
    }, function () {
        $(this).find('.arrow').removeClass('arrow-hover');
    });
}

function enableMinimise() {
    $('#arrow-collapse').on('click', function () {
        if ($('.areaBtn').is(':hidden')) {
            $(this).find('.arrow').addClass('up');
            $(this).find('.arrow').removeClass('down');
            $('.areaBtn').show("fast");
            timeTableMinimised = false;
        } else {
            $(this).find('.arrow').addClass('down');
            $(this).find('.arrow').removeClass('up');
            $('.areaBtn').hide("fast");
            $('.areaBtn').each(function () {
                let areaName = $(this).next().attr('id');
                $(`.${areaName}`).hide("fast");
            })
            timeTableMinimised = true;
            areas.forEach(area => area.areaTablesExpanded = false);
        }
    });
}

function enableScroll() {
    $('#arrow-scroll-left').on('click', function () {
        if (leftCellBoundary > minTime) {
            leftCellBoundary.setMinutes(leftCellBoundary.getMinutes() - timeInterval);
            rightCellBoundary.setMinutes(rightCellBoundary.getMinutes() - timeInterval);
            initialiseTimeTable();
        }
    });

    $('#arrow-scroll-right').on('click', function () {
        if (rightCellBoundary <= maxTime) {
            leftCellBoundary.setMinutes(leftCellBoundary.getMinutes() + timeInterval);
            rightCellBoundary.setMinutes(rightCellBoundary.getMinutes() + timeInterval);
            initialiseTimeTable();
        }
    });
}