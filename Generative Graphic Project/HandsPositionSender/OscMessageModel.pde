/**
 * Author: Tamboo aka Andrea Tamburrino in collab w/ Giacomo Paino.
 *
 * Class OscMessageModel, used as a data model for the OscSender
 */
 
class OscMessageModel {
  private PVector firstPosition;
  private PVector secondPosition;
  private float maxDistanceBetweenPositions;
  private OscAddressPattern addressPattern;

  OscMessageModel(final PVector position) {
    firstPosition = position;
    addressPattern = OscAddressPattern.ROTATE_ADDRESS_PATTERN;
  }

  OscMessageModel(final PVector firstPosition, final PVector secondPosition, final float maxDistanceBetweenPositions) {
    this.firstPosition = firstPosition;
    this.secondPosition = secondPosition;
    this.maxDistanceBetweenPositions = maxDistanceBetweenPositions;
    addressPattern = OscAddressPattern.ZOOM_ADDRESS_PATTERN;
  }
}
