import '../math/vector3.dart';

class Transform {
  Vector3 position;
  Vector3 rotation;
  Vector3 scale;

  Transform({
    Vector3? position,
    Vector3? rotation,
    Vector3? scale,
  })  : position = position ?? Vector3.zero(),
        rotation = rotation ?? Vector3.zero(),
        scale = scale ?? Vector3.one();
}