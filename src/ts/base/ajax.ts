import { Popup } from "./popup";

export module Ajax {

  function request(verb: string, url: string, next: Function) {
    var request = new XMLHttpRequest();
    request.open(verb, url, true);

    request.onload = function() {
      let status = null;
      let message = null;
      let data = null;

      if (request.status >= 200 && request.status < 400) {

        try {
          status = request.status;
          message = request.statusText;
          data = JSON.parse(request.responseText);
          Popup.show(Popup.Type.SUCCESS, 'Success', request.statusText);
        }
        catch(e) {
          status = request.status;
          data = null;
          Popup.show(Popup.Type.ERROR, 'ERROR', 'The server responded with bad data.');
        }
        next(null, {
          status: request.status,
          message: request.statusText,
          data: JSON.parse(request.responseText)
        });
      } else {
        Popup.show(Popup.Type.ERROR, 'Error', request.statusText);
        next({
          status: request.status,
          message: request.statusText,
          data: null
          }, null);

      }
    };

    request.onerror = function() {
      Popup.show(Popup.Type.ERROR, 'Error', 'No connection found');
      next({
        status: null,
        message: 'connection error',
        data: null
      }, null);
    };

    request.send();
  }

  export function post(url: string, next: Function) {
    request('POST', url, next);
  }

  export function get(url: string, next: Function) {
    request('GET', url, next);
  }

  //delete is a reserved word
  export function remove(url: string, next: Function) {
    request('DELETE', url, next);
  }

  export function put(url: string, next: Function) {
    request('PUT', url, next);
  }

  export function update(url: string, next: Function) {
    request('UPDATE', url, next);
  }

  export function patch(url: string, next: Function) {
    request('PATCH', url, next);
  }


}
