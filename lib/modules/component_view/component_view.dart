import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:template_flutter/globals/theme/colors.dart';
import 'package:template_flutter/globals/components/components.dart';
import 'package:template_flutter/stores/message_store.dart';

class ComponentViewScreen extends ConsumerStatefulWidget {
  const ComponentViewScreen({super.key});

  @override
  ConsumerState<ComponentViewScreen> createState() =>
      _ComponentViewScreenState();
}

class _ComponentViewScreenState extends ConsumerState<ComponentViewScreen> {
  // Estado del CheckBox
  bool checkBoxValue = false;

  // Manejo de error InputField
  String textValue = "";
  String? textError;

  // Manejo de error PhoneField
  String phoneValue = "";
  String? phoneError;

  // Estado local progress bar
  int progressStep = 0;

  //mostrar contraseña
  bool showPass = false;

  //estado del modal
  bool isModalOpen = false;
  CustomModalAnimation modalAnimation = CustomModalAnimation.fade;

  // Estado para DateField
  DateTime? selectedDate;

  // Estado para PhoneField
  String phoneNumber = "";

  // Estado para SelectField
  SelectItemOption<String>? selectedCountry;

  //estado seleccionado tabs
  int selectedTabInSelector = 0;

  // Controlador para input del message
  final TextEditingController urlController = TextEditingController();

  // Título de sección
  Widget sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Font(
        text: text,
        size: "lg",
        fontVariant: "RobotoBold",
        color: AppColorKey.primary,
      ),
    );
  }

  // Divider visual entre secciones
  Widget sectionDivider() => const Divider(thickness: 1, height: 32);

  @override
  Widget build(BuildContext context) {
    // Notifier global del Message
    final messageStore = ref.watch(messageStoreProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Font(
          text: "Components Preview",
          size: "2xl",
          color: AppColorKey.primary,
          fontVariant: "RobotoBold",
        ),
      ),

      body: Stack(
        children: [
          SafeArea(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // ================= CheckBox =================
                sectionTitle("CheckBox"),
                CheckBox(
                  checked: checkBoxValue,
                  onChange: (v) => setState(() => checkBoxValue = v),
                  child: Font(
                    text: "Opción de prueba",
                    size: "lg",
                    fontVariant: "RobotoRegular",
                    color: AppColorKey.black,
                  ),
                ),
                sectionDivider(),

                // ================= CustomButton =================
                sectionTitle("CustomButton"),
                CustomButton(
                  title: "Primary Button",
                  variant: ButtonVariant.primary,
                  onPressed: () {},
                ),

                const SizedBox(height: 10),
                CustomButton(
                  title: "Secondary Button",
                  variant: ButtonVariant.secondary,
                  onPressed: () {},
                ),

                const SizedBox(height: 10),
                CustomButton(
                  title: "Outline Button",
                  variant: ButtonVariant.outline,
                  onPressed: () {},
                ),

                const SizedBox(height: 10),
                CustomButton(
                  title: "Outline Secondary",
                  variant: ButtonVariant.outlineSecondary,
                  onPressed: () {},
                ),

                const SizedBox(height: 10),
                CustomButton(title: "Disabled Button", disabled: true),
                sectionDivider(),

                // ================= CustomModal =================
                sectionTitle("CustomModal"),
                CustomButton(
                  title: "Fade",
                  variant: ButtonVariant.secondary,
                  onPressed: () {
                    setState(() {
                      modalAnimation = CustomModalAnimation.fade;
                      isModalOpen = true;
                    });
                  },
                ),

                const SizedBox(height: 6),
                CustomButton(
                  title: "Slide",
                  variant: ButtonVariant.outline,
                  onPressed: () {
                    setState(() {
                      modalAnimation = CustomModalAnimation.slide;
                      isModalOpen = true;
                    });
                  },
                ),

                const SizedBox(height: 6),
                CustomButton(
                  title: "Zoom",
                  variant: ButtonVariant.outlineSecondary,
                  onPressed: () {
                    setState(() {
                      modalAnimation = CustomModalAnimation.zoom;
                      isModalOpen = true;
                    });
                  },
                ),
                sectionDivider(),

                // ================= DateField y DateModal =================
                sectionTitle("DateField y DateModal"),
                DateField(
                  title: "Fecha de nacimiento",
                  value: selectedDate,
                  error:
                      selectedDate == null
                          ? "Debe seleccionar una fecha"
                          : null,
                  onChange: (date) {
                    setState(() {
                      selectedDate = date;
                    });
                  },
                ),
                sectionDivider(),

                // ================= Font =================
                sectionTitle("Font"),
                Font(
                  text: "Texto XL Bold",
                  size: "xl",
                  fontVariant: "RobotoBold",
                  color: AppColorKey.primary,
                ),

                const SizedBox(height: 4),
                Font(
                  text: "Texto Small Gray",
                  size: "sm",
                  fontVariant: "RobotoRegular",
                  color: AppColorKey.secondary,
                ),

                const SizedBox(height: 4),
                Font(
                  text: "Texto extra largo que no debe desbordar lorem",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),

                const SizedBox(height: 4),
                Font(
                  text: "¿Olvidaste tu contraseña?",
                  color: AppColorKey.primary,
                  onTap: () {
                    debugPrint("Click!");
                  },
                ),
                sectionDivider(),

                // ================= Headers =================
                sectionTitle("Headers"),
                //variante base
                const Header(title: "Header Base", back: true),

                const SizedBox(height: 12),
                //variante Menu
                const Header(variant: HeaderVariant.menu, title: "Header Menu"),
                sectionDivider(),

                // ================= InputField =================
                sectionTitle("InputField"),
                //variante primary
                InputField(title: "Nombre", placeholder: "Ingresa tu nombre"),

                const SizedBox(height: 12),
                //variante secondary
                InputField(
                  variant: InputFieldVariant.secondary,
                  title: "Correo",
                  placeholder: "correo@ejemplo.com",
                  keyboardType: TextInputType.emailAddress,
                ),

                const SizedBox(height: 12),
                // Password con botón mostrar/ocultar
                InputField(
                  title: "Contraseña",
                  placeholder: "••••••••",
                  obscureText: !showPass,
                  rightIcon: ShowPasswordButton(
                    variant: ShowPasswordButtonVariant.normal,
                    color: AppColorKey.gray,
                    activeColor: AppColorKey.primary,
                    onToggle: (isShown) {
                      setState(() => showPass = isShown);
                    },
                  ),
                ),

                const SizedBox(height: 12),
                // Mensaje de Error
                InputField(
                  title: "Campo con error",
                  placeholder: "Texto inválido",
                  error: textError,
                  onChange: (value) {
                    setState(() {
                      textValue = value;
                      if (value.isNotEmpty) {
                        textError = null;
                      }
                    });
                  },
                ),
                const SizedBox(height: 12),
                CustomButton(
                  title: "Guardar",
                  onPressed: () {
                    setState(() {
                      if (textValue.trim().isEmpty) {
                        textError = "Este campo es obligatorio";
                      }
                    });
                  },
                ),

                const SizedBox(height: 12),
                // Input deshabilitado
                InputField(
                  title: "Código",
                  placeholder: "AUTO",
                  enabled: false,
                ),
                sectionDivider(),

                // ================= Message =================
                sectionTitle("Message"),
                CustomButton(
                  title: "Welcome to Mosaic",
                  variant: ButtonVariant.primary,
                  onPressed: () {
                    messageStore.showMessage(
                      title: "Welcome to Mosaic",
                      body: "Generate beautiful OG images automatically.",
                      image: Image.asset(
                        "assets/images/flutter-logo.png",
                        height: 120,
                      ),
                      buttons: MessageButtons(
                        confirm: MessageAction(
                          text: "Add Website",
                          variant: ButtonVariant.primary,
                          onPressed: () {},
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 10),

                CustomButton(
                  title: "Delete website?",
                  variant: ButtonVariant.primary,
                  onPressed: () {
                    messageStore.showMessage(
                      title: "Delete website?",
                      body: "This action cannot be undone.",
                      image: Image.asset(
                        "assets/images/flutter-logo.png",
                        height: 120,
                      ),
                      buttons: MessageButtons(
                        cancel: MessageAction(
                          text: "Cancel",
                          variant: ButtonVariant.outline,
                          onPressed: () {},
                        ),
                        confirm: MessageAction(
                          text: "Yes, Delete",
                          variant: ButtonVariant.primary,
                          onPressed: () {},
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 10),

                CustomButton(
                  title: "Custom Content",
                  variant: ButtonVariant.secondary,
                  onPressed: () {
                    messageStore.showMessage(
                      image: Image.asset(
                        "assets/images/flutter-logo.png",
                        height: 120,
                      ),
                      title: "Custom Content",
                      body: Column(
                        children: [
                          Font(
                            text: "Este es un widget dentro del body",
                            size: "md",
                            fontVariant: "RobotoRegular",
                            color: AppColorKey.black,
                          ),
                          const SizedBox(height: 10),
                          CustomButton(
                            title: "Click",
                            variant: ButtonVariant.primary,
                            onPressed: () {},
                          ),
                        ],
                      ),
                      buttons: MessageButtons(
                        confirm: MessageAction(
                          text: "OK",
                          variant: ButtonVariant.primary,
                          onPressed: () {},
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 10),

                CustomButton(
                  title: "body con widget",
                  variant: ButtonVariant.primary,
                  onPressed: () {
                    messageStore.showMessage(
                      title: "Enter website URL",
                      image: Image.asset(
                        "assets/images/flutter-logo.png",
                        height: 120,
                      ),
                      body: Column(
                        children: [
                          Font(
                            text: "Add your URL to generate OG images.",
                            size: "md",
                            fontVariant: "RobotoRegular",
                            color: AppColorKey.black,
                            align: TextAlign.center,
                          ),

                          const SizedBox(height: 16),

                          InputField(
                            title: "Website URL",
                            placeholder: "https://example.com",
                            controller: urlController,
                          ),
                        ],
                      ),
                      buttons: MessageButtons(
                        cancel: MessageAction(
                          text: "Cancel",
                          variant: ButtonVariant.outline,
                          onPressed: () {},
                        ),
                        confirm: MessageAction(
                          text: "Generate",
                          variant: ButtonVariant.primary,
                          onPressed: () {
                            debugPrint("URL: ${urlController.text}");
                          },
                        ),
                      ),
                    );
                  },
                ),
                sectionDivider(),

                // ================= PhoneField =================
                sectionTitle("PhoneField"),
                PhoneField(
                  title: "Teléfono",
                  placeholder: "Ingresa tu teléfono",
                  variant: SelectFieldVariant.secondary,
                  onChange: (v) => debugPrint("PHONE: $v"),
                ),

                const SizedBox(height: 15),
                PhoneField(
                  title: "Teléfono",
                  placeholder: "Ingresa tu teléfono",
                  variant: SelectFieldVariant.primary,
                  onChange: (v) => debugPrint("PHONE: $v"),
                ),
                sectionDivider(),

                // ================= ProgressBar =================
                sectionTitle("ProgressBar"),
                ProgressBar(
                  currentStep: progressStep,
                  steps: ["Inicio", "Datos", "Confirmar"],
                  onStepPress: (i, label) {
                    setState(() {
                      progressStep = i;
                    });
                  },
                ),
                sectionDivider(),

                // ================= SelectField =================
                sectionTitle("SelectField"),
                SelectField<String>(
                  options: const [
                    SelectItemOption(label: "Opción A", value: "a"),
                    SelectItemOption(label: "Opción B", value: "b"),
                    SelectItemOption(label: "Opción C", value: "c"),
                  ],
                  value: selectedCountry,
                  onChange: (option) {
                    setState(() => selectedCountry = option);
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text("Seleccionado: ${selectedCountry?.label ?? '-'}"),
                ),
                sectionDivider(),

                // ================= Separator =================
                sectionTitle("Separator"),

                Separator(
                  variant: SeparatorVariant.thin,
                  color: AppColorKey.gray,
                ),

                const SizedBox(height: 20),

                Separator(
                  variant: SeparatorVariant.thick,
                  color: AppColorKey.primary,
                ),

                const SizedBox(height: 20),

                Separator(
                  variant: SeparatorVariant.faded,
                  color: AppColorKey.secondary,
                  opacity: 0.4,
                ),

                const SizedBox(height: 20),

                Row(
                  children: [
                    Font(
                      text: "A",
                      size: "md",
                      fontVariant: "RobotoRegular",
                      color: AppColorKey.black,
                    ),

                    Separator(
                      variant: SeparatorVariant.thin,
                      vertical: true,
                      color: AppColorKey.primary,
                      height: 30,
                    ),

                    Font(
                      text: "B",
                      size: "md",
                      fontVariant: "RobotoRegular",
                      color: AppColorKey.black,
                    ),
                  ],
                ),
                sectionDivider(),

                // ================= ShowPasswordButton =================
                sectionTitle("ShowPasswordButton"),
                ShowPasswordButton(
                  variant: ShowPasswordButtonVariant.normal,
                  color: AppColorKey.gray,
                  activeColor: AppColorKey.primary,
                  onToggle: (_) {},
                ),

                const SizedBox(height: 16),

                ShowPasswordButton(
                  variant: ShowPasswordButtonVariant.accent,
                  color: AppColorKey.secondary,
                  activeColor: AppColorKey.primary,
                  onToggle: (_) {},
                ),

                const SizedBox(height: 16),

                ShowPasswordButton(
                  variant: ShowPasswordButtonVariant.thin,
                  color: AppColorKey.black,
                  onToggle: (_) {},
                ),

                const SizedBox(height: 16),

                ShowPasswordButton(
                  variant: ShowPasswordButtonVariant.bold,
                  color: AppColorKey.primary,
                  activeColor: AppColorKey.secondary,
                  onToggle: (_) {},
                ),

                InputField(
                  title: "Contraseña",
                  placeholder: "••••••••",
                  obscureText: !showPass,
                  rightIcon: ShowPasswordButton(
                    variant: ShowPasswordButtonVariant.normal,
                    color: AppColorKey.gray,
                    activeColor: AppColorKey.primary,
                    onToggle: (isShown) {
                      setState(() => showPass = isShown);
                    },
                  ),
                ),
                sectionDivider(),

                // ================= SplashScreen =================
                sectionTitle("SplashScreen"),
                CustomButton(
                  title: "Ver SplashScreen",
                  variant: ButtonVariant.primary,
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const SplashScreen()),
                    );
                  },
                ),
                sectionDivider(),

                // ================= Tabs =================
                sectionTitle("Tabs"),
                Tabs(
                  tabs: const ["Primero", "Segundo", "Tercero"],
                  variant: TabsVariant.primary,
                  animatedContent: true,
                  onTabChange: (index, label) {
                    debugPrint("Cambió a: $label ($index)");
                  },
                  children: const [
                    Center(
                      child: Font(
                        text: "Contenido del primer tab",
                        size: "lg",
                        fontVariant: "RobotoBold",
                        color: AppColorKey.primary,
                      ),
                    ),
                    Center(
                      child: Font(
                        text: "Contenido del segundo tab",
                        size: "lg",
                        fontVariant: "RobotoBold",
                        color: AppColorKey.primary,
                      ),
                    ),
                    Center(
                      child: Font(
                        text: "Contenido del tercer tab",
                        size: "lg",
                        fontVariant: "RobotoBold",
                        color: AppColorKey.primary,
                      ),
                    ),
                  ],
                ),
                sectionDivider(),

                // ================= TabsSelector =================
                sectionTitle("TabsSelector"),
                TabsSelector(
                  tabs: const ["Primero", "Segundo", "Tercero"],
                  variant: TabsVariant.primary,
                  active: selectedTabInSelector,
                  onChange: (index, label) {
                    setState(() => selectedTabInSelector = index);
                    debugPrint("Seleccionado: $label ($index)");
                  },
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),

          // ==== render del modal ====
          CustomModal(
            isOpen: isModalOpen,
            onClose: () => setState(() => isModalOpen = false),
            animation: modalAnimation,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Font(
                  text: "Hola desde el modal",
                  size: "lg",
                  fontVariant: "RobotoBold",
                  color: AppColorKey.black,
                ),
                const SizedBox(height: 16),
                CustomButton(
                  title: "Cerrar",
                  variant: ButtonVariant.primary,
                  onPressed: () => setState(() => isModalOpen = false),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
