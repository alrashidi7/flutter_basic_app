import 'package:flutter/material.dart';

extension EmptyBox on double {
  Widget get emptyBox => SizedBox();
  Widget get emptyBoxHeight => SizedBox(
        height: double.tryParse(toString()),
      );
  Widget get emptyBoxWidth => SizedBox(
        width: double.tryParse(toString()),
      );
}
