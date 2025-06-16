double responsiveFontSize(double screenWidth,double baseSize) {
  if (screenWidth < 350) {
    return baseSize * 0.7;
  } else if (screenWidth < 500) {
    return baseSize * 0.8;
  } else if (screenWidth < 700) {
    return baseSize;
  } else {
    return baseSize * 1.0;
  }
}
