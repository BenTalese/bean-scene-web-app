const statsUri = '/api/reporting/stats';

var pending = [2, 4, 3, 4, 6, 4, 7];
var approved = [8, 7, 5, 7, 9, 11, 10];
var complete = [15, 16, 18, 17, 16, 19, 17];
var noShow = [2, 2, 5, 5, 2, 1, 3];
var thisWeek = [12, 9, 14, 13, 17, 15, 17];
var lastWeek = [10, 11, 12, 12, 16, 15, 14];
var breakfast = [5, 4, 5, 5, 6, 9, 12];
var lunch = [4, 6, 5, 8, 7, 11, 10];
var dinner = [12, 9, 8, 10, 9, 13, 15];

$(() => { fetchStats() });

function fetchStats() {
    fetch(statsUri)
        .then(response => response.json())
        .then(data => initialiseCharts(data))
        .catch(error => console.error('Unable to get list of services.', error))
}

function initialiseCharts(allStats) {
    var ctx = document.getElementById("myChart").getContext("2d");
    var myChart = new Chart(ctx, {
        type: "line",
        data: {
            labels: [
                "Sunday",
                "Monday",
                "Tuesday",
                "Wednesday",
                "Thursday",
                "Friday",
                "Saturday",
            ],
            datasets: [
                {
                    label: "No-Shows",
                    data: allStats.noShow,
                    backgroundColor: "rgba(255,0,0,0.6)",
                },
                {
                    label: "Complete",
                    data: allStats.complete,
                    backgroundColor: "rgba(238,238,0,0.6)",
                },
            ],
        },
        options: {
            scales: {
                yAxes: [{
                    ticks: {
                        beginAtZero: true
                    }
                }]
            }
        }
    });

    var ctx3 = document.getElementById("myChart3").getContext("2d");
    var myChart3 = new Chart(ctx3, {
        type: "line",
        data: {
            labels: [
                "Sunday",
                "Monday",
                "Tuesday",
                "Wednesday",
                "Thursday",
                "Friday",
                "Saturday",
            ],
            datasets: [
                {
                    label: "Pending",
                    data: allStats.pending,
                    backgroundColor: "rgba(255,165,0,0.6)",
                },
                {
                    label: "Approved",
                    data: allStats.approved,
                    backgroundColor: "rgba(60,179,113,0.6)",
                },
            ],
        },
        options: {
            scales: {
                yAxes: [{
                    ticks: {
                        beginAtZero: true
                    }
                }]
            }
        }
    });

    var ctx2 = document.getElementById("myChart2").getContext("2d");
    var myChart2 = new Chart(ctx2, {
        type: "bar",
        data: {
            labels: [
                "Sunday",
                "Monday",
                "Tuesday",
                "Wednesday",
                "Thursday",
                "Friday",
                "Saturday",
            ],
            datasets: [
                {
                    label: "This Week",
                    data: allStats.thisWeek,
                    backgroundColor: "rgba(54,162,235,0.6)",
                },
                {
                    label: "Last Week",
                    data: allStats.lastWeek,
                    backgroundColor: "rgb(255,20,147,0.6)",
                },
            ],
        },
        options: {
            scales: {
                yAxes: [{
                    ticks: {
                        beginAtZero: true
                    }
                }]
            }
        }
    });

    var ctx4 = document.getElementById("myChart4").getContext("2d");
    var myChart4 = new Chart(ctx4, {
        type: "bar",
        data: {
            labels: [
                "Sunday",
                "Monday",
                "Tuesday",
                "Wednesday",
                "Thursday",
                "Friday",
                "Saturday",
            ],
            datasets: [
                {
                    label: "Breakfast",
                    data: allStats.breakfast,
                    backgroundColor: "rgb(165,42,42,0.5)",
                },
                {
                    label: "Lunch",
                    data: allStats.lunch,
                    backgroundColor: "rgba(153,102,255,0.6)",
                },
                {
                    label: "Dinner",
                    data: allStats.dinner,
                    backgroundColor: "rgba(0,255,255,0.6)",
                },
            ],
        },
        options: {
            scales: {
                yAxes: [{
                    ticks: {
                        beginAtZero: true
                    }
                }]
            }
        }
    });
}