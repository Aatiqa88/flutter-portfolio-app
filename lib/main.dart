import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(const PortfolioApp());

// ===========================================================================
// 1. YOUR DATA  (edit only this part)
// ===========================================================================
class Skill {
  final String name;
  final double level; // 0.0 - 1.0  (edit to match your real level)
  final String group;
  const Skill(this.name, this.level, this.group);
}

class Item {
  final IconData icon;
  final String title;
  final String detail;
  const Item(this.icon, this.title, this.detail);
}

class D {
  static const name = 'Aatiqa Bibi';
  static const initials = 'AB';
  static const profession = 'BSCS Student  •  Web Developer  •  AI Enthusiast';
  static const tagline =
      'I build clean, modern digital products with Flutter, the web and AI.';
  static const university = 'COMSATS University Islamabad';
  static const campus = 'Attock Campus';
  static const degree = 'BS Computer Science';
  static const semester = '4th';
  static const cgpa = '3.95';
  static const about =
      'I am a 4th-semester BSCS student at COMSATS University Islamabad with a '
      'CGPA of 3.95. My main interests are web development and artificial '
      'intelligence, and I am exploring mobile app development with Flutter '
      'and other modern technologies. I enjoy hackathons and coding '
      'competitions because they push me to learn fast and build real '
      'solutions.';

  static const email = 'your.email@example.com'; // CHANGE
  static const phone = '+92 3XX XXXXXXX'; // CHANGE
  static const location = 'Attock, Pakistan';

  static const fields = [
    Item(Icons.language, 'Web Development',
        'Responsive websites and full-stack apps using Node.js, React and REST APIs.'),
    Item(Icons.psychology_outlined, 'Artificial Intelligence',
        'Data analysis and visualization with Python, Pandas, NumPy, Matplotlib and Seaborn.'),
    Item(Icons.phone_android, 'Mobile App Development',
        'Cross-platform apps with Flutter and Dart.'),
  ];

  static const experience = [
    Item(Icons.emoji_events_outlined, 'Hackathons',
        'Participated in hackathons and built team-based solutions under time pressure.'),
    Item(Icons.terminal, 'Online Coding Competitions',
        'Competed in online coding contests to strengthen problem solving.'),
    Item(Icons.workspace_premium_outlined, 'Flutter Mobile App Fellowship',
        'Completed a fellowship focused on building mobile apps with Flutter.'),
  ];

  static const groups = ['Web Development', 'Mobile', 'AI & Data'];

  static const skills = [
    Skill('HTML', 0.90, 'Web Development'),
    Skill('CSS', 0.85, 'Web Development'),
    Skill('JavaScript', 0.75, 'Web Development'),
    Skill('Node.js', 0.65, 'Web Development'),
    Skill('React', 0.65, 'Web Development'),
    Skill('REST APIs', 0.70, 'Web Development'),
    Skill('Flutter', 0.80, 'Mobile'),
    Skill('Dart', 0.80, 'Mobile'),
    Skill('Python', 0.85, 'AI & Data'),
    Skill('Pandas', 0.75, 'AI & Data'),
    Skill('NumPy', 0.75, 'AI & Data'),
    Skill('Matplotlib', 0.75, 'AI & Data'),
    Skill('Seaborn', 0.70, 'AI & Data'),
  ];

  static const strengths = [
    'Problem Solving',
    'Competitive Coding',
    'Teamwork',
    'Fast Learner',
  ];
}

// ===========================================================================
// 2. THEME: teal green + salmon pink, with light & dark modes
// ===========================================================================
class Pal {
  final bool dark;
  const Pal(this.dark);

  static const Color accent = Color(0xFF0D9488); // teal green
  static const Color accent2 = Color(0xFFFA8072); // salmon pink
  static const LinearGradient grad = LinearGradient(
    colors: [accent, accent2],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  Color get bg => dark ? const Color(0xFF08171A) : const Color(0xFFF3FAF8);
  Color get alt => dark ? const Color(0xFF0B1F22) : const Color(0xFFE4F3F0);
  Color get surface => dark ? const Color(0xFF10282B) : Colors.white;
  Color get border => dark ? const Color(0xFF1D3B3F) : const Color(0xFFCFE6E1);
  Color get text => dark ? const Color(0xFFE8F5F3) : const Color(0xFF0F2A2A);
  Color get muted => dark ? const Color(0xFF92B0AE) : const Color(0xFF4F6B69);

  // Accent text colour that stays readable on light backgrounds
  Color get tag => dark ? accent2 : const Color(0xFFD94F45);

  // Home (hero) section colours
  List<Color> get heroColors => dark
      ? const [Color(0xFF08171A), Color(0xFF0F3D3E), Color(0xFF115E59)]
      : const [Color(0xFFE6F6F3), Color(0xFFD1EFE9), Color(0xFFFFE4DE)];
  Color get heroTitle => dark ? Colors.white : const Color(0xFF0F2A2A);
  Color get heroSub => dark ? Colors.white70 : const Color(0xFF3F5F5C);
  Color get heroRole =>
      dark ? const Color(0xFF99F6E4) : const Color(0xFF0F766E);
}

class Scope extends InheritedWidget {
  final bool dark;
  final VoidCallback toggle;
  const Scope({
    super.key,
    required this.dark,
    required this.toggle,
    required super.child,
  });

  Pal get p => Pal(dark);
  static Scope of(BuildContext c) =>
      c.dependOnInheritedWidgetOfExactType<Scope>()!;

  @override
  bool updateShouldNotify(Scope old) => dark != old.dark;
}

TextStyle ts(double size, Color color,
        {FontWeight w = FontWeight.normal, double? h}) =>
    TextStyle(fontSize: size, color: color, fontWeight: w, height: h);

void toast(BuildContext c, String msg) {
  ScaffoldMessenger.of(c).showSnackBar(SnackBar(
    content: Text(msg),
    behavior: SnackBarBehavior.floating,
    backgroundColor: Pal.accent,
  ));
}

// ===========================================================================
// 3. APP ROOT (StatefulWidget: holds dark/light mode)
// ===========================================================================
class PortfolioApp extends StatefulWidget {
  const PortfolioApp({super.key});
  @override
  State<PortfolioApp> createState() => _PortfolioAppState();
}

class _PortfolioAppState extends State<PortfolioApp> {
  bool _dark = false;

  @override
  Widget build(BuildContext context) {
    final p = Pal(_dark);
    return Scope(
      dark: _dark,
      toggle: () => setState(() => _dark = !_dark),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: '${D.name} - Portfolio',
        theme: ThemeData(
          useMaterial3: true,
          scaffoldBackgroundColor: p.bg,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Pal.accent,
            brightness: _dark ? Brightness.dark : Brightness.light,
          ),
        ),
        home: const PortfolioPage(),
      ),
    );
  }
}

// ===========================================================================
// 4. MAIN PAGE: navigation, smooth scrolling, back-to-top button
// ===========================================================================
class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});
  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  final _home = GlobalKey();
  final _about = GlobalKey();
  final _profession = GlobalKey();
  final _experience = GlobalKey();
  final _skills = GlobalKey();
  final _contact = GlobalKey();
  final _scroll = ScrollController();
  bool _showTop = false;

  @override
  void initState() {
    super.initState();
    _scroll.addListener(() {
      final show = _scroll.offset > 500;
      if (show != _showTop) setState(() => _showTop = show);
    });
  }

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  void _go(GlobalKey key) {
    final ctx = key.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(ctx,
          duration: const Duration(milliseconds: 700),
          curve: Curves.easeInOutCubic);
    }
  }

  @override
  Widget build(BuildContext context) {
    final sc = Scope.of(context);
    final p = sc.p;
    final nav = <String, GlobalKey>{
      'Home': _home,
      'About': _about,
      'Profession': _profession,
      'Experience': _experience,
      'Skills': _skills,
      'Contact': _contact,
    };
    final wide = MediaQuery.of(context).size.width > 920;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: p.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        shape: Border(bottom: BorderSide(color: p.border)),
        titleSpacing: 20,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                gradient: Pal.grad,
                borderRadius: BorderRadius.circular(10),
              ),
              alignment: Alignment.center,
              child: Text(D.initials,
                  style: ts(14, Colors.white, w: FontWeight.bold)),
            ),
            const SizedBox(width: 10),
            Text(D.name, style: ts(17, p.text, w: FontWeight.bold)),
          ],
        ),
        actions: [
          if (wide)
            for (final e in nav.entries)
              TextButton(
                onPressed: () => _go(e.value),
                child: Text(e.key, style: ts(14.5, p.muted)),
              ),
          IconButton(
            tooltip: sc.dark ? 'Switch to light mode' : 'Switch to dark mode',
            onPressed: sc.toggle,
            icon: Icon(sc.dark ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
                color: p.text),
          ),
          if (!wide)
            PopupMenuButton<GlobalKey>(
              icon: Icon(Icons.menu, color: p.text),
              color: p.surface,
              onSelected: _go,
              itemBuilder: (_) => [
                for (final e in nav.entries)
                  PopupMenuItem(
                      value: e.value,
                      child: Text(e.key, style: ts(14, p.text))),
              ],
            ),
          const SizedBox(width: 10),
        ],
      ),
      floatingActionButton: AnimatedScale(
        scale: _showTop ? 1 : 0,
        duration: const Duration(milliseconds: 200),
        child: FloatingActionButton.small(
          backgroundColor: Pal.accent,
          foregroundColor: Colors.white,
          onPressed: () => _scroll.animateTo(0,
              duration: const Duration(milliseconds: 700),
              curve: Curves.easeInOutCubic),
          child: const Icon(Icons.arrow_upward),
        ),
      ),
      body: SingleChildScrollView(
        controller: _scroll,
        child: Column(
          children: [
            Hero1(
                key: _home,
                onContact: () => _go(_contact),
                onSkills: () => _go(_skills)),
            AboutSection(key: _about),
            ProfessionSection(key: _profession),
            ExperienceSection(key: _experience),
            SkillsSection(key: _skills),
            ContactSection(key: _contact),
            const Footer(),
          ],
        ),
      ),
    );
  }
}

// ===========================================================================
// 5. SHARED WIDGETS
// ===========================================================================
class ContentWidth extends StatelessWidget {
  final Widget child;
  const ContentWidth({super.key, required this.child});
  @override
  Widget build(BuildContext context) => Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1050),
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22), child: child),
        ),
      );
}

class Section extends StatelessWidget {
  final String tag, title, subtitle;
  final bool alt;
  final Widget child;
  const Section({
    super.key,
    required this.tag,
    required this.title,
    required this.subtitle,
    required this.child,
    this.alt = false,
  });

  @override
  Widget build(BuildContext context) {
    final p = Scope.of(context).p;
    return Container(
      width: double.infinity,
      color: alt ? p.alt : p.bg,
      padding: const EdgeInsets.symmetric(vertical: 70),
      child: ContentWidth(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(tag.toUpperCase(),
                style: ts(12.5, p.tag, w: FontWeight.bold)
                    .copyWith(letterSpacing: 2.5)),
            const SizedBox(height: 8),
            Text(title, style: ts(32, p.text, w: FontWeight.bold)),
            const SizedBox(height: 10),
            Container(
              width: 70,
              height: 4,
              decoration: BoxDecoration(
                  gradient: Pal.grad, borderRadius: BorderRadius.circular(4)),
            ),
            const SizedBox(height: 12),
            Text(subtitle, style: ts(15, p.muted)),
            const SizedBox(height: 32),
            child,
          ],
        ),
      ),
    );
  }
}

// Card that lifts and glows on mouse hover
class HoverCard extends StatefulWidget {
  final Widget child;
  final double? width;
  final double? minHeight;
  final EdgeInsets padding;
  const HoverCard({
    super.key,
    required this.child,
    this.width,
    this.minHeight,
    this.padding = const EdgeInsets.all(22),
  });
  @override
  State<HoverCard> createState() => _HoverCardState();
}

class _HoverCardState extends State<HoverCard> {
  bool _hover = false;
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final p = Scope.of(context).p;
    final double scale = _pressed ? 0.97 : (_hover ? 1.025 : 1.0);
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() {
        _hover = false;
        _pressed = false;
      }),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _pressed = true),
        onTapUp: (_) => setState(() => _pressed = false),
        onTapCancel: () => setState(() => _pressed = false),
        child: AnimatedSlide(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOut,
          offset: Offset(0, _hover ? -0.02 : 0),
          child: AnimatedScale(
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeOut,
            scale: scale,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              width: widget.width,
              constraints: widget.minHeight == null
                  ? null
                  : BoxConstraints(minHeight: widget.minHeight!),
              alignment:
                  widget.minHeight == null ? null : Alignment.centerLeft,
              padding: widget.padding,
              decoration: BoxDecoration(
                color: p.surface,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: _hover ? Pal.accent : p.border),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(13, 148, 136, _hover ? 0.28 : 0.08),
                    blurRadius: _hover ? 28 : 14,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: widget.child,
            ),
          ),
        ),
      ),
    );
  }
}

class GradIcon extends StatelessWidget {
  final IconData icon;
  final double size;
  const GradIcon(this.icon, {super.key, this.size = 48});
  @override
  Widget build(BuildContext context) => Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
            gradient: Pal.grad, borderRadius: BorderRadius.circular(14)),
        child: Icon(icon, color: Colors.white, size: size * 0.5),
      );
}

// ===========================================================================
// 6. HOME
// ===========================================================================
class Hero1 extends StatelessWidget {
  final VoidCallback onContact, onSkills;
  const Hero1({super.key, required this.onContact, required this.onSkills});

  @override
  Widget build(BuildContext context) {
    final p = Scope.of(context).p;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: p.heroColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: -90,
            right: -70,
            child: Container(
              width: 320,
              height: 320,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromRGBO(250, 128, 114, 0.14),
              ),
            ),
          ),
          Positioned(
            bottom: -110,
            left: -60,
            child: Container(
              width: 300,
              height: 300,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromRGBO(13, 148, 136, 0.16),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 80),
            child: ContentWidth(
              child: LayoutBuilder(builder: (context, c) {
                final wide = c.maxWidth > 760;
                final align =
                    wide ? CrossAxisAlignment.start : CrossAxisAlignment.center;
                final ta = wide ? TextAlign.left : TextAlign.center;

                final text = Column(
                  crossAxisAlignment: align,
                  children: [
                    Text("Hello, I'm", style: ts(18, p.tag)),
                    const SizedBox(height: 4),
                    Text(D.name,
                        textAlign: ta,
                        style: ts(wide ? 54 : 38, p.heroTitle,
                            w: FontWeight.bold)),
                    const SizedBox(height: 10),
                    Text(D.profession,
                        textAlign: ta,
                        style: ts(16, p.heroRole,
                            w: FontWeight.w600)),
                    const SizedBox(height: 14),
                    Text(D.tagline,
                        textAlign: ta,
                        style: ts(15.5, p.heroSub, h: 1.6)),
                    const SizedBox(height: 28),
                    Wrap(
                      spacing: 14,
                      runSpacing: 12,
                      alignment:
                          wide ? WrapAlignment.start : WrapAlignment.center,
                      children: [
                        ElevatedButton.icon(
                          onPressed: onContact,
                          icon: const Icon(Icons.mail_outline),
                          label: const Text('Contact Me'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Pal.accent,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 18),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14)),
                          ),
                        ),
                        OutlinedButton.icon(
                          onPressed: onSkills,
                          icon: const Icon(Icons.bolt_outlined),
                          label: const Text('View Skills'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: p.heroTitle,
                            side: BorderSide(
                                color: p.dark ? Colors.white38 : Pal.accent),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 18),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14)),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 34),
                    Wrap(
                      spacing: 14,
                      runSpacing: 14,
                      alignment:
                          wide ? WrapAlignment.start : WrapAlignment.center,
                      children: const [
                        HeroStat(D.cgpa, 'CGPA'),
                        HeroStat(D.semester, 'Semester'),
                        HeroStat('3+', 'Experiences'),
                      ],
                    ),
                  ],
                );

                final avatar = Container(
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, gradient: Pal.grad),
                  child: CircleAvatar(
                    radius: wide ? 110 : 75,
                    backgroundColor: const Color(0xFF134E4A),
                    // Real photo: backgroundImage: const AssetImage('assets/profile.jpg'),
                    child: Text(D.initials,
                        style: ts(wide ? 74 : 50, Colors.white,
                                w: FontWeight.bold)
                            .copyWith(letterSpacing: 3)),
                  ),
                );

                return wide
                    ? Row(children: [
                        Expanded(child: text),
                        const SizedBox(width: 40),
                        avatar,
                      ])
                    : Column(children: [
                        avatar,
                        const SizedBox(height: 30),
                        text,
                      ]);
              }),
            ),
          ),
        ],
      ),
    );
  }
}

class HeroStat extends StatelessWidget {
  final String value, label;
  const HeroStat(this.value, this.label, {super.key});
  @override
  Widget build(BuildContext context) {
    final p = Scope.of(context).p;
    return Container(
      width: 112,
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: p.dark ? const Color.fromRGBO(255, 255, 255, 0.07) : Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
            color: p.dark
                ? const Color.fromRGBO(255, 255, 255, 0.14)
                : p.border),
      ),
      child: Column(children: [
        Text(value, style: ts(22, p.tag, w: FontWeight.bold)),
        const SizedBox(height: 3),
        Text(label, style: ts(12, p.dark ? Colors.white60 : p.muted)),
      ]),
    );
  }
}

// ===========================================================================
// 7. ABOUT
// ===========================================================================
class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final p = Scope.of(context).p;
    final info = [
      (Icons.school_outlined, 'University', D.university),
      (Icons.location_city_outlined, 'Campus', D.campus),
      (Icons.menu_book_outlined, 'Degree', D.degree),
      (Icons.calendar_month_outlined, 'Current Semester', D.semester),
      (Icons.star_outline, 'CGPA', D.cgpa),
    ];
    return Section(
      tag: 'Who I am',
      title: 'About Me',
      subtitle: 'A little about me and my education',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HoverCard(
            width: double.infinity,
            child: Text(D.about, style: ts(15.5, p.muted, h: 1.8)),
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              for (final i in info)
                HoverCard(
                  width: 320,
                  padding: const EdgeInsets.all(16),
                  child: Row(children: [
                    GradIcon(i.$1, size: 44),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(i.$2, style: ts(12, p.muted)),
                          const SizedBox(height: 3),
                          Text(i.$3,
                              style: ts(15, p.text, w: FontWeight.w600)),
                        ],
                      ),
                    ),
                  ]),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// 8. PROFESSION  (fields of work)
// ===========================================================================
class ProfessionSection extends StatelessWidget {
  const ProfessionSection({super.key});

  @override
  Widget build(BuildContext context) {
    final p = Scope.of(context).p;
    return Section(
      tag: 'What I do',
      title: 'Profession',
      subtitle: 'The fields I work in and the technologies I use',
      alt: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LayoutBuilder(builder: (context, c) {
            final cards = [
              for (final f in D.fields)
                HoverCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GradIcon(f.icon),
                      const SizedBox(height: 16),
                      Text(f.title,
                          style: ts(18, p.text, w: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Text(f.detail, style: ts(14, p.muted, h: 1.6)),
                    ],
                  ),
                ),
            ];
            if (c.maxWidth > 860) {
              // wide screen: 3 cards side by side, all the same height
              return IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    for (var i = 0; i < cards.length; i++) ...[
                      if (i > 0) const SizedBox(width: 16),
                      Expanded(child: cards[i]),
                    ],
                  ],
                ),
              );
            }
            return Column(children: [
              for (var i = 0; i < cards.length; i++) ...[
                if (i > 0) const SizedBox(height: 16),
                SizedBox(width: double.infinity, child: cards[i]),
              ],
            ]);
          }),
        ],
      ),
    );
  }
}

// ===========================================================================
// 8b. EXPERIENCE  (separate section with its own background)
// ===========================================================================
class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final p = Scope.of(context).p;
    final exp = D.experience;
    return Section(
      tag: 'My journey',
      title: 'Experience',
      subtitle: 'Hackathons, competitions and learning so far',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (var i = 0; i < exp.length; i++)
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    width: 34,
                    child: Column(children: [
                      Container(
                        width: 16,
                        height: 16,
                        margin: const EdgeInsets.only(top: 22),
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, gradient: Pal.grad),
                      ),
                      if (i != exp.length - 1)
                        Expanded(
                            child: Container(width: 2, color: p.border)),
                    ]),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: HoverCard(
                        minHeight: 96,
                        padding: const EdgeInsets.all(18),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(exp[i].icon, color: p.tag, size: 28),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(exp[i].title,
                                      style: ts(16, p.text,
                                          w: FontWeight.w600)),
                                  const SizedBox(height: 5),
                                  Text(exp[i].detail,
                                      style: ts(14, p.muted, h: 1.5)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

// ===========================================================================
// 9. SKILLS  (category filter + animated progress bars)
// ===========================================================================
class SkillsSection extends StatefulWidget {
  const SkillsSection({super.key});
  @override
  State<SkillsSection> createState() => _SkillsSectionState();
}

class _SkillsSectionState extends State<SkillsSection> {
  String _selected = 'All';

  @override
  Widget build(BuildContext context) {
    final p = Scope.of(context).p;
    final filters = ['All', ...D.groups];
    final shown = _selected == 'All'
        ? D.skills
        : D.skills.where((s) => s.group == _selected).toList();

    return Section(
      tag: 'What I know',
      title: 'Skills',
      subtitle: 'Filter by category to explore my technical skills',
      alt: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              for (final f in filters)
                ChoiceChip(
                  label: Text(f),
                  selected: _selected == f,
                  showCheckmark: false,
                  selectedColor: Pal.accent,
                  backgroundColor: p.surface,
                  side: BorderSide(
                      color: _selected == f ? Pal.accent : p.border),
                  labelStyle: ts(13.5,
                      _selected == f ? Colors.white : p.muted,
                      w: FontWeight.w600),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  onSelected: (_) => setState(() => _selected = f),
                ),
            ],
          ),
          const SizedBox(height: 26),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: Wrap(
              key: ValueKey(_selected),
              spacing: 16,
              runSpacing: 16,
              children: [for (final s in shown) SkillCard(skill: s)],
            ),
          ),
          const SizedBox(height: 40),
          Text('Strengths', style: ts(20, p.text, w: FontWeight.bold)),
          const SizedBox(height: 14),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              for (final s in D.strengths)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
                  decoration: BoxDecoration(
                    color: p.surface,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Pal.accent2),
                  ),
                  child: Text(s, style: ts(13.5, p.text, w: FontWeight.w600)),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class SkillCard extends StatelessWidget {
  final Skill skill;
  const SkillCard({super.key, required this.skill});

  @override
  Widget build(BuildContext context) {
    final p = Scope.of(context).p;
    return HoverCard(
      width: 320,
      padding: const EdgeInsets.all(18),
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: skill.level),
        duration: const Duration(milliseconds: 1100),
        curve: Curves.easeOutCubic,
        builder: (context, v, _) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(skill.name,
                    style: ts(16, p.text, w: FontWeight.w600)),
                Text('${(v * 100).round()}%',
                    style: ts(13.5, p.tag, w: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 4),
            Text(skill.group, style: ts(12, p.muted)),
            const SizedBox(height: 14),
            Container(
              height: 8,
              decoration: BoxDecoration(
                  color: p.border, borderRadius: BorderRadius.circular(8)),
              alignment: Alignment.centerLeft,
              child: FractionallySizedBox(
                widthFactor: v,
                child: Container(
                  decoration: BoxDecoration(
                      gradient: Pal.grad,
                      borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ===========================================================================
// 10. CONTACT  (info cards + validated form)
// ===========================================================================
class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final p = Scope.of(context).p;
    final info = HoverCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Let's work together",
                  style: ts(20, p.text, w: FontWeight.bold)),
              const SizedBox(height: 8),
              Text('Tap the copy icon to copy any detail.',
                  style: ts(13.5, p.muted)),
            ],
          ),
          const ContactRow(Icons.email_outlined, 'Email', D.email),
          const ContactRow(Icons.phone_outlined, 'Phone', D.phone),
          const ContactRow(Icons.location_on_outlined, 'Location', D.location),
        ],
      ),
    );
    const form = HoverCard(child: ContactForm());

    return Section(
      tag: 'Get in touch',
      title: 'Contact',
      subtitle: 'Have a project or opportunity in mind? Send me a message',
      child: LayoutBuilder(builder: (context, c) {
        if (c.maxWidth > 760) {
          return IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(child: info),
                const SizedBox(width: 20),
                const Expanded(child: form),
              ],
            ),
          );
        }
        return Column(children: [info, const SizedBox(height: 20), form]);
      }),
    );
  }
}

class ContactRow extends StatelessWidget {
  final IconData icon;
  final String label, value;
  const ContactRow(this.icon, this.label, this.value, {super.key});

  @override
  Widget build(BuildContext context) {
    final p = Scope.of(context).p;
    return Row(children: [
      GradIcon(icon, size: 44),
      const SizedBox(width: 14),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: ts(12, p.muted)),
            const SizedBox(height: 2),
            Text(value, style: ts(15, p.text, w: FontWeight.w600)),
          ],
        ),
      ),
      IconButton(
        tooltip: 'Copy',
        icon: Icon(Icons.copy_rounded, size: 19, color: p.muted),
        onPressed: () async {
          await Clipboard.setData(ClipboardData(text: value));
          if (context.mounted) toast(context, '$label copied');
        },
      ),
    ]);
  }
}

class ContactForm extends StatefulWidget {
  const ContactForm({super.key});
  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _msg = TextEditingController();
  bool _sending = false;

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _msg.dispose();
    super.dispose();
  }

  InputDecoration _dec(Pal p, String label, IconData icon) {
    OutlineInputBorder b(Color c) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: c));
    return InputDecoration(
      labelText: label,
      labelStyle: ts(14, p.muted),
      prefixIcon: Icon(icon, color: p.muted),
      filled: true,
      fillColor: p.bg,
      border: b(p.border),
      enabledBorder: b(p.border),
      focusedBorder: b(Pal.accent),
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _sending = true);
    await Future.delayed(const Duration(milliseconds: 900));
    if (!mounted) return;
    setState(() => _sending = false);
    final who = _name.text.trim();
    _formKey.currentState!.reset();
    _name.clear();
    _email.clear();
    _msg.clear();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Message ready'),
        content: Text('Thank you, $who! Your message was recorded.\n\n'
            '(Demo form: connect an email service or backend to deliver it.)'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final p = Scope.of(context).p;
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Send a message', style: ts(20, p.text, w: FontWeight.bold)),
          const SizedBox(height: 18),
          TextFormField(
            controller: _name,
            style: ts(15, p.text),
            decoration: _dec(p, 'Your name', Icons.person_outline),
            validator: (v) =>
                (v == null || v.trim().isEmpty) ? 'Please enter your name' : null,
          ),
          const SizedBox(height: 14),
          TextFormField(
            controller: _email,
            style: ts(15, p.text),
            keyboardType: TextInputType.emailAddress,
            decoration: _dec(p, 'Your email', Icons.email_outlined),
            validator: (v) => RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$')
                    .hasMatch(v?.trim() ?? '')
                ? null
                : 'Enter a valid email address',
          ),
          const SizedBox(height: 14),
          TextFormField(
            controller: _msg,
            style: ts(15, p.text),
            maxLines: 4,
            decoration: _dec(p, 'Message', Icons.chat_bubble_outline),
            validator: (v) => (v == null || v.trim().length < 10)
                ? 'Message should be at least 10 characters'
                : null,
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton.icon(
              onPressed: _sending ? null : _submit,
              icon: _sending
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                          strokeWidth: 2, color: Colors.white))
                  : const Icon(Icons.send_rounded),
              label: Text(_sending ? 'Sending...' : 'Send Message',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w600)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Pal.accent,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// 11. FOOTER
// ===========================================================================
class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    final p = Scope.of(context).p;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 26),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [p.heroColors[0], p.heroColors[1]]),
        border: Border(top: BorderSide(color: p.border)),
      ),
      child: Center(
        child: Text('© 2026 ${D.name}  •  Built with Flutter',
            style: ts(13, p.dark ? Colors.white60 : p.muted)),
      ),
    );
  }
}
