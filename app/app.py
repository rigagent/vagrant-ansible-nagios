#!/usr/bin/python

import os
from bottle import route, run

@route('/app')
def app():
    return '''
        <b> Application created on Bottle Py! </b> <hr>
        System load average per one minute
    '''

@route('/app/loadavg')
def loadavg():
    return str(os.getloadavg()[0])

if __name__ == "__main__":
    run(host='0.0.0.0', port=5000, debug=True)
