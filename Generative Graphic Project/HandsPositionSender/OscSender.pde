/**
 * Author: Tamboo aka Andrea Tamburrino in collab w/ Giacomo Paino.
 *
 * This class handles the sending of the OSC messages.
 */

import oscP5.*;
import netP5.*;

class OscSender {
  private final int OSC_LOCAL_PORT = 7001;
  private final int OSC_REMOTE_PORT = 8889;
  private final String REMOTE_DESTINATION_IP = "Add here the destination IP address";
  final NetAddress destinationNetAddress;
  private OscP5 oscP5;

  public OscSender(HandsPositionSender context) {
    oscP5 = new OscP5(context, OSC_LOCAL_PORT);
    destinationNetAddress = new NetAddress(REMOTE_DESTINATION_IP, OSC_REMOTE_PORT);
  }

  /**
   * send method creates and send an OscMessage depending on the OscMessageModel data model
   *
   * @param       OscMessageModel
   * @return      void
   */
  public void send(OscMessageModel oscMessageModel) {
    final OscMessage message = new OscMessage(oscMessageModel.addressPattern.getAddressPattern());
    switch(oscMessageModel.addressPattern) {
    case ROTATE_ADDRESS_PATTERN:
      message.add(oscMessageModel.firstPosition.x);
      message.add(oscMessageModel.firstPosition.y);
      message.add(oscMessageModel.firstPosition.z);
      break;
    case ZOOM_ADDRESS_PATTERN:
      message.add(oscMessageModel.firstPosition.x);
      message.add(oscMessageModel.firstPosition.y);
      message.add(oscMessageModel.firstPosition.z);
      message.add(oscMessageModel.secondPosition.x);
      message.add(oscMessageModel.secondPosition.y);
      message.add(oscMessageModel.secondPosition.z);
      message.add(oscMessageModel.maxDistanceBetweenPositions);
    }
    message.print();
    oscP5.send(message, destinationNetAddress);
    println(OscSender.class.getSimpleName() +" - Osc message sent");
  }
}
