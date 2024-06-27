enum AppRoute {
  main(
    name: '/',
    canPop: false,
  ),
  taskDetail(
    name: '/task_detail',
    canPop: true,
  );

  const AppRoute({required this.name, required this.canPop,});

  final String name;
  final bool canPop;
}