#!/bin/bash

# Image parameters
width=400
height=160
columns=11
rows=5
dot_radius=5  # Radius of the dots
dot_color="gray"
background="none"  # Transparent background

# Calculate spacing
col_spacing=$((width / (columns + 1)))
row_spacing=$((height / (rows + 1)))

# Create a new image with transparent background
convert -size ${width}x${height} xc:$background -format png miff:- | \

# Add the dots in a grid pattern
while read x y; do
  convert - -fill $dot_color -draw "circle $x,$y $((x + dot_radius)),$y" miff:-
done <<EOF |
$(for row in $(seq 1 $rows); do
  for col in $(seq 1 $columns); do
    echo "$((col * col_spacing)) $((row * row_spacing))"
  done
done)
EOF

# Save the final image
convert - output.png

