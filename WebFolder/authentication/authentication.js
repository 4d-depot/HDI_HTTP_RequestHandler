function onClick()
{
sendData({identifier:document.forms['myForm'].elements['identifier'].value , password:document.forms['myForm'].elements['password'].value})
};

function sendData(data) {
  var XHR = new XMLHttpRequest();
  
  XHR.onload = function() {
    let result = XHR.response;
    if (result === 'OK')  { 
      window.location = "/myApp";
      }
      else {
      document.getElementById("authenticationFailed").style.visibility = "visible";
      document.getElementById("authenticationFailed").innerHTML = result;
      }
  };
  XHR.open('POST', '/authenticate/'); 
  XHR.send(JSON.stringify(data));
};