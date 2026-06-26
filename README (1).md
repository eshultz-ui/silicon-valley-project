# Crew Dispatch — Route Optimizer

A single-page web app that splits jobs across work crews and builds an optimized route for each crew, then reports miles, drive time, labor cost, and fuel cost.

It's one self-contained file (`index.html`) — no build step, no dependencies to install, no server code. Open it in a browser or host it anywhere static.

## Features
- Add a home base and job stops by address, lat/lng, map click, or bulk paste.
- Assign jobs across N crews and optimize each route (real road network via OSRM for ≤99 stops; calibrated estimate for larger batches).
- Balance modes: even workload (finish together), equal stop counts, or fewest total miles.
- Time-of-day traffic model (depart/return times scale drive time, labor, and fuel).
- Round-trip travel-time buffer per crew.
- Cost outputs: total miles, drive time, parallel finish time, labor ($/hr), and fuel ($/gal ÷ MPG).
- "Compare crew counts" to see the cost-vs-time tradeoff and pick the right number of crews.

## Run locally
Just open `index.html` in any modern browser (Chrome, Edge, Firefox, Safari).

## Host it (pick one)
- **Netlify Drop:** go to https://app.netlify.com/drop and drag `index.html` in. Instant public URL, no account required.
- **GitHub Pages:** create a repo, add `index.html`, then Settings → Pages → Deploy from branch → `main` / root. URL: `https://<user>.github.io/<repo>/`.
- **Cloudflare Pages / Vercel:** create a project from the repo (framework preset: none). It serves the file as-is.

## Notes / limitations
- Needs an internet connection: routing uses the public OSRM server and address lookup uses OpenStreetMap Nominatim.
- Address lookups are restricted to the San Francisco Bay Area.
- The public OSRM server caps a distance matrix at 100 locations; above that the app uses a road-calibrated estimate.
- Address geocoding is throttled to ~1 request/second (OpenStreetMap policy); pasting `lat,lng` coordinates is instant.
- No data leaves the browser except routing/geocoding lookups; there is no backend and nothing is stored.
