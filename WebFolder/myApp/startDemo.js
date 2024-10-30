
  updateCurrent();
  
function populateCurrent(result) {   
    var logElem = document.getElementById("current");
    logElem.innerHTML = result.result
}
        
   
function changeStylesNext() {

 var element = document.getElementById("nextButton");
 element.classList.remove("btn-primary");
 element.classList.add("btn-success");
    
 var element = document.getElementById("current");
 element.classList.add("border-bottom");
 element.classList.add("border-success");
 element.classList.add("border-3");
 //$('.nextButton').addClass('class');

}   


function onClickNext() {
  
    provideNext();
    //changeStylesNext();
}

function onClick20Requests() {
   
   for (let i = 0; i < 20; i++)
{
    let requestURL = 'http://127.0.0.1:8044/rest/$catalog/provideSequentialNumber';
    let request = new XMLHttpRequest();
    request.open('POST', requestURL);
    request.responseType = 'json';
    request.send();
    
    request.onload = function() {
      let result = request.response;
      populateResult(result);
      updateCurrent();
    }
 } 
    var element = document.getElementById("clearResultsButton");
    element.classList.remove("disabled");
 
}

function onClickClear() {
   
populateResult();
 
}


function populateResult(result) {
if (result === undefined)
  {  
    var logElem = document.getElementById("requestsResult");
    logElem.innerHTML = '';
  }
  else
  {
    var logElem = document.getElementById("requestsResult");
    if (logElem.innerHTML)
      {
         logElem.innerHTML = logElem.innerHTML + ' -  ' + result.result;
      }
      else
      {
           logElem.innerHTML = result.result;
      }
   }
  
} 

function updateCurrent() {

    let requestURL = 'http://127.0.0.1:8044/rest/$catalog/currentSequentialNumber';
    let request = new XMLHttpRequest();
    request.open('POST', requestURL);
    request.responseType = 'json';
    request.send();
    
    request.onload = function() {
      let result = request.response;
      populateCurrent(result);
    }

}

function provideNext() {

    let requestURL = 'http://127.0.0.1:8044/rest/$catalog/provideSequentialNumber';
    let request = new XMLHttpRequest();
    request.open('POST', requestURL);
    request.responseType = 'json';
    request.send();
    
  request.onload = function() {
  let result = request.response;
  populateCurrent(result);
  }

}

