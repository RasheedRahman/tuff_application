import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      bottomNavigationBar: const _BottomNav(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const _TopHeader(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),

                  // Welcome
                  const Text(
                    "Welcome back, John",
                    style:
                    TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 8),

                  // Subscription badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFE8A3),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.flash_on, size: 14),
                        SizedBox(width: 6),
                        Text(
                          "Active Subscription : Pro Member",
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Cards
                  Row(
                    children: [
                      Expanded(
                        child: _StatCard(
                          title: "ATTENDANCE",
                          value: "85%",
                          icon: Icons.calendar_today,
                          progress: 0.85, // 👈 only here
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _StatCard(
                          title: "BMI",
                          value: "22.4",
                          icon: Icons.fitness_center,
                          subtitle: "HEALTHY RANGE", // 👈 only text
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Banner
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEAD7A5),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 0,          // smooth shadow
                          spreadRadius: 0,        // 👈 important (avoid all sides)
                          offset: const Offset(4, 4), // 👈 right + bottom
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Unleash the Beast",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          "Unlock hyper-personalized training\nprotocols and elite meal plans.",
                          style: TextStyle(fontSize: 13),
                        ),
                        const SizedBox(height: 12),
                        Align(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFAC00C),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            onPressed: () {},
                            child: const Text(
                              "PURCHASE PLAN",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Live updates label
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.orange),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        "LIVE UPDATES",
                        style: TextStyle(fontSize: 11),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  const _UpdateTile(
                    title: "WORKOUT COMPLETE",
                    subtitle: "Upper body hypertrophy.",
                    time: "2h ago",
                    icon: Icons.check,
                  ),
                  const _UpdateTile(
                    title: "NEW CHALLENGE AVAILABLE",
                    subtitle:
                    "The 7-day velocity sprint starts tomorrow.",
                    icon: Icons.rocket_launch,
                  ),
                  const _UpdateTile(
                    title: "MILESTONE ACHIEVED",
                    subtitle: "10-day workout streak. Keep it up!",
                    time: "1d ago",
                    icon: Icons.emoji_events,
                  ),

                  const SizedBox(height: 80),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TopHeader extends StatelessWidget {
  const _TopHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: const BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: const [
            CircleAvatar(
              radius: 22,
              backgroundColor: Colors.orange,
              backgroundImage: AssetImage('assets/images/profile_image.jpg'),
            ),
            CircleAvatar(
              radius: 18,
              backgroundColor: Color(0xFF4b3e1a),
              child: Icon(Icons.notifications_none_outlined, color: Color(0xFFFAC00C)),
            ),

          ],
        ),
      ),
    );
  }
}
//#4b3e1a give this colour

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final String? subtitle;
  final IconData icon;
  final double? progress; // 👈 nullable

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    this.progress, // optional now
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height:100,
      padding: const EdgeInsets.only(right: 12, top: 20, bottom: 20),
      decoration: BoxDecoration(
        color: const Color(0xFFF5E8E8),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 1,          // smooth shadow
            spreadRadius: 0,        // 👈 important (avoid all sides)
            offset: const Offset(4, 4), // 👈 right + bottom
          ),
        ],
      ),
      child: Row(
        children: [
          // 🔶 Show left indicator ONLY if progress exists
          //if (progress != null)
            Container(
              width: 12,
              height: 50,
              decoration: BoxDecoration(
                color: Color(0xFFFAC00C),
                borderRadius: BorderRadius.circular(10),
              ),

            ),

          SizedBox(width: 10,),
          Column(

            children: [
              Icon(icon, size: 20, color: const Color(0xFFFAC00C)),
            ],
          ),
          SizedBox(width: 10,),



          // 🔶 Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween, // 👈 THIS
              children: [
                Text(title, style: const TextStyle(fontSize: 11)),

                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: value.replaceAll('%', ''),
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      if (value.contains('%'))
                        const TextSpan(
                          text: '%',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFFFAC00C),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                    ],
                  ),
                ),

                if (progress != null)
                  SizedBox(
                    width: 75,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: progress,
                        minHeight: 6,
                        backgroundColor: Colors.white,
                        valueColor: const AlwaysStoppedAnimation(
                          Color(0xFFFAC00C),
                        ),
                      ),
                    ),
                  ),

                if (progress == null && subtitle != null)
                  Text(
                    subtitle!,
                    style: const TextStyle(
                      fontSize: 10,
                      color: Color(0xFFFAC00C),
                    ),
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _UpdateTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String? time;
  final IconData icon;

  const _UpdateTile({
    required this.title,
    required this.subtitle,
    this.time,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFEAD7A5),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.black,
            child: Icon(icon, color: Colors.yellow),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 12)),
                Text(subtitle, style: const TextStyle(fontSize: 12)),
              ],
            ),
          ),
          if (time != null)
            Text(time!, style: const TextStyle(fontSize: 11)),
        ],
      ),
    );
  }
}


class _BottomNav extends StatelessWidget {
  const _BottomNav();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: const BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const [
          _NavItem(icon: Icons.home, label: "HOME"),
          _NavItem(icon: Icons.receipt, label: "REPORT"),
          _NavItem(icon: Icons.fitness_center, label: "COURSES"),
          _NavItem(icon: Icons.person, label: "PROFILE"),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const _NavItem({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: Color(0xFFFAC00C)),
        const SizedBox(height: 4),
        Text(label,
            style: const TextStyle(
                fontSize: 10, color: Color(0xFFFAC00C))),
      ],
    );
  }
}
