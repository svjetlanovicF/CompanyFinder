import 'dart:developer';

import 'package:company_finder_app/models/company_filter.dart';
import 'package:company_finder_app/screens/company_info_screen.dart';
import 'package:flutter/material.dart';
import '../models/company_model.dart';
import '../services/http_service.dart';
import 'package:flutter_svg/flutter_svg.dart';
import './fullscreen_dialog.dart';

class CustomSearchDelegate extends SearchDelegate {
  CompanyFilter filter = CompanyFilter();

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      Padding(
          padding: EdgeInsets.symmetric(horizontal: 4),
          child: InkWell(
              onTap: () async {
                await _displayDialog(context, filter);
                log('This is filter ${filter.limitOfResult}');
              },
              child: SvgPicture.asset(
                'images/filter.svg',
                height: MediaQuery.of(context).size.width * 0.06,
              )))

      // IconButton(
      //   icon: Icon(Icons.clear),
      //   onPressed: () {
      //     query = '';
      //   },
      // )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    HttpService httpService = HttpService();

    return Container(
      child: FutureBuilder<List<CompanyModel>>(
        future: httpService.fetchData(
            name: query, searchQuery: query, filter: filter),
        builder: (context, snapshot) {
          var data = snapshot.data;
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: data?.length,
            itemBuilder: (ctx, index) {
              return InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CompanyInfoScreen(fetchURL: '${data?[index].fetchURL}' )));
                },
                child: Card(
                  elevation: 4,
                  child: ListTile(
                    title: Text('${data?[index].name}'),
                    subtitle:
                        Text('${data?[index].address1}, ${data?[index].city}'),
                    trailing: data?[index].companyStatus == 'inactive'
                        ? Container(
                            width: 10,
                            height: 10,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.red,
                            ),
                          )
                        : Container(
                            width: 10,
                            height: 10,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.green,
                            ),
                          ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContexcontext) {
    HttpService httpService = HttpService();

    return Container(
      child: FutureBuilder<List<CompanyModel>>(
        future: httpService.fetchData(
            name: query, searchQuery: query, filter: filter),
        builder: (context, snapshot) {
          var data = snapshot.data;
          if (!snapshot.hasData) {
            return Center(
              child: Text('Search Companies'),
            );
          }
          return ListView.builder(
            itemCount: data?.length,
            itemBuilder: (ctx, index) {
              return InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CompanyInfoScreen(fetchURL: '${data?[index].fetchURL}' )));
                },
                child: Card(
                  elevation: 4,
                  child: ListTile(
                    title: Text('${data?[index].name}'),
                    subtitle:
                        Text('${data?[index].address1}, ${data?[index].city}'),
                    trailing: data?[index].companyStatus == 'inactive'
                        ? Container(
                            width: 10,
                            height: 10,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.red,
                            ),
                          )
                        : Container(
                            width: 10,
                            height: 10,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.green,
                            ),
                          ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  _displayDialog(BuildContext context, CompanyFilter filter) {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      transitionDuration: Duration(milliseconds: 500),
      // transitionBuilder: (context, animation, secondaryAnimation, child) {
      //   return FadeTransition(
      //     opacity: animation,
      //     child: ScaleTransition(
      //       scale: animation,
      //       child: child,
      //     ),
      //   );
      // },
      pageBuilder: (context, animation, secondaryAnimation) {
        return FullscreenDialog(
          filter: filter,
        );
      },
    );
  }
}
