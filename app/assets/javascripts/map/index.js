//= require map/components/utils

function initMap() {
  console.log("Map loaded")
  const branch = JSON.parse(data.branch)
  const lat = parseFloat(branch.latlong.split(",")[0])
  const lng = parseFloat(branch.latlong.split(",")[1])
  console.log({branch})
  
  const mapContainer = document.getElementById("map");
  if (mapContainer) {
    map = new google.maps.Map(mapContainer, {
      center: { lat, lng },
      zoom: 12,
    });
    displayMarker(branch.latlong, branch.name, imageUrlToGoogleMapIcon(branch.image_path))
    displayCircle(branch.latlong, branch.distance_catered, "#ffb0b0")
    displayFoodDeliveryAreas(branch)
  }
}

const displayFoodDeliveryAreas = (branch) => {
  branch.food_delivery_areas.forEach(area => {
    displayMarker(area.latlong, area.name, imageUrlToGoogleMapIcon('/images/food-delivery-area.svg'))
    // displayCircle(area.latlong, area.maximum_distance, area.color)
    displayCircle(area.latlong, area.minimum_distance, area.color)
    area.stores.forEach(store => {
      displayMarker(store.latlong, `${store.name} | ${area.name}`, imageUrlToGoogleMapIcon('/images/restaurant.svg'))
    })
  })
}

