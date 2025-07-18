
# jam
🎵 Command-line music cue system for MOC - 

# 🎵 Jam — Command Line Music Cue System for MOC

**Jam** is a minimalist command-line utility for creating, managing, and saving music playlists using [MOC (Music on Console)](https://moc.daper.net/). It blends fuzzy-search curation with terminal fluency—giving you a fast, expressive way to control your vibe from the shell.

---

## 🔧 Prerequisites

Note: Depending on which terminal emulator you use, the Unicode glyphs in the shell script may not render properly. Kitty, Wezterm, and Yakuake all render the Unicode glyphs. Konsole does not. Jam was created using the Zsh shell.

Before you start jamming, make sure these are installed and available in your terminal:

- [`fzf`](https://github.com/junegunn/fzf) — Fuzzy finder for interactive track selection  
  _Install via_ `brew install fzf`, `sudo apt install fzf`, or [fzf install guide](https://github.com/junegunn/fzf#installation)

- [`moc`](https://moc.daper.net/) — MOC: Music On Console, a terminal-based music player  
  _Install via_ `brew install moc` or `sudo apt install moc`

---

## 🎸 Features

Usage: jam [command]

 🎬 Session Management
  jam on          (jon)     Start MOC server
  jam off         (jff)     Stop MOC server
  jam stop        (jst)     Stop/start playlist cache rebuild toggle
  jam status      (js)      Show loop/shuffle status and now playing
  jam monitor     (jm)      Show live track updates and loop/shuffle status

 🎵 Playback Control
  jam play        (jp)      Playback from beginning of current playlist
  jam grace       {jg}      Toggle to stop/restart playback from beginning of current track.
  jam quit        (jqt)     Stop playback and keep playlist
  jam pause       (jz)      Pause or resume playback toggle
  jam next        (jn)      Skip to the next track
  jam prev        (jb)      Skip to the previous track
  jam rewind      (jrw)     Rewind current track to the beginning
  jam loop        (jl)      Toggle loop mode
  jam shuffle     (jf)      Toggle shuffle mode

 🔊 Volume Control
  jam volume up   (jvu)     Increase volume
  jam volume down (jvd)     Decrease volume

 📁 Cache & Library Ops
  jam add         (ja)      Add tracks via fzf from selected directory
  jam clear       (jcl)     Clear the playlist and stop playback
  jam load        (jld)     Load the playlist-tracks cache.
  jam save        (jsv)     Save current cache as .m3u
  jam shutdown    (jsd)     Graceful shutdown sequence
  jam random      (jr)      Queue a surprise track
  jam print       (jpt)     Display playlist cache

 🩺 Diagnostics & Docs
  jam sync        (jsy)     Sync default state across all blocks
  jam doctor      (jd)      Show diagnostics output
  jam clean       (jdc)     Clean cache and restore priveledges
  jam help        (jh)      Show this help message

🎛  jam  — Launch fzf and queue tracks interactively

---

## 📦 Installation

Clone the project into your preferred dotfiles or script directory:

```bash
git clone https://github.com/hubcapserf/jam.git ~/.jam
 (🎶 Initial commit with jam, README, LICENSE, and CREDITS)
