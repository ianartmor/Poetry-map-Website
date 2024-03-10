library(osrm)
library(nngeo)
library(tidycensus)

test <- locs_sf %>% rowwise() %>% group_split() %>% map(~osrmIsochrone(loc = .x, breaks =10, osrm.profile = "foot"))
isos <- osrmIsochrone(loc = locs_sf, breaks = 5, osrm.profile = "foot")

census_blocks <- get_decennial(
  geography = "block",
  state = "OR",
  variables = "P1_001N",
  year = 2020,
  geometry = TRUE,
  keep_geo_vars = TRUE
)
census_blocks <- census_blocks %>% st_transform(4326)



isochrones <- test %>% as_tibble_col() %>% unnest(value)

isochrones_sf <- st_as_sf(isochrones) %>% nngeo::st_remove_holes() %>% st_make_valid()%>% st_union()

covered_by_posts <- census_blocks[isochrones_sf,]

covered_by_posts$value %>% sum()

leaflet(isochrones_sf) %>% addTiles() %>% addPolygons() %>% addPolygons(data=covered_by_posts, fillColor ="green")
