const path = require('path');
const fs = require('fs');

const IMAGE_TO_COPY = path.resolve('..', 'guide_snapshots', 'Template.png');

const MAX_X_ROOM = 7;
const MAX_Y_ROOM = 20;

for (let y = -MAX_X_ROOM; y<= MAX_X_ROOM; y++) {
  for (let x = 0; x <= MAX_Y_ROOM; x++) {

    const level = `Level_${x}_${y}`;
    const fileName = path.resolve('..', 'guide_snapshots', `${level}.png`);

    fs.copyFile(IMAGE_TO_COPY, fileName, function (err, data) {
      if (err) {
        return console.log(err);
      }
      console.log('written', fileName)
    });
  }
}