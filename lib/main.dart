import 'package:flutter/material.dart';

void main() {
  runApp(const ViralStudioApp());
}

// ================================================================
// ROOT APP - GLOBAL THEME STATE
// ================================================================

class ViralStudioApp extends StatefulWidget {
  const ViralStudioApp({super.key});

  @override
  State<ViralStudioApp> createState() => _ViralStudioAppState();
}

class _ViralStudioAppState extends State<ViralStudioApp> {
  bool isDarkMode = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Viral Content Studio',
      theme: isDarkMode
          ? ThemeData.dark(useMaterial3: true)
          : ThemeData.light(useMaterial3: true),

      home: ViralContentScreen(
        isDark: isDarkMode,
        onToggleTheme: () {
          setState(() {
            isDarkMode = !isDarkMode;
          });
        },
      ),
    );
  }
}

// ================================================================
// MAIN SCREEN
// ================================================================

class ViralContentScreen extends StatefulWidget {
  final bool isDark;
  final VoidCallback onToggleTheme;

  const ViralContentScreen({
    super.key,
    required this.isDark,
    required this.onToggleTheme,
  });

  @override
  State<ViralContentScreen> createState() => _ViralContentScreenState();
}

class _ViralContentScreenState extends State<ViralContentScreen> {
  // ==============================================================
  // STATE VARIABLES
  // ==============================================================

  int likes = 0;
  int comments = 0;
  int shares = 0;
  int saves = 0;

  int streak = 0;

  bool isTrending = false;

  String lastAction = "READY TO GO VIRAL";

  // Total engagement points:
  // Like = 1
  // Comment = 2
  // Share = 3
  // Save = 2

  int get totalScore {
    return likes + (comments * 2) + (shares * 3) + (saves * 2);
  }

  void _performAction(String action, int points) {
    setState(() {
      if (action == "LIKE") {
        likes++;
      } else if (action == "COMMENT") {
        comments++;
      } else if (action == "SHARE") {
        shares++;
      } else if (action == "SAVE") {
        saves++;
      }

      streak++;

      lastAction = "$action +$points POINTS";

      // Trending unlock condition
      isTrending = totalScore >= 20;
    });
  }

  void _resetPost() {
    setState(() {
      likes = 0;
      comments = 0;
      shares = 0;
      saves = 0;
      streak = 0;
      isTrending = false;
      lastAction = "POST RESET";
    });
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = isTrending
        ? (widget.isDark ? const Color(0xFF321515) : const Color(0xFFFFE0E0))
        : (widget.isDark ? const Color(0xFF181820) : const Color(0xFFF0F2F5));

    final cardColor = widget.isDark ? const Color(0xFF24242F) : Colors.white;

    return Scaffold(
      backgroundColor: backgroundColor,

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,

        title: const Text(
          "VIRAL CONTENT STUDIO",
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.1),
        ),

        actions: [
          IconButton(
            tooltip: "Switch Theme",
            icon: Icon(widget.isDark ? Icons.light_mode : Icons.dark_mode),
            onPressed: widget.onToggleTheme,
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            // ======================================================
            // STATELESS WIDGET #1
            // ======================================================

            StudioHeader(isTrending: isTrending, score: totalScore),

            const SizedBox(height: 20),

            // Trending condition
            if (isTrending) const TrendingBanner(),

            if (isTrending) const SizedBox(height: 16),

            // ======================================================
            // METRICS CARD
            // ======================================================
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),

              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(22),

                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(
                      widget.isDark ? 0.30 : 0.08,
                    ),
                    blurRadius: 14,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),

              child: Column(
                children: [
                  // STATELESS WIDGET #2 used multiple times

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,

                    children: [
                      MetricBadge(
                        title: "LIKES",
                        value: likes,
                        icon: Icons.favorite,
                      ),

                      MetricBadge(
                        title: "COMMENTS",
                        value: comments,
                        icon: Icons.comment,
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,

                    children: [
                      MetricBadge(
                        title: "SHARES",
                        value: shares,
                        icon: Icons.share,
                      ),

                      MetricBadge(
                        title: "SAVES",
                        value: saves,
                        icon: Icons.bookmark,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ======================================================
            // ENGAGEMENT SCORE
            // ======================================================
            Text(
              "ENGAGEMENT SCORE: $totalScore / 20",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            LinearProgressIndicator(
              value: (totalScore / 20).clamp(0.0, 1.0),
              minHeight: 12,
              borderRadius: BorderRadius.circular(12),

              color: isTrending ? Colors.orange : Colors.blueAccent,
            ),

            const SizedBox(height: 10),

            Text(
              isTrending
                  ? "TRENDING MODE UNLOCKED!"
                  : "${20 - totalScore > 0 ? 20 - totalScore : 0} points until trending",
            ),

            const SizedBox(height: 8),

            Text(
              "ENGAGEMENT STREAK: $streak",
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: 8),

            Text(
              "LAST ACTION: $lastAction",
              style: TextStyle(
                fontFamily: 'monospace',
                fontWeight: FontWeight.bold,
                color: isTrending ? Colors.orangeAccent : Colors.blueAccent,
              ),
            ),

            const SizedBox(height: 30),

            // ======================================================
            // TACTILE ACTION BUTTONS
            // ==============================================================
            Wrap(
              spacing: 18,
              runSpacing: 18,
              alignment: WrapAlignment.center,

              children: [
                TactileActionButton(
                  icon: Icons.favorite,
                  label: "LIKE",
                  points: "+1",
                  accentColor: Colors.pinkAccent,
                  isDark: widget.isDark,
                  onPressed: () {
                    _performAction("LIKE", 1);
                  },
                ),

                TactileActionButton(
                  icon: Icons.comment,
                  label: "COMMENT",
                  points: "+2",
                  accentColor: Colors.blueAccent,
                  isDark: widget.isDark,
                  onPressed: () {
                    _performAction("COMMENT", 2);
                  },
                ),

                TactileActionButton(
                  icon: Icons.share,
                  label: "SHARE",
                  points: "+3",
                  accentColor: Colors.greenAccent,
                  isDark: widget.isDark,
                  onPressed: () {
                    _performAction("SHARE", 3);
                  },
                ),

                TactileActionButton(
                  icon: Icons.bookmark,
                  label: "SAVE",
                  points: "+2",
                  accentColor: Colors.amber,
                  isDark: widget.isDark,
                  onPressed: () {
                    _performAction("SAVE", 2);
                  },
                ),
              ],
            ),

            const SizedBox(height: 32),

            ElevatedButton.icon(
              onPressed: _resetPost,
              icon: const Icon(Icons.refresh),
              label: const Text("RESET POST"),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

// =================================================================
// STATELESS WIDGET #1
// =================================================================

class StudioHeader extends StatelessWidget {
  final bool isTrending;
  final int score;

  const StudioHeader({
    super.key,
    required this.isTrending,
    required this.score,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          isTrending ? Icons.local_fire_department : Icons.smartphone,
          size: 55,
          color: isTrending ? Colors.orange : Colors.blueAccent,
        ),

        const SizedBox(height: 8),

        Text(
          isTrending ? "YOUR POST IS EXPLODING!" : "BUILD YOUR ENGAGEMENT",
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 5),

        Text(
          "Current Engagement Score: $score",
          style: const TextStyle(color: Colors.grey),
        ),
      ],
    );
  }
}

// =================================================================
// STATELESS WIDGET #2
// =================================================================

class MetricBadge extends StatelessWidget {
  final String title;
  final int value;
  final IconData icon;

  const MetricBadge({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: Colors.blueAccent),

        const SizedBox(height: 5),

        Text(
          "$value",
          style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),

        Text(
          title,
          style: const TextStyle(
            fontSize: 10,
            color: Colors.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

// =================================================================
// EXTRA STATELESS WIDGET
// =================================================================

class TrendingBanner extends StatelessWidget {
  const TrendingBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.deepOrange, Colors.orange],
        ),

        borderRadius: BorderRadius.circular(18),
      ),

      child: const Text(
        "🔥 TRENDING 🔥",
        textAlign: TextAlign.center,

        style: TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
          letterSpacing: 2,
        ),
      ),
    );
  }
}

// =================================================================
// CUSTOM STATEFUL WIDGET
// =================================================================

class TactileActionButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final String points;
  final Color accentColor;
  final bool isDark;
  final VoidCallback onPressed;

  const TactileActionButton({
    super.key,
    required this.icon,
    required this.label,
    required this.points,
    required this.accentColor,
    required this.isDark,
    required this.onPressed,
  });

  @override
  State<TactileActionButton> createState() => _TactileActionButtonState();
}

class _TactileActionButtonState extends State<TactileActionButton> {
  // Private local state
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    final baseColor = widget.isDark
        ? const Color(0xFF24242F)
        : const Color(0xFFE5E9F0);

    final darkShadow = widget.isDark ? Colors.black87 : const Color(0xFFA3B1C6);

    final lightShadow = widget.isDark ? const Color(0xFF353545) : Colors.white;

    return GestureDetector(
      // Finger touches button
      onTapDown: (_) {
        setState(() {
          isPressed = true;
        });
      },

      // Finger releases button
      onTapUp: (_) {
        setState(() {
          isPressed = false;
        });

        widget.onPressed();
      },

      // Gesture cancelled
      onTapCancel: () {
        setState(() {
          isPressed = false;
        });
      },

      child: AnimatedScale(
        scale: isPressed ? 0.94 : 1.0,
        duration: const Duration(milliseconds: 100),

        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),

          width: 145,
          height: 135,

          decoration: BoxDecoration(
            color: baseColor,
            borderRadius: BorderRadius.circular(24),

            boxShadow: isPressed
                ? [
                    BoxShadow(
                      color: darkShadow.withOpacity(0.5),
                      offset: const Offset(2, 2),
                      blurRadius: 4,
                    ),

                    BoxShadow(
                      color: lightShadow.withOpacity(0.5),
                      offset: const Offset(-2, -2),
                      blurRadius: 4,
                    ),
                  ]
                : [
                    BoxShadow(
                      color: darkShadow.withOpacity(0.7),
                      offset: const Offset(8, 8),
                      blurRadius: 16,
                    ),

                    BoxShadow(
                      color: lightShadow.withOpacity(0.7),
                      offset: const Offset(-8, -8),
                      blurRadius: 16,
                    ),
                  ],
          ),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              Icon(
                widget.icon,
                size: isPressed ? 38 : 45,
                color: isPressed
                    ? widget.accentColor
                    : widget.accentColor.withOpacity(0.8),
              ),

              const SizedBox(height: 7),

              Text(
                widget.label,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),

              const SizedBox(height: 4),

              Text(
                widget.points,
                style: TextStyle(
                  color: widget.accentColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
