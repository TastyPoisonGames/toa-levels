const path = require('path');
const fs = require('fs');

const FILE_TO_COPY = path.resolve('Levels', 'BaseLevel.tscn');

const MAX_X_ROOM = 7;
const MAX_Y_ROOM = 20;

for (y = -MAX_X_ROOM; y<= MAX_X_ROOM; y++) {
  for (x = 0; x <= MAX_Y_ROOM; x++) {
    const fileName = `NewLevels/Level_${x}_${y}.tscn`
    console.log('Creating', fileName);

    fs.readFile(FILE_TO_COPY, 'utf8', function (err, data) {
      if (err) {
        return console.log(err);
      }

      fs.writeFile(fileName, data, function (err, result) {
        if (err) {
          return console.log(err);
        }
        console.log('written', fileName);
      });
    });
  }
}