var exec = require('cordova/exec');

var SharePlugin = {
    share: function(options, success, error) {
        exec(success, error, 'SharePlugin', 'share', [options]);
    }
};

module.exports = SharePlugin;
