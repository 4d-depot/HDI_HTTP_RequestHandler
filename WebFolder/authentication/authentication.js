function onClick()
{
sendData({identifier:document.forms['myForm'].elements['identifier'].value , password:document.forms['myForm'].elements['password'].value})
};

function sendData(data) {
  var XHR = new XMLHttpRequest();
  
  let myArray = [];
    
  myArray.push(data);
  
  XHR.onload = function() {
    let result = XHR.response;
    if (JSON.parse(result).result === 'OK')  { 
      window.location = "http://127.0.0.1/myApp/welcome.html";
      }
      else {
      document.getElementById("authenticationFailed").style.visibility = "visible";
      document.getElementById("authenticationFailed").innerHTML = JSON.parse(result).result;
      }
  };
  
  XHR.open('POST', 'http://127.0.0.1:80/rest/$catalog/authentify'); 
// XHR.setRequestHeader('identifier', data.identifier);
//  XHR.setRequestHeader('password', data.password);
  XHR.send(JSON.stringify(myArray));
};