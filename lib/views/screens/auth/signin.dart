import 'package:bdm/controllers/auth_controller.dart';
import 'package:bdm/controllers/service_controller.dart';
import 'package:bdm/models/area_model.dart';
import 'package:bdm/services/api_service.dart';
import 'package:bdm/views/base/custom_button.dart';
import 'package:bdm/views/base/custom_networked_image.dart';
import 'package:bdm/views/base/custom_text_field.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:bdm/views/screens/auth/login.dart';
import 'package:bdm/views/screens/auth/welcome.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final auth = Get.find<AuthController>();
  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final conPassCtrl = TextEditingController();
  final shopNameCtrl = TextEditingController();
  final shopAddressCtrl = TextEditingController();
  final areaCtrl = TextEditingController();
  final areaFocusNode = FocusNode();
  final GlobalKey _areaSectionKey = GlobalKey();

  int? area;

  /// GetX's [Get.snackbar] uses `Overlay.of(Get.overlayContext!)`, but on recent
  /// Flutter versions that context can resolve to `_Theater` without an [Overlay]
  /// ancestor (crash after async). [ScaffoldMessenger] avoids that and matches the
  /// usual Get snackbar layout (floating, title + message).
  SnackBar _snackBarFor(String title, String message, {required bool isError}) {
    return SnackBar(
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.fromLTRB(12, 0, 12, 12),
      duration: const Duration(seconds: 4),
      elevation: 6,
      backgroundColor:
          isError
              ? const Color(0xFFB00020).withValues(alpha: 0.95)
              : const Color(0xFF323232).withValues(alpha: 0.95),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            message,
            style: const TextStyle(
              fontSize: 13,
              color: Colors.white,
              height: 1.25,
            ),
          ),
        ],
      ),
    );
  }

  void _routeSnackbar(
    String title,
    String message, {
    bool isError = false,
    BuildContext? snackbarContext,
  }) {
    final target = snackbarContext ?? (mounted ? context : null);
    if (target == null) return;
    final messenger = ScaffoldMessenger.maybeOf(target);
    if (messenger == null) return;
    messenger.clearSnackBars();
    messenger.showSnackBar(_snackBarFor(title, message, isError: isError));
  }

  void _scrollAreaSectionIntoView() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final ctx = _areaSectionKey.currentContext;
      if (ctx != null) {
        Scrollable.ensureVisible(
          ctx,
          alignment: 0.05,
          duration: const Duration(milliseconds: 280),
          curve: Curves.easeOutCubic,
        );
      }
    });
  }

  void _onAreaFocusChanged() {
    setState(() {});
    if (areaFocusNode.hasFocus) {
      _scrollAreaSectionIntoView();
    }
  }

  void _onAreaTextChanged() {
    if (area != null) {
      AreaModel? matched;
      for (final a in auth.areas) {
        if (a.areaId == area) {
          matched = a;
          break;
        }
      }
      if (matched != null && areaCtrl.text != matched.areaName) {
        area = null;
      }
    }
    setState(() {});
    if (areaFocusNode.hasFocus && areaCtrl.text.isNotEmpty) {
      _scrollAreaSectionIntoView();
    }
  }

  int? _resolveAreaId() {
    final trimmed = areaCtrl.text.trim();
    if (trimmed.isEmpty) return null;
    if (area != null) {
      for (final a in auth.areas) {
        if (a.areaId == area &&
            a.areaName.toLowerCase() == trimmed.toLowerCase()) {
          return area;
        }
      }
    }
    final matches =
        auth.areas
            .where((a) => a.areaName.toLowerCase() == trimmed.toLowerCase())
            .toList();
    if (matches.length == 1) return matches.first.areaId;
    return null;
  }

  @override
  void initState() {
    super.initState();
    areaCtrl.addListener(_onAreaTextChanged);
    areaFocusNode.addListener(_onAreaFocusChanged);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final message = await auth.getAreas();
      if (message != "success") {
        _routeSnackbar("error_occurred".tr, message, isError: true);
        await auth.getAreas();
      }
    });
  }

  @override
  void dispose() {
    areaCtrl.removeListener(_onAreaTextChanged);
    areaFocusNode.removeListener(_onAreaFocusChanged);
    nameCtrl.dispose();
    emailCtrl.dispose();
    phoneCtrl.dispose();
    passCtrl.dispose();
    conPassCtrl.dispose();
    shopNameCtrl.dispose();
    shopAddressCtrl.dispose();
    areaCtrl.dispose();
    areaFocusNode.dispose();
    super.dispose();
  }

  void callBack() async {
    final areaId = _resolveAreaId();
    if (areaId == null) {
      _routeSnackbar(
        "error_occurred".tr,
        "shop_area_select_suggestion".tr,
        isError: true,
      );
      return;
    }
    final message = await auth.signup(
      nameCtrl.text,
      emailCtrl.text,
      phoneCtrl.text,
      shopNameCtrl.text,
      shopAddressCtrl.text,
      areaId.toString(),
      passCtrl.text,
      conPassCtrl.text,
    );

    if (message == "success") {
      Get.off(() => Welcome());
      Get.to(() => Login());
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _routeSnackbar(
          "User created successfully",
          "Please Login to your account",
          isError: false,
          snackbarContext: Get.key.currentContext,
        );
      });
    } else {
      _routeSnackbar("error_occurred".tr, message, isError: true);
    }
  }

  Widget _shopAreaAutocomplete(BuildContext context) {
    final areas = auth.areas.toList();
    final q = areaCtrl.text.toLowerCase();
    final filtered =
        q.isEmpty
            ? <AreaModel>[]
            : areas.where((a) => a.areaName.toLowerCase().contains(q)).toList();
    final showSuggestions =
        areaFocusNode.hasFocus &&
        areaCtrl.text.isNotEmpty &&
        filtered.isNotEmpty;

    return Column(
      key: _areaSectionKey,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(
            "shop_area".tr,
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
          ),
        ),
        Builder(
          builder: (context) {
            final isFocused = areaFocusNode.hasFocus;
            return Container(
              height: 56,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color:
                      isFocused
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).dividerColor,
                  width: isFocused ? 1.0 : 0.5,
                ),
                boxShadow: [
                  if (isFocused)
                    BoxShadow(
                      color: Theme.of(
                        context,
                      ).primaryColor.withValues(alpha: 0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                ],
              ),
              child: Row(
                spacing: 12,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/icons/location.svg",
                    height: 20,
                    width: 20,
                    colorFilter: ColorFilter.mode(
                      isFocused
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).iconTheme.color ?? Colors.grey,
                      BlendMode.srcIn,
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      controller: areaCtrl,
                      focusNode: areaFocusNode,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                        hintText: "shop_area_hint".tr,
                        hintStyle: TextStyle(
                          color: Theme.of(context).textTheme.bodySmall?.color,
                        ),
                      ),
                      cursorColor: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        if (showSuggestions) ...[
          const SizedBox(height: 8),
          Material(
            elevation: 2,
            borderRadius: BorderRadius.circular(12),
            color: Theme.of(context).cardColor,
            clipBehavior: Clip.antiAlias,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 220),
              child: ListView.separated(
                shrinkWrap: true,
                primary: false,
                physics: const ClampingScrollPhysics(),
                padding: const EdgeInsets.symmetric(vertical: 4),
                itemCount: filtered.length,
                separatorBuilder:
                    (_, __) => Divider(
                      height: 1,
                      color: Theme.of(context).dividerColor,
                    ),
                itemBuilder: (context, index) {
                  final a = filtered[index];
                  return ListTile(
                    dense: true,
                    title: Text(a.areaName),
                    onTap: () {
                      setState(() {
                        area = a.areaId;
                        areaCtrl.text = a.areaName;
                        areaCtrl.selection = TextSelection.collapsed(
                          offset: areaCtrl.text.length,
                        );
                      });
                      areaFocusNode.unfocus();
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final keyboardBottom = MediaQuery.viewInsetsOf(context).bottom;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Align(
          alignment: Alignment.center,
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 0, 16, 16 + keyboardBottom),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 24),
                  Obx(() {
                    final service = Get.find<ServiceController>();
                    if (service.serviceInfo.value != null) {
                      return CustomNetworkedImage(
                        url: ApiService.getImage(
                          service.serviceInfo.value!.logo,
                        ),
                        height: 120,
                        width: 120,
                        baseColor: Colors.transparent,
                        errorWidget: Container(),
                      );
                    }
                    return Container();
                  }),
                  const SizedBox(height: 24, width: double.infinity),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "signin".tr,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "signin2".tr,
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      border: Border.all(
                        width: 0.5,
                        color: Theme.of(context).dividerColor,
                      ),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).shadowColor,
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      spacing: 12,
                      children: [
                        CustomTextField(
                          title: "signin3".tr,
                          hintText: "signin4".tr,
                          controller: nameCtrl,
                          leading: "assets/icons/profile.svg",
                        ),
                        CustomTextField(
                          title: "signin5".tr,
                          hintText: "signin6".tr,
                          controller: emailCtrl,
                          leading: "assets/icons/email.svg",
                        ),
                        CustomTextField(
                          title: "singin7".tr,
                          hintText: "singin8".tr,
                          controller: phoneCtrl,
                          leading: "assets/icons/phone.svg",
                        ),
                        CustomTextField(
                          leading: "assets/icons/lock.svg",
                          title: "signin9".tr,
                          hintText: "signin10".tr,
                          controller: passCtrl,
                          isPassword: true,
                        ),
                        CustomTextField(
                          leading: "assets/icons/lock.svg",
                          title: "signin11".tr,
                          hintText: "signin12".tr,
                          controller: conPassCtrl,
                          isPassword: true,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "signin13".tr,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      border: Border.all(
                        width: 0.5,
                        color: Theme.of(context).dividerColor,
                      ),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).shadowColor,
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      spacing: 12,
                      children: [
                        CustomTextField(
                          title: "shop_name".tr,
                          hintText: "shop_name_hint".tr,
                          controller: shopNameCtrl,
                          leading: "assets/icons/shop.svg",
                        ),
                        CustomTextField(
                          title: "shop_address".tr,
                          hintText: "shop_address_hint".tr,
                          controller: shopAddressCtrl,
                          leading: "assets/icons/home.svg",
                        ),
                        Obx(() => _shopAreaAutocomplete(context)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  Obx(() {
                    return CustomButton(
                      text: "Register".tr,
                      onTap: callBack,
                      isLoading: auth.isLoading.value,
                    );
                  }),
                  const SizedBox(height: 12),
                  Row(
                    spacing: 4,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account?".tr,
                        style: TextStyle(fontSize: 12),
                      ),
                      InkWell(
                        onTap: () {
                          Get.off(() => Login());
                        },
                        child: Text(
                          "Log In".tr,
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
