START_DATE="2025-02-01"
DAYS=90
FILE="README.md"

# Calculate start and end dates in seconds since epoch
START_SECONDS=$(date -d "$START_DATE" "+%s")
END_SECONDS=$(date "+%s")  # Current date/time

# Calculate the total number of seconds in the date range
RANGE_SECONDS=$((END_SECONDS - START_SECONDS))

for ((i=0; i<$DAYS; i++)); do
  # Generate a random number of seconds within the date range
  RANDOM_SECONDS=$((RANDOM % RANGE_SECONDS))
  # Calculate random commit date
  COMMIT_SECONDS=$((START_SECONDS + RANDOM_SECONDS))
  COMMIT_DATE=$(date -d "@$COMMIT_SECONDS" "+%Y-%m-%dT%H:%M:%S")
  COMMIT_DISPLAY=$(date -d "@$COMMIT_SECONDS" "+%Y-%m-%d %H:%M:%S")
  echo "Commit on $COMMIT_DISPLAY" >> $FILE
  git add $FILE
  GIT_AUTHOR_DATE="$COMMIT_DATE" GIT_COMMITTER_DATE="$COMMIT_DATE" git commit -m "Auto commit on $COMMIT_DISPLAY"
done

echo "✅ Done generating fake commits."
