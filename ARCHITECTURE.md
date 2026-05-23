# Arquitectura de CAD_APP

## Descripción general

cad_app es un prototipo de motor CAD/gráfico desarrollado con Flutter.

El proyecto está organizado por sistemas en lugar de pantallas UI para permitir escalabilidad futura hacia:

- CAD 2D
- renderizado 3D
- gestión de escenas
- selección de objetos
- sistemas de cámara
- pipelines de renderizado

---

# Arquitectura actual

lib/

camera/
Sistemas de movimiento y navegación de cámara.

Archivos:
- camera_controller.dart
- orbit_camera.dart

Responsabilidades:
- zoom
- pan
- movimiento orbital
- futuros sistemas de rotación

---

core/
Sistemas centrales del motor.

Archivos:
- engine.dart

Responsabilidades:
- ciclo de vida del motor
- coordinación de sistemas
- futuro update loop

---

input/
Sistema de manejo de entradas.

Archivos:
- input_manager.dart

Responsabilidades:
- entrada táctil
- gestos
- mouse
- teclado

---

math/
Base matemática del motor.

Archivos:
- vector3.dart
- matrix4.dart

Responsabilidades:
- vectores
- matrices
- transformaciones
- matemáticas de proyección

Este módulo es considerado el núcleo matemático del engine.

---

objects/
Entidades y transformaciones de escena.

Archivos:
- scene_object.dart
- transform.dart

Responsabilidades:
- transformaciones de objetos
- jerarquías
- posición
- rotación
- escala

---

renderer/
Sistema de renderizado.

Archivos:
- renderer.dart
- cube_renderer.dart
- grid_renderer.dart

Responsabilidades:
- dibujo
- pipeline de renderizado
- renderizado del grid
- renderizado de objetos

---

scene/
Gestión de escenas.

Archivos:
- scene_manager.dart

Responsabilidades:
- almacenamiento de escena
- recorrido de objetos
- gestión de entidades

---

selection/
Sistema de selección.

Archivos:
- selection_manager.dart

Responsabilidades:
- selección de objetos
- picking
- futuros sistemas de snapping

---

viewport/
Capa visual de interacción y render.

Archivos:
- viewport_screen.dart
- viewport_widget.dart

Responsabilidades:
- visualización
- interacción
- conexión con cámara

---

ui/
Reservado para componentes visuales futuros.

---

# Filosofía de renderizado

El engine seguirá este pipeline conceptual:

Espacio Mundo
→ Espacio Cámara
→ Proyección
→ Espacio Pantalla
→ Renderizado Canvas

La pantalla seguirá siendo 2D mientras representa un mundo matemático 3D.

---

# Funcionalidades actuales

Implementadas:
- renderizado de grid
- origen centrado
- sistema de pan
- sistema de zoom
- soporte táctil móvil
- arquitectura modular

---

# Funcionalidades planeadas

## Cámara
- zoom centrado
- movimiento suave
- orbit controls

## Escena
- scene graph
- jerarquías

## Renderizado
- proyección 3D
- wireframe
- depth sorting

## Selección
- picking
- snapping
- gizmos de transformación

## Objetos
- sistema de meshes
- transformaciones
- materiales

---

# Metodología de desarrollo

El proyecto utiliza una metodología Agile/Kanban ligera.

El desarrollo se realiza de forma incremental:
1. base estable
2. sistemas de cámara
3. sistemas de escena
4. sistemas de renderizado
5. expansión 3D

---

# Objetivo a largo plazo

Construir un motor CAD/render ligero utilizando Flutter y sistemas matemáticos personalizados.