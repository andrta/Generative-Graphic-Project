/**
 * Author: Tamboo aka Andrea Tamburrino in collab w/ Giacomo Paino.
 *
 * ShapeModel MandelBulb
 */

class Mandelbulb implements ShapeModel {
  private final int DIM = 16; //128;
  private final float TRIANGLE_SIZE = 0.7f;
  private final float POSITION_INDEX = 500f;
  private final int MIN_CAMERA_DISTANCE = 500;
  private float rotationAngleY = 0f;
  private ArrayList<PVector> mandelbulb = new ArrayList<PVector>();

  Mandelbulb() {
    createMandelbulb();
  }

  /**
   * show method draws the Mandelbulb ShapeModel, each vector has a tetrahedron shape.
   * The cameraPosition parameter is used to calculate the color opacity
   *
   * @param       float[] cameraPosition
   * @return      void
   */
  void show(final float[] cameraPosition) {
    for (PVector mandelbulbVector : mandelbulb) {
      setShapeColor(mandelbulbVector, cameraPosition);
      pushMatrix();
      translate(mandelbulbVector.x, mandelbulbVector.y, mandelbulbVector.z);
      rotateY(rotationAngleY += random(0.0001, 0.0005));
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

  /**
   * getMinCameraDistance returns MIN_CAMERA_DISTANCE value
   *
   * @return      int
   */
  int getMinCameraDistance() {
    return MIN_CAMERA_DISTANCE;
  }

  /**
   * createMandelbulb used to populate the mandelbulb ArrayList of PVectors
   *
   * @return      void
   */
  private void createMandelbulb() {
    for (int i = 0; i < DIM; i++) {
      for (int j = 0; j < DIM; j++) {
        boolean edge = false;

        for (int k = 0; k < DIM; k++) {
          float x = map(i, 0, DIM, -1, 1);
          float y = map(j, 0, DIM, -1, 1);
          float z = map(k, 0, DIM, -1, 1);

          PVector zeta = new PVector(0, 0, 0);
          int n = 8;
          int maxIteration = 10;
          int iteration = 0;

          while (true) {
            Spherical sphericalZ = getSphericalFromCartesian(zeta.x, zeta.y, zeta.z);
            float newX = pow(sphericalZ.r, n) * sin(sphericalZ.theta * n) * cos(sphericalZ.phi * n);
            float newY = pow(sphericalZ.r, n) * sin(sphericalZ.theta * n) * sin(sphericalZ.phi * n);
            float newZ = pow(sphericalZ.r, n) * cos(sphericalZ.theta * n);
            zeta.x = newX + x;
            zeta.y = newY + y;
            zeta.z = newZ + z;
            iteration++;

            if (sphericalZ.r > 2) {
              if (edge) {
                edge = false;
              }
              break;
            }
            if (iteration > maxIteration) {
              if (!edge) {
                edge = true;
                mandelbulb.add(new PVector(x * POSITION_INDEX, y * POSITION_INDEX, z * POSITION_INDEX));
              }
              break;
            }
          }
        }
      }
    }
  }

  private class Spherical {
    float r, theta, phi;
    Spherical(float r, float theta, float phi) {
      this.r = r;
      this.theta = theta;
      this.phi = phi;
    }
  }

  /**
   * getSphericalFromCartesian returns a Spherical object from cartesian coordinates
   *
   * @param       float x
   * @param       float y
   * @param       float z
   * @return      Spherical
   */
  private Spherical getSphericalFromCartesian(float x, float y, float z) {
    float r = sqrt(x*x + y*y + z*z);
    float theta = atan2(sqrt(x*x + y*y), z);
    float phi = atan2(y, x);
    return new Spherical(r, theta, phi);
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
  private void setShapeColor(PVector mandelbulbVector, float[] cameraPosition) {
    PVector cameraVector = new PVector(cameraPosition[0], cameraPosition[1], cameraPosition[2]);
    float mandelbulbDistanceFromCamera = mandelbulbVector.dist(cameraVector);
    float colorGradient = map(mandelbulbDistanceFromCamera, 200, 2000, 255, 50);
    stroke(colorGradient);
    noFill();
  }
}
