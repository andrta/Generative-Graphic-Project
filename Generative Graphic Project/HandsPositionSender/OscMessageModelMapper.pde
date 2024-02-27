/**
 * Author: Tamboo aka Andrea Tamburrino in collab w/ Giacomo Paino.
 *
 * Class OscMessageModelMapper, used to map HandGestureModel data model to OscMessageModel data model
 */

class OscMessageModelMapper {
  OscMessageModelMapper() {
  }

  /**
   * map method creates OscMessageModel data model from an HandGestureModel data model
   *
   * @param       HandGestureModel
   * @return      OscMessageModel
   */
  OscMessageModel map(final HandGestureModel handGestureModel) {
    if (handGestureModel.maxDistanceBetweenHands == null) return new OscMessageModel(handGestureModel.leftHandPosition);
    else return new OscMessageModel(handGestureModel.leftHandPosition, handGestureModel.rightHandPosition, handGestureModel.maxDistanceBetweenHands);
  }
}
