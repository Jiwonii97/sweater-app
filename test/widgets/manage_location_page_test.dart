import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:sweater/main.dart';
import 'package:sweater/pages/manage_location_page.dart';
import 'package:flutter/material.dart';
import 'package:sweater/providers/coordi_provider.dart';
import 'package:sweater/providers/location_provider.dart';
import 'package:sweater/providers/user_provider.dart';
import 'package:sweater/providers/weather_provider.dart';
import 'package:sweater/theme/global_theme.dart';

void main() {
  //   testWidgets('위치 관리 페이지로 이동', (WidgetTester tester) async {
  //   //위치를 20정도 추가한다.
  //   //스크롤을 아래로 내린다.
  //   //마지막 위치를 클릭해
  //   //위치 정보가 바뀌면 성공 (shared_preperence가 바뀜을 확인)
  //   await tester.pumpWidget(const MyApp());
  //   expect(find.text("SWEATER"), findsOneWidget); // appbar의 SWEATER 글자를 발견
  //   await tester.tap(find.descendant(
  //       of: find.byType(AppBar),
  //       matching:
  //           find.byType(IconButton))); //appbar의 iconButton을 tap -> drawer를 켬
  //   expect(find.byType(Drawer), findsOneWidget); // drawer 발견
  //   expect(
  //       find.descendant(
  //           of: find.byType(Drawer), matching: find.byType(ListTile)),
  //       findsNWidgets(3)); // 3개의 메뉴 발견
  //   await tester.tap(find.byType(ListTile).at(0)); //3개의 메뉴 중 첫 번째를 클릭
  //   expect(find.text("위치 관리"), findsOneWidget); // 위치 관리 페이지로 넘어왔고 위치 관리 텍스트가 보임
  //   // expect('true', 'true');
  // });
  testWidgets('위치 관리 페이지 스크롤 기능', (WidgetTester tester) async {
    //위치를 20정도 추가한다.
    //스크롤을 아래로 내린다.
    //마지막 위치를 클릭해
    //위치 정보가 바뀌면 성공 (shared_preperence가 바뀜을 확인)
    // testWidgets('go to ')
    final locationProvider = LocationProvider();
    await tester.pumpWidget(MultiProvider(
        providers: [
          ChangeNotifierProvider<UserProvider>(
              create: (context) => UserProvider()),
          ChangeNotifierProvider<CoordiProvider>(
              create: (context) => CoordiProvider()),
          ChangeNotifierProvider<WeatherProvider>(
              create: (context) => WeatherProvider()),
          ChangeNotifierProvider<LocationProvider>(
              create: (context) => locationProvider),
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: GlobalTheme.lightTheme,
            home: const ManageLocationPage())));
    locationProvider.expect(find.text('위치 관리'), findsOneWidget);
  });

  test('상단 액션 클릭시 페이지 이동', () {
    //상단 우측 + 액션을 클릭시 위치 추가 페이지로 이동한다.
  });

  test('뒤로가기 누를 시 홈으로 이동', () {
    //상단 왼쪽 <- 리딩 클릭시 홈 페이지로 이동한다.
  });

  test('저장된 위치 불러오기', () {
    //shared_preperence에서 위치 정보를 불러와 리스트로 띄운다.
    //5개의 위치를 저장해놓고, 5개의 리스트가 뜨면 성공
  });
  test('위치 선택 기능', () {
    //위치 정보를 불러와 리스트로 띄우고, 그 중 하나를 선택한다.
    //선택시 현재 위치가 바뀐다
    //shared_preperence에 저장된 값이 바뀐다.
  });

  test('최초 앱 실행시 동작구로 위치가 설정되어 있어야한다.', () {
    //shared_preperence가 비어있을 때
    //default로 동작구가 추가되어있고,
    //동작구가 선택되어 있어야한다.
  });

  test('위치 삭제', () {
    //위치를 20정도 추가한다.
    //위치 리스트 하나를 슬라이드한다.
    //슬라이드 후 우측의 삭제 버튼이 드러나며,
    //삭제 버튼을 클릭한다.

    //요소가 삭제되면  성공
  });

  test('현재 선택된 위치는 삭제되지 않게 한다.', () {
    //현재 선택되어 있는 위치가 슬라이드 되지 않으면 성공
  });
}
