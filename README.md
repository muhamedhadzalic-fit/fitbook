# FitBook

A two-sided marketplace connecting clients with verified personal trainers.

University seminar project — *Razvoj softvera II*, FIT Mostar, index **230209**.

**Roles:** Client · Trainer · Admin. Trainers self-register from the mobile app into a `Pending`
state; an admin verifies them from the desktop app. Trainers — not admins — confirm and reject
their own bookings.

## What runs today

| Part | State |
|---|---|
| `fitbook_mobile` — Android, client + trainer | **All 14 screens built**, running on mock data |
| `fitbook_desktop` — Windows, admin | **All 7 screens built**, running on mock data |
| `FitBook.Api` · `FitBook.Worker` · `Services` · `Repository` · `Domain` | Project scaffold only |

Both Flutter apps are the finished presentation layer with no backend attached: no HTTP client, no
auth, no Stripe, no PDF generation. Every literal they display lives under `lib/mockup/` in each
app, so wiring the API means replacing that directory with repositories returning the same model
types — no screen changes.

Run steps and role credentials for the graded build land here once auth exists.

## Running the apps

Both apps talk to the API over **plain HTTP** — no HTTPS, no self-signed certificates. The base URL
is supplied at build time and is never hardcoded in source.

### Mobile (Android)

```bash
cd fitbook_mobile
flutter pub get
flutter run -d android --dart-define=API_BASE_URL=http://10.0.2.2:5274
```

`10.0.2.2` is the standard Android emulator address for the host machine.

The app opens on the **welcome screen**. "Create account" leads into registration — pick *I'm a
member* to land in the client app, or *I'm a trainer* to continue through the trainer application
into the trainer workspace. "I already have an account" signs straight in as a client, standing in
for the login form until auth exists.

The client app is four tabs — Home, Discover, Bookings, Profile — with trainer profiles, the
booking flow, notifications, membership and the assistant pushed on top. Tapping a trainer on Home
runs the full journey: trainer → reserve → confirm → back on the Bookings tab with the new
reservation flagged. The trainer app is three tabs: Bookings, Report, Profile.

Sign out from Profile → *Sign out* to get back to the welcome screen and try the other role.

### Desktop (Windows)

```bash
cd fitbook_desktop
flutter pub get
flutter run -d windows --dart-define=API_BASE_URL=http://localhost:5274
```

The app opens on the admin dashboard. Navigate with the sidebar; clicking a reservation row opens
its read-only detail view. Locations, Notifications, Payments and Settings are in the design but
not yet built, and say so when opened.

### Backend

```bash
dotnet build
dotnet run --project FitBook.Api      # http://localhost:5274
dotnet run --project FitBook.Worker   # separate microservice process
```

The API is still the project template. Nothing in the Flutter apps calls it yet.

## Tests and checks

```bash
# per app
flutter analyze
dart format lib test
flutter test                                 # everything
flutter test test/widget_test.dart           # behaviour
flutter test test/screens_render_test.dart   # layout sweep over every screen
```

The layout sweep pumps every screen — the mobile app at a phone viewport, the admin app at three
window sizes including a deliberately cramped one — and fails on any layout overflow.

Widget tests that assert on layout must call `loadInterFonts()` from `test/test_fonts.dart` in
`setUpAll`. Without it Flutter substitutes a font whose glyphs are all squares the width of the
font size, which reports overflows that do not exist in the real app.

## Typeface

Inter (weights 400/500/600/700/800) is committed under each app's `assets/fonts/` rather than
fetched through `google_fonts`. A runtime font download would leave both apps looking wrong on an
offline machine.

## Repository layout

```
FitBook.Api/          HTTP, controllers, DI, middleware, SignalR hubs
FitBook.Services/     business rules, booking state machine, ML.NET recommender
FitBook.Repository/   EF queries, entity configuration, DbContext
FitBook.Domain/       entities, enums, DTOs, custom exceptions
FitBook.Worker/       RabbitMQ consumer, email and notification handlers
fitbook_desktop/      Flutter Desktop — admin (Windows)
fitbook_mobile/       Flutter Mobile — client + trainer (Android)
```

Each project carries its own layer-specific working notes in a `CLAUDE.md`, alongside the project
and grading context under `.claude/context/`. Both are kept out of version control, so they are
local working documents rather than part of the delivered repository.

## Stack

SQL Server (database `230209`) · RabbitMQ · SignalR · Stripe sandbox · ML.NET · Docker Compose ·
Flutter Desktop (Windows) + Flutter Mobile (Android). There is no web frontend.
