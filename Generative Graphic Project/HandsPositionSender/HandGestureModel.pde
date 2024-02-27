/**
 * Author: Tamboo aka Andrea Tamburrino in collab w/ Giacomo Paino.
 *
 * Class HandGestureModel, used as a data model for the HandGesturesRecogniser
 */

class HandGestureModel {
  private PVector leftHandPosition = null;
  private PVector rightHandPosition = null;
  private Float maxDistanceBetweenHands = null;

  HandGestureModel(final PVector handPosition) { // using leftHandPosition if only one hand is detected
    this.leftHandPosition = handPosition;
  }

  HandGestureModel(final PVector leftHandPosition, final PVector rightHandPosition, final Float maxDistanceBetweenHands) {
    this.leftHandPosition = leftHandPosition;
    this.rightHandPosition = rightHandPosition;
    this.maxDistanceBetweenHands = maxDistanceBetweenHands;
  }
}
