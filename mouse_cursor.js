var p = document.getElementById('yes');

var cursorNormal = 'url(https://www.kindpng.com/imgv/iRxThox_white-png-picsart-white-circle-sticker-png-transparent/#gal_white-png-picsart-white-circle-sticker-png-transparent-png_iRxThox_1621766.png) 25 25, auto;';
var cursorFilled = 'url(https://www.transparentpng.com/thumb/circle/2P2Onf-circle-picture.png) 25, 25, auto;'

function changeCursor() {
    if (p.style.cursor == cursorNormal) {
        p.style.cursor = cursorFilled;
    } else {
        p.style.cursor = cursorNormal;
    }
}

document.body.addEventListener('mousedown', changeCursor);
document.body.addEventListener('mouseup', changeCursor);