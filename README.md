# CineVibe

Spotify dinleme geçmişine göre ruh halini analiz edip film öneren bir uygulama.

Son dinlediğin şarkılar Gemini ile yorumlanır, TMDB üzerinden o moda uyan filmler listelenir.

## Özellikler

- Spotify ile giriş (OAuth)
- Son dinlenen parçalardan ruh hali analizi (Google Gemini)
- Moda göre film önerileri (TMDB)
- Flutter arayüz: giriş, yükleme ve öneri ekranları
- Yerel watchlist desteği

## Mimari

```
CineVibe2/
├── backend/     # Express API (Spotify + Gemini + TMDB)
└── frontend/    # Flutter uygulaması
```

Akış: Spotify login → son dinlenen parçalar → Gemini mood analizi → TMDB araması → öneriler

## Gereksinimler

- Node.js 18+
- Flutter SDK
- Spotify Developer uygulaması
- Google Gemini API anahtarı
- TMDB API anahtarı

## Kurulum

### 1. Backend

```bash
cd backend
cp .env.example .env
npm install
```

`.env` dosyasını doldur:

```env
PORT=3000
SPOTIFY_CLIENT_ID=
SPOTIFY_CLIENT_SECRET=
SPOTIFY_REDIRECT_URI=http://localhost:3000/callback
GEMINI_API_KEY=
TMDB_API_KEY=
```

Sunucuyu başlat:

```bash
npm start
```

API varsayılan olarak `http://localhost:3000` adresinde çalışır.

### 2. Frontend

```bash
cd frontend
flutter pub get
flutter run
```

Android emülatörde backend adresi otomatik olarak `10.0.2.2:3000` kullanılır; iOS/web için `localhost:3000`.

## API

| Method | Endpoint   | Açıklama                                      |
|--------|------------|-----------------------------------------------|
| GET    | `/login`   | Spotify OAuth başlangıcı                      |
| GET    | `/callback`| Spotify auth kodunu token'a çevirir           |
| POST   | `/analyze` | Body: `{ "accessToken" }` → mood + film listesi |

## Teknolojiler

- **Frontend:** Flutter, Provider, Google Fonts
- **Backend:** Node.js, Express
- **Servisler:** Spotify Web API, Google Gemini, TMDB

## Lisans

ISC
