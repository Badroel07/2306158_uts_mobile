import 'package:flutter/material.dart';
import 'package:pertemuan_4/models/quest_model.dart';
import 'package:pertemuan_4/models/user_model.dart';
import 'package:pertemuan_4/pages/detail_quest_page.dart';
import 'package:pertemuan_4/widgets/chip_widget.dart';
import 'package:pertemuan_4/widgets/header_widget.dart';
import 'package:pertemuan_4/widgets/quest_widget.dart';

class HomePage extends StatefulWidget {
  final UserModel user;

  const HomePage({super.key, required this.user});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Hardcoded list of quests
  final List<QuestModel> _quests = [
    QuestModel(
      id: "1",
      title: "Defeat the Slime King",
      rank: "F",
      reward: "100 Gold, 50 XP",
      image: "assets/images/slime.png",
      description: "A giant slime is terrorizing the village outskirts. Defeat it before it absorbs more items!",
    ),
    QuestModel(
      id: "2",
      title: "Find the Lost Cat",
      rank: "E",
      reward: "50 Gold",
      image: "assets/images/cat.png",
      description: "Mrs. Pommel's black cat went missing in the dark alley. Bring it back safely.",
    ),
    QuestModel(
      id: "3",
      title: "Slay the Goblin King",
      rank: "C",
      reward: "500 Gold, 300 XP, Rare Sword",
      image: "assets/images/goblin.png",
      description: "The goblins are grouping up under a new leader. Go to their cave and slay the Goblin King.",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.transparent,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Adventure Guild",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1.2,
                      ),
                    ),                  ],
                ),
                const SizedBox(height: 20),
                HeaderWidget(
                  name: widget.user.name,
                  level: widget.user.level,
                  role: widget.user.role,
                  rank: widget.user.rank,
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: ChipWidget(
                        label: "HP: ",
                        ikon: Icons.favorite,
                        warna: Colors.redAccent,
                        nilai: 100,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ChipWidget(
                        label: "Mana: ",
                        ikon: Icons.auto_awesome,
                        warna: Colors.blueAccent,
                        nilai: 100,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ChipWidget(
                        label: "Str: ",
                        ikon: Icons.fitness_center,
                        warna: Colors.greenAccent,
                        nilai: 100,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Available Quests",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1,
                      ),
                    ),                  ],
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView.separated(
                    itemCount: _quests.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final quest = _quests[index];
                      // Wrap QuestWidget in Hero for image transition later if needed
                      // For now, QuestWidget just displays the list item.
                      return QuestWidget(
                        quest: quest,
                        onTap: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailQuestPage(quest: quest),
                            ),
                          );
                          if (result == true) {
                            setState(() {
                              quest.isTaken = true;
                            });
                          }
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

