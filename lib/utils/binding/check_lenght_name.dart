String checkNameLength({required String productName}) {
  if (productName.length > 13) {
    return '${productName.substring(0, 13)}...';
  } else {
    return productName;
  }
}