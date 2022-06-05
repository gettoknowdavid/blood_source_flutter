import 'package:blood_source/app/app.locator.dart';
import 'package:blood_source/app/app.router.dart';
import 'package:blood_source/common/app_colors.dart';
import 'package:blood_source/models/dashboard_button_model.dart';
import 'package:blood_source/models/request.dart';
import 'package:blood_source/models/request_user.dart';
import 'package:blood_source/models/user-type.dart';
import 'package:blood_source/models/user_location.dart';
import 'package:blood_source/services/auth_service.dart';
import 'package:blood_source/services/store_service.dart';
import 'package:blood_source/models/blood_source_user.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:uuid/uuid.dart';

class DashboardViewModel extends ReactiveViewModel with ReactiveServiceMixin {
  DashboardViewModel() {
    listenToReactiveValues([_buttonList]);
  }

  Future<void> init() async {
    setBusy(true);
    final result = await getList();
    _buttonList.value = result;
    setBusy(false);
  }

  final AuthService _authService = locator<AuthService>();
  final StoreService _storeService = locator<StoreService>();
  final NavigationService _navService = locator<NavigationService>();

  // final ReactiveValue<int> _donorCount = ReactiveValue<int>(0);
  int get donorCount => _storeService.donorCount;
  int get requestCount => _storeService.requestCount;

  final ReactiveValue<List<DashboardButtonModel>> _buttonList =
      ReactiveValue<List<DashboardButtonModel>>(donorButtonList);
  List<DashboardButtonModel> get buttonList => _buttonList.value;

  String get displayName => _authService.currentUser!.displayName!;

  BloodSourceUser get user => _storeService.bloodUser!;

  String get firstName => displayName.toString().split(" ").first;

  Future<List<DashboardButtonModel>> getList() async {
    switch (user.userType) {
      case UserType.donor:
        _buttonList.value = await getDonorButtonList();
        break;
      case UserType.recipient:
        _buttonList.value = await getRecipientButtonList();
        break;
      default:
        _buttonList.value = await getDonorButtonList();
    }
    return _buttonList.value;
  }

  void goToDonors() async {
    final Request request = Request(
      uid: const Uuid().v4(),
      bloodGroup: user.bloodGroup!,
      requestGranted: false,
      showContactInfo: true,
      timeAdded: DateTime.now(),
      user: RequestUser(
        uid: user.uid!,
        name: user.name!,
        avatar: user.avatar!,
        location: UserLocation(
          user.location!.latitude,
          user.location!.longitude,
        ),
      ),
    );

    await _storeService.setRequest(request);

    _navService.navigateTo(
      Routes.donorView,
      arguments: DonorViewArguments(request: request, fromRequestView: false),
    );
  }

  Future<List<DashboardButtonModel>> getDonorButtonList() async {
    await _storeService.getDonorCount();
    await _storeService.getMyRequestCount();

    return <DashboardButtonModel>[
      DashboardButtonModel(
        'Find Requests',
        '$donorCount',
        const Icon(Icons.search, color: AppColors.primary),
        const Color(0xFFFA6393),
        Routes.requestListView,
      ),
      DashboardButtonModel(
        'My Requests',
        '$requestCount',
        const ImageIcon(
          AssetImage('assets/images/bell.png'),
          color: AppColors.primary,
        ),
        const Color(0xFFFA6393),
        Routes.myRequestsListView,
      ),
      DashboardButtonModel(
        'Events',
        'Map',
        const ImageIcon(
          AssetImage('assets/images/blood.png'),
          color: Color(0xFF00CC99),
        ),
        const Color(0xFF00CC99),
        Routes.donateView,
      ),
      DashboardButtonModel(
        'Others',
        'More',
        const ImageIcon(
          AssetImage('assets/images/settings.png'),
          color: Color(0xFF999999),
        ),
        const Color(0xFF999999),
        Routes.donateView,
      ),
    ];
  }

  Future<List<DashboardButtonModel>> getRecipientButtonList() async {
    await _storeService.getDonorCount();
    await _storeService.getMyRequestCount();

    return <DashboardButtonModel>[
      DashboardButtonModel(
        'Find a Donor',
        '$donorCount',
        const Icon(Icons.search, color: AppColors.primary),
        const Color(0xFFFA6393),
        Routes.donorView,
      ),
      DashboardButtonModel(
        'My Requests',
        '$requestCount',
        const ImageIcon(
          AssetImage('assets/images/bell.png'),
          color: AppColors.primary,
        ),
        const Color(0xFFFA6393),
        Routes.myRequestsListView,
      ),
      DashboardButtonModel(
        'Events',
        'Map',
        const ImageIcon(
          AssetImage('assets/images/blood.png'),
          color: Color(0xFF00CC99),
        ),
        const Color(0xFF00CC99),
        Routes.donateView,
      ),
      DashboardButtonModel(
        'Others',
        'More',
        const ImageIcon(
          AssetImage('assets/images/settings.png'),
          color: Color(0xFF999999),
        ),
        const Color(0xFF999999),
        Routes.donateView,
      ),
    ];
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_storeService];
}
