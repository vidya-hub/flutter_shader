import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:newshader/shader_painter.dart';

class ShaderHome extends StatefulWidget {
  const ShaderHome({super.key, required this.title});

  final String title;

  @override
  State<ShaderHome> createState() => _ShaderHomeState();
}

class _ShaderHomeState extends State<ShaderHome>
    with SingleTickerProviderStateMixin {
  Future<FragmentShader> _load() async {
    FragmentProgram program = await FragmentProgram.fromAsset(
      'shaders/shader.frag',
    );
    FragmentShader shader = program.fragmentShader();
    return shader;
  }

  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
    animationBehavior: AnimationBehavior.preserve,
    lowerBound: -1,
    upperBound: 1,
  )..repeat();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 10,
          width: width * 0.4,
          child: FutureBuilder(
            future: _load(),
            builder: (context, snapShot) {
              if (!snapShot.hasData) {
                return const CircularProgressIndicator();
              }
              return AnimatedBuilder(
                animation: _controller,
                builder: (context, _) {
                  snapShot.data!.setFloat(2, _controller.value);

                  return CustomPaint(
                    painter: ShaderPainter(
                      shader: snapShot.data!,
                      timeTick: _controller.value,
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
