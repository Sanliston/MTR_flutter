import 'package:MTR_flutter/utilities/utility_imports.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';
import 'package:MTR_flutter/utilities/constants.dart';
import 'package:MTR_flutter/state_management/root_template_state.dart';

class CustomizePlaceCard extends StatelessWidget {
  const CustomizePlaceCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: darkNight,
      child: Center(
        child: Text(
          'This is the tab',
          style: const TextStyle(fontSize: 36),
        ),
      ),
    );
  }
}
