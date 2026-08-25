require('dotenv').config();
const express = require('express');
const cors = require('cors');
const axios = require('axios');
const { GoogleGenerativeAI } = require('@google/generative-ai');

const app = express();
const port = process.env.PORT || 3000;

app.use(cors());
app.use(express.json());

const genAI = new GoogleGenerativeAI(process.env.GEMINI_API_KEY);

// Spotify OAuth Endpoints
app.get('/login', (req, res) => {
  const scope = 'user-read-recently-played user-top-read';
  res.redirect('https://accounts.spotify.com/authorize?' +
    new URLSearchParams({
      response_type: 'code',
      client_id: process.env.SPOTIFY_CLIENT_ID,
      scope: scope,
      redirect_uri: process.env.SPOTIFY_REDIRECT_URI,
    }).toString());
});

app.get('/callback', async (req, res) => {
  const code = req.query.code || null;
  
  try {
    const response = await axios({
      method: 'post',
      url: 'https://accounts.spotify.com/api/token',
      data: new URLSearchParams({
        code: code,
        redirect_uri: process.env.SPOTIFY_REDIRECT_URI,
        grant_type: 'authorization_code',
      }).toString(),
      headers: {
        'content-type': 'application/x-www-form-urlencoded',
        'Authorization': 'Basic ' + (Buffer.from(process.env.SPOTIFY_CLIENT_ID + ':' + process.env.SPOTIFY_CLIENT_SECRET).toString('base64'))
      },
    });

    const { access_token, refresh_token } = response.data;
    // In a real app, we'd redirect to the flutter app with these tokens
    // For now, let's just send them back
    res.json({ access_token, refresh_token });
  } catch (error) {
    console.error(error);
    res.status(500).send('Authentication Error');
  }
});

// Analyze Mood and Suggest Movies
app.post('/analyze', async (req, res) => {
  const { accessToken } = req.body;

  try {
    // 1. Fetch Spotify Data (Recently Played)
    const spotifyRes = await axios.get('https://api.spotify.com/v1/me/player/recently-played?limit=10', {
      headers: { 'Authorization': `Bearer ${accessToken}` }
    });

    const tracks = spotifyRes.data.items.map(item => ({
      name: item.track.name,
      artist: item.track.artists[0].name
    }));

    // 2. Gemini AI Analysis
    const model = genAI.getGenerativeModel({ model: "gemini-1.5-flash" });
    const prompt = `Analyze the following music tracks and artists to determine the user's current "mood". 
    Tracks: ${tracks.map(t => `${t.name} by ${t.artist}`).join(', ')}.
    Return a JSON response with:
    - "mood": a single word mood (e.g., Melancholic, Energetic, Romantic)
    - "description": a short explanation of the mood analysis.
    - "search_keywords": 3 keywords for movie searching.`;

    const result = await model.generateContent(prompt);
    const analysis = JSON.parse(result.response.text().replace(/```json|```/g, ''));

    // 3. TMDB Search
    const tmdbRes = await axios.get(`https://api.themoviedb.org/3/search/movie`, {
      params: {
        api_key: process.env.TMDB_API_KEY,
        query: analysis.search_keywords[0], // Using first keyword for search
        include_adult: false,
        language: 'en-US',
        page: 1
      }
    });

    const movies = tmdbRes.data.results.slice(0, 5).map(movie => ({
      id: movie.id,
      title: movie.title,
      overview: movie.overview,
      poster_path: `https://image.tmdb.org/t/p/w500${movie.poster_path}`,
      release_date: movie.release_date
    }));

    res.json({
      mood: analysis.mood,
      description: analysis.description,
      tracks: tracks,
      movies: movies
    });

  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Analysis failed' });
  }
});

app.listen(port, () => {
  console.log(`Server running at http://localhost:${port}`);
});
