/**
 * Author: Tamboo aka Andrea Tamburrino in collab w/ Giacomo Paino.
 *
 * This class handles the OSC received messages.
 */

import oscP5.*;
import netP5.*;

class OscReceiver {
  private final String ROTATE_ADDRESS_PATTERN = "/rotate";
  private final String ZOOM_ADDRESS_PATTERN = "/zoom";
  private final int OSC_LOCAL_PORT = 8889;

  private PVector leftHandPosition = new PVector();
  private PVector rightHandPosition = new PVector();
  private float maxDistanceBetweenHandsJoints;

  OscP5 oscP5;
  private Drawer drawer;

  OscReceiver(final Drawer drawer) {
    this.drawer = drawer;
    oscP5 = new OscP5(this, OSC_LOCAL_PORT);
  }

  /**
   * oscEvent method from the oscP5 library called when a message is received
   * Checking the address patterns identifies which action should be performed
   *
   * @return      void
   */
  void oscEvent(OscMessage message) {
    if (message.checkAddrPattern(ZOOM_ADDRESS_PATTERN)) {
      drawer.releaseRotateAction();
      updateHandPositions(message);
      updateMaxDistance(message);
      drawer.handleZoom(leftHandPosition, rightHandPosition, maxDistanceBetweenHandsJoints);
      logZoom(message.typetag());
    } else if (message.checkAddrPattern(ROTATE_ADDRESS_PATTERN)) {
      final int x = (int) message.get(0).floatValue();
      final int y = (int) message.get(1).floatValue();
      drawer.activateRotateAction(x, y);
      logRotate(message.typetag(), x, y);
    }
  }

  /**
   * updateHandPositions parse the OscMessage to get the hands positions coordinates
   *
   * @return      void
   */
  private void updateHandPositions(OscMessage message) {
    leftHandPosition.set(message.get(0).floatValue(), message.get(1).floatValue(), message.get(2).floatValue());
    rightHandPosition.set(message.get(3).floatValue(), message.get(4).floatValue(), message.get(5).floatValue());
  }

  /**
   * updateMaxDistance parse the OscMessage to get the maxDistanceBetweenHandsJoints
   *
   * @return      void
   */
  private void updateMaxDistance(OscMessage message) {
    maxDistanceBetweenHandsJoints = message.get(6).floatValue();
  }

  /**
   * getClassName to get the simple class name
   *
   * @return      String
   */
  private String getClassName() {
    return OscReceiver.class.getSimpleName();
  }

  /**
   * logZoom prints on the terminal the zoom Osc message data
   *
   * @return      void
   */
  private void logZoom(String typetag) {
    println(getClassName() +" ### received an osc message "+ZOOM_ADDRESS_PATTERN+" - typetag: "+typetag+", with values:");
    println(getClassName() +" LEFT_HAND x-> "+leftHandPosition.x+", y-> "+leftHandPosition.y+", z-> "+leftHandPosition.z);
    println(getClassName() +" RIGHT_HAND x-> "+rightHandPosition.x+", y-> "+rightHandPosition.y+", z-> "+rightHandPosition.z);
    println(getClassName() +" MAX DISTANCE BETWEEN HANDS -> "+maxDistanceBetweenHandsJoints);
    println(getClassName() +" ----------------------");
  }

  /**
   * logRotate prints on the terminal the rotate Osc message data
   *
   * @return      void
   */
  private void logRotate(String typetag, int x, int y) {
    println(getClassName() +" ### received an osc message "+ROTATE_ADDRESS_PATTERN+" - typetag: "+typetag+", with values:");
    println(getClassName() +" ROTATE_POSITION x-> "+ x +", y-> "+ y);
    println(getClassName() +" ----------------------");
  }
}
