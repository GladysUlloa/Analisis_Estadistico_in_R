# ==========================================
# PROYECTO: Animaciones y Visualizaciones en R
# AUTOR: Gladys Choque Ulloa, PhD(c)
# OBJETIVO: Crear gráficos animados y mapas dinámicos para análisis estadístico y visualización de datos
# ==========================================

# -----------------------------
# GRÁFICO 1: Bubble Chart Animado – Gapminder
# -----------------------------
# Instalar paquetes necesarios
install.packages(c("ggplot2","gganimate","gapminder","viridis","transformr","magick"))

# Cargar librerías
library(ggplot2)
library(gganimate)
library(gapminder)
library(viridis)

# Cargar dataset
data <- gapminder

# Crear gráfico de burbujas animado
p <- ggplot(data, aes(gdpPercap, lifeExp,
                      size = pop,
                      color = continent)) +
  geom_point(alpha = 0.7) +  # Transparencia para mejor visualización
  scale_size(range = c(2, 20)) +  # Tamaño de burbujas
  scale_color_viridis(discrete = TRUE) +  # Paleta de colores
  scale_x_log10() +  # Escala logarítmica en PIB per cápita
  labs(title = "Evolución Global: {frame_time}",
       x = "PIB per cápita (log)",
       y = "Esperanza de Vida") +
  theme_minimal(base_size = 14) +
  transition_time(year) +  # Animación según año
  ease_aes('cubic-in-out')  # Suavizado de transición

# Exportar animación a GIF
animate(p, width = 900, height = 600, fps = 10,
        renderer = gifski_renderer("gifs/bubble_animation.gif"))

# -----------------------------
# GRÁFICO 2: Heatmap Dinámico
# -----------------------------
install.packages(c("tidyverse","gganimate","viridis","reshape2"))
library(tidyverse)
library(gganimate)
library(viridis)

set.seed(123)

# Simulación de datos para heatmap
frames <- 20
grid_size <- 20
data <- expand.grid(
  x = 1:grid_size,
  y = 1:grid_size,
  time = 1:frames
)
data$value <- with(data, sin(x/3 + time/2) * cos(y/4 - time/3))

# Crear heatmap animado
p_heat <- ggplot(data, aes(x, y, fill = value)) +
  geom_tile() +
  scale_fill_viridis(option = "magma") +
  coord_fixed() +
  labs(title = "Mapa de Calor Dinámico - Frame: {frame_time}") +
  theme_minimal() +
  transition_time(time) +
  ease_aes("linear")

animate(p_heat, width = 700, height = 700, fps = 8,
        renderer = gifski_renderer("gifs/heatmap_animation.gif"))

# -----------------------------
# GRÁFICO 3: Evolución K-means
# -----------------------------
install.packages(c("ggplot2","gganimate","cluster","viridis"))
library(ggplot2)
library(gganimate)
library(viridis)

set.seed(42)

# Crear datos simulados para clustering
n <- 300
x <- rbind(
  matrix(rnorm(n, mean = 0), ncol = 2),
  matrix(rnorm(n, mean = 4), ncol = 2),
  matrix(rnorm(n, mean = -4), ncol = 2)
)
df <- as.data.frame(x)
colnames(df) <- c("x","y")

frames <- 15

# Simulación del algoritmo K-means en varias iteraciones
cluster_data <- do.call(rbind, lapply(1:frames, function(i){
  km <- kmeans(df, centers = 3, iter.max = i)
  cbind(df, cluster = factor(km$cluster), iter = i)
}))

# Gráfico de evolución de clusters
p_cluster <- ggplot(cluster_data,
                    aes(x, y, color = cluster)) +
  geom_point(size = 3, alpha = 0.8) +
  scale_color_viridis(discrete = TRUE) +
  labs(title = "Evolución K-means - Iteración: {frame_time}") +
  theme_minimal() +
  transition_time(iter) +
  ease_aes("cubic-in-out")

animate(p_cluster, width = 800, height = 600, fps = 6,
        renderer = gifski_renderer("gifs/kmeans_animation.gif"))

# -----------------------------
# GRÁFICO 4: Densidad 2D Dinámica
# -----------------------------
install.packages(c("ggplot2","gganimate","viridis","MASS","transformr"))
library(ggplot2)
library(gganimate)
library(viridis)
library(MASS)

set.seed(123)

frames <- 30
n <- 800

# Simulación de puntos dinámicos
data <- do.call(rbind, lapply(1:frames, function(t) {
  data.frame(
    x = rnorm(n, mean = sin(t/5)*3, sd = 1.2),
    y = rnorm(n, mean = cos(t/6)*3, sd = 1.2),
    time = t
  )
}))

# Gráfico de densidad 2D animado
p <- ggplot(data, aes(x, y)) +
  stat_density_2d(aes(fill = after_stat(level)),
                  geom = "polygon",
                  alpha = 0.6,
                  contour = TRUE) +
  geom_point(alpha = 0.4, size = 2, color = "white") +
  scale_fill_viridis(option = "inferno") +
  labs(title = "Densidad 2D Dinámica\nFrame: {frame_time}",
       x = "Variable X",
       y = "Variable Y") +
  theme_minimal(base_size = 15) +
  theme(legend.position = "none") +
  transition_time(time) +
  ease_aes("cubic-in-out")

animate(p, width = 900, height = 700, fps = 10,
        renderer = gifski_renderer("gifs/density2D_animation.gif"))

# -----------------------------
# GRÁFICO 5: Frontera de Decisión Dinámica
# -----------------------------
install.packages(c("ggplot2","gganimate","viridis","dplyr","transformr"))
library(ggplot2)
library(gganimate)
library(viridis)
library(dplyr)

set.seed(123)

# Crear datos no lineales
n <- 500
data <- data.frame(
  x = runif(n, -3, 3),
  y = runif(n, -3, 3)
)
data$class <- ifelse(data$x^2 + data$y^2 + rnorm(n,0,0.8) > 4, 1, 0)

frames <- 40

# Crear grilla para frontera de decisión
grid <- expand.grid(
  x = seq(-3,3,length.out=150),
  y = seq(-3,3,length.out=150)
)

# Evolución dinámica de frontera
decision_data <- do.call(rbind, lapply(1:frames, function(t){
  grid$z <- grid$x^2 + grid$y^2 + sin(t/5)
  grid$time <- t
  grid
}))

# Gráfico animado de frontera de decisión
p <- ggplot() +
  geom_contour_filled(data = decision_data,
                      aes(x, y, z = z),
                      alpha = 0.6) +
  geom_point(data = data,
             aes(x, y, color = factor(class)),
             size = 2, alpha = 0.9) +
  scale_color_viridis(discrete = TRUE) +
  scale_fill_viridis(discrete = TRUE, option = "magma") +
  labs(title = "Frontera de Decisión Dinámica\nFrame: {frame_time}",
       color = "Clase", fill = "Región") +
  theme_minimal(base_size = 15) +
  theme(legend.position = "right") +
  transition_time(time) +
  ease_aes("cubic-in-out")

animate(p, width = 900, height = 700, fps = 10,
        renderer = gifski_renderer("gifs/decision_boundary_animation.gif"))

# -----------------------------
# GRÁFICO 6: Descenso del Gradiente
# -----------------------------
library(ggplot2)
library(gganimate)
library(viridis)

# Función de pérdida
loss_function <- function(x, y){
  x^2 + y^2 + 10*sin(x) + 10*sin(y)
}

# Crear superficie
x_seq <- seq(-6, 6, length.out = 200)
y_seq <- seq(-6, 6, length.out = 200)
grid <- expand.grid(x = x_seq, y = y_seq)
grid$z <- loss_function(grid$x, grid$y)

# Gradiente descendente simulado
learning_rate <- 0.05
steps <- 40
x <- -5; y <- 5
trajectory <- data.frame()

for(i in 1:steps){
  grad_x <- 2*x + 10*cos(x)
  grad_y <- 2*y + 10*cos(y)
  x <- x - learning_rate * grad_x
  y <- y - learning_rate * grad_y
  trajectory <- rbind(trajectory, data.frame(x=x, y=y, step=i))
}

# Gráfico animado del descenso del gradiente
p <- ggplot() +
  geom_contour_filled(data = grid,
                      aes(x, y, z = z),
                      bins = 30,
                      alpha = 0.8) +
  geom_path(data = trajectory, aes(x, y), color = "white", size = 1.2) +
  geom_point(data = trajectory, aes(x, y), color = "red", size = 4) +
  scale_fill_viridis(discrete = TRUE, option = "magma") +
  labs(title = "Descenso del Gradiente\nIteración: {frame_along}",
       x = "Parámetro 1", y = "Parámetro 2", fill = "Loss") +
  theme_minimal(base_size = 15) +
  theme(panel.background = element_rect(fill = "black"),
        plot.background = element_rect(fill = "black"),
        text = element_text(color = "white"),
        legend.position = "right") +
  transition_reveal(step)

animate(p, width = 900, height = 700, fps = 10,
        renderer = gifski_renderer("gifs/gradient_descent.gif"))

# -----------------------------
# GRÁFICO 7: Mapa Global Animado
# -----------------------------
install.packages(c("sf","rnaturalearth","ggplot2","gganimate","viridis","dplyr","transformr"))
library(sf)
install.packages("rnaturalearthdata")
library(rnaturalearthdata)
library(rnaturalearth)
library(ggplot2)
library(gganimate)
library(viridis)
library(dplyr)

set.seed(123)

# Cargar mapa mundial
world <- ne_countries(scale = "medium", returnclass = "sf")

# Obtener coordenadas centrales de cada país
world_points <- st_point_on_surface(world)
coords <- st_coordinates(world_points)
data_base <- data.frame(country = world$name, lon = coords[,1], lat = coords[,2])

# Crear animación temporal
frames <- 25
data_anim <- do.call(rbind, lapply(1:frames, function(t){
  data_base %>%
    mutate(value = abs(rnorm(n(), mean = 50 + 30*sin(t/4), sd = 15)),
           time = t)
}))

# Gráfico animado de mapa global
p_map <- ggplot() +
  geom_sf(data = world, fill = "gray10", color = "gray40", linewidth = 0.2) +
  geom_point(data = data_anim, aes(x = lon, y = lat, size = value, color = value), alpha = 0.8) +
  scale_size(range = c(1,18)) +
  scale_color_viridis(option = "inferno") +
  labs(title = "Dinámica Global de Intensidad\nFrame: {frame_time}",
       subtitle = "Simulación Espacio-Temporal",
       size = "Magnitud", color = "Magnitud") +
  theme_void() +
  theme(plot.background = element_rect(fill = "black"),
        panel.background = element_rect(fill = "black"),
        text = element_text(color = "white"),
        legend.position = "right") +
  transition_time(time) +
  ease_aes("cubic-in-out")

animate(p_map, width = 1100, height = 650, fps = 8,
        renderer = gifski_renderer("gifs/mapa_global_top.gif"))