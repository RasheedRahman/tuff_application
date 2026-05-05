import 'package:flutter/material.dart';
import 'package:turf_application/screens/success_screen.dart';

import 'home_screen.dart';

class PhysicalDetailsScreen extends StatefulWidget {
  const PhysicalDetailsScreen({super.key});

  @override
  State<PhysicalDetailsScreen> createState() => _PhysicalDetailsScreenState();
}

class _PhysicalDetailsScreenState extends State<PhysicalDetailsScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;
  final int _totalPages = 7;


  // ── Collected data ──
  String _name = '';
  String _gender = '';
  String _dobDay = '';
  String _dobMonth = '';
  String _dobYear = '';
  double _heightCm = 178;
  bool _heightIsCm = true;
  double _weightKg = 75;
  bool _weightIsKg = true;
  String _experience = '';
  bool _hasInjuries = false;
  final Set<String> _injuries = {};

  void _nextPage() {
    if (_currentPage < _totalPages - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SuccessScreen()),
      );
    }
  }

  void _prevPage() {
    if (_currentPage > 0) {
      _controller.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // ── Top bar: back arrow + step indicator ──
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Row(
                children: [
                  if (_currentPage > 0)
                    GestureDetector(
                      onTap: _prevPage,
                      child: const Icon(Icons.arrow_back_ios,
                          size: 20, color: Colors.black87),
                    )
                  else
                    const SizedBox(width: 20),
                  const Spacer(),
                  Text(
                    'STEP ${_currentPage + 1} OF $_totalPages',
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFFAC00C),
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
            ),

            // ── Pages ──
            Expanded(
              child: PageView(
                controller: _controller,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (i) => setState(() => _currentPage = i),
                children: [
                  // Page 1 – Name
                  _NamePage(
                    value: _name,
                    onChanged: (v) => setState(() => _name = v),
                  ),
                  // Page 2 – Gender
                  _GenderPage(
                    selected: _gender,
                    onSelected: (v) => setState(() => _gender = v),
                  ),
                  // Page 3 – Date of Birth
                  _DobPage(
                    day: _dobDay,
                    month: _dobMonth,
                    year: _dobYear,
                    onDayChanged: (v) => setState(() => _dobDay = v),
                    onMonthChanged: (v) => setState(() => _dobMonth = v),
                    onYearChanged: (v) => setState(() => _dobYear = v),
                  ),
                  // Page 4 – Height
                  _HeightPage(
                    heightCm: _heightCm,
                    isCm: _heightIsCm,
                    onHeightChanged: (v) => setState(() => _heightCm = v),
                    onUnitToggle: () =>
                        setState(() => _heightIsCm = !_heightIsCm),
                  ),
                  // Page 5 – Weight
                  _WeightPage(
                    weightKg: _weightKg,
                    isKg: _weightIsKg,
                    onWeightChanged: (v) => setState(() => _weightKg = v),
                    onUnitToggle: () =>
                        setState(() => _weightIsKg = !_weightIsKg),
                  ),
                  // Page 6 – Experience
                  _ExperiencePage(
                    selected: _experience,
                    onSelected: (v) => setState(() => _experience = v),
                  ),
                  // Page 7 – Injuries
                  _InjuriesPage(
                    hasInjuries: _hasInjuries,
                    selected: _injuries,
                    onYes: () => setState(() => _hasInjuries = true),
                    onNo: () => setState(() {
                      _hasInjuries = false;
                      _injuries.clear();
                    }),
                    onToggleInjury: (v) => setState(() {
                      if (_injuries.contains(v)) {
                        _injuries.remove(v);
                      } else {
                        _injuries.add(v);
                      }
                    }),
                  ),
                ],
              ),
            ),

            // ── Next Button ──
            Padding(
              padding: const EdgeInsets.all(24),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _nextPage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFAC00C),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    _currentPage == _totalPages - 1 ? 'GET STARTED' : 'NEXT',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.1,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Shared Widgets
// ─────────────────────────────────────────────

/// Bold heading with one word highlighted in orange
class _HighlightHeading extends StatelessWidget {
  final String prefix;
  final String highlight;
  final String suffix;

  const _HighlightHeading({
    required this.prefix,
    required this.highlight,
    this.suffix = '',
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.w800,
          color: Colors.black,
          height: 1.2,
        ),
        children: [
          TextSpan(text: prefix),
          TextSpan(
            text: highlight,
            style: const TextStyle(color: Color(0xFFFAC00C)),
          ),
          TextSpan(text: suffix),
        ],
      ),
    );
  }
}

/// Small grey subtitle
class _SubTitle extends StatelessWidget {
  final String text;
  const _SubTitle(this.text);
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 8),
    child: Text(
      text,
      style: TextStyle(fontSize: 13, color: Colors.grey.shade500),
    ),
  );
}

/// Orange-accented selection card
class _SelectCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool selected;
  final VoidCallback onTap;

  const _SelectCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFFFAC00C) : Colors.white,
          border: Border.all(
            color: const Color(0xFFFAC00C), // always yellow
            width: selected ? 1.5 : 1, // optional: thicker when selected
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Color(0xFFFEEDBB), // background color
                shape: BoxShape.circle,   // makes it rounded
              ),
              child: Icon(
                icon,
                color: const Color(0xFFFAC00C), // always yellow
                size: 20,
              ),
            ),
            const SizedBox(width: 14),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Page 1 – Name
// ─────────────────────────────────────────────
class _NamePage extends StatelessWidget {
  final String value;
  final ValueChanged<String> onChanged;
  const _NamePage({required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          const _HighlightHeading(
            prefix: "What's your ",
            highlight: 'name',
            suffix: '?',
          ),
          const _SubTitle(
              'We will use this to personalize your training experience.'),
          const SizedBox(height: 48),
          TextField(
            onChanged: onChanged,
            decoration: InputDecoration(
              hintText: 'John Mathew',
              hintStyle: TextStyle(color: Colors.grey.shade400),
              prefixIcon: Icon(Icons.person_outline,
                  color: Colors.grey.shade400),
              enabledBorder: UnderlineInputBorder(
                borderSide:
                BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFFAC00C)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Page 2 – Gender
// ─────────────────────────────────────────────
class _GenderPage extends StatelessWidget {
  final String selected;
  final ValueChanged<String> onSelected;
  const _GenderPage(
      {required this.selected, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          const _HighlightHeading(
            prefix: "What's your ",
            highlight: 'gender',
            suffix: '?',
          ),
          const _SubTitle(
              'We use this to calculate your metabolic rate and tailor your workout intensity.'),
          const SizedBox(height: 32),
          _SelectCard(
            icon: Icons.male,
            title: 'Male',
            subtitle: 'Focus on muscle mass & strength.',
            selected: selected == 'Male',
            onTap: () => onSelected('Male'),
          ),
          _SelectCard(
            icon: Icons.female,
            title: 'Female',
            subtitle: 'Focus on toning & endurance.',
            selected: selected == 'Female',
            onTap: () => onSelected('Female'),
          ),
          _SelectCard(
            icon: Icons.transgender,
            title: 'Other',
            subtitle: 'Personalized performance profile.',
            selected: selected == 'Other',
            onTap: () => onSelected('Other'),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Page 3 – Date of Birth
// ─────────────────────────────────────────────
class _DobPage extends StatelessWidget {
  final String day, month, year;
  final ValueChanged<String> onDayChanged, onMonthChanged, onYearChanged;

  const _DobPage({
    required this.day,
    required this.month,
    required this.year,
    required this.onDayChanged,
    required this.onMonthChanged,
    required this.onYearChanged,
  });

  Widget _field(
      String hint, ValueChanged<String> onChange, double width) {
    return SizedBox(
      width: width,
      child: TextField(
        onChanged: onChange,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey.shade400),
          contentPadding:
          const EdgeInsets.symmetric(vertical: 14),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide:
            BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFFFAC00C)),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          const _HighlightHeading(
            prefix: "When's your ",
            highlight: 'Birthday',
            suffix: '?',
          ),
          const _SubTitle(
              'We use this to calculate your age and provide more accurate health insights.'),
          const SizedBox(height: 48),
          Row(
            children: [
              _field('DD', onDayChanged, 80),
              const SizedBox(width: 12),
              _field('MM', onMonthChanged, 80),
              const SizedBox(width: 12),
              _field('YYYY', onYearChanged, 110),
            ],
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Page 4 – Height
// ─────────────────────────────────────────────
class _HeightPage extends StatelessWidget {
  final double heightCm;
  final bool isCm;
  final ValueChanged<double> onHeightChanged;
  final VoidCallback onUnitToggle;

  const _HeightPage({
    required this.heightCm,
    required this.isCm,
    required this.onHeightChanged,
    required this.onUnitToggle,
  });

  String get _displayValue {
    if (isCm) return '${heightCm.round()} cm';
    final inches = heightCm / 2.54;
    final ft = (inches / 12).floor();
    final inc = (inches % 12).round();
    return "$ft'$inc\"";
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          const _HighlightHeading(
            prefix: 'How ',
            highlight: 'Tall',
            suffix: ' are you?',
          ),
          const _SubTitle(
              'Your height helps us personalize your calorie burn and stride length calculations.'),
          const SizedBox(height: 40),

          // Big value display
          Center(
            child: Container(
              width: 201, // 👈 added
              height: 171, // 👈 added
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
              decoration: BoxDecoration(
                color: const Color(0xFFFEEDBB),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: const Color(0xFFFAC00C), // 👈 subtle border
                  width: 0.5, // 👈 as per spec
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center, // 👈 better vertical alignment
                children: [
                  Text(
                    _displayValue,
                    style: const TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFAC00C),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Unit toggle
                  GestureDetector(
                    onTap: onUnitToggle,
                    child: Container(

                      decoration: BoxDecoration(

                        color: Colors.grey.shade500,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.all(2),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _unitBtn('CM', isCm),
                          _unitBtn('FT', !isCm),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 32),

          // Slider
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: Color(0xFFFAC00C),
              inactiveTrackColor: Colors.grey.shade200,
              thumbColor: Color(0xFFFAC00C),
              overlayColor: Color(0xFFFAC00C).withOpacity(0.1),
              trackHeight: 3,
            ),
            child: Slider(
              min: 100,
              max: 250,
              value: heightCm,
              onChanged: onHeightChanged,
            ),
          ),

          // Tick labels
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: ['155', '165', '175', '185', '195']
                  .map((e) => Text(e,
                  style: TextStyle(
                      fontSize: 11, color: Colors.grey.shade400)))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _unitBtn(String label, bool active) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding:
      const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: active ? Color(0xFFFAC00C) : Colors.grey.shade500,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontSize: 10,
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Page 5 – Weight
// ─────────────────────────────────────────────
class _WeightPage extends StatelessWidget {
  final double weightKg;
  final bool isKg;
  final ValueChanged<double> onWeightChanged;
  final VoidCallback onUnitToggle;

  const _WeightPage({
    required this.weightKg,
    required this.isKg,
    required this.onWeightChanged,
    required this.onUnitToggle,
  });

  String get _displayValue {
    if (isKg) return '${weightKg.round()} kg';
    return '${(weightKg * 2.20462).round()} lb';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          const _HighlightHeading(
            prefix: 'How much do you ',
            highlight: 'Weigh',
            suffix: '?',
          ),
          const _SubTitle(
              'We use this to calculate your daily calorie burn and personalized workout intensity.'),
          const SizedBox(height: 40),

          // ✅ SAME CARD STYLE AS HEIGHT
          Center(
            child: Container(
              width: 201,
              height: 171,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
              decoration: BoxDecoration(
                color: const Color(0xFFFEEDBB),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: const Color(0xFFFAC00C),
                  width: 0.5,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // ✅ SAME TEXT STYLE (no rich text)
                  Text(
                    _displayValue,
                    style: const TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFAC00C),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // ✅ SAME TOGGLE STYLE
                  GestureDetector(
                    onTap: onUnitToggle,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade500,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.all(2),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _unitBtn('KG', isKg),
                          _unitBtn('LB', !isKg),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 32),

          // ✅ SAME SLIDER STYLE
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: const Color(0xFFFAC00C),
              inactiveTrackColor: Colors.grey.shade200,
              thumbColor: const Color(0xFFFAC00C),
              overlayColor: const Color(0xFFFAC00C).withOpacity(0.1),
              trackHeight: 3,
            ),
            child: Slider(
              min: 30,
              max: 200,
              value: weightKg,
              onChanged: onWeightChanged,
            ),
          ),

          // ✅ SAME TICKS STYLE
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: ['70', '75', '80', '85', '90']
                  .map((e) => Text(
                e,
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey.shade400,
                ),
              ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  // ✅ EXACT SAME BUTTON STYLE AS HEIGHT PAGE
  Widget _unitBtn(String label, bool active) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: active ? const Color(0xFFFAC00C) : Colors.grey.shade500,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontSize: 10,
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Page 6 – Experience
// ─────────────────────────────────────────────
class _ExperiencePage extends StatelessWidget {
  final String selected;
  final ValueChanged<String> onSelected;
  const _ExperiencePage(
      {required this.selected, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          const _HighlightHeading(
            prefix: "What's your training\n",
            highlight: 'Experience',
            suffix: '?',
          ),
          const _SubTitle('This helps us tailor your workout intensity.'),
          const SizedBox(height: 32),
          _SelectCard(
            icon: Icons.fitness_center_outlined,
            title: 'Beginner',
            subtitle: 'New to training.',
            selected: selected == 'Beginner',
            onTap: () => onSelected('Beginner'),
          ),
          _SelectCard(
            icon: Icons.trending_up,
            title: 'Intermediate',
            subtitle: '1–2 year experience.',
            selected: selected == 'Intermediate',
            onTap: () => onSelected('Intermediate'),
          ),
          _SelectCard(
            icon: Icons.military_tech_outlined,
            title: 'Advanced',
            subtitle: '3+ year experience.',
            selected: selected == 'Advanced',
            onTap: () => onSelected('Advanced'),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Page 7 – Injuries / Medical Conditions
// ─────────────────────────────────────────────
class _InjuriesPage extends StatelessWidget {
  final bool hasInjuries;
  final Set<String> selected;
  final VoidCallback onYes;
  final VoidCallback onNo;
  final ValueChanged<String> onToggleInjury;

  const _InjuriesPage({
    required this.hasInjuries,
    required this.selected,
    required this.onYes,
    required this.onNo,
    required this.onToggleInjury,
  });

  static const _options = [
    'Back pain',
    'Knee injury',
    'Shoulder pain',
    'Cardiovascular',
    'Hip pain',
    'Ankle sprain',
  ];

  static const Map<String, IconData> _injuryIcons = {
    'Back pain': Icons.airline_seat_flat,
    'Knee injury': Icons.accessibility_new,
    'Shoulder pain': Icons.fitness_center,
    'Cardiovascular': Icons.favorite,
    'Hip pain': Icons.directions_walk,
    'Ankle sprain': Icons.directions_run,
  };


  @override
  Widget build(BuildContext context) {
    final String selectedOption;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          const _HighlightHeading(
            prefix: 'Do you have any current\n',
            highlight: 'Injuries',
            suffix: ' or medical\nconditions?',
          ),
          const _SubTitle(
              'We need to know your current physical limitations.'),
          const SizedBox(height: 24),

          // YES / NO buttons
          Row(
            children: [
              Expanded(
                child: _YesNoButton(
                  label: 'YES',
                  active: hasInjuries,
                  onTap: onYes,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _YesNoButton(
                  label: 'NO',
                  active: !hasInjuries,
                  onTap: onNo,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Injury chips — only visible when YES is selected
          if (hasInjuries)
            GridView.count(
              crossAxisCount: 2, // 👈 2 per row
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 3, // adjust height/width ratio
              children: _options.map((label) {
                return _InjuryChip(
                  label: label,
                  icon: _injuryIcons[label] ?? Icons.help_outline,
                  selected: selected.contains(label),
                  onTap: () => onToggleInjury(label),
                );
              }).toList(),
            )
        ],
      ),
    );
  }
}

class _YesNoButton extends StatelessWidget {
  final String label;
  final bool active;
  final VoidCallback onTap;

  const _YesNoButton({
    required this.label,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: active ? Color(0xFFFAC00C) : Colors.white,
          border: Border.all(
            color: active ? Color(0xFFFAC00C) : Colors.grey.shade300,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: active ? Colors.white : Colors.grey.shade600,
            ),
          ),
        ),
      ),
    );
  }
}

class _InjuryChip extends StatelessWidget {
  final String label;
  final IconData icon; // 👈 added
  final bool selected;
  final VoidCallback onTap;

  const _InjuryChip({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFFFAC00C) : Colors.white,
          border: Border.all(
            color: selected
                ? const Color(0xFFFAC00C)
                : Colors.grey.shade300,
            width: selected ? 1.5 : 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 18,
              color: selected
                  ? Colors.white
                  : const Color(0xFFFAC00C),
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight:
                selected ? FontWeight.w600 : FontWeight.normal,
                color: selected
                    ? Colors.black
                    : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}