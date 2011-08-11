var Icosplay = {

    path : {
        favorite_user_path : function (user_id) {
             return "/users/" + user_id + "/favorite";
        },

        unfavorite_user_path : function(user_id) {
            return "/users/" + user_id + "/unfavorite";
        }
    },

    favorite_user : function(user_id, callback) {
        var self = this;
        $.get(self.path.favorite_user_path(user_id), function(){
            callback();
        }, 'json');
    },

    unfavorite_user : function(user_id, callback) {
        var self = this;
        $.get(self.path.unfavorite_user_path(user_id), function(){
              callback();
        }, 'json');
    }
};