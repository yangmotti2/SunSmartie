
//마우스오버에 따른 지도 색 변환
function change_map_color(lat, lng) {
    fetch(`radi_table.do?lat=${lat}&lng=${lng}`)
        .then(response => {
            if (!response.ok) {
                throw new Error('Network response was not ok ' + response.statusText);
            }
            return response.json();
        })
        .then(data => {
         	 let updated_radi_list = data.radi_list; //cityname, list 두개이므로 list를 꺼내야 함
         	 let map_color = update_map_color(updated_radi_list); // 하단의 함수 호출
         	 if(map_color != null){ //현재 시각에 해당하는 값이 없어서 null인 경우 있음
         	 	console.log(map_color);
         	 	currentPolygon.setOptions({fillColor : map_color});
         	 }else{
         	 	currentPolygon.setOptions({ fillColor: '#09f' });
         	 }
        })
        .catch(error => console.error('There has been a problem with your fetch operation:', error));
}

//마우스클릭에 따른 알림
function change_uv_notice(lat, lng, callback) {
    fetch(`radi_table.do?lat=${lat}&lng=${lng}`)
        .then(response => {
            if (!response.ok) {
                throw new Error('Network response was not ok ' + response.statusText);
            }
            return response.json();
        })
        .then(data => {
            let updated_radi_list = data.radi_list; //cityname, list 두개이므로 list를 꺼내야 함
            let uv_notice = update_uv_notice(updated_radi_list);
            if (uv_notice != null) { // 현재 시각에 해당하는 값이 없어서 null인 경우 있음
                console.log(uv_notice);
                callback(uv_notice);
            } else {
                callback("before sunrise");
            }
        })
        .catch(error => console.error('There has been a problem with your fetch operation:', error));
}



//날짜 포맷 함수
function formatDate(date) {
    // 날짜 부분 포맷팅
    let year = date.getFullYear();
    let month = ('0' + (date.getMonth() + 1)).slice(-2); //월 0~11 + 1, 앞에 0붙이고 뒤에서부터 2자리 슬라이스
    let day = ('0' + date.getDate()).slice(-2);
    
    // 시간 부분 포맷팅
    let hours = ('0' + date.getHours()).slice(-2);
    let minutes = ('0' + date.getMinutes()).slice(-2);
    let seconds = ('0' + date.getSeconds()).slice(-2);
     
    // 포맷팅된 문자열 합치기
    return `${year}-${month}-${day} ${hours}:${minutes}:${seconds}`;
}

//현재 시간의 uv_color값 반환
function update_map_color(newList){
	let now = new Date();
	let formattedDate = formatDate(now);
	let currentHour = now.getHours();
	console.log("현재날짜 : " + formattedDate);
	console.log("현재시간 : " + currentHour);
	
	let found = newList.find(vo => {
		let date = vo.uv_time;
		let listHour = date.substring(11, 13);
		return listHour == currentHour;
	});
	return found ? found.uv_color : null;
}

//현재 시간의 uv_notice값 반환
function update_uv_notice(newList){
	let now = new Date();
	let formattedDate = formatDate(now);
	let currentHour = now.getHours();
	
	let found = newList.find(vo => {
		let date = vo.uv_time;
		let listHour = date.substring(11, 13);
		return listHour == currentHour;
	});
	return found ? found.uv_notice : null;
}