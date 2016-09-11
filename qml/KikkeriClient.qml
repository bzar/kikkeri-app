import QtQuick 2.0
import "util.js" as Util

Item {
  property string siteUrl
  property variant players: []
  property variant tags: []
  property variant latestGames: []

  signal error(int code, string cause)

  function updatePlayers(err) {
    Util.get(siteUrl + "/player/", function(req) {
      players = JSON.parse(req.response);
    }, function(req) {
      error(req.status, req.statusText);
      if(err) err(req);
    });
  }

  function updateTags(err) {
    Util.get(siteUrl + "/game/tags/", function(req) {
      tags = JSON.parse(req.response);
    }, function(req) {
      error(req.status, req.statusText);
      if(err) err(req);
    });
  }

  function updateLatestGames(err) {
    Util.get(siteUrl + "/game/?limit=20", function(req) {
      latestGames = JSON.parse(req.response);
      for(var i = 0; i < latestGames.length; ++i) {
        var game = latestGames[i];
        for(var t = 0; t < game.teams.length; ++t) {
          var team = game.teams[t];
          for(var p = 0; p < team.players.length; ++p) {
            var name = team.players[p];
            if(players.indexOf(name) === -1) {
              players.push(name);
            }
          }
        }
      }
      players.sort();
    }, function(req) {
      error(req.status, req.statusText);
      if(err) err(req);
    });
  }


  function submit(game) {
    Util.post(siteUrl + /game/, game, function(req) {
      updateLatestGames();
    }, function(req) {
      error(req.status, req.statusText);
      if(err) err(req);
    });
  }

  function getGames(params, cb, err) {
    Util.get(siteUrl + "/game/?" + Util.obj2params(params), function(req) {
      cb(JSON.parse(req.response));
    }, function(req) {
      error(req.status, req.statusText);
      if(err) err(req);
    });

  }
}
