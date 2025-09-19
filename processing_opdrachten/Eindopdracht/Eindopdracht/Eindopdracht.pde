int paddleHeight = 100;
int paddleWidth = 20;
int leftPaddleX = 10;
int rightPaddleX = 700 - 10 - paddleWidth;

int canvasWidth = 700;
int canvasHeight = 500;

int winningScore = 10;
int computerSpeed = 3;

color ballColor, leftPaddleColor, rightPaddleColor, borderColor;
color black, white, red;

float gameModeWidth = 140, gameModeHeight = 30;
float gameModeX = canvasWidth/2 - gameModeWidth/2, gameModeY = 10;

boolean gameMode = false;

boolean won = false;
String winText = "";
int winStartMillis = 0;
int winDuration = 5000;
int leftScore = 0;
int rightScore = 0;

Paddle rightPaddle;
Paddle leftPaddle;
Ball ball;

class Paddle {
  float Vel = 4;
  float paddleWidth = 0;
  float paddleHeight = 0;
  float xpos, ypos;
  color colorPaddle;
  float originalX, originalY;

  Paddle(float x, float y, float w, float h, color c) {
    xpos = x;
    ypos = y;
    paddleWidth = w;
    paddleHeight = h;
    colorPaddle = c;
    originalX = xpos;
    originalY = ypos;
  }

  void draw () {
    fill(colorPaddle);
    rect(xpos, ypos, paddleWidth, paddleHeight);
  }

  void move(boolean up) {
    if (up) ypos -= Vel;
    else ypos += Vel;
  }

  void reset() {
    xpos = originalX;
    ypos = originalY;
  }
}

class Ball {
  float max_vel = 5;
  float xpos = 0;
  float ypos = 0;
  float radius = 0;
  color colorBall;
  float x_vel = 0;
  float y_vel = 0;
  float originalX = 0;
  float originalY = 0;

  Ball(float x, float y, float r, color c) {
    x_vel = max_vel;
    y_vel = 0;
    xpos = x;
    ypos = y;
    radius = r;
    colorBall = c;
    originalX = xpos;
    originalY = ypos;
  }

  void draw() {
    fill(colorBall);
    ellipse(xpos, ypos, radius * 2, radius * 2);
  }

  void move() {
    xpos += x_vel;
    ypos += y_vel;
  }

  void reset() {
    xpos = originalX;
    ypos = originalY;
    y_vel = 0;
    x_vel *= -1;
  }
}

void setup() {
  size(700, 500);
  white = color(255, 255, 255);
  black = color(0, 0, 0);
  leftPaddleColor = color(100, 180, 255);
  rightPaddleColor = color(220, 80, 80);
  ballColor = color(255, 230, 40);
  borderColor = color(120, 220, 150);
  rightPaddle = new Paddle(rightPaddleX, 500/2 - paddleHeight/2, paddleWidth, paddleHeight, rightPaddleColor);
  leftPaddle = new Paddle(leftPaddleX, 500/2 - paddleHeight/2, paddleWidth, paddleHeight, leftPaddleColor);
  ball = new Ball(700/2, 500 / 2, 7, ballColor);
  red = color(255, 0, 0);
}

void draw() {
  background(black);

  fill(white);
  textSize(30);
  text(leftScore, canvasWidth/4, 30);
  text(rightScore, 3*canvasWidth/4, 30);

  rightPaddle.draw();
  leftPaddle.draw();

  noStroke();

  int segmentH = canvasHeight / 20;
  int idx = 0;
  for (int y = 50; y < canvasHeight; y += segmentH) {
    if (idx % 2 == 0) {
      noStroke();
      fill(white);
      rect(canvasWidth/2 - 5, y, 10, segmentH);
    }
    idx++;
  }

  ball.draw();

  stroke(borderColor);
  strokeWeight(2);
  noFill();
  rect(gameModeX, gameModeY, gameModeWidth, gameModeHeight);
  noStroke();

  String leftLabel = gameMode ? "Player" : "Player 1";
  String rightLabel = gameMode ? "AI" : "Player 2";
  String vsLabel = "VS";

  textSize(14);

  textAlign(RIGHT, CENTER);
  fill(leftPaddleColor);
  text(leftLabel, gameModeX + gameModeWidth/2.0 - 15, gameModeY + gameModeHeight/2.0);

  textAlign(LEFT, CENTER);
  fill(rightPaddleColor);
  text(rightLabel, gameModeX + gameModeWidth/2.0 + 15, gameModeY + gameModeHeight/2.0);

  textAlign(CENTER, CENTER);
  fill(white);
  text(vsLabel, gameModeX + gameModeWidth/2.0, gameModeY + gameModeHeight/2.0);


  if (!won) {
    handlePaddleMovement();
    ball.move();
    handleCollision();

    if (ball.xpos - ball.radius < 0) {
      rightScore++;
      ball.reset();
    } else if (ball.xpos - ball.radius > canvasWidth) {
      leftScore++;
      ball.reset();
    }

    if (leftScore >= winningScore) {
      won = true;
      winText = "Player 1 Won!";
      winStartMillis = millis();
    } else if (rightScore >= winningScore) {
      won = true;
      winText = "Player 2 Won!";
      winStartMillis = millis();
    }
  } else {
    fill(red);
    textSize(48);
    textAlign(CENTER, CENTER);
    text(winText, canvasWidth/2, canvasHeight/2);

    if (millis() - winStartMillis >= winDuration) {
      won = false;
      leftScore = 0;
      rightScore = 0;
      ball.reset();
      leftPaddle.reset();
      rightPaddle.reset();
    }
  }
}

void handleCollision() {
  if (ball.ypos - ball.radius <= 0 || ball.ypos + ball.radius >= canvasHeight) {
    ball.y_vel *= -1;
  }

  if (ball.x_vel < 0) {
    if (ball.ypos > leftPaddle.ypos && ball.ypos < leftPaddle.ypos + leftPaddle.paddleHeight &&
      ball.xpos - ball.radius <= leftPaddle.xpos + leftPaddle.paddleWidth) {
      ball.x_vel *= -1;
      float middleY = leftPaddle.ypos + leftPaddle.paddleHeight/2.0;
      float diffY = middleY - ball.ypos;
      float reductionFactor = (leftPaddle.paddleHeight / 2.0) / ball.max_vel;
      ball.y_vel = -1 * (diffY / reductionFactor);
    }
  } else {
    if (ball.ypos > rightPaddle.ypos && ball.ypos < rightPaddle.ypos + rightPaddle.paddleHeight &&
      ball.xpos + ball.radius >= rightPaddle.xpos) {
      ball.x_vel *= -1;
      float middleY = rightPaddle.ypos + rightPaddle.paddleHeight/2.0;
      float diffY = middleY - ball.ypos;
      float reductionFactor = (rightPaddle.paddleHeight / 2.0f) / ball.max_vel;
      ball.y_vel = -1 * (diffY / reductionFactor);
    }
  }
}


void mousePressed() {
  if (mouseButton == LEFT) {
    if (mouseX > gameModeX && mouseX < gameModeX + gameModeWidth && mouseY >
      gameModeY && mouseY < gameModeY + gameModeHeight) {
      gameMode = !gameMode;
    }
  }
}

void handlePaddleMovement() {
  if (keyPressed) {
    if (key == 'w' || key == 'W') leftPaddle.move(true);
    if (key == 's' || key == 'S') leftPaddle.move(false);
  }

  if (!gameMode) {
    if (keyPressed) {
      if (keyCode == UP && rightPaddle.ypos - rightPaddle.Vel >= 0) rightPaddle.move(true);
      if (keyCode == DOWN && rightPaddle.ypos + rightPaddle.Vel + rightPaddle.paddleHeight <= canvasHeight) rightPaddle.move(false);
    }
  } else {
    handleComupterMovement();
  }

  rightPaddle.ypos = constrain(rightPaddle.ypos, 0, canvasHeight - rightPaddle.paddleHeight);
  leftPaddle.ypos = constrain(leftPaddle.ypos, 0, canvasHeight - leftPaddle.paddleHeight);
}

void handleComupterMovement() {
  float paddleCenter = rightPaddle.ypos + rightPaddle.paddleHeight/2.0;
  if (paddleCenter < ball.ypos - computerSpeed) {
    rightPaddle.ypos += computerSpeed;
  } else if (paddleCenter > ball.ypos + computerSpeed) {
    rightPaddle.ypos -= computerSpeed;
  }
  rightPaddle.ypos = constrain(rightPaddle.ypos, 0, canvasHeight - rightPaddle.paddleHeight);
}
