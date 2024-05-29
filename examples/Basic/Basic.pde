import controlP5.*;

import queasycam.*;

QueasyCam cam;
PVector spherePos;
PVector initialCamPos;
float initialDistanceFromCenter;

ArrayList<Paddle> paddles = new ArrayList<>();
Ball ball;

void setup() {
  fullScreen( P3D);
  cam = new QueasyCam(this);
  spherePos = new PVector(0, 0, 0);

  initialDistanceFromCenter = 200 - 10;
  initialCamPos = PVector.add(spherePos, new PVector(0, 0, initialDistanceFromCenter));
  cam.position = initialCamPos.copy();

  paddles.add(new PlayerPaddle());
  paddles.add(new OpponentPaddle());
  ball = new Ball();
}

void draw() {
  background(0);
  lights();
  sphereDetail(30);
  pushMatrix();
  translate(spherePos.x, spherePos.y, spherePos.z);
  fill(127, 127,127);
  sphere(200);
  popMatrix();

  constrainCameraMovement();

  for (Paddle paddle : paddles) {
    paddle.update(ball);
    paddle.display();
  }

  ball.update(paddles);
  ball.display();

}

void constrainCameraMovement() {
  PVector camPos = cam.position;
  PVector toInitialPos = PVector.sub(camPos, spherePos);

  // Ensure the camera remains at the initial distance from the center
  toInitialPos.normalize();
  cam.position = PVector.add(spherePos, PVector.mult(toInitialPos, initialDistanceFromCenter));
}
