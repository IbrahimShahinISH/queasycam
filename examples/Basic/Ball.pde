class Ball {
  PVector position;
  PVector velocity;
  float radius = 5;

  Ball() {
    position = new PVector(0, 0, 0);
    velocity = PVector.random3D();
    velocity.y = 0;
    velocity.setMag(2);
  }

  void update(ArrayList<Paddle> paddles) {
    position.add(velocity);

    if (position.mag() > initialDistanceFromCenter) {
      PVector toCenter = PVector.sub(spherePos, position);
      toCenter.normalize();
      velocity = reflect(velocity, toCenter);
      position.add(velocity);
    }

    for (Paddle paddle : paddles) {
      checkPaddleCollision(paddle);
    }
  }

  void checkPaddleCollision(Paddle paddle) {
    PVector toPaddle = PVector.sub(position, paddle.position);
    if (toPaddle.mag() < radius + paddle.height / 2) {
      velocity = reflect(velocity, toPaddle);
    }
  }

  PVector reflect(PVector incoming, PVector normal) {
    return PVector.sub(incoming, PVector.mult(normal, 2 * incoming.dot(normal)));
  }

  void display() {
    pushMatrix();
    translate(position.x, position.y, position.z);
    fill(255);
    sphere(radius);
    popMatrix();
  }
}
