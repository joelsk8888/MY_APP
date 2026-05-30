## Dia 1
Optimización de cuadrícula (renderizar solo área visible)

Sistema de selección de objetos

Fase 2: Transición a 3D
Antes de ir a 3D, debemos introducir:

Extensión del eje Z en geometría

Transformaciones Matrix4

Proyección en perspectiva

Sistema de cámara orbital

Fase 3: Motor CAD 3D Completo
Rotación (guiñada, cabeceo, alabeo)

Cámara con perspectiva

Sistema de iluminación

Renderizado de objetos 3D

Picking por rayos (selección en 3D)

Concepto Clave: Transición 2D → 3D
Actualmente estamos en:

[Mundo 2D]
(x, y)

Siguiente paso:

[Mundo 3D]
(x, y, z)

Actualizaremos:

Offset → Vector3

canvas.scale/translate → Transformaciones Matrix4

cuadrícula plana → plano de cuadrícula 3D

cámara estática → cámara orbital

Esto asegura que el motor escale correctamente en lugar de romperse más adelante.

# REGISTRO DEL PROYECTO

## Día 2

Configuración inicial del proyecto.

Completado:
- instalación de Flutter
- instalación de Visual Studio para soporte Windows
- configuración Git y GitHub
- pruebas Android
- viewport CAD inicial

Sistemas implementados:
- renderizado de grid
- origen centrado
- movimiento pan
- zoom básico

Mejoras de arquitectura:
- estructura modular
- separación del sistema de cámara
- separación del sistema renderer
- creación del módulo math
- creación del sistema scene
- preparación del sistema de objetos

Estado actual:
El proyecto ahora se comporta como un prototipo temprano de engine/CAD y no como una aplicación Flutter tradicional.

Próximos objetivos:
- zoom centrado
- sistema SceneObject
- sistema Transform
- pipeline de renderizado
- sistema de selección
## Día 3

Implementación inicial del sistema de herramientas CAD.

Nuevas funcionalidades:
- toolbar inferior
- selector de herramienta
- modo selección
- modo creación de cuadrados

Sistema de objetos:
- creación dinámica de cuadrados
- renderizado basado en listas de objetos
- conversión pantalla → mundo

Mejoras internas:
- eliminación de objetos hardcodeados
- viewport desacoplado
- inicio de arquitectura orientada a escena

Estado actual:
La aplicación ya permite crear objetos interactivos dentro del viewport usando coordenadas del mundo.
## Día 3

Implementación del sistema de selección de objetos.

Nuevas funcionalidades:
- selección de rectángulos mediante toque
- deselección tocando espacio vacío
- resaltado visual del objeto seleccionado
- integración de selección con el sistema de herramientas

Mejoras:
- hit detection sobre objetos rectangulares
- soporte para múltiples objetos en escena

Estado actual:
La aplicación permite crear múltiples rectángulos, seleccionarlos individualmente y mantener la selección sincronizada con el viewport.
## Refactorización de selección

- Se creó SelectionManager.
- Se movió la lógica de selección fuera del viewport.
- Se separaron responsabilidades entre UI y lógica.
- El viewport ahora delega la selección al manager correspondiente.
## Sistema de movimiento de objetos

Nuevas funcionalidades:
- arrastre de objetos seleccionados
- movimiento de rectángulos en coordenadas mundo
- integración entre SelectionManager y viewport

Mejoras:
- soporte para edición básica de escena
- preparación para futuras transformaciones

Estado actual:
El usuario puede crear, seleccionar y mover objetos dentro del viewport.
## Sistema de coordenadas visual

- Se añadieron coordenadas mundo en tiempo real.
- Visualización X/Y en pantalla.
- Compatible con zoom y pan.
- Base preparada para líneas y snap.