### TO JAM MUSIC FROM COMMAND LINE AND BUILD A PLAYLIST
jam() {
  local music_dir="<Users file director>"
  local subcmd=$1
  local status_file
  local playlist_file="/tmp/jam-playlist-tracks"

  case "$subcmd" in
    stop)
      mocp -s
      echo "⏹️ MOC server stopped. Silence... for now."
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
      echo "  🎵 Tracks in Playlist: $song_count"
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
