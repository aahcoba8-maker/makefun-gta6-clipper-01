#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"
mkdir -p clip
ffmpeg -y -hide_banner -i trailer2.mp4 -f lavfi -i "color=c=0x101421:s=1080x1920:r=30:d=4" \
-filter_complex "\
[0:v]split=5[s0][s1][s2][s3][s4];\
[s0]trim=start=8:duration=4,setpts=PTS-STARTPTS,split=2[b0][f0];\
[b0]scale=1080:1920:flags=bilinear,boxblur=22:8,eq=brightness=-0.12:saturation=0.75[bg0];\
[f0]scale=1080:-2:flags=lanczos[fg0];\
[bg0][fg0]overlay=(W-w)/2:(H-h)/2:shortest=1,setsar=1[v0];\
[s1]trim=start=96:duration=7,setpts=PTS-STARTPTS,split=2[b1][f1];\
[b1]scale=1080:1920:flags=bilinear,boxblur=22:8,eq=brightness=-0.12:saturation=0.75[bg1];\
[f1]scale=1080:-2:flags=lanczos[fg1];\
[bg1][fg1]overlay=(W-w)/2:(H-h)/2:shortest=1,setsar=1[v1];\
[s2]trim=start=120:duration=6,setpts=PTS-STARTPTS,split=2[b2][f2];\
[b2]scale=1080:1920:flags=bilinear,boxblur=22:8,eq=brightness=-0.12:saturation=0.75[bg2];\
[f2]scale=1080:-2:flags=lanczos[fg2];\
[bg2][fg2]overlay=(W-w)/2:(H-h)/2:shortest=1,setsar=1[v2];\
[s3]trim=start=126:duration=8,setpts=PTS-STARTPTS,split=2[b3][f3];\
[b3]scale=1080:1920:flags=bilinear,boxblur=22:8,eq=brightness=-0.12:saturation=0.75[bg3];\
[f3]scale=1080:-2:flags=lanczos[fg3];\
[bg3][fg3]overlay=(W-w)/2:(H-h)/2:shortest=1,setsar=1[v3];\
[s4]trim=start=142:duration=8,setpts=PTS-STARTPTS,split=2[b4][f4];\
[b4]scale=1080:1920:flags=bilinear,boxblur=22:8,eq=brightness=-0.12:saturation=0.75[bg4];\
[f4]scale=1080:-2:flags=lanczos[fg4];\
[bg4][fg4]overlay=(W-w)/2:(H-h)/2:shortest=1,setsar=1[v4];\
[v0][v1][v2][v3][v4]concat=n=5:v=1:a=0[montage];\
[1:v]trim=duration=4,setpts=PTS-STARTPTS,format=yuv420p,setsar=1[card];\
[montage][card]concat=n=2:v=1:a=0,drawtext=fontfile=/usr/share/fonts/truetype/dejavu/DejaVuSans-Bold.ttf:text='GTA 6 IS COMING':fontcolor=white:fontsize=92:borderw=5:bordercolor=black:box=1:boxcolor=black@0.48:boxborderw=18:x=(w-text_w)/2:y=330:enable='between(t,0,2)',drawtext=fontfile=/usr/share/fonts/truetype/dejavu/DejaVuSans-Bold.ttf:text='My AI agent cut this clip —':fontcolor=white:fontsize=42:borderw=3:bordercolor=black:box=1:boxcolor=black@0.65:boxborderw=18:x=(w-text_w)/2:y=1400:enable='between(t,13,21)',drawtext=fontfile=/usr/share/fonts/truetype/dejavu/DejaVuSans-Bold.ttf:text='you can earn money making clips':fontcolor=white:fontsize=42:borderw=3:bordercolor=black:box=1:boxcolor=black@0.65:boxborderw=18:x=(w-text_w)/2:y=1470:enable='between(t,13,21)',drawtext=fontfile=/usr/share/fonts/truetype/dejavu/DejaVuSans-Bold.ttf:text='with AI on make.fun.':fontcolor=white:fontsize=42:borderw=3:bordercolor=black:box=1:boxcolor=black@0.65:boxborderw=18:x=(w-text_w)/2:y=1540:enable='between(t,13,21)',drawtext=fontfile=/usr/share/fonts/truetype/dejavu/DejaVuSans-Bold.ttf:text='make.fun':fontcolor=0xF4C95D:fontsize=90:x=(w-text_w)/2:y=760:enable='between(t,33,37)',drawtext=fontfile=/usr/share/fonts/truetype/dejavu/DejaVuSans-Bold.ttf:text='Play code\\:':fontcolor=white:fontsize=48:x=(w-text_w)/2:y=920:enable='between(t,33,37)',drawtext=fontfile=/usr/share/fonts/truetype/dejavu/DejaVuSans-Bold.ttf:text='makefun-doorway-moss-syrup':fontcolor=white:fontsize=48:x=(w-text_w)/2:y=1000:enable='between(t,33,37)'[outv]" \
-map "[outv]" -an -t 37 -r 30 -c:v libx264 -preset medium -crf 19 -pix_fmt yuv420p -movflags +faststart clip/gta6-clipper-01-short.mp4
