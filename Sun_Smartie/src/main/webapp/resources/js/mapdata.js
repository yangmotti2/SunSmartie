var simplemaps_countrymap_mapdata={
  main_settings: {
   //General settings
    width: "responsive", //'700' or 'responsive'
    background_color: "#FFFFFF",
    background_transparent: "yes",
    border_color: "#ffffff",
    
    //State defaults
    state_description: "State description",
    state_color: "#88A4BC",
    state_hover_color: "#3B729F",
    state_url: "",
    border_size: 1.5,
    all_states_inactive: "no",
    all_states_zoomable: "yes",
    
    //Location defaults
    location_description: "Location description",
    location_url: "",
    location_color: "#FF0067",
    location_opacity: 0.8,
    location_hover_opacity: 1,
    location_size: "35",
    location_type: "square",
    location_image_source: "frog.png",
    location_border_color: "#FFFFFF",
    location_border: 2,
    location_hover_border: 2.5,
    all_locations_inactive: "no",
    all_locations_hidden: "no",
    
    //Label defaults
    label_color: "#ffffff",
    label_hover_color: "#ffffff",
    label_size: 16,
    label_font: "Arial",
    label_display: "auto",
    label_scale: "yes",
    hide_labels: "no",
    hide_eastern_labels: "no",
   
    //Zoom settings
    zoom: "yes",
    manual_zoom: "yes",
    back_image: "no",
    initial_back: "no",
    initial_zoom: "-1",
    initial_zoom_solo: "no",
    region_opacity: 1,
    region_hover_opacity: 0.6,
    zoom_out_incrementally: "yes",
    zoom_percentage: 0.99,
    zoom_time: 0.5,
    
    //Popup settings
    popup_color: "white",
    popup_opacity: 0.9,
    popup_shadow: 1,
    popup_corners: 5,
    popup_font: "12px/1.5 Verdana, Arial, Helvetica, sans-serif",
    popup_nocss: "no",
    
    //Advanced settings
    div: "map",
    auto_load: "yes",
    url_new_tab: "no",
    images_directory: "default",
    fade_time: 0.1,
    link_text: "View Website",
    popups: "detect",
    state_image_url: "",
    state_image_position: "",
    location_image_url: ""
  },
  state_specific: {
    KR11: {
      name: "Seoul"
    },
    KR26: {
      name: "Busan"
    },
    KR27: {
      name: "Daegu"
    },
    KR28: {
      name: "Incheon"
    },
    KR29: {
      name: "Gwangju"
    },
    KR30: {
      name: "Daejeon"
    },
    KR31: {
      name: "Ulsan"
    },
    KR41: {
      name: "Gyeonggi"
    },
    KR42: {
      name: "Gangwon"
    },
    KR43: {
      name: "North Chungcheong"
    },
    KR44: {
      name: "South Chungcheong"
    },
    KR45: {
      name: "North Jeolla"
    },
    KR46: {
      name: "South Jeolla"
    },
    KR47: {
      name: "North Gyeongsang"
    },
    KR48: {
      name: "South Gyeongsang"
    },
    KR49: {
      name: "Jeju"
    },
    KR50: {
      name: "Sejong"
    }
  },
  locations: {
    "0": {
      lat: 37.559,
      lng: 127,
      name: "seoul"
    },
    "1": {
      lat: "37.7491",
      lng: "128.8785",
      name: "Gangneung"
    },
    "2": {
      lat: "37.5219",
      lng: "129.1166",
      name: "Donghae"
    },
    "3": {
      lat: "37.4471",
      lng: "129.1675",
      name: "Samcheok"
    },
    "4": {
      lat: "38.2043",
      lng: "128.5942",
      name: "Sokcho"
    }
  },
  labels: {
    KR11: {
      name: "Seoul",
      parent_id: "KR11"
    },
    KR26: {
      name: "Busan",
      parent_id: "KR26"
    },
    KR27: {
      name: "Daegu",
      parent_id: "KR27"
    },
    KR28: {
      name: "Incheon",
      parent_id: "KR28"
    },
    KR29: {
      name: "Gwangju",
      parent_id: "KR29"
    },
    KR30: {
      name: "Daejeon",
      parent_id: "KR30"
    },
    KR31: {
      name: "Ulsan",
      parent_id: "KR31"
    },
    KR41: {
      name: "Gyeonggi",
      parent_id: "KR41"
    },
    KR42: {
      name: "Gangwon",
      parent_id: "KR42"
    },
    KR43: {
      name: "North Chungcheong",
      parent_id: "KR43"
    },
    KR44: {
      name: "South Chungcheong",
      parent_id: "KR44"
    },
    KR45: {
      name: "North Jeolla",
      parent_id: "KR45"
    },
    KR46: {
      name: "South Jeolla",
      parent_id: "KR46"
    },
    KR47: {
      name: "North Gyeongsang",
      parent_id: "KR47"
    },
    KR48: {
      name: "South Gyeongsang",
      parent_id: "KR48"
    },
    KR49: {
      name: "Jeju",
      parent_id: "KR49"
    },
    KR50: {
      name: "Sejong",
      parent_id: "KR50"
    }
  },
  legend: {
    entries: []
  },
  regions: {}
};