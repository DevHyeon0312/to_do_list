enum AppRoute {
  main(
    name: '/',
    canPop: false,
  );

  const AppRoute({required this.name, required this.canPop,});

  final String name;
  final bool canPop;
}