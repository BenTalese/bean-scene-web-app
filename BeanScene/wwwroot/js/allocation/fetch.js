function fetchServicesOnDate() {
    let date = $('#dateForFetchAPI').val();
    let day = date.split('/')[0];
    let month = date.split('/')[1];
    let year = date.split('/')[2];
    let uri = `/api/service/${day}/${month}/${year}`;

    fetch(uri)
        .then(response => response.json())
        .then(data => data.forEach(service => servicesOnDate.push(service)))
        .then(() => initialisePage())
        .catch(error => console.error('Unable to get list of services.', error))
}

function unconfirmTableReservations() {
    let uri = '/api/allocation/unassign-tables';
    fetch(uri, {
        method: 'DELETE',
        headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(modifiedTableReservations)
    })
        .then(() => confirmTableReservations())
        .catch(error => {
            notifyError('There was an error updating table reservations.', 'Please try again.')  // refresh with "OK"
            console.error('Unable to modify existing table reservations.', error)
        });
}

function confirmTableReservations() {
    let uri = '/api/allocation/assign-tables';
    console.log(JSON.stringify(newTableReservations));
    fetch(uri, {
        method: 'POST',
        headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(newTableReservations)
    })
        .then(response => response.json())
        .then(data => {
            console.log('Success:', data);
        })
        .then(() => notifySuccess())
        .catch(error => {
            notifyError()
            console.error('Unable to create table reservations.', error)
        });
}