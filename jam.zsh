### TO JAM MUSIC FROM COMMAND LINE AND BUILD A PLAYLIST

[[ -f "$HOME/.jamrc" ]] && source "$HOME/.jamrc"

jam() {
  local music_dir="${JAM_MUSIC_DIR:-<Your music directory>}"
  local subcmd=$1
  local status_file
  local playlist_file="/tmp/jam-playlist-tracks"

  case "$subcmd" in
    stop)
      echo "$(mocp -Q %file 2>/dev/null)" > /tmp/jam-last-track
      mocp -s
      echo "⏹️ MOC server stopped. Silence... for now."
      ;;

     play)
      state=$(mocp -Q %state 2>/dev/null)
      last_track_file="/tmp/jam-last-track"

      if [[ "$state" == "STOP" && -f "$last_track_file" ]]; then
        track=$(<"$last_track_file")
        if [[ -f "$track" ]]; then
          mocp -c                  # Clear current playlist
          mocp -a "$track"         # Add last track back
          mocp -r                  # Rewind to beginning
          mocp -p                  # Play
          echo "🔁 Restarting the last tune: $(basename "$track")"
        else
          echo "⚠️ Couldn’t find the previous track file. Queue something fresh?"
        fi
      elif [[ "$state" == "PAUSE" ]]; then
        echo "⏸️ Currently paused. Use 'jam pause' to resume without rewinding."
      elif [[ "$state" == "PLAY" ]]; then
        echo "🎧 Already mid-vibe. No need to restart."
      else
        echo "⚠️ No recent track found. Let’s jam something new."
      fi
      ;;

    pause)
      state=$(mocp -Q %state 2>/dev/null)
      if [[ "$state" == "PLAY" ]]; then
        echo "⏸️ Pausing the groove..."
        mocp -P
      elif [[ "$state" == "PAUSE" ]]; then
        echo "▶️ Resuming the vibe."
        mocp -U
      else
        echo "⚠️ No track to pause or resume."
      fi
      ;;

    next)
      mocp -f
      echo "⏭️ Skipped to the next tune."
      ;;

    prev)
      mocp -r
      echo "⏮️ Rewound to a previous jam."
      ;;

    loop)
      mocp -t repeat
      status_file="/tmp/jam-loop-status"
      if [[ -f "$status_file" && $(<"$status_file") == "on" ]]; then
        echo "🔁 Loop mode toggled: Repeat off."
        echo "off" > "$status_file"
      else
        echo "🔁 Loop mode toggled: Repeat on."
        echo "on" > "$status_file"
      fi
      ;;

    shuffle)
      mocp -t shuffle
      status_file="/tmp/jam-shuffle-status"
      if [[ -f "$status_file" && $(<"$status_file") == "on" ]]; then
        echo "🔀 Shuffle toggled. Shuffle off."
        echo "off" > "$status_file"
      else
        echo "🔀 Shuffle toggled. Shuffle on."
        echo "on" > "$status_file"
      fi
      ;;

    clear)
      if mocp -Q %state &>/dev/null; then
        mocp -c
        echo "🧼 Cleared the jam playlist. Blank slate, ready to create."
      else
        echo "⚠️ MOC server isn't running. Nothing to clear."
      fi
      rm -f "$playlist_file"
      ;;

    status)
      loop_file="/tmp/jam-loop-status"
      shuffle_file="/tmp/jam-shuffle-status"
      loop_state="off"
      shuffle_state="off"

      [[ -f "$loop_file" ]] && loop_state=$(<"$loop_file")
      [[ -f "$shuffle_file" ]] && shuffle_state=$(<"$shuffle_file")

      song_count=0
      [[ -f "$playlist_file" ]] && song_count=$(wc -l < "$playlist_file")

      now_playing=$(mocp -Q %file 2>/dev/null)
      [[ -n "$now_playing" ]] && now_playing=$(basename "$now_playing")

      echo "🎛️ Jam Mode Status:"
      echo "  🔁 Loop:    $loop_state  →  $([[ "$loop_state" == "on" ]] && echo 'Repeat playlist' || echo 'Stop at end of playlist')"
      echo "  🔀 Shuffle: $shuffle_state  →  $([[ "$shuffle_state" == "on" ]] && echo 'We roll the dice' || echo 'Stickin’ to the script')"
      echo "  🎵 Tracks added this jam session: $song_count"
      [[ -n "$now_playing" ]] && echo "  ▶️ Now Playing: $now_playing"
      ;;

    random)
      track=$(find "$music_dir" -type f \( -iname "*.mp3" -o -iname "*.flac" -o -iname "*.wav" \) | shuf -n1)

      if [[ -n "$track" ]]; then
        if ! mocp -Q %state &>/dev/null; then
          mocp -S
          echo "🎧 MOC server started. Rolling the dice..."
        fi

        mocp -a "$track"
        echo "$track" >> "$playlist_file"

        if [[ "$(mocp -Q %state 2>/dev/null)" != "PLAY" ]]; then
          mocp -p
          echo "🎲 First track queued: $(basename "$track")"
        else
          echo "🎲 Randomly added: $(basename "$track")"
        fi
      else
        echo "🙅 No tracks found to shuffle into the mix."
      fi
      ;;

    save)
      local timestamp
      timestamp=$(date +"%Y%m%d-%H%M")
      local saved_file="$music_dir/playlist-$timestamp.m3u"

      if [[ -s "$playlist_file" ]]; then
        cp "$playlist_file" "$saved_file"
        echo "💾 Playlist saved to: $saved_file"
      else
        echo "⚠️ No tracks to save. Jam something first!"
      fi
      ;;

    help)
      echo "🎵 Jam – Terminal Music Playlist Launcher"
      echo
      echo "Usage: jam [command]"
      echo
      echo "Commands:"
      echo "  jam              Launch fzf to select and queue tracks"
      echo "  jam status       Show loop/shuffle status and now playing"
      echo "  jam clear        Clear the playlist and stop playback"
      echo "  jam stop         Stop playback (mocp -s)"
      echo "  jam play         Playback from beginning of current track"
      echo "  jam pause        Pause or resume playback"
      echo "  jam next         Skip to the next track"
      echo "  jam prev         Rewind to the previous track"
      echo "  jam loop         Toggle loop mode"
      echo "  jam shuffle      Toggle shuffle mode"
      echo "  jam random       Queue and optionally start a random track"
      echo "  jam save         Save the current playlist with a timestamp"
      echo "  jam help         Show this help message"
      ;;

    *)
      if ! mocp -Q %state > /dev/null 2>&1; then
        mocp -S
        echo "🎧 MOC server started. Time to curate the vibes."
      fi

      IFS=$'\n' tracks=($(find "$music_dir" -type f \( -iname "*.mp3" -o -iname "*.flac" -o -iname "*.wav" -o -iname "*.m4a" \) | fzf --multi))

      if (( ${#tracks[@]} )); then
        for track in "${tracks[@]}"; do
          if [[ -f "$track" ]]; then
            mocp -a "$track"
            echo "$track" >> "$playlist_file"
          else
            echo "⚠️ Skipped non-file: $track"
          fi
        done
        mocp -p
        echo "🎶 Playlist queued. Turn the crank."
      else
        echo "🙅 No tracks selected. Silence speaks volumes?"
      fi
      ;;
  esac
}
