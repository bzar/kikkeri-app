function get(url, cb, err) {
  var req = new XMLHttpRequest();
  req.onreadystatechange = function() {
    if (req.readyState === XMLHttpRequest.DONE) {
      if(req.status === 200) {
        cb(req);
      } else {
        err(req);
      }
    }
  }

  console.log("GET " + url)
  req.open("GET", url);
  req.send();
}

function post(url, data, cb, err) {
  var req = new XMLHttpRequest();
  req.onreadystatechange = function() {
    if (req.readyState === XMLHttpRequest.DONE) {
      if(req.status === 200) {
        cb(req);
      } else {
        err(req);
      }
    }
  }

  console.log("POST " + url)
  console.log(JSON.stringify(data))

  req.open("POST", url, true);
  req.setRequestHeader("Content-type", "application/json");
  req.setRequestHeader("Content-length", data.length);
  req.setRequestHeader("Connection", "close");
  req.send(JSON.stringify(data));

}

function obj2params(obj) {
  var params = [];
  for(var key in obj) {
    params.push([key, encodeURIComponent(obj[key])].join("="));
  }
  return params.join("&");
}

function listmodel2array(model) {
  var array = [];
  for(var i = 0; i < model.count; ++i) {
    array.push(model.get(i));
  }
}

function fuzzysince(date) {
  var now = new Date();
  now.setHours(0, 0, 0, 0);
  var delta =  now - date;

  if(delta <= 0) {
    return qsTr("tänään");
  } else {
    var days = parseInt(delta / (1000*60*60*24)) + 1;
    if(days === 1) {
      return qsTr("eilen");
    } else if(days < 7) {
      return qsTr(days + " päivää")
    } else if(days < 30) {
      return qsTr(parseInt(days/7) + " viikkoa")
    } else if(days < 365) {
      return qsTr(parseInt(days/30) + " kuukautta")
    } else {
      return qsTr(parseInt(days/365) + " vuotta")
    }
  }

}
