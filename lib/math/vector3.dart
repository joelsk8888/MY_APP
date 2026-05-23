class Vector3 {
  double x;
  double y;
  double z;

  Vector3(this.x, this.y, this.z);

  factory Vector3.zero() {
    return Vector3(0, 0, 0);
  }

  factory Vector3.one() {
    return Vector3(1, 1, 1);
  }
}