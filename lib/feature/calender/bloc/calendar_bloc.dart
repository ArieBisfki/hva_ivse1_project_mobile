import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:ivse1_gymlife/feature/calender/recources/calendar_repository.dart';

part 'calendar_event.dart';
part 'calendar_state.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  final CalendarRepository calendarRepository;

  CalendarBloc({required this.calendarRepository}) : super(CalendarInitial());

  CalendarState get initialState => CalendarInitial();

  // crazy example
  @override
  Stream<CalendarState> mapEventToState(
    CalendarEvent event,
  ) async* {
    // if (event is ) {
    //   yield CalendarInitial();
    // }
    //   if (event is GetTimeOffEvent) {
    //     yield TimeOffDataState(StateLoading());

    //     await userRepository.fetchAndPersistAllUsers();

    //     if (_categories.isEmpty) {
    //       final categoriesResult =
    //           await timeOffCategoriesRepository.getTimeOffCategories();

    //       if (categoriesResult.status == Status.Error) {
    //         yield TimeOffDataState(StateError(categoriesResult.message));
    //         return;
    //       } else if (categoriesResult.status == Status.Success) {
    //         _categories = categoriesResult.data;
    //       } else {
    //         return; //if not Error or Success status
    //       }
    //     }

    //     final DataResponse<List<TimeOff>> result =
    //         await timeOffRepository.getAllTimeOffs();

    //     switch (result.status) {
    //       case Status.Error:
    //         yield TimeOffDataState(StateError(result.message));
    //         break;
    //       case Status.Loading:
    //         yield TimeOffDataState(StateLoading());
    //         break;
    //       case Status.Success:
    //         if (result == null || result.data == null || result.data.isEmpty) {
    //           yield TimeOffDataState(StateEmpty());
    //         } else {
    //           final filtered = await mapItemWithContextUser(
    //               result.data, userRepository.currentUserInstance);

    //           if (filtered.isEmpty) {
    //             yield TimeOffDataState(StateEmpty());
    //           } else {
    //             _timeOffItems = filtered
    //                 .map((item) => _mapCategoriesToTimeOff(item))
    //                 .toList();
    //             final successState =
    //                 StateSuccess<List<TimeOffWithContextUser>>(_timeOffItems);
    //             yield TimeOffDataState(successState);
    //           }
    //         }
    //         break;
    //       default:
    //         print('Unknow state in ${toString()}: ${state.toString()}');
    //     }
    //   } else if (event is GetTimeOffOnlyEvent) {
    //     final timeOffOnlyItems = _timeOffItems != null
    //         ? _timeOffItems
    //             .where((item) => !item.timeOff.timeOffCategory.isOverTimeCategory)
    //             .where((item) => !item.timeOff.timeOffCategory.isMutationCateogry)
    //             .where((item) => !item.timeOff.timeOffCategory.isHoliday)
    //             .toList()
    //         : <TimeOffWithContextUser>[];

    //     if (timeOffOnlyItems.isEmpty) {
    //       yield TimeOffDataState(TimeOffOnlyEmpty());
    //     } else {
    //       yield TimeOffOnlyItemsLoadedState(timeOffOnlyItems);
    //     }
    //   } else if (event is GetOvertimeItemsEvent) {
    //     final overtimeItems = _timeOffItems != null
    //         ? _timeOffItems
    //             .where((item) => item.timeOff.timeOffCategory.isOverTimeCategory)
    //             .toList()
    //         : [];

    //     if (overtimeItems.isEmpty) {
    //       yield TimeOffDataState(OvertimeEmpty());
    //     } else {
    //       yield OvertimeItemsLoaded(overtimeItems);
    //     }
    //   }
  }
}
