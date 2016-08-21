import QtQuick 2.0

QtObject {
  property string players: ""
  property string tags: ""
  property string since
  property string until
  property int numPlayers
  property int limit: 50
  property var results

  function update() {
    var params = {};
    if(players.length > 0) {
      params.players = players;
    }
    if(tags.length > 0) {
      params.gameTags = tags;
    }
    if(since.length > 0) {
      params.since = since;
    }
    if(until.length > 0) {
      params.until = until;
    }
    if(numPlayers) {
      params.numPlayers = numPlayers;
    }

    client.getGames(params, function(games) {
      results = games;
    });
  }
}
