.pragma library

function ajaxGet(url, doneCallback, anyCallback )
{
    const xhr = new XMLHttpRequest();
    xhr.open("GET", url, true);
    xhr.onreadystatechange = function() {
        if (XMLHttpRequest.DONE === xhr.readyState && xhr.status == 200) {
            doneCallback(xhr.responseText);
        } else {
            if("function" === typeof anyCallback) {
                anyCallback(xhr);
            }
        }
    }

    xhr.send();
}
 
