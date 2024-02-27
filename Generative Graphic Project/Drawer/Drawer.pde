/**
 * Created by Tamboo aka Andrea Tamburrino in collab w/ Giacomo Paino.
 *
 * This project was created for the final exam of the Generative Graphics class at the Audiovisual Innovation Master at BAU (https://www.baued.es/).
 * The course was taught by Multimedia Artist Diego Suarez Barcena (http://diegosuba.com/).
 *
 * The 3D shapes were inspired by Daniel Shiffman's website (https://thecodingtrain.com/)
 * and specifically the "Mandelbulb" challenge (https://thecodingtrain.com/challenges/168-the-mandelbulb).
 *
 * Project modules:
 * **HandsPositionSender:** Detects hands and sends their positions through OSC.
 * **Drawer:** Draws the 3D model and uses the received hand positions to move the camera by zooming and rotating around the model.
 *
 * Libraries used:
 * **KinectPV2:** (https://codigogenerativo.com/code/kinectpv2-k4w2-processing-library/)
 * **PeasyCam:** (https://mrfeinberg.com/peasycam/)
 * **oscP5:** (https://sojamo.de/libraries/oscp5/)
 * **java.awt:** (https://docs.oracle.com/javase%2F7%2Fdocs%2Fapi%2F%2F/java/awt/package-summary.html)
 *
 * A big thanks to the teachers, helpers, and creators of the above libraries!
 */

static enum ShapeModelEnum {
  MANDELBULB, CUBE
}
ShapeModelEnum currentModel = ShapeModelEnum.MANDELBULB;

private ShapeModel mandelBulb;
private ShapeModel cube;
private ICamera camera;
OscReceiver oscReceiver;

void setup() {
  fullScreen(P3D);
  noCursor();
  smooth(8);

  camera = new Camera(this);
  oscReceiver = new OscReceiver(this);
  cube = new Cube();
  mandelBulb = new Mandelbulb();
}

void draw() {
  background(0);
  if (currentModel == ShapeModelEnum.MANDELBULB) {
    camera.setMinimumDistance(mandelBulb.getMinCameraDistance());
    mandelBulb.show(camera.getCameraPosition());
  } else if (currentModel == ShapeModelEnum.CUBE) {
    camera.setMinimumDistance(cube.getMinCameraDistance());
    cube.show(camera.getCameraPosition());
  }
}

/**
 * handleZoom method calls the camera method handleCameraZoom sending the positions PVectors and the float maxDistanceBetweenHandsJoints
 *
 * @param       PVector leftHandPosition
 * @param       PVector rightHandPosition
 * @param       float maxDistanceBetweenHandsJoints
 * @return      void
 */
void handleZoom(PVector leftHandPosition, PVector rightHandPosition, float maxDistanceBetweenHandsJoints) {
  camera.handleCameraZoom(leftHandPosition, rightHandPosition, maxDistanceBetweenHandsJoints);
}

/**
 * activateRotateAction method calls the camera method activateRotateAction sending the int coordinates x, y
 *
 * @param       int x
 * @param       int y
 * @return      void
 */
void activateRotateAction(int x, int y) {
  camera.activateRotateAction(x, y);
}

/**
 * releaseRotateAction method calls the camera method releaseRotateAction
 *
 * @return      void
 */
void releaseRotateAction() {
  camera.releaseRotateAction();
}

/**
 * keyPressed method change the 3D shape to draw.
 * Pressing key 1 changes to the MandelBuld shape
 * Pressing key 2 changes to the Cube shape
 *
 * @return      void
 */
void keyPressed() {
  if (key == '1') currentModel = ShapeModelEnum.MANDELBULB;
  if (key == '2') currentModel = ShapeModelEnum.CUBE;
}
