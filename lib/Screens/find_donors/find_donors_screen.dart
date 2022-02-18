import 'package:blood_donation/Styles/Strings.dart';
import 'package:blood_donation/UsableWidgets/custom_sized_box_height.dart';
import 'package:blood_donation/UsableWidgets/loading.dart';
import 'package:blood_donation/UsableWidgets/no_result.dart';
import 'package:blood_donation/shared/constants.dart';
import 'package:blood_donation/translations/locale_keys.g.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../model/user_model.dart';
import 'donor_card.dart';

class FindDonorsScreen extends StatefulWidget {
  const FindDonorsScreen({Key? key}) : super(key: key);

  @override
  _FindDonorsScreenState createState() => _FindDonorsScreenState();
}

class _FindDonorsScreenState extends State<FindDonorsScreen> {
  late Future resultsLoaded2;
  List? _snapshotResultsList;
  List _searchResultList = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    resultsLoaded2 = getSnapshots();
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  _onSearchChanged() {
    searchResultsList();
  }

  searchResultsList() {
    var showResults = [];

    if (_searchController.text != "") {
      for (var donorSnapshot in _snapshotResultsList!) {
        var title =
            UserModel.fromSnapshot(donorSnapshot).userName!.toLowerCase();
        if (title.contains(
          _searchController.text.toLowerCase(),
        )) {
          showResults.add(donorSnapshot);
        }
      }
    } else {
      showResults = List.from(_snapshotResultsList!);
    }
    setState(
      () {
        _searchResultList = showResults;
      },
    );
  }

  getSnapshots() async {
    var data = await FirebaseFirestore.instance
        .collection(Strings.usersCollection)
        .get();
    setState(
      () {
        _snapshotResultsList = data.docs;
      },
    );
    searchResultsList();
    return "complete";
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.find_donors.tr()),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: Constants.primaryPadding,
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              TextFormField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: LocaleKeys.search_for_donor.tr(),
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.search),
                  ),
                ),
              ),
              const CustomSizedBoxHeight(),
              _snapshotResultsList != null && _searchResultList.isNotEmpty
                  ? SingleChildScrollView(
                      physics: ScrollPhysics(),
                      child: SizedBox(
                        height: height,
                        child: ListView.separated(
                          physics: ScrollPhysics(),
                          itemBuilder: (context, index) {
                            var donorData = _searchResultList[index];
                            return DonorCard(
                              donorName: donorData[Strings.userName],
                              donorPhone: donorData[Strings.userPhone],
                              donorAddress: donorData[Strings.userAddress],
                              donorBloodType: donorData[Strings.userBloodType],
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const CustomSizedBoxHeight();
                          },
                          itemCount: _searchResultList.length,
                        ),
                      ),
                    )
                  : _snapshotResultsList == null && _searchResultList.isEmpty
                      ? const WidgetNoResult()
                      : const Loading(),
            ],
          ),
        ),
      ),
    );
  }
}
