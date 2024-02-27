/**
 * Author: Tamboo aka Andrea Tamburrino in collab w/ Giacomo Paino.
 *
 * HandGesturesRecogniser class using the KinectPV2 library
 */

import KinectPV2.KJoint;
import KinectPV2.*;

class HandGesturesRecogniser {
  private final int MAX_RECOGNITION_DISTANCE_THRESHOLD = 1000;
  private final int MIN_RECOGNITION_DISTANCE_THRESHOLD = 500;

  private int CLOSE_HAND_STATE = KinectPV2.HandState_Closed;
  private int OPEN_HAND_STATE = KinectPV2.HandState_Open;

  private int LEFT_HAND_JOINT = KinectPV2.JointType_HandLeft;
  private int RIGHT_HAND_JOINT =KinectPV2.JointType_HandRight;

  private final int[] JOINT_PATH_FROM_LEFT_HAND_TO_RIGHT_HAND = {
    KinectPV2.JointType_HandLeft,
    KinectPV2.JointType_WristLeft,
    KinectPV2.JointType_ElbowLeft,
    KinectPV2.JointType_ShoulderLeft,
    KinectPV2.JointType_SpineShoulder,
    KinectPV2.JointType_ShoulderRight,
    KinectPV2.JointType_ElbowRight,
    KinectPV2.JointType_WristRight,
    KinectPV2.JointType_HandRight
  };

  private KinectPV2 kinect;

  HandGesturesRecogniser(final HandsPositionSender context) {
    kinect = new KinectPV2(context);
    kinect.enableDepthImg(true);
    kinect.enableDepthMaskImg(true);
    kinect.enableSkeletonDepthMap(true);
    kinect.enableSkeletonColorMap(true);
    kinect.setLowThresholdPC(MIN_RECOGNITION_DISTANCE_THRESHOLD);
    kinect.setHighThresholdPC(MAX_RECOGNITION_DISTANCE_THRESHOLD);
    kinect.init();
  }

  /**
   * getDepthMaskImage method returns getDepthMaskImage from the kinect
   *
   * @return      PImage
   */
  PImage getDepthMaskImage() {
    return kinect.getDepthMaskImage();
  }

  /**
   * getHandsGestures method returns a specific HandGestureModel data model depending on the hands states.
   * Depending if the hand state is CLOSE_HAND_STATE the method returns HandGestureModel with the hands position.
   *
   * @return      HandGestureModel
   */
  HandGestureModel getHandsGestures() {
    ArrayList<KSkeleton> skeletonArray = kinect.getSkeletonColorMap();
    if (skeletonArray.isEmpty()) return null; // No skeleton detected

    final KSkeleton skeleton = skeletonArray.get(0);
    if (!skeleton.isTracked()) return null; // First skeleton in the array is not tracked

    final KJoint[] joints = skeleton.getJoints();
    final KJoint leftHandJoint = joints[LEFT_HAND_JOINT];
    final KJoint rightHandJoint = joints[RIGHT_HAND_JOINT];
    final int leftHandState = leftHandJoint.getState();
    final int rightHandState = rightHandJoint.getState();

    if (CLOSE_HAND_STATE == leftHandState  && CLOSE_HAND_STATE == rightHandState) { // Check if the two hands are closed
      return new HandGestureModel(
        leftHandJoint.getPosition(),
        rightHandJoint.getPosition(),
        getMaxDistanceBetweenHands(joints));
    } else if (OPEN_HAND_STATE == leftHandState && CLOSE_HAND_STATE == rightHandState) { // Check if only the right hand is closed
      return new HandGestureModel(rightHandJoint.getPosition());
    } else if (CLOSE_HAND_STATE == leftHandState && OPEN_HAND_STATE == rightHandState) { // Check if only the left hand is closed
      return new HandGestureModel(leftHandJoint.getPosition());
    }

    return null; // None of the expected conditions were met
  }

  /**
   * getMaxDistanceBetweenHands method returns maxDistance from the left hand to the right hand as a float value.
   *
   * @param       KJoint[]
   * @return      float
   */
  private float getMaxDistanceBetweenHands(final KJoint[] joints) {
    float maxDistance = 0f;
    for (int i = 0; i < JOINT_PATH_FROM_LEFT_HAND_TO_RIGHT_HAND.length - 1; i++) {
      int jointIndex1 = JOINT_PATH_FROM_LEFT_HAND_TO_RIGHT_HAND[i];
      int jointIndex2 = JOINT_PATH_FROM_LEFT_HAND_TO_RIGHT_HAND[i + 1];
      maxDistance += joints[jointIndex1].getPosition().dist(joints[jointIndex2].getPosition());
    }
    return maxDistance;
  }
}
