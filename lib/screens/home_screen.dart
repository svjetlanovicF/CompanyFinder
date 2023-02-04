import 'dart:convert';
import 'dart:developer';
import 'package:company_finder_app/components/company_card.dart';

import '../models/company_model.dart';
import 'package:flutter/material.dart';
import '../services/http_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../components/custom_search_delegate.dart';
import './profile_screen.dart';
import './favourite_companies_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int _currentPage = 1;

  @override
  Widget build(BuildContext context) {
    HttpService httpService = HttpService();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent.shade400,
        actions: [
          
          IconButton(
              onPressed: (() {
                showSearch(context: context, delegate: CustomSearchDelegate());
              }),
              icon: const Icon(Icons.search)),
        ],
      ),

      
      body: getScreen(_currentPage),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentPage,
        backgroundColor: Colors.white,
        elevation: 15,
        fixedColor: Colors.greenAccent.shade400,
        iconSize: 35,
        onTap: (_index) {
          setState(() {
            _currentPage = _index;
            print(_currentPage);
          });
        },
        items: const [
          BottomNavigationBarItem(
            label: 'Profile',
            icon: Icon(
              Icons.account_circle,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.home_rounded),
          ),
          BottomNavigationBarItem(
            label: 'Favorite',
            icon: Icon(Icons.favorite_border_rounded),
          ),
        ],
      ),
    );
  }

  Center home() {
    return Center(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_rounded,
              size: 100.0,
              color: Colors.greenAccent.shade400,
            ),
            Text(
              'Search companies',
              style: TextStyle(color: Colors.greenAccent.shade400, fontSize: 20.0),
            )
          ],
        ),
        
      ),
    );
  }

  Widget getScreen(int index) {

    if(index == 0) {
      return const ProfileScreen();
    }
    else if(index == 1){
      return home();
    }
    else {
      return const FavouriteCompaniesScreen();
    }

  }


}
