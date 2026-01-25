#!/usr/bin/env bash

# momento_mori.sh

set -euo pipefail

birth_date="1979-09-11" # YYYY-MM-DD
life_expectancy=85      # years

SECONDS_PER_DAY=86400
DAYS_PER_YEAR=365.2422
DAYS_PER_MONTH=$(awk "BEGIN{print $DAYS_PER_YEAR/12}")

end_epoch=$(date -d "$birth_date + ${life_expectancy} years" +%s)
now_epoch=$(date +%s)

remaining_days=$(((end_epoch - now_epoch) / SECONDS_PER_DAY))
remaining_years=$(awk "BEGIN{print int(($remaining_days/$DAYS_PER_YEAR)+0.5)}")
remaining_months=$(awk "BEGIN{print int(($remaining_days/$DAYS_PER_MONTH)+0.5)}")

target_date=$(date -d "@$end_epoch" +%F)

# IMPORTANT: emit \\n (two characters) so JSON stays valid
printf '{"text":"%s | %s | %s","tooltip":"Birth: %s\\nExpectancy: %sy\\nTarget: %s","class":"life-left"}\n' \
  "$remaining_years" "$remaining_months" "$remaining_days" \
  "$birth_date" "$life_expectancy" "$target_date"

