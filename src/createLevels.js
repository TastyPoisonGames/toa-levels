const path = require('path');
const fs = require('fs');

const FILE_TO_COPY = path.resolve('Levels', 'Level.tscn');

const MIN_X_ROOM = -7;
const MAX_X_ROOM = 4;
const MIN_Y_ROOM = 0;
const MAX_Y_ROOM = 19;
const ROOM_SIZE_X = 1280;
const ROOM_SIZE_Y = 720;

var resource_paths = [];
var packed_scenes = [];

let id = 7;

for (let y = MIN_X_ROOM; y<= MAX_X_ROOM; y++) {
  for (let x = MIN_Y_ROOM; x <= MAX_Y_ROOM; x++) {

    const level = `Level_${x}_${y}`;
    const fileName = `NewLevels/${level}.tscn`
    const xPos = ROOM_SIZE_X * x;
    const yPos = ROOM_SIZE_Y * y;

    resource_paths.push(`[ext_resource path="res://src/${fileName}" type="PackedScene" id=${id}]`);

    packed_scenes.push(
      `[node name="${level}" parent="Levels" instance=ExtResource( ${id} )]\nposition = Vector2( ${xPos}, ${yPos} )\n`
    )
    id++;

    fs.readFile(FILE_TO_COPY, 'utf8', function (err, data) {
      if (err) {
        return console.log(err);
      }

      let newData = data.replace('Level_0_0.png', `${level}.png`);

      fs.writeFile(fileName, newData, function (err, result) {
        if (err) {
          return console.log(err);
        }
      });
    });
  }
}

resource_paths.map(rp => console.log(rp));
packed_scenes.map(ps => console.log(ps));