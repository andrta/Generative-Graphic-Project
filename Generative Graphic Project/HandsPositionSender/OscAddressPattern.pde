/**
 * Author: Tamboo aka Andrea Tamburrino in collab w/ Giacomo Paino.
 *
 * Enum OscAddressPattern, defines the current OSC address pattern
 */
 
static enum OscAddressPattern {
  ROTATE_ADDRESS_PATTERN("/rotate"),
    ZOOM_ADDRESS_PATTERN("/zoom");

  private String addressPattern;
  private OscAddressPattern(String addressPattern) {
    this.addressPattern = addressPattern;
  }
  public String getAddressPattern() {
    return addressPattern;
  }
}
