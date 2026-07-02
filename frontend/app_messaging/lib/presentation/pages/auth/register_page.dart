import 'package:flutter/material.dart';
import 'package:app_messaging/core/constants/colors.dart';
import 'package:app_messaging/core/constants/sizes.dart';
import 'package:app_messaging/core/widgets/input_text.dart';
import 'package:app_messaging/core/widgets/button_primary.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLoginPressed() {
    // TODO: brancher la logique d'authentification
  }

  void _onLoginAccountPressed() {
    // naviguer vers l'écran d'inscription
    context.goNamed('login');
  }

  void _onGoogleRegisterPressed() {
    // TODO: connexion via Google
  }

  void _onFacebookRegisterPressed() {
    // TODO: connexion via Facebook
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.defaultPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 48),
              _buildLogo(),
              const SizedBox(height: 32),
              _buildTitle(),
              const SizedBox(height: 8),
              _buildSubtitle(),
              const SizedBox(height: 32),
              _buildFieldLabel('Email ou numéro téléphone'),
              const SizedBox(height: 8),
              InputText(
                label: 'example@gmail.com',
                controller: _emailController,
                variant: InputTextVariant.simple,
                isEmail: true,
              ),
              const SizedBox(height: 24),
              _buildFieldLabel('Mot de passe'),
              const SizedBox(height: 8),
              InputText(
                label: 'Mot de passe',
                controller: _passwordController,
                variant: InputTextVariant.passwordHidden,
              ),
              const SizedBox(height: 24),
              _buildFieldLabel('Confirmer mot de passe'),
              const SizedBox(height: 8),
              InputText(
                label: 'Confirmer mot de passe',
                controller: _passwordController,
                variant: InputTextVariant.passwordHidden,
              ),
              const SizedBox(height: 24),
              ButtonPrimary(text: 'Créer compte', onPressed: _onLoginPressed),
              const SizedBox(height: 20),
              _buildCreateAccountRow(),
              const SizedBox(height: 28),
              _buildDividerWithText('or'),
              const SizedBox(height: 24),
              _buildSocialButtonsRow(),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Center(child: SvgPicture.asset('assets/splash_screen.svg'));
  }

  Widget _buildTitle() {
    return SizedBox(
      width: double.infinity,
      child: RichText(
        textAlign: TextAlign.center,
        text: const TextSpan(
          style: TextStyle(
            fontSize: AppSizes.textSizeExtraLarge,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
          children: [
            TextSpan(text: 'Bienvenue dans '),
            TextSpan(
              text: 'Hifandray',
              style: TextStyle(color: AppColors.primary),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubtitle() {
    return const SizedBox(
      width: double.infinity,
      child: Text(
        "Rejoignez-nous pour poursuivre la conversation",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: AppSizes.textSizeMedium,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }

  Widget _buildFieldLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: AppSizes.textSizeMedium,
        color: AppColors.textPrimary,
      ),
    );
  }

  Widget _buildCreateAccountRow() {
    return Center(
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Vous avez un compte? ",
              style: TextStyle(
                fontSize: AppSizes.textSizeMedium,
                color: AppColors.textPrimary,
              ),
            ),
            GestureDetector(
              onTap: _onLoginAccountPressed,
              child: const Text(
                'Se connecter',
                style: TextStyle(
                  fontSize: AppSizes.textSizeMedium,
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDividerWithText(String text) {
    return Row(
      children: [
        const Expanded(child: Divider(color: AppColors.divider)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            text,
            style: const TextStyle(
              fontSize: AppSizes.textSizeMedium,
              color: AppColors.textPrimary,
            ),
          ),
        ),
        const Expanded(child: Divider(color: AppColors.divider)),
      ],
    );
  }

  Widget _buildSocialButtonsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _SocialButton(
          onTap: _onGoogleRegisterPressed,
          child: SvgPicture.asset(
            'assets/social/google.svg',
            width: 28,
            height: 28,
          ),
        ),
        const SizedBox(width: 20),
        _SocialButton(
          onTap: _onFacebookRegisterPressed,
          child: SvgPicture.asset(
            'assets/social/facebook.svg',
            width: 28,
            height: 28,
          ),
        ),
      ],
    );
  }
}

/// Bouton social circulaire réutilisable (Google, Facebook, etc.)
class _SocialButton extends StatelessWidget {
  final VoidCallback onTap;
  final Widget child;

  const _SocialButton({required this.onTap, required this.child});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      customBorder: const CircleBorder(),
      child: Container(
        width: 56,
        height: 56,
        decoration: const BoxDecoration(
          color: AppColors.socialButtonBg,
          shape: BoxShape.circle,
        ),
        child: Center(child: child),
      ),
    );
  }
}
