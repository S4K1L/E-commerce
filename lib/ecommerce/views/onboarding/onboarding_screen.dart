import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/app_colors.dart';
import '../../config/app_routes.dart';
import '../../config/app_text_styles.dart';

class _OnboardingPage {
  final String title;
  final List<String> highlight;
  final String description;
  final Widget visual;
  const _OnboardingPage({
    required this.title,
    required this.highlight,
    required this.description,
    required this.visual,
  });
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _index = 0;

  late final List<_OnboardingPage> _pages = [
    _OnboardingPage(
      title: 'Your Shopping Destination for Everything',
      highlight: const ['Shopping', 'Everything'],
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt.',
      visual: _GridVisual(images: const [
        'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=300&q=80',
        'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=300&q=80',
        'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=300&q=80',
        'https://images.unsplash.com/photo-1551488831-00ddcb6c6bd3?w=300&q=80',
        'https://images.unsplash.com/photo-1592286927505-1def25115558?w=300&q=80',
        'https://images.unsplash.com/photo-1523170335258-f5ed11844a49?w=300&q=80',
      ]),
    ),
    _OnboardingPage(
      title: 'Seamless Shopping Experience',
      highlight: const ['Seamless'],
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt.',
      visual: const _PhoneVisual(
        image:
            'https://images.unsplash.com/photo-1483985988355-763728e1935b?w=600&q=80',
      ),
    ),
    _OnboardingPage(
      title: 'Wishlist to Dream Product, in Just a Few Clicks',
      highlight: const ['Wishlist', 'Dream'],
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt.',
      visual: const _PhoneVisual(
        image:
            'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=600&q=80',
      ),
    ),
    _OnboardingPage(
      title: 'Swift and Reliable Delivery',
      highlight: const ['Swift', 'Reliable'],
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt.',
      visual: const _PhoneVisual(
        image:
            'https://images.unsplash.com/photo-1556742393-d75f468bfcb0?w=600&q=80',
      ),
    ),
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _next() {
    if (_index >= _pages.length - 1) {
      Get.offAllNamed<void>(Routes.signIn);
      return;
    }
    _controller.nextPage(
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
    );
  }

  void _previous() {
    if (_index == 0) return;
    _controller.previousPage(
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Get.offAllNamed<void>(Routes.signIn),
                    child: Text('Skip',
                        style: AppTextStyles.subtitle
                            .copyWith(color: AppColors.textPrimary)),
                  ),
                ],
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: _pages.length,
                onPageChanged: (i) => setState(() => _index = i),
                itemBuilder: (_, i) {
                  final page = _pages[i];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        Expanded(child: Center(child: page.visual)),
                        const SizedBox(height: 24),
                        _HighlightedTitle(
                            text: page.title, highlight: page.highlight),
                        const SizedBox(height: 12),
                        Text(
                          page.description,
                          textAlign: TextAlign.center,
                          style: AppTextStyles.body
                              .copyWith(color: AppColors.textSecondary),
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Row(
                children: [
                  _CircleArrowButton(
                    icon: Icons.arrow_back,
                    filled: false,
                    onTap: _previous,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(_pages.length, (i) {
                        final active = i == _index;
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          margin:
                              const EdgeInsets.symmetric(horizontal: 4),
                          width: active ? 24 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: active
                                ? AppColors.primary
                                : AppColors.primaryLight,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        );
                      }),
                    ),
                  ),
                  const SizedBox(width: 16),
                  _CircleArrowButton(
                    icon: Icons.arrow_forward,
                    filled: true,
                    onTap: _next,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HighlightedTitle extends StatelessWidget {
  final String text;
  final List<String> highlight;
  const _HighlightedTitle({required this.text, required this.highlight});

  @override
  Widget build(BuildContext context) {
    final spans = <TextSpan>[];
    final words = text.split(' ');
    for (var i = 0; i < words.length; i++) {
      final word = words[i];
      final isHi = highlight.any((h) =>
          word.toLowerCase().contains(h.toLowerCase()));
      spans.add(TextSpan(
        text: i == words.length - 1 ? word : '$word ',
        style: AppTextStyles.h2.copyWith(
          color: isHi ? AppColors.primary : AppColors.textPrimary,
          fontWeight: FontWeight.w700,
        ),
      ));
    }
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(children: spans),
    );
  }
}

class _CircleArrowButton extends StatelessWidget {
  final IconData icon;
  final bool filled;
  final VoidCallback onTap;
  const _CircleArrowButton({
    required this.icon,
    required this.filled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: filled ? AppColors.primary : Colors.white,
          border: Border.all(color: AppColors.primary, width: 1.4),
          boxShadow: filled
              ? [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.3),
                    blurRadius: 14,
                    offset: const Offset(0, 6),
                  )
                ]
              : null,
        ),
        child: Icon(icon,
            color: filled ? Colors.white : AppColors.primary, size: 22),
      ),
    );
  }
}

class _GridVisual extends StatelessWidget {
  final List<String> images;
  const _GridVisual({required this.images});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      children: List.generate(images.length, (i) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: AspectRatio(
            aspectRatio: 1,
            child: Container(
              color: AppColors.surface,
              child: CachedNetworkImage(
                imageUrl: images[i],
                fit: BoxFit.cover,
                errorWidget: (_, __, ___) =>
                    Container(color: AppColors.surface),
              ),
            ),
          ),
        );
      }),
    );
  }
}

class _PhoneVisual extends StatelessWidget {
  final String image;
  const _PhoneVisual({required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      height: 460,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.2),
            blurRadius: 30,
            offset: const Offset(0, 10),
          )
        ],
      ),
      padding: const EdgeInsets.all(8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(34),
        child: CachedNetworkImage(
          imageUrl: image,
          fit: BoxFit.cover,
          errorWidget: (_, __, ___) => Container(color: AppColors.surface),
        ),
      ),
    );
  }
}
