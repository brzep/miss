globals [teleport-pairs]
patches-own [base-potential potential exit?]

; pcolors
;   green 65 (around)
;   white 9.9
;   blue 108 (around)

to setup-map
  resize-world 0 151 0 80
  set-patch-size 9
  import-pcolors "d17-turtles.bmp"
end

to setup-patches
  let color-accuracy 4
  ask patches with [pcolor = 65] [
    set exit? true
    spread-base-potential 999 false
  ]

  ask patches [
    set potential base-potential
    maybe-show-potential
  ]
end

to spread-base-potential [p teleport-exit-flag]
  (ifelse
    (pcolor = 9.9 or pcolor = 125.4 or pcolor = 14.9 or pcolor = 65 or teleport-exit-flag = true)
    and base-potential < p
    [
      set base-potential p
      ask neighbors4 [ spread-base-potential p - 1 false ]
      ask neighbors [ spread-base-potential p - 1.4 false ]
    ]
    pcolor = 104.2 and base-potential < p [
      set base-potential p
      check-teleport-potential p
    ]
  )
end

to check-teleport-potential [p]
  foreach teleport-pairs [
    this-pair ->
    let tel1-x item 0 item 0 this-pair
    let tel1-y item 1 item 0 this-pair
    let tel2-x item 0 item 1 this-pair
    let tel2-y item 1 item 1 this-pair

    (ifelse
      (tel1-x = pxcor and tel1-y = pycor) [
        ask patch tel2-x tel2-y [ spread-base-potential p - 5 true ]
      ]
      (tel2-x = pxcor and tel2-y = pycor) [
        ask patch tel1-x tel1-y [ spread-base-potential p - 5 true ]
      ]
     )
    ]
end


to setup-turtles
  ask patches with [pcolor = 125.4] [
    sprout 1 [
      set size 2
    ]
    set pcolor 9.9
  ]
  ;create-turtles 400
  ;ask turtles [
  ;  set size 2
  ;  while [ any? other turtles-here or pcolor != 9.9 ] [
  ;    setxy random-xcor random-ycor
  ;    move-to patch-here
  ;  ]
  ;]
end




to add-red-pixel [x y]
  ask patch x y [
    set pcolor red
  ]
end

to setup-teleports
  set teleport-pairs [
    ; 1-2
      [[36 64] [113 65]]
      [[36 63] [113 66]]
      [[36 62] [114 67]]
    ; 2-3
      [[112 64] [37 24]]
      [[112 63] [37 25]]
      [[112 62] [38 26]]
    ; 3-4
      [[36 23] [115 26]]
      [[36 22] [114 25]]
      [[35 21] [114 24]]
  ]
end

to setup
  clear-all

  setup-teleports
  setup-map
  setup-patches
  setup-turtles

  reset-ticks
end

to go
  if count turtles = 0 [ stop ]

  evacuate-exits
  update-potential-field
  move-turtles

  tick
  (ifelse
    ticks = 30 [
      open-kor31
    ]
    ticks = 126 [
      open-431
    ]
    ticks = 134 [
      open-429
    ]
    ticks = 360 [
      open-241
    ]
    ticks = 364 [
      open-kor2
    ]
    ticks = 400 [
      open-428
    ]
    ticks = 410 [
      open-323
    ]
    ticks = 420 [
      open-426
    ]
    ticks = 430 [
      open-327c
    ]
    ticks = 434 [
      open-kor4
    ]
    ticks = 446 [
      open-kor32
    ]
    ticks = 456 [
      open-324
    ]
    ticks = 476 [
      open-430
    ]
    ticks = 480 [
      open-327b
    ]
    ticks = 502 [
      open-kor1
    ]
    ticks = 508 [
      open-327e
    ]
    ticks = 518 [
      open-w3
    ]
    ticks = 560 [
      open-327a
    ]
    ticks = 664 [
      open-327d
    ]
    ticks = 808 [
      open-szat
    ]
  )
end

to evacuate-exits
  ask patches with [ exit? = true ] [
    ask turtles-here [ die ]
  ]
end

to update-potential-field
  ask patches with [ exit? = false ] [
    let nc sum [count turtles-here] of neighbors
    set potential base-potential - nc * 150
    maybe-show-potential
  ]
end

to move-turtles
  ask turtles [
    move-to patch-here

    let color-accuracy 4
    let available-moves neighbors with [ pcolor = 9.9 or pcolor = 65 or pcolor = 104.2 ]
    if any? available-moves [
      let target max-one-of available-moves with [ count turtles-here = 0 ] [potential]
      if target != nobody and [potential] of target > potential [
        face target
        move-to target
      ]
    ]
    check-teleport-move
  ]
end

to check-teleport-move
  foreach teleport-pairs [
    this-pair ->
    let tel1-x item 0 item 0 this-pair
    let tel1-y item 1 item 0 this-pair
    let tel2-x item 0 item 1 this-pair
    let tel2-y item 1 item 1 this-pair

    ifelse tel1-x = xcor and tel1-y = ycor [
      if (count (turtles-on patch tel2-x tel2-y) = 0) [
        setxy tel2-x tel2-y
      ]
    ]
    [
      if tel2-x = xcor and tel2-y = ycor [
      if (count (turtles-on patch tel1-x tel1-y) = 0) [
          setxy tel1-x tel1-y
        ]
      ]
    ]

    ]
end


to maybe-show-potential
  set plabel-color red
  ifelse show-potential? [
    set plabel precision potential 1] [
    set plabel "" ]

end

to open-w3
  ask patch 39 68 [set pcolor 9.9]
  ask patch 40 68 [set pcolor 9.9]

  ask patch 39 69 [
    set exit? true
    set base-potential -2137
    spread-base-potential 999 false
  ]
  ask patch 40 69 [
    set exit? true
    set base-potential -2137
    spread-base-potential 999 false
  ]

  ask patches [
    set potential base-potential
    maybe-show-potential
  ]
  update-potential-field
end

to open-kor31
  ask patch 36 20 [set pcolor 9.9]
  ask patch 37 20 [set pcolor 9.9]
end

to open-431
  ask patch 99 18 [set pcolor 9.9]
end

to open-429
  ask patch 104 12 [set pcolor 9.9]
end

to open-241
  ask patch 132 48 [set pcolor 9.9]
  ask patch 134 48 [set pcolor 9.9]
end

to open-kor2
  ask patch 112 60 [set pcolor 9.9]
  ask patch 113 60 [set pcolor 9.9]
end

to open-428
  ask patch 112 12 [set pcolor 9.9]
end

to open-323
  ask patch 51 14 [set pcolor 9.9]
end

to open-426
  ask patch 123 11 [set pcolor 9.9]
end

to open-327c
  ask patch 32 12 [set pcolor 9.9]
end

to open-kor4
  ask patch 100 16 [set pcolor 9.9]
  ask patch 101 16 [set pcolor 9.9]
  ask patch 102 16 [set pcolor 9.9]
  ask patch 102 15 [set pcolor 9.9]
  ask patch 102 14 [set pcolor 9.9]
  ask patch 102 13 [set pcolor 9.9]
end

to open-kor32
  ask patch 24 13 [set pcolor 9.9]
  ask patch 24 14 [set pcolor 9.9]
  ask patch 24 15 [set pcolor 9.9]
  ask patch 25 15 [set pcolor 9.9]
  ask patch 25 16 [set pcolor 9.9]
  ask patch 26 16 [set pcolor 9.9]
  ask patch 27 16 [set pcolor 9.9]
  ask patch 28 16 [set pcolor 9.9]
  ask patch 29 16 [set pcolor 9.9]
  ask patch 29 15 [set pcolor 9.9]
  ask patch 30 15 [set pcolor 9.9]
  ask patch 30 14 [set pcolor 9.9]
  ask patch 30 13 [set pcolor 9.9]

end

to open-324
  ask patch 58 11 [set pcolor 9.9]
end

to open-430
  ask patch 98 11 [set pcolor 9.9]
end

to open-327b
  ask patch 43 12 [set pcolor 9.9]
end

to open-kor1
  ask patch 38 58 [set pcolor 9.9]
  ask patch 38 57 [set pcolor 9.9]
  ask patch 38 56 [set pcolor 9.9]
end

to open-327e
  ask patch 22 18 [set pcolor 9.9]
end

to open-327a
  ask patch 46 11 [set pcolor 9.9]
end

to open-327d
  ask patch 21 11 [set pcolor 9.9]
end

to open-szat
  ask patch 16 58 [set pcolor 9.9]
  ask patch 17 58 [set pcolor 9.9]
  ask patch 18 58 [set pcolor 9.9]
  ask patch 19 58 [set pcolor 9.9]
  ask patch 20 58 [set pcolor 9.9]
end
@#$#@#$#@
GRAPHICS-WINDOW
274
24
1650
762
-1
-1
9.0
1
1
1
1
1
0
1
1
1
0
151
0
80
0
0
1
ticks
30.0

BUTTON
17
25
130
58
NIL
setup-turtles
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
27
76
127
109
NIL
setup-map
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
14
130
123
163
NIL
clear-turtles
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
15
174
81
207
NIL
setup
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
18
220
130
253
NIL
move-turtles
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

SWITCH
11
335
167
368
show-potential?
show-potential?
0
1
-1000

BUTTON
62
286
125
319
NIL
go
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

PLOT
35
436
235
586
turtles
NIL
NIL
0.0
10.0
0.0
10.0
true
false
"" ""
PENS
"default" 1.0 0 -16777216 true "" "plot count turtles"

@#$#@#$#@
kocham netlogo <3
szkoda tylko, że netlogo mnie nie kocha

pozdrawiamy serdecznie jeśli to czytasz :))
powodzenia z netlogo
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

airplane
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

box
false
0
Polygon -7500403 true true 150 285 285 225 285 75 150 135
Polygon -7500403 true true 150 135 15 75 150 15 285 75
Polygon -7500403 true true 15 75 15 225 150 285 150 135
Line -16777216 false 150 285 150 135
Line -16777216 false 150 135 15 75
Line -16777216 false 150 135 285 75

bug
true
0
Circle -7500403 true true 96 182 108
Circle -7500403 true true 110 127 80
Circle -7500403 true true 110 75 80
Line -7500403 true 150 100 80 30
Line -7500403 true 150 100 220 30

butterfly
true
0
Polygon -7500403 true true 150 165 209 199 225 225 225 255 195 270 165 255 150 240
Polygon -7500403 true true 150 165 89 198 75 225 75 255 105 270 135 255 150 240
Polygon -7500403 true true 139 148 100 105 55 90 25 90 10 105 10 135 25 180 40 195 85 194 139 163
Polygon -7500403 true true 162 150 200 105 245 90 275 90 290 105 290 135 275 180 260 195 215 195 162 165
Polygon -16777216 true false 150 255 135 225 120 150 135 120 150 105 165 120 180 150 165 225
Circle -16777216 true false 135 90 30
Line -16777216 false 150 105 195 60
Line -16777216 false 150 105 105 60

car
false
0
Polygon -7500403 true true 300 180 279 164 261 144 240 135 226 132 213 106 203 84 185 63 159 50 135 50 75 60 0 150 0 165 0 225 300 225 300 180
Circle -16777216 true false 180 180 90
Circle -16777216 true false 30 180 90
Polygon -16777216 true false 162 80 132 78 134 135 209 135 194 105 189 96 180 89
Circle -7500403 true true 47 195 58
Circle -7500403 true true 195 195 58

circle
false
0
Circle -7500403 true true 0 0 300

circle 2
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240

cow
false
0
Polygon -7500403 true true 200 193 197 249 179 249 177 196 166 187 140 189 93 191 78 179 72 211 49 209 48 181 37 149 25 120 25 89 45 72 103 84 179 75 198 76 252 64 272 81 293 103 285 121 255 121 242 118 224 167
Polygon -7500403 true true 73 210 86 251 62 249 48 208
Polygon -7500403 true true 25 114 16 195 9 204 23 213 25 200 39 123

cylinder
false
0
Circle -7500403 true true 0 0 300

dot
false
0
Circle -7500403 true true 90 90 120

face happy
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 255 90 239 62 213 47 191 67 179 90 203 109 218 150 225 192 218 210 203 227 181 251 194 236 217 212 240

face neutral
false
0
Circle -7500403 true true 8 7 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Rectangle -16777216 true false 60 195 240 225

face sad
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 168 90 184 62 210 47 232 67 244 90 220 109 205 150 198 192 205 210 220 227 242 251 229 236 206 212 183

fish
false
0
Polygon -1 true false 44 131 21 87 15 86 0 120 15 150 0 180 13 214 20 212 45 166
Polygon -1 true false 135 195 119 235 95 218 76 210 46 204 60 165
Polygon -1 true false 75 45 83 77 71 103 86 114 166 78 135 60
Polygon -7500403 true true 30 136 151 77 226 81 280 119 292 146 292 160 287 170 270 195 195 210 151 212 30 166
Circle -16777216 true false 215 106 30

flag
false
0
Rectangle -7500403 true true 60 15 75 300
Polygon -7500403 true true 90 150 270 90 90 30
Line -7500403 true 75 135 90 135
Line -7500403 true 75 45 90 45

flower
false
0
Polygon -10899396 true false 135 120 165 165 180 210 180 240 150 300 165 300 195 240 195 195 165 135
Circle -7500403 true true 85 132 38
Circle -7500403 true true 130 147 38
Circle -7500403 true true 192 85 38
Circle -7500403 true true 85 40 38
Circle -7500403 true true 177 40 38
Circle -7500403 true true 177 132 38
Circle -7500403 true true 70 85 38
Circle -7500403 true true 130 25 38
Circle -7500403 true true 96 51 108
Circle -16777216 true false 113 68 74
Polygon -10899396 true false 189 233 219 188 249 173 279 188 234 218
Polygon -10899396 true false 180 255 150 210 105 210 75 240 135 240

house
false
0
Rectangle -7500403 true true 45 120 255 285
Rectangle -16777216 true false 120 210 180 285
Polygon -7500403 true true 15 120 150 15 285 120
Line -16777216 false 30 120 270 120

leaf
false
0
Polygon -7500403 true true 150 210 135 195 120 210 60 210 30 195 60 180 60 165 15 135 30 120 15 105 40 104 45 90 60 90 90 105 105 120 120 120 105 60 120 60 135 30 150 15 165 30 180 60 195 60 180 120 195 120 210 105 240 90 255 90 263 104 285 105 270 120 285 135 240 165 240 180 270 195 240 210 180 210 165 195
Polygon -7500403 true true 135 195 135 240 120 255 105 255 105 285 135 285 165 240 165 195

line
true
0
Line -7500403 true 150 0 150 300

line half
true
0
Line -7500403 true 150 0 150 150

pentagon
false
0
Polygon -7500403 true true 150 15 15 120 60 285 240 285 285 120

person
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105

plant
false
0
Rectangle -7500403 true true 135 90 165 300
Polygon -7500403 true true 135 255 90 210 45 195 75 255 135 285
Polygon -7500403 true true 165 255 210 210 255 195 225 255 165 285
Polygon -7500403 true true 135 180 90 135 45 120 75 180 135 210
Polygon -7500403 true true 165 180 165 210 225 180 255 120 210 135
Polygon -7500403 true true 135 105 90 60 45 45 75 105 135 135
Polygon -7500403 true true 165 105 165 135 225 105 255 45 210 60
Polygon -7500403 true true 135 90 120 45 150 15 180 45 165 90

sheep
false
15
Circle -1 true true 203 65 88
Circle -1 true true 70 65 162
Circle -1 true true 150 105 120
Polygon -7500403 true false 218 120 240 165 255 165 278 120
Circle -7500403 true false 214 72 67
Rectangle -1 true true 164 223 179 298
Polygon -1 true true 45 285 30 285 30 240 15 195 45 210
Circle -1 true true 3 83 150
Rectangle -1 true true 65 221 80 296
Polygon -1 true true 195 285 210 285 210 240 240 210 195 210
Polygon -7500403 true false 276 85 285 105 302 99 294 83
Polygon -7500403 true false 219 85 210 105 193 99 201 83

square
false
0
Rectangle -7500403 true true 30 30 270 270

square 2
false
0
Rectangle -7500403 true true 30 30 270 270
Rectangle -16777216 true false 60 60 240 240

star
false
0
Polygon -7500403 true true 151 1 185 108 298 108 207 175 242 282 151 216 59 282 94 175 3 108 116 108

target
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240
Circle -7500403 true true 60 60 180
Circle -16777216 true false 90 90 120
Circle -7500403 true true 120 120 60

tree
false
0
Circle -7500403 true true 118 3 94
Rectangle -6459832 true false 120 195 180 300
Circle -7500403 true true 65 21 108
Circle -7500403 true true 116 41 127
Circle -7500403 true true 45 90 120
Circle -7500403 true true 104 74 152

triangle
false
0
Polygon -7500403 true true 150 30 15 255 285 255

triangle 2
false
0
Polygon -7500403 true true 150 30 15 255 285 255
Polygon -16777216 true false 151 99 225 223 75 224

truck
false
0
Rectangle -7500403 true true 4 45 195 187
Polygon -7500403 true true 296 193 296 150 259 134 244 104 208 104 207 194
Rectangle -1 true false 195 60 195 105
Polygon -16777216 true false 238 112 252 141 219 141 218 112
Circle -16777216 true false 234 174 42
Rectangle -7500403 true true 181 185 214 194
Circle -16777216 true false 144 174 42
Circle -16777216 true false 24 174 42
Circle -7500403 false true 24 174 42
Circle -7500403 false true 144 174 42
Circle -7500403 false true 234 174 42

turtle
true
0
Polygon -10899396 true false 215 204 240 233 246 254 228 266 215 252 193 210
Polygon -10899396 true false 195 90 225 75 245 75 260 89 269 108 261 124 240 105 225 105 210 105
Polygon -10899396 true false 105 90 75 75 55 75 40 89 31 108 39 124 60 105 75 105 90 105
Polygon -10899396 true false 132 85 134 64 107 51 108 17 150 2 192 18 192 52 169 65 172 87
Polygon -10899396 true false 85 204 60 233 54 254 72 266 85 252 107 210
Polygon -7500403 true true 119 75 179 75 209 101 224 135 220 225 175 261 128 261 81 224 74 135 88 99

wheel
false
0
Circle -7500403 true true 3 3 294
Circle -16777216 true false 30 30 240
Line -7500403 true 150 285 150 15
Line -7500403 true 15 150 285 150
Circle -7500403 true true 120 120 60
Line -7500403 true 216 40 79 269
Line -7500403 true 40 84 269 221
Line -7500403 true 40 216 269 79
Line -7500403 true 84 40 221 269

wolf
false
0
Polygon -16777216 true false 253 133 245 131 245 133
Polygon -7500403 true true 2 194 13 197 30 191 38 193 38 205 20 226 20 257 27 265 38 266 40 260 31 253 31 230 60 206 68 198 75 209 66 228 65 243 82 261 84 268 100 267 103 261 77 239 79 231 100 207 98 196 119 201 143 202 160 195 166 210 172 213 173 238 167 251 160 248 154 265 169 264 178 247 186 240 198 260 200 271 217 271 219 262 207 258 195 230 192 198 210 184 227 164 242 144 259 145 284 151 277 141 293 140 299 134 297 127 273 119 270 105
Polygon -7500403 true true -1 195 14 180 36 166 40 153 53 140 82 131 134 133 159 126 188 115 227 108 236 102 238 98 268 86 269 92 281 87 269 103 269 113

x
false
0
Polygon -7500403 true true 270 75 225 30 30 225 75 270
Polygon -7500403 true true 30 75 75 30 270 225 225 270
@#$#@#$#@
NetLogo 6.4.0
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
default
0.0
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180
@#$#@#$#@
0
@#$#@#$#@
