var Icosplay = {

    path : {
        favorite_user_path : function (user_id) {
             return "/users/" + user_id + "/favorite";
        },

        unfavorite_user_path : function(user_id) {
            return "/users/" + user_id + "/unfavorite";
        },

        favorite_photo_path : function(photo_id) {
            return '/photos/' + photo_id + '/favorite';
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
    },

    favorite_photo : function(photo_id, callback) {
        var self = this;
        $.get(self.path.favorite_photo_path(photo_id), function(result){
            if (result.status === 'fail' ) {
                window.location = '/login';
                return;
            }
            callback();
        }, 'json');
    }
};
