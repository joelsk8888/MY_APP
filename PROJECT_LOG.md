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