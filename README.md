
# jam
🎵 Command-line music cue system for MOC - 

# 🎵 Jam — Command Line Music Cue System for MOC

**Jam** is a minimalist command-line utility for creating, managing, and saving music playlists using [MOC (Music on Console)](https://moc.daper.net/). It blends fuzzy-search curation with terminal fluency—giving you a fast, expressive way to control your vibe from the shell.

---

## 🔧 Prerequisites

Before you start jamming, make sure these are installed and available in your terminal:

- [`fzf`](https://github.com/junegunn/fzf) — Fuzzy finder for interactive track selection  
  _Install via_ `brew install fzf`, `sudo apt install fzf`, or [fzf install guide](https://github.com/junegunn/fzf#installation)

- [`moc`](https://moc.daper.net/) — MOC: Music On Console, a terminal-based music player  
  _Install via_ `brew install moc` or `sudo apt install moc`

---

## 🎸 Features

- 🎧 `jam` — Launch a fuzzy selector to choose and queue tracks
- 🔢 `jam status` — Show loop/shuffle status, playlist count, and what's now playing
- ⏹️ `jam stop` — Halt playback without clearing the queue
- ⏸️ `jam pause` — Pause/resume playback
- ⏮️ `jam prev` / ⏭️ `jam next` — Skip to previous or next track
- 🔁 `jam loop` — Toggle repeat mode with persistent state
- 🔀 `jam shuffle` — Toggle shuffle mode with persistent state
- 🎲 `jam random` — Play a random track from your collection
- 🧼 `jam clear` — Wipe the current playlist clean
- 💾 `jam save` — Archive your playlist to a timestamped `.m3u` file

---

## 📦 Installation

Clone the project into your preferred dotfiles or script directory:

```bash
git clone https://github.com/hubcapserf/jam.git ~/.jam
 (🎶 Initial commit with jam.zsh, README, LICENSE, and CREDITS)
