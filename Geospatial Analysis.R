# Install and load required packages
library(spatial)
library(leaflet)

# Generate sample real estate data
set.seed(123)
num_properties <- 100
real_estate <- data.frame(
  Longitude = runif(num_properties, 73.16, 75.16),
  Latitude = runif(num_properties, 18.33, 20.53),
  Bedrooms = sample(1:5, num_properties, replace = TRUE),
  Bathrooms = sample(1:3, num_properties, replace = TRUE),
  SquareFeet = sample(1000:3000, num_properties, replace = TRUE),
  YearBuilt = sample(1980:2020, num_properties, replace = TRUE),
  Price = rnorm(num_properties, mean = 4472, sd = 1000)
)
# Summary statistics
summary(real_estate)


# Scatter plot of real estate prices against longitude and latitude
plot(real_estate$Longitude, real_estate$Latitude, col = "blue", pch = 20, xlab = "Longitude", ylab = "Latitude")
# Install and load required packages
library(spatialreg)

# Fit a spatial regression model
model <- lm.Price <- lm(Price ~ Longitude + Latitude + Bedrooms + Bathrooms + SquareFeet + YearBuilt, data = real_estate)

# Print model summary
summary(model)
# Create an interactive map with Leaflet
map <- leaflet() %>%
  addTiles() %>%
  setView(lng = mean(real_estate$Longitude), lat = mean(real_estate$Latitude), zoom = 12)

# Add markers for real estate properties with predicted prices
map <- map %>%
  addCircleMarkers(data = real_estate, lng = ~Longitude, lat = ~Latitude, radius = 5, color = "red", popup = ~paste("Price/sq.feet: Rs", round(Price, 2)))

# Display the map
map

