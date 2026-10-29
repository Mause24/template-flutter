import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:template_flutter/globals/components/components.dart';
import 'package:template_flutter/globals/theme/colors.dart';

class Authlayout extends ConsumerStatefulWidget {
  final String? title;
  final Widget child;
  final GoRouterState state;

  const Authlayout({
    super.key,
    this.title,
    required this.child,
    required this.state,
  });

  @override
  ConsumerState<Authlayout> createState() => _AuthlayoutState();
}

class _AuthlayoutState extends ConsumerState<Authlayout> {
  double percentageMoved = 1;

  @override
  void initState() {
    onInitAuthLayout(widget.state.fullPath ?? "");
    super.initState();
  }

  @override
  void didUpdateWidget(covariant Authlayout oldWidget) {
    if (oldWidget.state.fullPath != widget.state.fullPath) {
      onInitAuthLayout(widget.state.fullPath ?? "");
    }
    super.didUpdateWidget(oldWidget);
  }

  void toggleModal() {
    setState(() {
      percentageMoved = percentageMoved == 1 ? 0 : 1;
    });
  }

  void onNavigateLogin() {
    if (context.mounted &&
        !(widget.state.fullPath?.contains("login") ?? false)) {
      context.go("/auth/login");
    }
    setState(() {
      percentageMoved = 0.2;
    });
  }

  void onNavigateRegister() {
    if (context.mounted &&
        !(widget.state.fullPath?.contains("register") ?? false)) {
      context.go("/auth/register");
    }
    setState(() {
      percentageMoved = 0;
    });
  }

  void onInitAuthLayout(String path) {
    if (path.contains("/auth/register")) {
      onNavigateRegister();
    } else if (path.contains("/auth/login")) {
      onNavigateLogin();
    }
  }

  @override
  Widget build(BuildContext context) {
    final widthScreen = MediaQuery.of(context).size.width;
    final heightScreen = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            child: Container(
              color: AppColors.primaryLight,
              width: widthScreen,
              height: heightScreen,
            ),
          ),
          /* ICONOS VAN AQUI */
          Positioned(
            top: 100,
            left: (widthScreen * 0.5) - 30,
            child: CustomButton(
              title: "Hola",
              onPressed: toggleModal,
              variant: ButtonVariant.secondary,
            ),
          ),
          percentageMoved == 1
              ? Positioned(
                bottom: 100,
                left: widthScreen * ((1 - 0.85) / 2),
                child: SizedBox(
                  width: widthScreen * 0.85,
                  child: Column(
                    spacing: 25,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Image.asset(
                          "assets/images/appIcon.png",
                          height: 150,
                        ),
                      ),
                      Font(
                        align: TextAlign.center,
                        size: "base", // Usa tu escala tipográfica
                        color: AppColorKey.white, // Usa tu sistema de colores
                        style: TextStyle(fontWeight: FontWeight.w600),
                        text:
                            "Labore cillum irure tempor in mollit laborum labore mollit. Id incididunt cupidatat anim mollit. Laborum irure adipisicing duis laboris culpa officia aute aliquip id. Aliqua nisi do proident in minim do irure excepteur laboris ad velit dolor ex esse.",
                      ),
                      Column(
                        spacing: 10,
                        children: [
                          CustomButton(
                            title: "Iniciar Sesion",
                            onPressed: onNavigateLogin,
                            variant: ButtonVariant.secondary,
                          ),
                          CustomButton(
                            title: "Crear una cuenta nueva",
                            onPressed: onNavigateRegister,
                            variant: ButtonVariant.alternate,
                          ),
                        ],
                      ),
                      /* Separator(
                          thickness: 2,
                          color: AppColorKey.dividerLight,
                          label: "O",
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () {
                                debugPrint("Hola Google");
                              },
                              icon: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppColors.white,

                                  boxShadow: [
                                    BoxShadow(
                                      color: Color.fromRGBO(50, 50, 93, 0.25),
                                      blurRadius: 27,
                                      spreadRadius: -5,
                                      offset: Offset(0, 13),
                                    ),
                                    BoxShadow(
                                      color: Color.fromRGBO(0, 0, 0, 0.3),
                                      blurRadius: 16,
                                      spreadRadius: -8,
                                      offset: Offset(0, 8),
                                    ),
                                  ],
                                ),
                                child: Image.asset(
                                  "assets/images/googleIcon.png",
                                  width: 40,
                                  height: 40,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                debugPrint("Hola Facebook");
                              },
                              icon: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppColors.white,

                                  boxShadow: [
                                    BoxShadow(
                                      color: Color.fromRGBO(50, 50, 93, 0.25),
                                      blurRadius: 27,
                                      spreadRadius: -5,
                                      offset: Offset(0, 13),
                                    ),
                                    BoxShadow(
                                      color: Color.fromRGBO(0, 0, 0, 0.3),
                                      blurRadius: 16,
                                      spreadRadius: -8,
                                      offset: Offset(0, 8),
                                    ),
                                  ],
                                ),
                                child: Image.asset(
                                  "assets/images/facebookIcon.png",
                                  width: 40,
                                  height: 40,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                debugPrint("Hola Apple");
                              },
                              icon: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppColors.white,

                                  boxShadow: [
                                    BoxShadow(
                                      color: Color.fromRGBO(50, 50, 93, 0.25),
                                      blurRadius: 27,
                                      spreadRadius: -5,
                                      offset: Offset(0, 13),
                                    ),
                                    BoxShadow(
                                      color: Color.fromRGBO(0, 0, 0, 0.3),
                                      blurRadius: 16,
                                      spreadRadius: -8,
                                      offset: Offset(0, 8),
                                    ),
                                  ],
                                ),
                                child: Image.asset(
                                  "assets/images/appleIcon.png",
                                  width: 40,
                                  height: 40,
                                ),
                              ),
                            ),
                          ],
                        ), */
                    ],
                  ),
                ),
              )
              : Container(),
          Positioned(
            bottom: 0,
            child: AnimatedSlide(
              offset: Offset(0, percentageMoved),
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutCubic,
              child: Container(
                clipBehavior: Clip.antiAlias,
                width: widthScreen,
                height: heightScreen * 0.7,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                  color: Colors.white,
                ),
                child: widget.child,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
