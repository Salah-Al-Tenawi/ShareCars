import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sharecars/core/them/my_colors.dart';
import 'package:sharecars/core/utils/functions/show_my_snackbar.dart';
import 'package:sharecars/core/utils/widgets/loading_widget_size_150.dart';
import 'package:sharecars/features/trip_booking/data/model/booking_me_model.dart';
import 'package:sharecars/features/trip_booking/presantion/manger/cubit/booking_me_cubit.dart';
import 'package:sharecars/features/trip_create/data/model/trip_model.dart';
import 'package:sharecars/features/trip_me/presantion/manger/cubit/trip_me_cubit.dart';
import 'package:sharecars/features/trip_me/presantion/view/widget/trip_item.dart';

class BookingMeList extends StatefulWidget {
  const BookingMeList({super.key});

  @override
  State<BookingMeList> createState() => _BookingMeListState();
}

class _BookingMeListState extends State<BookingMeList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 100,
        height: 100,
        color: MyColors.accent,
      ),
    );
  }
}










// Scaffold(
//       body: BlocConsumer<BookingMeCubit, BookingMeState>(
//         listener: (context, state) {
//           if (state is BookingMeErorr) {
//             showMySnackBar(context, state.message);
//           } else if (state is BookingMeCanceled) {
//             showMySnackBar(context, state.message);
//           }
//         },
//         builder: (context, state) {
//           if (state is TripMeLoading) {
//             return const Center(child: LoadingWidgetSize150());
//           } else if (state is BookingMeListLoaded) {
//             final List<BookingMeModel> bookings = state.Bookings;

//             Future<void> refreshData() async {
//               await context.read<BookingMeCubit>().getMybooking();
//             }

//             return RefreshIndicator(
//               onRefresh: refreshData,
//               child: bookings.isEmpty
//                   ? SingleChildScrollView(
//                       physics: const AlwaysScrollableScrollPhysics(),
//                       child: SizedBox(
//                         width: double.infinity,
//                         height: MediaQuery.of(context).size.height,
//                         child: Column(
//                           children: [
//                             SizedBox(
//                               height: 80.h,
//                             ),
//                             Image.asset(
//                               'assets/images/Empty.png',
//                               width: 300.w,
//                               height: 300.h,
//                               fit: BoxFit.contain,
//                             ),
//                             SizedBox(height: 16.h),
//                             const Text(
//                               'لا توجد حجوزات',
//                               style: TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     )
//                   : ListView.builder(
//                       physics: const AlwaysScrollableScrollPhysics(),
//                       padding: const EdgeInsets.only(top: 8, bottom: 16),
//                       itemCount: bookings.length,
//                       itemBuilder: (context, index) {
//                         final booking = bookings[index];

//                       return ItemTrip(
//                           trip: TripModel.fromMap({}),
//                           onTap: () {
//                             // Get.toNamed(RouteName.tripDetails,
//                                 // arguments: trip.id);
//                           },
//                           onCancel: () async {
//                             final confirm = await showDialog<bool>(
//                               context: context,
//                               builder: (ctx) => AlertDialog(
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(20),
//                                 ),
//                                 backgroundColor: Colors.white,
//                                 title: const Row(
//                                   children: [
//                                     Icon(Icons.warning_amber_rounded,
//                                         color: MyColors.accent, size: 28),
//                                     SizedBox(width: 8),
//                                     Text(
//                                       'تأكيد',
//                                       style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 20,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 content: const Text(
//                                   'هل أنت متأكد من إلغاء الحجز ',
//                                   style: TextStyle(
//                                       fontSize: 16, color: Colors.black87),
//                                 ),
//                                 actionsPadding: const EdgeInsets.symmetric(
//                                     horizontal: 16, vertical: 8),
//                                 actions: [
//                                   ElevatedButton(
//                                     onPressed: () => Navigator.pop(ctx, false),
//                                     style: ElevatedButton.styleFrom(
//                                       backgroundColor:
//                                           MyColors.secondaryBackground,
//                                       foregroundColor: MyColors.primaryText,
//                                       shape: RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.circular(12),
//                                       ),
//                                       padding: const EdgeInsets.symmetric(
//                                           horizontal: 24, vertical: 12),
//                                     ),
//                                     child: const Text('لا',
//                                         style: TextStyle(
//                                             fontWeight: FontWeight.bold)),
//                                   ),
//                                   ElevatedButton(
//                                     onPressed: () => Navigator.pop(ctx, true),
//                                     style: ElevatedButton.styleFrom(
//                                       backgroundColor: MyColors.accent,
//                                       foregroundColor: Colors.white,
//                                       shape: RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.circular(12),
//                                       ),
//                                       padding: const EdgeInsets.symmetric(
//                                           horizontal: 24, vertical: 12),
//                                     ),
//                                     child: const Text('نعم',
//                                         style: TextStyle(
//                                             fontWeight: FontWeight.bold)),
//                                   ),
//                                 ],
//                               ),
//                             );

//                             if (confirm == true) {
//                               // await context
//                                   // .read<BookingMeCubit>()
//                                   // .cancelBooking(booking.id);
//                             }
//                           },
//                         );
//                       },
//                     ),
//             );
//           } else if (state is BookingMeErorr) {
//             return RefreshIndicator(
//               onRefresh: () async {
//                 await context.read<BookingMeCubit>().getMybooking();
//               },
//               child: SingleChildScrollView(
//                 physics: const AlwaysScrollableScrollPhysics(),
//                 child: SizedBox(
//                   height: MediaQuery.of(context).size.height,
//                   child: Center(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(state.message),
//                         SizedBox(height: 16.h),
//                         IconButton(
//                           onPressed: () {
//                             context.read<TripMeCubit>().getMeTrips();
//                           },
//                           icon: const Icon(
//                             Icons.refresh,
//                             color: MyColors.accent,
//                             size: 50,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             );
//           } else {
//             WidgetsBinding.instance.addPostFrameCallback((_) {
//               context.read<BookingMeCubit>().getMybooking();
//             });
//             return const SizedBox.shrink();
//           }
//         },
//       ),
//     );
 