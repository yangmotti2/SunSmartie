<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html>
   <head>
   <meta charset="UTF-8">
   <title>Insert title here</title>
   
   <style>
         .overlay_info {
            position: relative;
            border: 1px solid #ccc;
            background-color: white;
            padding: 10px;
            border-radius: 10px;
            box-shadow: 2px 2px 2px rgba(0, 0, 0, 0.3);
            width: 80px;
            height: 50px;
            text-align: center;
            line-height:3;
        }

        .overlay_info .nv_notice {
            font-size: 14px;
            color: #777;
        }

        .overlay_info::after {
            content: '';
            position: absolute;
            bottom: -19px; /* /* Adjust this to position the tail */
            left: 50%;
            margin-left: -10px;
            width: 0;
            height: 0;
            border-width: 10px;
            border-style: solid;
            border-color: white transparent transparent transparent;
            z-index: 1; /* Ensures it is above the shadow */
        }

        .overlay_info::before {
            content: '';
            position: absolute;
            bottom: -24px; /* /* Adjust this to position the shadow */
            left: 50%;
            margin-left: -11px;
            width: 0;
            height: 0;
            border-width: 12px;
            border-style: solid;
            border-color: rgba(0, 0, 0, 0.3) transparent transparent transparent;
            z-index: 0; /* Ensures it is below the main tail */
        }
    </style>

</head>
   
<body>

   <div id="map" style="width: 500px; height: 500px;"></div>

   <!-- <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> -->
   <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=0764536504d016798367cf2283191f94&libraries=clusterer"></script>
    <script type="text/javascript">
        // Chrome 보안 강화 정책에 따른 서드파티 쿠키 허용
        document.cookie = 'cookie2=value2; SameSite=None; Secure';

        // -- 변수 선언 --
        let container = document.getElementById('map'); // 지도를 담을 영역의 DOM 레퍼런스
        let lat = ${latitude != null ? latitude : 33.450701}; // 세션에서 가져온 값이 있으면 사용, 없으면 기본값
        let lon = ${longitude != null ? longitude : 126.570667}; // 세션에서 가져온 값이 있으면 사용, 없으면 기본값
        let level = ${level != null ? level : 12}; // 세션에서 가져온 값이 있으면 사용, 없으면 기본값
        
        let options = { // 지도를 생성할 때 필요한 기본 옵션
            //center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표 (제주도).
//*세션에 담긴 위도경도 값으로 지도 중심좌표 잡기            
            center: new kakao.maps.LatLng(${lat}, ${lon}),
            level: level // 지도의 레벨(확대, 축소 정도)
        };

        let map = new kakao.maps.Map(container, options); // 지도 생성 및 객체 리턴
        let customOverlay = new kakao.maps.CustomOverlay({});
        let detailMode = false; // level에 따라 다른 json 파일 사용 (sido.json인지 sig.json인지 구분하기 위해 설정한 불린변수)
        /* let level = ''; */ //현재 줌인 레벨을 확인하기 위한 전역변수 설정
        let polygons = [];        
        let areas = []; // areas 변수를 전역으로 선언하여 참조 가능하게 함 (각 지역정보를 맵에 넣을 수 있는 상태로 정리해서 넣을 배열)
//*현재 마우스 오버된 폴리곤을 저장할 전역변수      
        let currentPolygon = null; 
        
//*마커 변수 선언
        let marker = null;
 
//*알림표시 정보를 담을 커스텀오버레이 전역 변수로 선언 (이전 정보 지우기 위해)
        let newCustomOverlay = null; 


        
        // -- 변수 선언 끝 --
		
        /* if (level <= 10) { // level에 따라 다른 json 파일을 사용한다.
                detailMode = true;
                removePolygon();
                init("resources/json/sig.json"); //다시 선을 그려라
        } else if (level > 10) { // level에 따라 다른 json 파일을 사용한다.
                detailMode = false;
                removePolygon();
                init("resources/json/sido.json");
        } */
        init("resources/json/sido.json");

        kakao.maps.event.addListener(map, 'zoom_changed', function() {
            level = map.getLevel();
            console.log(level); //현재 레벨 콘솔에서 확인
            if (!detailMode && level <= 10) { // level에 따라 다른 json 파일을 사용한다.
                detailMode = true;
                removePolygon(); //배경에 선을 일단 지워라
                init("resources/json/sig.json"); //다시 선을 그려라
            } else if (detailMode && level > 10) { // level에 따라 다른 json 파일을 사용한다.
                detailMode = false;
                removePolygon();
                init("resources/json/sido.json");
            }
        });

        // 모든 폴리곤을 지우는 함수
        function removePolygon() {
            for (let i = 0; i < polygons.length; i++) {
                polygons[i].setMap(null); //setMap이란 메서드 제공됨. null을 넣으면 polygon배열값을 모두 null로 만들어서 공백을 지도에 올린다
            }
            areas = [];
            polygons = []; //배열 초기화
        }
        
        // 폴리곤의 중심을 계산하는 함수 (우리 커스터마이즈)
        function getPolygonCenter(path) { //path는 json파일
            let minLat = path[0].getLat();
            let maxLat = path[0].getLat();
            let minLng = path[0].getLng();
            let maxLng = path[0].getLng();

            path.forEach(function(latlng) { //한 지역의 모든 coordinates좌표를 돌면서 최대, 최소값 찾음
                if (latlng.getLat() < minLat) minLat = latlng.getLat();
                if (latlng.getLat() > maxLat) maxLat = latlng.getLat();
                if (latlng.getLng() < minLng) minLng = latlng.getLng();
                if (latlng.getLng() > maxLng) maxLng = latlng.getLng();
            });

            let centerLat = (minLat + maxLat) / 2;
            let centerLng = (minLng + maxLng) / 2;

            return new kakao.maps.LatLng(centerLat, centerLng);
        }
        
        // 폴리곤 생성 
        function init(path) {//각 지역을 맵에 뿌리기 편한 상태로 정리해서 배열화 시키고 맵에 넣는 메서드
            // path 경로의 json 파일 파싱
            fetch(path)
                .then(response => response.json())
                .then(geojson => {
                    var units = geojson.features; // json key값이 "features"인 것의 value를 통으로 가져온다.

                    units.forEach((unit, index) => { // 1개 지역씩 꺼내서 사용. unit은 그 1개 지역에 대한 정보를 담는다 (각 freature를 unit변수에 담는다)
                        var coordinates = []; // 좌표 저장할 배열
                        var name = ''; // 지역 이름
                        var cd_location = '';

                        if (unit.properties) { //sido.json에서 properties값 가져오기
                            coordinates = unit.geometry.coordinates; // 1개 지역의 영역을 구성하는 다각형의 모든 좌표 배열
                            name = unit.properties.SIG_KOR_NM || unit.properties.CTP_KOR_NM; // 1개 지역의 이름 (한글이름 없으면 영어이름 넣기)

                            if (path.includes("sido.json")) { //파일별로 이름 다른거 구분해서 넣음
                                cd_location = unit.properties.CTPRVN_CD;
                            } else if (path.includes("sig.json")) {
                                cd_location = unit.properties.SIG_CD;
                            }

                            var ob = {
                                name: name,
                                path: [],
                                location: cd_location
                            };
							//지도에는 latlng이라는 객체를 만들어서 넣어야함
                            coordinates[0].forEach(coordinate => {
                                ob.path.push(new kakao.maps.LatLng(coordinate[1], coordinate[0]));
                            });

                            areas[index] = ob; //인덱스0부터 돌면서 각 지역 배열로 넣음
                        } else {
                            console.error("CTPRVN_CD or SIG_CD not found in unit.properties");
                        }
                    });

                    // 지도에 영역데이터를 폴리곤으로 표시
                    for (var i = 0, len = areas.length; i < len; i++) {
                        displayArea(areas[i]);
                    }
                })
                .catch(error => console.error('Error fetching JSON:', error));
        }

        function displayArea(area) {
            var polygon = new kakao.maps.Polygon({
                map: map, //처음 선언한 맵 자체
                path: area.path, //다각형을 구성하는 좌표의 배열 혹은 좌표 배열의 배열. 위에서 넣은 path[]
                strokeWeight: 2,
                strokeColor: '#004c80',
                strokeOpacity: 0.8,
                fillColor: '#fff',
                fillOpacity: 0.3
            });
            polygons.push(polygon);
            
            var center = getPolygonCenter(area.path); // 폴리곤의 중심 계산
            


            kakao.maps.event.addListener(polygon, 'mouseover', function(mouseEvent) {
//마우스오버 색변환            	
            	var latlng = mouseEvent.latLng;
            	var lat = latlng.getLat();
            	var lng = latlng.getLng();
            	
            	currentPolygon = polygon; // 마우스 오버된 폴리곤을 저장
            	change_map_color(lat, lng);
            	
            	//polygon.setOptions({ fillColor: map_color });
                //polygon.setOptions({ fillColor: '#09f' });
                /* customOverlay.setContent('<div class="area">' + area.name + '</div>'); */
                customOverlay.setPosition(mouseEvent.latLng);
                customOverlay.setMap(map);
            });

            kakao.maps.event.addListener(polygon, 'mousemove', function(mouseEvent) {
                customOverlay.setPosition(mouseEvent.latLng);
            });

            kakao.maps.event.addListener(polygon, 'mouseout', function() {
                polygon.setOptions({ fillColor: '#fff' });
                customOverlay.setMap(null);
            });

            kakao.maps.event.addListener(polygon, 'click', async function(mouseEvent) {
            	var latlng = mouseEvent.latLng;
            	var lat = latlng.getLat();
            	var lng = latlng.getLng();
            	
                if (!detailMode) {//detail모드가 아닐때 true가 되므로 실행
                    map.setLevel(10); // level에 따라 이벤트 변경
                    
                    // 지도의 중심을 부드럽게 클릭한 위치로 이동시킵니다.
                    map.panTo(latlng);
                    console.log(latlng);
                    
                } else {
                    map.setLevel(level); // level에 따라 이벤트 변경
                    map.panTo(center); // 클릭한 폴리곤의 중심을 지도 중심으로 설정
                	change_radi_list(lat, lng);
                }
     
	            //단일 마커 추가갱신 기능
	           /*  if (marker) { // 기존 마커가 있는 경우 위치를 갱신
	                marker.setPosition(latlng);
	            } else { // 기존 마커가 없는 경우 새로 추가
	                marker = new kakao.maps.Marker({
	                    position: latlng,
	                    map: map
	                });
	            } */
	            
	            change_uv_notice(lat, lng, function(uv_notice) {//function - 콜백함수
	                //커스텀 오버레이 내용 설정
	                var content = '<div class="overlay_info">';
	                content += '        <span class="uv_notice">' + uv_notice + '</span>';
	                content += '    </div>';
	                content += '</div>';

	                //기존 커스텀 오버레이가 있는 경우 제거 (이전 마우스클릭 포인트에 알림창 쌓이지 않게)
	                if (newCustomOverlay) {
	                    newCustomOverlay.setMap(null);
	                }

	                //새로운 커스텀 오버레이 생성 및 갱신
	                newCustomOverlay = new kakao.maps.CustomOverlay({
	                    position: latlng,
	                    content: content,
	                    xAnchor: 0.5,
	                    yAnchor: 1.1
	                });

	                //새로운 커스텀 오버레이를 지도에 표시
	                newCustomOverlay.setMap(map);
	            });

            });
        }
    </script>
   
</body>
</html>














