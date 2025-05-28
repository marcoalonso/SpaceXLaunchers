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

- ### 🔐 Firebase Authentication

- Inicio de sesión con **email y contraseña**
- Registro de nuevos usuarios
- Verificación del usuario logueado
- Logout con retorno a la pantalla de login
- You can login with: email: user@user.com  password: 123456

### 🔎 Búsqueda avanzada

- SearchBar integrada para filtrar lanzamientos por:
  - Nombre de la misión
  - Sitio de lanzamiento

### 📱 UI Adaptativa

- Animaciones suaves al hacer scroll o filtrar resultados
- Diseño con **Auto Layout** responsivo a tamaño de pantalla
- Mensaje e imagen de **"Sin resultados"** cuando no hay coincidencias

---

🌱 Estructura de Ramas (Branching Strategy)

Este proyecto fue desarrollado utilizando una estrategia basada en ramas feature y una rama principal de desarrollo:
- main → rama principal para producción (release final)
- development → rama de integración donde se prueban y combinan funcionalidades
- feature/launch-list → lista de lanzamientos en UITableView
- feature/launch-detail → vista detalle con imágenes y enlaces
- feature/coredata-storage → persistencia local con Core Data
- feature/searchbar → búsqueda con UISearchBar
- feature/splash-screen → implementación del splash
- feature/coordinator-pattern → navegación desacoplada usando patrón Coordinator

Cada nueva funcionalidad se desarrolló en su propia rama y luego fue mergeada en development para mantener una integración controlada y ordenada.

## 🧑‍💻 Desarrollador

**Marco Alonso Rodriguez**  
iOS Developer | Swift | SwiftUI | UIKit  

---
![image](https://github.com/user-attachments/assets/fc4439c6-280e-4805-8ff9-c29a3a2e2485)



![image](https://github.com/user-attachments/assets/6efc917d-2634-493c-b885-3de742ddaf1b)



![image](https://github.com/user-attachments/assets/dc4e9606-22b3-4ccd-bcb6-5d9a117e58b4)


![image](https://github.com/user-attachments/assets/c51eb32b-4a31-4ec7-a424-97352465a07b)



![image](https://github.com/user-attachments/assets/3db8f5ec-f6f2-4222-bfdd-ed9d26953e9e)



![image](https://github.com/user-attachments/assets/3ac60ca7-7018-4dbd-a118-4225c013278d)



![image](https://github.com/user-attachments/assets/a98a77ac-5c0b-4801-bdef-ecdcf3fe02a6)



![image](https://github.com/user-attachments/assets/651303d0-a81a-4eea-ac33-245089509cfe)



![image](https://github.com/user-attachments/assets/94a34763-afe7-4c38-a88d-b88c06df9e72)


![image](https://github.com/user-attachments/assets/807d8b64-0af4-4941-8bf6-de37eae1cc60)



![image](https://github.com/user-attachments/assets/6bc41bdc-d60b-4672-8009-c2bfd2514039)



![image](https://github.com/user-attachments/assets/2665e139-937b-45bc-bdb7-cf0e8c8bf87d)


