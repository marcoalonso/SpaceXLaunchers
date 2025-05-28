🚀 SpaceX Launches App

Una aplicación iOS desarrollada con UIKit que muestra los lanzamientos de SpaceX, utilizando datos en tiempo real desde la API pública. Permite visualizar detalles, ver videos en YouTube, realizar búsquedas filtradas, e incluso funciona sin conexión gracias a la persistencia local con Core Data.

⸻

🛠 Tecnologías utilizadas
	•	UIKit
	•	Arquitectura MVVM
	•	Core Data para persistencia local
	•	Combine para enlaces reactivos entre la lógica y la interfaz
	•	Kingfisher para carga y caché de imágenes
	•	YTPlayerView para la integración de videos de YouTube
	•	Auto Layout adaptable a diferentes tamaños de pantalla
	•	Uso combinado de XIBs y Storyboards

⸻

✨ Características principales

🔍 Lista de lanzamientos
	•	Lista de lanzamientos usando UITableView
	•	Vista de detalle con información completa de cada lanzamiento
	•	Soporte sin conexión: los lanzamientos se guardan en Core Data

🎥 Integración con YouTube
	•	Cada lanzamiento puede mostrar su video de lanzamiento desde un reproductor integrado

🔐 Autenticación con Firebase
	•	Inicio de sesión mediante correo electrónico y contraseña
	•	Registro de nuevos usuarios
	•	Verificación automática del usuario autenticado
	•	Cierre de sesión con retorno a la pantalla de login
	•	Puedes iniciar sesión con:
	•	Correo: user@user.com
	•	Contraseña: 123456

🔎 Búsqueda avanzada
	•	Barra de búsqueda integrada para filtrar lanzamientos por:
	•	Nombre de la misión
	•	Lugar del lanzamiento

📱 Interfaz adaptativa
	•	Animaciones suaves al hacer scroll o aplicar filtros
	•	Diseño adaptable con Auto Layout para múltiples dispositivos
	•	Mensaje e imagen de “Sin resultados” cuando no hay coincidencias

⸻

🌱 Estructura de ramas

Este proyecto fue desarrollado utilizando una estrategia basada en ramas específicas para funcionalidades, más una rama principal de desarrollo:
	•	main → rama principal para producción (versión final)
	•	development → rama de integración donde se prueban y combinan las funcionalidades
	•	feature/launch-list → desarrollo de la lista de lanzamientos con UITableView
	•	feature/launch-detail → vista detallada con imágenes y enlaces
	•	feature/coredata-storage → persistencia local con Core Data
	•	feature/searchbar → implementación de la búsqueda con UISearchBar
	•	feature/splash-screen → pantalla de presentación (splash screen)
	•	feature/coordinator-pattern → navegación desacoplada usando el patrón Coordinator
 	•	feature/firebase-login → Login y registro de usuarios con Firebase
 

Cada nueva funcionalidad se desarrolló en su propia rama y luego fue integrada en development para mantener un flujo de trabajo limpio y controlado.

⸻

👨‍💻 Desarrollador

Marco Alonso Rodríguez
Desarrollador iOS | Swift | SwiftUI | UIKit

--- Algunas capturas de pantalla de la aplicación



![image](https://github.com/user-attachments/assets/fc4439c6-280e-4805-8ff9-c29a3a2e2485)



![image](https://github.com/user-attachments/assets/6efc917d-2634-493c-b885-3de742ddaf1b)



![image](https://github.com/user-attachments/assets/dc4e9606-22b3-4ccd-bcb6-5d9a117e58b4)


![image](https://github.com/user-attachments/assets/34ff3c2e-8634-4368-9bc7-f0f989030e16)



![image](https://github.com/user-attachments/assets/3db8f5ec-f6f2-4222-bfdd-ed9d26953e9e)



![image](https://github.com/user-attachments/assets/3ac60ca7-7018-4dbd-a118-4225c013278d)



![image](https://github.com/user-attachments/assets/a98a77ac-5c0b-4801-bdef-ecdcf3fe02a6)



![image](https://github.com/user-attachments/assets/651303d0-a81a-4eea-ac33-245089509cfe)



![image](https://github.com/user-attachments/assets/94a34763-afe7-4c38-a88d-b88c06df9e72)


![image](https://github.com/user-attachments/assets/807d8b64-0af4-4941-8bf6-de37eae1cc60)



![image](https://github.com/user-attachments/assets/6bc41bdc-d60b-4672-8009-c2bfd2514039)



![image](https://github.com/user-attachments/assets/2665e139-937b-45bc-bdb7-cf0e8c8bf87d)


