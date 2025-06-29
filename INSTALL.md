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
   Open `jam.zsh` and update the first line to point to your music folder:
   ```bash
   nano ~/projects/jam/jam.zsh
   ```
   Change:
   ```zsh
   MUSIC_DIR="$HOME/Music"
   ```
   to match your actual music directory.

3. **Source `jam.zsh` in your shell config**:

   - For `zsh` users:
     ```bash
     echo 'source ~/projects/jam/jam.zsh' >> ~/.zshrc
     ```

   - For `bash` users:
     ```bash
     echo 'source ~/projects/jam/jam.zsh' >> ~/.bashrc
     ```

4. **Reload your shell**:
   ```bash
   source ~/.zshrc   # or ~/.bashrc
   ```

---

### Option 2: Manual Copy

1. **Copy `jam.zsh` to a standard location**:
   ```bash
   mkdir -p ~/.jam
   cp jam.zsh ~/.jam/jam.zsh
   ```

2. **Edit the file to set your music directory**:
   ```bash
   nano ~/.jam/jam.zsh
   ```
   Update the `MUSIC_DIR` variable as needed.

3. **Source it in your shell config**:
   ```bash
   echo 'source ~/.jam/jam.zsh' >> ~/.zshrc   # or ~/.bashrc
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

```bash
jam
```
Launches the interactive `fzf` interface to browse your music directory.

```bash
jam status
```
Shows loop/shuffle status, playlist count, and currently playing track.

```bash
jam clear
```
Clears the playlist and stops playback.

```bash
jam play
```
Starts playback of the current playlist.

```bash
jam stop
```
Stops playback without clearing the playlist.

```bash
jam pause
```
Toggles pause/resume on the current track.

```bash
jam next
```
Skips to the next track.

```bash
jam prev
```
Rewinds to the previous track.

```bash
jam loop
```
Toggles loop mode on/off.

```bash
jam shuffle
```
Toggles shuffle mode on/off.

```bash
jam random
```
Adds a random track to the playlist and starts playback if idle.

```bash
jam save
```
Saves the current playlist to a timestamped `.m3u` file in your music directory.

```bash
jam help
```
Displays a summary of all available commands.

---

## 🛠 Configuration

- You can customize:
  - `MUSIC_DIR` — your music folder
  - `PLAYER_CMD` — the command used to play music (e.g., `mocp`, `mpv`)
  - Keybindings and playlist behavior

All of this lives inside `jam.zsh`.

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
