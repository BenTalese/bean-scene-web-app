var ctx = document.getElementById("myChart").getContext("2d");
var myChart = new Chart(ctx, {
    type: "line",
    data: {
        labels: [
            "Monday",
            "Tuesday",
            "Wednesday",
            "Thursday",
            "Friday",
            "Saturday",
            "Sunday",
        ],
        datasets: [
            {
                label: "NoShows",
                data: [2, 2, 5, 5, 2, 1, 10],
                backgroundColor: "rgba(255,165,0,0.6)",
            },
            {
                label: "Complete",
                data: [2, 9, 3, 17, 6, 3, 7],
                backgroundColor: "rgba(255,0,0,0.6)",
            },
        ],
    },
});

var ctx = document.getElementById("myChart2").getContext("2d");
var myChart = new Chart(ctx, {
    type: "bar",
    data: {
        labels: [
            "Monday",
            "Tuesday",
            "Wednesday",
            "Thursday",
            "Friday",
            "Saturday",
            "Sunday",
        ],
        datasets: [
            {
                label: "Approved",
                data: [2, 2, 5, 5, 2, 1, 10],
                backgroundColor: "rgba(60,179,113,0.6)",
            },
            {
                label: "Pending",
                data: [2, 9, 3, 17, 6, 3, 7],
                backgroundColor: "rgba(238,238,0,0.6)",
            },
        ],
    },
});