$(function() {
    var FAVORITE_ID = 'favorite';
    var UNFAVORITE_ID = 'unfavorite';
    var $favorite = $('#' + FAVORITE_ID);
    var favorite_callback = function() {
        $favorite.hide();
        $unfavorite.show();
    };

    var $unfavorite = $('#' + UNFAVORITE_ID);
    var unfavorite_callback = function() {
        $favorite.show();
        $unfavorite.hide();
    };

    $favorite.click(function() {
        var $this = $(this);
        Icosplay.favorite_user($this.attr('user_id'), favorite_callback);
    });

    $unfavorite.click(function() {
        var $this = $(this);
        Icosplay.unfavorite_user($this.attr('user_id'), unfavorite_callback)
    });

});