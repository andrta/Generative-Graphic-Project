/**
 * Author: Tamboo aka Andrea Tamburrino in collab w/ Giacomo Paino.
 *
 * Camera interface
 */

interface ICamera {
  void setMinimumDistance(int distance);
  void setMaximumDistance(int distance);
  void handleCameraZoom(PVector leftHandPosition, PVector rightHandPosition, float maxDistanceBetweenHandsJoints);
  void activateRotateAction(int x, int y);
  void releaseRotateAction();
  float[] getCameraPosition();
}
