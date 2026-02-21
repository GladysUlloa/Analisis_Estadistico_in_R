# Visualizaciones y Animaciones en R para Ciencia de Datos

**Autoría:** Gladys Choque Ulloa, PhD(c)  
**Contacto / Portfolio:** [Redes Sociales](https://linktr.ee/gladyschoqueulloa)  

Este repositorio contiene **proyectos avanzados en R** enfocados en **análisis estadístico, simulaciones, animaciones y visualizaciones dinámicas** aplicadas a Ciencia de Datos y Machine Learning.  
Los proyectos muestran desde gráficos animados de Gapminder hasta mapas globales, fronteras de decisión y simulaciones de descenso del gradiente.

---

## 🔹 Contenido del repositorio

### 1. Bubble Chart Animado – Gapminder
- Visualiza la relación entre **PIB per cápita y esperanza de vida** a lo largo de los años.  
- Tamaño de burbuja representa población.  
- Librerías: `ggplot2`, `gganimate`, `gapminder`, `viridis`.  
- GIF generado: `gifs/bubble_animation.gif`

### 2. Heatmap Dinámico
- Mapas de calor animados que muestran patrones espaciales cambiantes en el tiempo.  
- Librerías: `ggplot2`, `gganimate`, `viridis`, `reshape2`.  
- GIF generado: `gifs/heatmap_animation.gif`

### 3. Evolución K-means
- Animación mostrando cómo se ajustan los centroides de un **clustering K-means** con cada iteración.  
- Librerías: `ggplot2`, `gganimate`, `viridis`, `cluster`.  
- GIF generado: `gifs/kmeans_animation.gif`

### 4. Densidad 2D Dinámica
- Muestra la evolución de la **densidad de puntos en 2D**, con puntos y niveles de densidad animados.  
- Librerías: `ggplot2`, `gganimate`, `viridis`, `MASS`.  
- GIF generado: `gifs/density2D_animation.gif`

### 5. Frontera de Decisión Dinámica
- Visualiza cómo cambia la frontera de decisión de una **clasificación no lineal** con el tiempo.  
- Librerías: `ggplot2`, `gganimate`, `viridis`.  
- GIF generado: `gifs/decision_boundary_animation.gif`

### 6. Descenso del Gradiente
- Simula un **algoritmo de descenso del gradiente** sobre una función de pérdida.  
- Visualiza cómo un punto converge al mínimo de la superficie.  
- Librerías: `ggplot2`, `gganimate`, `viridis`.  
- GIF generado: `gifs/gradient_descent.gif`

### 7. Mapa Global Animado
- Animación con **burbujas dinámicas** mostrando intensidad global simulada.  
- Librerías: `sf`, `rnaturalearth`, `rnaturalearthdata`, `ggplot2`, `gganimate`, `viridis`, `dplyr`.  
- GIF generado: `gifs/mapa_global_top.gif`

---

## 🔹 Estructura del proyecto

```text
R_Analisis_Estadistico/
│
├── scripts/          # Scripts R por gráfico
├── gifs/             # GIFs animados generados
├── data/             # Datasets (si aplica)
├── README.md         # Este archivo
└── requirements.R    # Paquetes necesarios
```

## 🔹 Requisitos de paquetes

Antes de correr los scripts, asegúrate de instalar los paquetes necesarios:

Paquetes necesarios en R:

```text
install.packages(c(
  "ggplot2", "gganimate", "gapminder", "viridis", "transformr",
  "magick", "dplyr", "MASS", "cluster", "sf", 
  "rnaturalearth", "rnaturalearthdata"
))
```
Nota: En Windows puede ser necesario instalar `rnaturalearthdata` manualmente:
```text
install.packages("rnaturalearthdata")
```
## 🔹 Cómo ejecutar los scripts

* Abre RStudio y establece como directorio de trabajo la carpeta del proyecto.
* Ejecuta cada script de scripts/ por separado.
* Los GIFs se generarán automáticamente en la carpeta gifs/.
* Visualiza los resultados directamente desde tu explorador de archivos o inclúyelos en tus presentaciones.

## 🔹 Objetivo del repositorio

* Mostrar visualizaciones interactivas y animadas en R.
* Documentar técnicas de análisis estadístico y Machine Learning.
* Servir como portafolio profesional para LinkedIn o presentación académica.
* Inspirar a otros a aprender visualización avanzada en R.

## 🔹 Licencia

Este proyecto es open-source y puede ser usado libremente con fines educativos y profesionales.
