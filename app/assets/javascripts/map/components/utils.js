const imageUrlToGoogleMapIcon = (image) =>{
  return {
    url: image,
    scaledSize: new google.maps.Size(36, 36),
    fillOpacity: 1,
    fillColor: 'red',
    strokeWeight: 2,
    strokeColor: "white",
  }
}

const convertStringToLatlong = (latlong = ",") => {
  return {
    lat: parseFloat(latlong.split(",")[0]),
    lng: parseFloat(latlong.split(",")[1]),
  }
}

const displayMarker = (latlong, content, icon) => {
  const position = convertStringToLatlong(latlong);
  let config = {
    position,
    map,
  }
  if(icon != null) {
    config.icon = icon
  }
  const marker = new google.maps.Marker(config);
  const infoWindow = new google.maps.InfoWindow();

  marker.addListener("click", () => {
    infoWindow.close();
    infoWindow.setContent(content);
    infoWindow.open(marker.getMap(), marker);
  });
};

const displayCircle = (latlong, distance = 0, color) => {
  return new google.maps.Circle({
    strokeColor: color || "#FF0000",
    strokeOpacity: 0.5,
    strokeWeight: 2,
    fillColor: color || "#FF0000",
    fillOpacity: 0.15,
    map,
    center: convertStringToLatlong(latlong),
    radius: distance * 1000,
  });
}