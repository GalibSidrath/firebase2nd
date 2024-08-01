import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase2nd/models/football_match_score_model.dart';
import 'package:firebase2nd/widgets/team_score.dart';
import 'package:flutter/material.dart';

class FootballScoreScreen extends StatefulWidget {
  const FootballScoreScreen({super.key});

  @override
  State<FootballScoreScreen> createState() => _FootballScoreScreenState();
}

class _FootballScoreScreenState extends State<FootballScoreScreen> {
  List<FootballMatchScoreModel> matchList = [];
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  Future<void> _getFootballMatchScoreData() async {
    matchList.clear();
    final QuerySnapshot result =
        await firebaseFirestore.collection('football').get();
    for (QueryDocumentSnapshot doc in result.docs) {
      matchList.add(
        FootballMatchScoreModel(
          doc.get('team1name'),
          doc.get('team1score'),
          doc.get('team2score'),
          doc.get('team2score'),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _getFootballMatchScoreData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Football Match Score',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
          itemCount: matchList.length,
          itemBuilder: (context, index) {
            return FootballMatchScoreCard(matchList[index]);
          }),
    );
  }

  Widget FootballMatchScoreCard(FootballMatchScoreModel model) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 3,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TeamScore(model.team1Name, model.team1Score.toString()),
            const Text(
              'vs',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            TeamScore(model.team2Name, model.team2Score.toString()),
          ],
        ),
      ),
    );
  }
}