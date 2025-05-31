part of '../pages/home_page.dart';

class HomeController extends State<HomePage> {
  Widget builder(AppShortcut my) => const Placeholder();

  @override
  Widget build(BuildContext context) => builder(AppShortcut.of(context));
}
