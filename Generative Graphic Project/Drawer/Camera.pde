/**
 * Author: Tamboo aka Andrea Tamburrino in collab w/ Giacomo Paino.
 *
 * Camera class using the PeasyCam library
 *
 * The current solution is using the AWT Robot class in order to move the mouse and interact with the camera
 */

import peasy.*;
import java.awt.AWTException;
import java.awt.Robot;
import java.awt.event.InputEvent;

class Camera implements ICamera {
  private final int MIN_CAMERA_DISTANCE = 100;
  private final int MAX_CAMERA_DISTANCE = 2000;

  private PeasyCam peasyCam;
  private Robot robot;

  Camera(final Drawer drawer) {
    try {
      robot = new Robot();
    }
    catch (AWTException e) {
      println("Robot class not supported by your system!");
      exit();
    }
    peasyCam = new PeasyCam(drawer, MAX_CAMERA_DISTANCE);
    setMaximumDistance(MAX_CAMERA_DISTANCE);
  }

  /**
   * setMinimumDistance used to call setMinimumDistance on the PeasyCam object
   *
   * @param       int distance
   * @return      void
   */
  void setMinimumDistance(int distance) {
    peasyCam.setMinimumDistance(distance);
  }

  /**
   * setMaximumDistance used to call setMaximumDistance on the PeasyCam object
   *
   * @param       int distance
   * @return      void
   */
  void setMaximumDistance(int distance) {
    peasyCam.setMaximumDistance(distance);
  }

  /**
   * setDistance used to call setDistance on the PeasyCam object
   *
   * @param       int distance
   * @return      void
   */
  private void setDistance(float distance) {
    peasyCam.setDistance(distance);
  }

  /**
   * getCameraPosition returns the PeasyCam object position with as an array of float
   *
   * @return      float[]
   */
  float[] getCameraPosition() {
    return peasyCam.getPosition();
  }

  /**
   * handleCameraZoom is the responsible to set the camera distance depending on the distance between the two hands positions
   *
   * @param       PVector leftHandPosition
   * @param       PVector rightHandPosition
   * @param       float maxDistanceBetweenHandsJoints
   * @return      void
   */
  void handleCameraZoom(PVector leftHandPosition, PVector rightHandPosition, float maxDistanceBetweenHandsJoints) {
    float currentDistanceBetweenHands = leftHandPosition.dist(rightHandPosition);
    float nextCameraDistance = map(currentDistanceBetweenHands, 10, maxDistanceBetweenHandsJoints, MAX_CAMERA_DISTANCE, MIN_CAMERA_DISTANCE);
    setDistance(nextCameraDistance);
    logCameraZoom(maxDistanceBetweenHandsJoints, currentDistanceBetweenHands, peasyCam.getDistance(), nextCameraDistance);
  }

  /**
   * activateRotateAction calls the robot object to move to specific coordinates
   *
   * @param       int x
   * @param       int y
   * @return      void
   */
  void activateRotateAction(int x, int y) {
    robot.mousePress(InputEvent.BUTTON1_DOWN_MASK);
    robot.mouseMove(x, y);
    logCameraRotate(x, y);
  }

  /**
   * releaseRotateAction uses the robot object to release the mouse press
   *
   * @return      void
   */
  void releaseRotateAction() {
    robot.mouseRelease(InputEvent.BUTTON1_DOWN_MASK);
  }

  /**
   * logCameraZoom prints on the terminal the zoom camera information
   *
   * @return      void
   */
  private void logCameraZoom(float maxDistanceBetweenHandsJoints, float currentDistanceBetweenHands, double currentCameraDistance, float nextCameraDistance) {
    println(getClassName()+" Max Hands distance: " + maxDistanceBetweenHandsJoints);
    println(getClassName()+" Current Hands distance: " + currentDistanceBetweenHands);
    println(getClassName()+" Current Camera distance: " + currentCameraDistance);
    println(getClassName()+" Next Camera distance: " + nextCameraDistance);
    println("----------------------");
  }

  /**
   * logCameraRotate prints on the terminal the rotate camera information
   *
   * @return      void
   */
  private void logCameraRotate(float x, float y) {
    println(getClassName()+" Rotate camera to coordinates: x:" +x+", y: "+y);
    println("----------------------");
  }

  /**
   * getClassName to get the simple class name
   *
   * @return      String
   */
  private String getClassName() {
    return Camera.class.getSimpleName();
  }
}
