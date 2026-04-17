import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/router/route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/extensions/context_extensions.dart';
import '../../../../core/utils/extensions/string_extensions.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_text_field.dart';
import '../providers/auth_provider.dart';

class LoginPage extends HookConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final formKey = useMemoized(GlobalKey<FormState>.new);
    final isPasswordVisible = useState(false);

    final authState = ref.watch(authNotifierProvider);

    // Listen for errors
    ref.listen(authNotifierProvider, (previous, next) {
      next.maybeWhen(
        error: (message) => context.showSnackBar(message, isError: true),
        authenticated: (_) => context.go(RouteNames.dashboard),
        orElse: () {},
      );
    });

    // final isLoading = authState is _Loading;
    const isLoading = true;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),

                // Logo & Header
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(
                    Icons.trending_up_rounded,
                    size: 36,
                    color: AppColors.white,
                  ),
                ),
                const SizedBox(height: 32),
                Text('Welcome back', style: context.textTheme.headlineMedium),
                const SizedBox(height: 8),
                Text(
                  'Sign in to manage your sales',
                  style: context.textTheme.bodyLarge,
                ),
                const SizedBox(height: 40),

                // Email Field
                AppTextField(
                  controller: emailController,
                  label: 'Email address',
                  hint: 'you@company.com',
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: Icons.email_outlined,
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Email is required';
                    if (!value.isValidEmail) return 'Enter a valid email address';
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Password Field
                AppTextField(
                  controller: passwordController,
                  label: 'Password',
                  hint: '••••••••',
                  obscureText: !isPasswordVisible.value,
                  prefixIcon: Icons.lock_outline,
                  suffixIcon: IconButton(
                    icon: Icon(
                      isPasswordVisible.value
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: AppColors.grey400,
                    ),
                    onPressed: () =>
                        isPasswordVisible.value = !isPasswordVisible.value,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Password is required';
                    if (value.length < 6) return 'Password must be at least 6 characters';
                    return null;
                  },
                ),
                const SizedBox(height: 12),

                // Forgot Password
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: const Text('Forgot password?'),
                  ),
                ),
                const SizedBox(height: 24),

                // Sign In Button
                AppButton(
                  label: 'Sign In',
                  isLoading: isLoading,
                  onPressed: () {
                    if (formKey.currentState?.validate() ?? false) {
                      context.hideKeyboard();
                      ref.read(authNotifierProvider.notifier).signIn(
                            email: emailController.text.trim(),
                            password: passwordController.text,
                          );
                    }
                  },
                ),
                const SizedBox(height: 32),

                // Footer
                Center(
                  child: Text(
                    'Contact your administrator for access',
                    style: AppTextStyles.bodySmall,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
