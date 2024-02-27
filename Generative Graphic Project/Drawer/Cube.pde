/**
 * Author: Tamboo aka Andrea Tamburrino in collab w/ Giacomo Paino.
 *
 * ShapeModel Cube
 */

class Cube implements ShapeModel {
  private final int MIN_CAMERA_DISTANCE = 100;
  private final int SIZE = 32;
  private final float TRIANGLE_SIZE = 0.5f;
  private final float POSITION_INDEX = 500f;

  private float yPerlin = 0.0f;
  private float slideY = 0.1f;
  private float rotationAngleY = 0f;

  Cube() {
  }

  /**
   * show method draws the Cube ShapeModel, each vector has a tetrahedron shape.
   * The cameraPosition parameter is used to calculate the color opacity
   *
   * @param       float[] cameraPosition
   * @return      void
   */
  void show(final float[] cameraPosition) {
    for (int i = 0; i < SIZE; i++) {
      for (int j = 0; j < SIZE; j++) {
        for (int k = 0; k < SIZE; k++) {
          float x = map(i, 0, SIZE, -POSITION_INDEX, POSITION_INDEX);
          float y = map(j, 0, SIZE, -POSITION_INDEX, POSITION_INDEX);
          float z = map(k, 0, SIZE, -POSITION_INDEX, POSITION_INDEX);
          setShapeColor(x, y, z, cameraPosition);
          pushMatrix();
          translate(x, y, z);
          rotateY(rotationAngleY +=  noise(yPerlin + slideY));
          beginShape(TRIANGLE_STRIP);
          vertex( TRIANGLE_SIZE, TRIANGLE_SIZE, TRIANGLE_SIZE);
          vertex(-TRIANGLE_SIZE, -TRIANGLE_SIZE, TRIANGLE_SIZE);
          vertex(-TRIANGLE_SIZE, TRIANGLE_SIZE, -TRIANGLE_SIZE);
          vertex( TRIANGLE_SIZE, -TRIANGLE_SIZE, -TRIANGLE_SIZE);
          vertex( TRIANGLE_SIZE, TRIANGLE_SIZE, TRIANGLE_SIZE);
          vertex(-TRIANGLE_SIZE, -TRIANGLE_SIZE, TRIANGLE_SIZE);
          endShape();
          popMatrix();
        }
      }
    }
    yPerlin = 0;
    slideY += random(0.0001, 0.0002);
  }

  /**
   * getMinCameraDistance returns MIN_CAMERA_DISTANCE value
   *
   * @return      int
   */
  int getMinCameraDistance() {
    return MIN_CAMERA_DISTANCE;
  }

  /**
   * setShapeColor sets the color opacity depending to the camera distance
   *
   * @param       float x
   * @param       float y
   * @param       float z
   * @param       float[] cameraPosition
   * @return      void
   */
  private void setShapeColor(float x, float y, float z, float[] cameraPosition) {
    PVector cubeVector = new PVector(x, y, z);
    PVector cameraVector = new PVector(cameraPosition[0], cameraPosition[1], cameraPosition[2]);
    float cubeDistanceFromCamera = cubeVector.dist(cameraVector);
    float colorGradient = map(cubeDistanceFromCamera, 200, 2000, 200, 50);
    stroke(0, colorGradient, 0);
    noFill();
  }
}
