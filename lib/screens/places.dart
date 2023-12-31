import 'package:favorite_places/providers/places_provider.dart';
import 'package:favorite_places/screens/add_place.dart';
import 'package:favorite_places/widgets/places_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlacesScreen extends ConsumerStatefulWidget {
  const PlacesScreen({super.key});

  @override
  ConsumerState<PlacesScreen> createState() => _PlacesScreenState();
}

class _PlacesScreenState extends ConsumerState<PlacesScreen> {
  late Future<void> _placesFuture;

  @override
  void initState() {
    super.initState();
    _placesFuture = ref.read(placesProvider.notifier).loadPlaces();
  }

  @override
  Widget build(BuildContext context) {
    final places = ref.watch(placesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Places'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddPlaceScreen(),
                  ));
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: places.isEmpty
          ? Center(
              child: Text(
                'No places added yet',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(8),
              child: FutureBuilder(
                future: _placesFuture,
                builder: (context, snapshot) =>
                    snapshot.connectionState == ConnectionState.waiting
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : PlacesList(
                            places: places,
                          ),
              ),
            ),
    );
  }
}
