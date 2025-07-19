# 🎵 Installing Jam

Jam is a lightweight terminal music launcher powered by `fzf`, designed for quick playlist building and playback from your local music directory.

---

## 📦 Installation

### Option 1: Clone and Source

1. **Clone the repository**:
   ```bash
   git clone https://github.com/yourusername/jam.git ~/projects/jam
   ```

2. **Set your music directory**:  
   Open `jam` and update the first line to point to your music folder:
   ```bash
   nano ~/projects/jam/jam
   ```
   Change:
   ```zsh
   MUSIC_DIR="$HOME/Music"
   ```
   to match your actual music directory.

3. **Source `jam` in your shell config**:

   - For `zsh` users:
     ```bash
     echo 'source ~/projects/jam/jam' >> ~/.zshrc
     ```

   - For `bash` users:
     ```bash
     echo 'source ~/projects/jam/jam' >> ~/.bashrc
     ```

4. **Reload your shell**:
   ```bash
   source ~/.zshrc   # or ~/.bashrc
   ```

---

### Option 2: Manual Copy

1. **Copy `jam.` to a standard location**:
   ```bash
   mkdir -p ~/.jam
   cp jam ~/.jam/jam
   ```

2. **Edit the file to set your music directory**:
   ```bash
   nano ~/.jam/jam
   ```
   Update the `MUSIC_DIR` variable as needed.

3. **Source it in your shell config**:
   ```bash
   echo 'source ~/.jam/jam' >> ~/.zshrc   # or ~/.bashrc
   ```

4. **Reload your shell**:
   ```bash
   source ~/.zshrc   # or ~/.bashrc
   ```

---

## 🚀 Getting Started

1. **Launch Jam**:
   ```bash
   jam
   ```

2. **Select music**:
   - `fzf` will open in your terminal, showing the contents of your music directory.
   - Use the **arrow keys** to navigate.
   - Press **TAB** to add a song to your playlist.
   - Press **Enter** to start playback.

3. **Controls**:
   - Press `q` to quit playback.
   - Press `Ctrl+C` to exit Jam at any time.

---

## 🎛 Available Commands

1. jam help (jh) prints a list of all available commands with a summary of the commands.


```

---
## .jamrc has configuration for aliases.

## 🛠 Configuration

- You can customize:
  - `MUSIC_DIR` — your music folder
  - `PLAYER_CMD` — the command used to play music (e.g., `mocp`, `mpv`)
  - Keybindings and playlist behavior

All of this lives inside `jam`.

---

## 🧪 Requirements

- `fzf`
- `mocp` or another terminal music player
- A folder of playable audio files (`.mp3`, `.ogg`, `.flac`, etc.)
- UTF-8-compatible terminal  
  *(If some glyphs appear as tofu ▯▯, consider using a Nerd Font for better rendering.)*

---

## 💬 Need Help?

Open an [issue](https://github.com/yourusername/jam/issues) or check out the [CONTRIBUTING.md](./CONTRIBUTING.md) for more info.

---

Happy jamming! 🎧
