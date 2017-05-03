'use strict';

require("./static/material.min.css");
require("./static/material.min.js");
require("./static/material_icons.css");

// Require index.html so it gets copied to dist
require('./index.html');

var Elm = require('./Main.elm');
var mountNode = document.getElementById('main');

var flags = {
    gameId: process.env.GAME_ID
};

setTimeout(function() {
    var app = Elm.TestingBoard.embed(mountNode, flags);
});
