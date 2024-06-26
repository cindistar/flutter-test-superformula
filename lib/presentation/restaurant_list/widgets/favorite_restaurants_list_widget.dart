import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantour/core/utils/utils.dart';
import 'package:restaurantour/presentation/cubit/cubit.dart';
import 'package:restaurantour/presentation/restaurant_detail/views/views.dart';
import 'package:restaurantour/presentation/restaurant_list/widgets/widgets.dart';
import 'package:restaurantour/presentation/widgets/widgets.dart';

class FavoriteRestaurantsListWidget extends StatefulWidget {
  const FavoriteRestaurantsListWidget({
    super.key,
    required this.favoriteRestaurantsCubit,
  });
  final FavoriteRestaurantsCubit favoriteRestaurantsCubit;

  @override
  State<FavoriteRestaurantsListWidget> createState() =>
      _FavoriteRestaurantsListWidgetState();
}

class _FavoriteRestaurantsListWidgetState
    extends State<FavoriteRestaurantsListWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteRestaurantsCubit, FavoriteRestaurantsListState>(
      bloc: widget.favoriteRestaurantsCubit,
      builder: (context, state) {
        if (state.status == StatusEnum.empty) {
          return const CustomEmptyWidget();
        }

        if (state.status == StatusEnum.success) {
          final restaurantsList = state.restaurantsList;

          return ListView.separated(
            shrinkWrap: true,
            padding: const EdgeInsets.only(
              left: 12,
              top: 16,
              right: 12,
              bottom: 100,
            ),
            itemCount: restaurantsList?.length ?? 0,
            itemBuilder: (context, index) {
              var restaurant = restaurantsList?[index];
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => RestaurantDetailPage(
                        restaurantEntity: restaurant,
                      ),
                    ),
                  );
                },
                child: RestaurantInfoCardWidget(
                  restaurant: restaurant,
                ),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(
              height: 12,
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
