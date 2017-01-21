// pull in desired CSS/SASS files
require( './styles/main.scss' );
var $ = jQuery = require( '../../node_modules/jquery/dist/jquery.js' );           // <--- remove if jQuery not needed
require( '../../node_modules/bootstrap-sass/assets/javascripts/bootstrap.js' );   // <--- remove if Bootstrap's JS not needed

// inject bundled Elm app into div#main
require('./data/gh-star-event.json')
var Elm = require( '../elm/Main' );
var main = Elm.Main.embed( document.getElementById( 'main' ) );

// Elm.fullscreen(Elm.Main, {reset:[]});   // take over the whole page
// var div = document.getElementById('elm-main');
// var main = Elm.embed(Elm.Main, div, {reset:[]});

// You can send and receive values through
// ports 'reset' and 'count'.
// main.ports.reset.send([]);
main.ports.check.subscribe(function(event) {
    console.log(event);
});
