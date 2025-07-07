const { addonBuilder } = require("stremio-addon-sdk");
const axios = require("axios");
const cheerio = require("cheerio");
require("dotenv").config();

const user = process.env.STREAMUJ_USER;
const pass = process.env.STREAMUJ_PASS;

const manifest = {
  id: "org.streamuj.tv",
  version: "1.2.0",
  name: "StreamujTV (Sosac) Premium",
  description: "Addon pre prehrávanie streamuj.tv (Sosáč) podľa titulov z TMDB/Cinemeta",
  catalogs: [],
  resources: ["stream"],
  types: ["movie"],
  idPrefixes: ["tt"]
};

const builder = new addonBuilder(manifest);

builder.defineStreamHandler(async ({ id }) => {
  console.log("📡 Požiadavka na stream ID:", id);

  try {
    const imdbId = id.startsWith("tt") ? id : null;
    if (!imdbId) return { streams: [] };

    const url = `http://tv.sosac.to/jsonsearchapi.php?q=${imdbId}`;
    const response = await axios.get(url);

    if (!Array.isArray(response.data) || !response.data.length) return { streams: [] };

    const detailId = response.data[0].video;
    const videoUrl = `http://www.streamuj.tv/video/${detailId}`;
    const res = await axios.get(videoUrl);
    const $ = cheerio.load(res.data);
    const scripts = $('script').map((i, el) => $(el).html()).get();
    const mp4Link = scripts.find(s => s && s.includes(".mp4"));
    const match = mp4Link && mp4Link.match(/(https?:\/\/[^"']+\.mp4[^"']*)/);

    if (match && match[1]) {
      const finalUrl = `${match[1]}?pass=${user}:::${pass}`;
      return {
        streams: [{ title: "HD Streamuj.tv (prémiový)", url: finalUrl }]
      };
    }
  } catch (e) {
    console.error("❗ Chyba vo stream handleri:", e.message);
  }

  return { streams: [] };
});

require("http").createServer(builder.getInterface()).listen(7000, () => {
  console.log("✅ Addon beží na http://localhost:7000/manifest.json");
});