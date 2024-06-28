function change_radi_list(lat, lng) {
    fetch(`radi_table.do?lat=${lat}&lng=${lng}`)
        .then(response => {
            if (!response.ok) {
                throw new Error('Network response was not ok ' + response.statusText);
            }
            return response.json();
        })
        .then(updated_radi_list => {
            update_radi_table(updated_radi_list);
            update_radi_bar(updated_radi_list);
        })
        .catch(error => console.error('There has been a problem with your fetch operation:', error));
}

function update_radi_table(newList) {
    const tableBody = document.getElementById('radi-table-body');
    let tableRows = '';
    newList.forEach(vo => {
        tableRows += `<tr>
            <td>${vo.uv_time}</td>
            <td>${vo.uv}</td>
            <td>${vo.latitude}</td>
            <td>${vo.longitude}</td>
        </tr>`;
    });
    tableBody.innerHTML = tableRows;
}

function update_radi_bar(newList) {
    const container = document.getElementById('uv_box-container');
    let boxElements = '';
    const boxWidth = `calc(100% / ${newList.length} - 2px)`;

    newList.forEach(vo => {
        boxElements += `<div class="uv_box" onclick="uv_change('${vo.uv_color}');" 
                             style="width: ${boxWidth}; background-color: ${vo.uv_color}">
                            ${vo.uv}
                        </div>`;
    });

    container.innerHTML = boxElements;
}