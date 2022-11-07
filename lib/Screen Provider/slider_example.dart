import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Provider/slider_provider.dart';

class SliderPage extends StatefulWidget {
  const SliderPage({Key? key}) : super(key: key);

  @override
  State<SliderPage> createState() => _SliderPageState();
}

class _SliderPageState extends State<SliderPage> {
  double value = 1.0;
  @override
  Widget build(BuildContext context) {
    print('Builder');
    final provider = Provider.of<SliderProvider>(context,listen: false);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Consumer<SliderProvider>(builder: (context,value,child){
            return Slider(
                min: 0,
                max: 1,
                value: value.value, onChanged: (val){
              value.setValue(val);
              // print(value);
            });
          }),
          Consumer<SliderProvider>(builder: (context,value,child){
            return Row(
              children: [
                Expanded(
                  child: Container(
                    height: 100.0,
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(value.value),
                    ),
                    child: Center(child: const Text('Container 1')),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 100.0,
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(value.value),
                    ),
                    child: const Center(child: Text('Container 2')),
                  ),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }
}
