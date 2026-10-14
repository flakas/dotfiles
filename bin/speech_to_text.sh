#!/bin/bash

# Speech to text script for Copilot button
# Logs press/release events to ~/.cache/s2t.log

LOG_FILE="$HOME/.cache/s2t.log"
STATE_FILE="$HOME/.cache/s2t.state"
PID_FILE="$HOME/.cache/s2t.pid"
AUDIO_FILE="$HOME/.cache/s2t_recording.wav"
EVENT_TYPE="${1:-unknown}"

# Whisper.cpp configuration
WHISPER_BIN="$HOME/whisper.cpp/build/bin/whisper-cli"
WHISPER_MODEL="$HOME/whisper.cpp/models/ggml-base.en.bin"

# Ensure cache directory exists
mkdir -p "$(dirname "$LOG_FILE")"

# Get timestamp
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S.%3N')

# Log the event
case "$EVENT_TYPE" in
    press)
        # Only log and act on the first press (ignore key repeat)
        if [[ ! -f "$STATE_FILE" ]]; then
            touch "$STATE_FILE"
            echo "[$TIMESTAMP] COPILOT BUTTON PRESSED - Starting recording" >> "$LOG_FILE"

            # Start recording audio in background
            # Format: 16kHz, 16-bit, mono WAV (standard for speech recognition)
            arecord -f S16_LE -r 16000 -c 1 "$AUDIO_FILE" > /dev/null 2>&1 &
            RECORD_PID=$!
            echo "$RECORD_PID" > "$PID_FILE"

            echo "[$TIMESTAMP] Recording started (PID: $RECORD_PID)" >> "$LOG_FILE"
        fi
        ;;
    release)
        # Only log if we have an active press state
        if [[ -f "$STATE_FILE" ]]; then
            echo "[$TIMESTAMP] COPILOT BUTTON RELEASED - Stopping recording" >> "$LOG_FILE"

            # Stop recording
            if [[ -f "$PID_FILE" ]]; then
                RECORD_PID=$(cat "$PID_FILE")
                if kill -0 "$RECORD_PID" 2>/dev/null; then
                    kill "$RECORD_PID" 2>/dev/null
                    wait "$RECORD_PID" 2>/dev/null
                    echo "[$TIMESTAMP] Recording stopped" >> "$LOG_FILE"
                fi
                rm -f "$PID_FILE"
            fi

            # Process with whisper.cpp if audio file exists
            if [[ -f "$AUDIO_FILE" ]]; then
                echo "[$TIMESTAMP] Processing audio with whisper.cpp..." >> "$LOG_FILE"

                # Run whisper and capture output
                # Extract only the transcription text (after the timestamp)
                START_TIME=$(date +%s.%N)
                TRANSCRIPTION=$("$WHISPER_BIN" -m "$WHISPER_MODEL" -f "$AUDIO_FILE" 2>&1 | grep "^\[" | sed 's/\[.*\]//g' | tr -d '\n' | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
                END_TIME=$(date +%s.%N)
                PROCESSING_TIME=$(echo "$END_TIME - $START_TIME" | bc)

                if [[ -n "$TRANSCRIPTION" ]]; then
                    echo "[$TIMESTAMP] TRANSCRIPTION: $TRANSCRIPTION" >> "$LOG_FILE"
                    echo "[$TIMESTAMP] Processing time: ${PROCESSING_TIME}s" >> "$LOG_FILE"

                    # Copy to both clipboard selections for maximum compatibility
                    echo -n "$TRANSCRIPTION" | xclip -selection clipboard
                    echo -n "$TRANSCRIPTION" | xclip -selection primary
                    echo "[$TIMESTAMP] Copied to clipboard" >> "$LOG_FILE"

                    # Type the text directly - works in all applications
                    sleep 0.1
                    xdotool type --delay 0 "$TRANSCRIPTION"
                    echo "[$TIMESTAMP] Typed into active input" >> "$LOG_FILE"
                else
                    echo "[$TIMESTAMP] No transcription generated (audio may be too short or empty)" >> "$LOG_FILE"
                fi

                # Clean up audio file
                rm -f "$AUDIO_FILE"
            else
                echo "[$TIMESTAMP] ERROR: Audio file not found" >> "$LOG_FILE"
            fi

            rm -f "$STATE_FILE"
        fi
        ;;
    *)
        echo "[$TIMESTAMP] ERROR: Unknown event type: $EVENT_TYPE" >> "$LOG_FILE"
        exit 1
        ;;
esac
