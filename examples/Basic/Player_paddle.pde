class PlayerPaddle extends Paddle {
  PlayerPaddle() {
    position = PVector.add(spherePos, new PVector(0, 0, initialDistanceFromCenter - 1));
  }

  void update(Ball ball) {
    float angle = radians(map(mouseX, 0, width, -45, 45));
    position.x = initialDistanceFromCenter * cos(angle);
    position.z = initialDistanceFromCenter * sin(angle);
    position = PVector.add(spherePos, position);
  }
}
