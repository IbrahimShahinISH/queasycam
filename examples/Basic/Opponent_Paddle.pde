class OpponentPaddle extends Paddle {
  OpponentPaddle() {
    position = PVector.add(spherePos, new PVector(0, 0, -initialDistanceFromCenter + 1));
  }

  void update(Ball ball) {
    float angle = atan2(ball.position.z, ball.position.x);
    position.x = initialDistanceFromCenter * cos(angle);
    position.z = initialDistanceFromCenter * sin(angle);
    position = PVector.add(spherePos, position);
  }
}
