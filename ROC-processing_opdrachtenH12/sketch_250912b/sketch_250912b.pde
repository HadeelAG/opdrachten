// Processing (Java) - Pong (robust keyboard handling + non-blocking win text)

int WIN_W = 700;
int WIN_H = 500;

int paddleWidth = 20;
int paddleHeight = 100;
int ballRadius = 7;
int winningScore = 10;
int computerSpeed = 3;

color white, black, red;
color leftPaddleColor, rightPaddleColor, ballColor, borderColor;

Paddle leftPaddle, rightPaddle;
Ball ball;
int leftScore = 0;
int rightScore = 0;
boolean gameMode = true;  // true: Player vs AI, false: Player vs Player

// Game-mode toggle rectangle
int gmX, gmY, gmW = 140, gmH = 30;

// Winner state (non-blocking)
boolean won = false;
String winText = "";
int winStartMillis = 0;
int winDuration = 5000; // 5000 ms = 5 seconds

void setup() {
  size(700, 500);
  frameRate(60);

  // Colors
  white = color(255, 255, 255);
  black = color(0, 0, 0);
  red = color(255, 0, 0);
  leftPaddleColor = color(100, 180, 255);
  rightPaddleColor = color(220, 80, 80);
  ballColor = color(255, 230, 40);
  borderColor = color(120, 220, 150);

  leftPaddle = new Paddle(10, WIN_H/2 - paddleHeight/2, paddleWidth, paddleHeight, leftPaddleColor);
  rightPaddle = new Paddle(WIN_W - 10 - paddleWidth, WIN_H/2 - paddleHeight/2, paddleWidth, paddleHeight, rightPaddleColor);
  ball = new Ball(WIN_W/2, WIN_H/2, ballRadius);

  gmX = WIN_W/2 - gmW/2;
  gmY = 10;

  textAlign(CENTER, CENTER);
}

void draw() {
  background(black);

  // Scores
  fill(white);
  textSize(30);
  text(leftScore, WIN_W/4, 20);
  text(rightScore, 3*WIN_W/4, 20);

  // Draw paddles
  leftPaddle.draw();
  rightPaddle.draw();

  // Stippled center line
  noStroke();
  int segmentH = WIN_H / 20;
  int idx = 0;
  for (int y = 50; y < WIN_H; y += segmentH) {
    if (idx % 2 == 0) {
      rect(WIN_W/2 - 5, y, 10, segmentH);
    }
    idx++;
  }

  // Draw ball
  ball.draw();

  // Game mode toggle box
  stroke(borderColor);
  strokeWeight(2);
  noFill();
  rect(gmX, gmY, gmW, gmH);
  noStroke();
  fill(white);
  textSize(15);
  String modeText = gameMode ? "Player VS AI" : "Player VS Player";
  text(modeText, gmX + gmW/2, gmY + gmH/2);

  // If nobody has won, update the game normally
  if (!won) {
    handlePaddleMovement();   // <-- robust per-frame check (works in AI mode too)
    ball.move();
    handleCollision();

    // Scoring (ball out of bounds)
    if (ball.x - ball.radius < 0) {
      rightScore++;
      ball.reset();
    } else if (ball.x + ball.radius > WIN_W) {
      leftScore++;
      ball.reset();
    }

    // Check for winner and start the non-blocking win timer
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
    // Display the win text (overlay) while paused
    fill(red);
    textSize(48);
    text(winText, WIN_W/2, WIN_H/2);

    // After duration, reset everything and continue
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

// Robust, per-frame paddle movement handling.
// This checks the current key state every frame (using the global keyPressed flag and key/keyCode).
// This is more reliable than relying only on keyPressed()/keyReleased() events.
void handlePaddleMovement() {
  // LEFT PADDLE (always player-controlled with W / S)
  if (keyPressed) {
    // Character keys (w / s)
    if ((key == 'w' || key == 'W') && leftPaddle.y - leftPaddle.VEL >= 0) {
      leftPaddle.move(true);
    } else if ((key == 's' || key == 'S') && leftPaddle.y + leftPaddle.VEL + leftPaddle.height <= WIN_H) {
      leftPaddle.move(false);
    }
    // Also support arrow keys for left paddle if desired (optional).
    // if (keyCode == UP && leftPaddle.y - leftPaddle.VEL >= 0) leftPaddle.move(true);
    // if (keyCode == DOWN && leftPaddle.y + leftPaddle.VEL + leftPaddle.height <= WIN_H) leftPaddle.move(false);
  }

  // RIGHT PADDLE: either AI or player (Up/Down)
  if (!gameMode) {
    // Player vs Player: use arrow keys for right paddle
    if (keyPressed) {
      if (keyCode == UP && rightPaddle.y - rightPaddle.VEL >= 0) rightPaddle.move(true);
      if (keyCode == DOWN && rightPaddle.y + rightPaddle.VEL + rightPaddle.height <= WIN_H) rightPaddle.move(false);
    }
  } else {
    // Player vs AI: simple AI tracks ball
    rightPaddleAI();
  }

  // Clamp paddles to window
  leftPaddle.y = constrain(leftPaddle.y, 0, WIN_H - leftPaddle.height);
  rightPaddle.y = constrain(rightPaddle.y, 0, WIN_H - rightPaddle.height);
}

void rightPaddleAI() {
  float paddleCenter = rightPaddle.y + rightPaddle.height/2.0;
  if (paddleCenter < ball.y - computerSpeed) {
    rightPaddle.y += computerSpeed;
  } else if (paddleCenter > ball.y + computerSpeed) {
    rightPaddle.y -= computerSpeed;
  }
  rightPaddle.y = constrain(rightPaddle.y, 0, WIN_H - rightPaddle.height);
}

void mousePressed() {
  if (mouseButton == LEFT) {
    if (mouseX > gmX && mouseX < gmX + gmW && mouseY > gmY && mouseY < gmY + gmH) {
      gameMode = !gameMode;
    }
  }
}

void handleCollision() {
  // Bounce from top/bottom
  if (ball.y - ball.radius <= 0 || ball.y + ball.radius >= WIN_H) {
    ball.y_vel *= -1;
  }

  // Left paddle collision
  if (ball.x_vel < 0) {
    if (ball.y > leftPaddle.y && ball.y < leftPaddle.y + leftPaddle.height &&
      ball.x - ball.radius <= leftPaddle.x + leftPaddle.width) {
      ball.x_vel *= -1;
      float middleY = leftPaddle.y + leftPaddle.height/2.0;
      float diffY = middleY - ball.y;
      float reductionFactor = (leftPaddle.height / 2.0f) / ball.MAX_VEL;
      ball.y_vel = -1 * (diffY / reductionFactor);
    }
  } else {
    // Right paddle collision
    if (ball.y > rightPaddle.y && ball.y < rightPaddle.y + rightPaddle.height &&
      ball.x + ball.radius >= rightPaddle.x) {
      ball.x_vel *= -1;
      float middleY = rightPaddle.y + rightPaddle.height/2.0;
      float diffY = middleY - ball.y;
      float reductionFactor = (rightPaddle.height / 2.0f) / ball.MAX_VEL;
      ball.y_vel = -1 * (diffY / reductionFactor);
    }
  }
}

// Paddle class
class Paddle {
  float x, y;
  float originalX, originalY;
  int width, height;
  color c;
  final int VEL = 4;

  Paddle(float x, float y, int w, int h, color c) {
    this.x = x;
    this.y = y;
    this.originalX = x;
    this.originalY = y;
    this.width = w;
    this.height = h;
    this.c = c;
  }

  void draw() {
    fill(c);
    noStroke();
    rect(x, y, width, height);
  }

  void move(boolean up) {
    if (up) y -= VEL;
    else y += VEL;
  }

  void reset() {
    x = originalX;
    y = originalY;
  }
}

// Ball class
class Ball {
  float x, y;
  float originalX, originalY;
  int radius;
  float x_vel, y_vel;
  final float MAX_VEL = 5;

  Ball(float x, float y, int r) {
    this.x = x;
    this.y = y;
    this.originalX = x;
    this.originalY = y;
    this.radius = r;
    x_vel = MAX_VEL;
    y_vel = 0;
  }

  void draw() {
    fill(ballColor);
    noStroke();
    ellipse(x, y, radius*2, radius*2);
  }

  void move() {
    x += x_vel;
    y += y_vel;
  }

  void reset() {
    x = originalX;
    y = originalY;
    y_vel = 0;
    x_vel *= -1;
  }
}
