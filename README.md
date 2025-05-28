# 🚀 SpaceX Launches App

Una aplicación iOS desarrollada con UIKit que muestra los lanzamientos de SpaceX, utilizando datos en tiempo real desde la API pública. Permite visualizar detalles, ver videos en YouTube, realizar búsquedas filtradas, y funciona incluso sin conexión gracias a la persistencia con Core Data.

---

## 🛠 Tecnologías utilizadas

- **UIKit**
- **MVVM Architecture**
- **Core Data** para persistencia local
- **Combine** para binding reactivo
- **Kingfisher** para carga y cache de imágenes
- **YTPlayerView** para integración de YouTube
- **Auto Layout** responsivo (soporta diferentes tamaños de pantalla)
- **XIBs y Storyboards** combinados

---

## ✨ Características principales

### 🔍 Launches

- Lista de lanzamientos usando **table view**
- Vista de detalle con información completa de cada lanzamiento
- Soporte offline: los lanzamientos se guardan en Core Data

### 🎥 YouTube Integration

- Cada lanzamiento puede mostrar el video del lanzamiento en un reproductor integrado

### 🔎 Búsqueda avanzada

- SearchBar integrada para filtrar lanzamientos por:
  - Nombre de la misión
  - Sitio de lanzamiento

### 📱 UI Adaptativa

- Animaciones suaves al hacer scroll o filtrar resultados
- Diseño con **Auto Layout** responsivo a tamaño de pantalla
- Mensaje e imagen de **"Sin resultados"** cuando no hay coincidencias

---

## 🧑‍💻 Desarrollador

**Marco Alonso**  
iOS Developer | Swift | SwiftUI | UIKit  
[GitHub](https://github.com/marcoalonso) | [YouTube - iOS Bootcamp MX](https://youtube.com/@marcoalonsoios)

---
