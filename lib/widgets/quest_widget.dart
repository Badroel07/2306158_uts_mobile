import 'package:flutter/material.dart';
import 'package:pertemuan_4/models/quest_model.dart';
import 'dart:ui';

class QuestWidget extends StatelessWidget {
  final QuestModel quest;
  final VoidCallback onTap;

  const QuestWidget({
    super.key,
    required this.quest,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool taken = quest.isTaken;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF1E1E1E),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: taken ? Colors.tealAccent.withOpacity(0.3) : Colors.white.withOpacity(0.1),
              ),
            ),
            child: Row(
              children: [
                Hero(
                  tag: 'quest_image_${quest.id}',
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(quest.image),
                        fit: BoxFit.cover,
                        colorFilter: taken ? const ColorFilter.mode(Colors.black54, BlendMode.darken) : null,
                      ),
                    ),
                    child: taken 
                      ? const Icon(Icons.check_circle, color: Colors.tealAccent, size: 30)
                      : null,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        quest.title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: taken ? Colors.grey.shade500 : Colors.white,
                          decoration: taken ? TextDecoration.lineThrough : null,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          "Rank ${quest.rank}",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.tealAccent.shade100,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.chevron_right, color: Colors.white.withOpacity(0.3)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
