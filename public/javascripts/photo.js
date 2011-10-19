$(function() {
    var $inc = $('#inc');
    var $photo_id = $('#photo_id');

    $inc.click(function() {
        var $this = $(this);
        $.post('/photos/' + $photo_id.val() + '/inc', {}, function() {
            $this.css('color', 'silver');
        });
        return false;
    });

    var $favorite_photo = $('#favorite_photo');
    var $favorited_photo = $('#favorited_photo');
    var favorite_photo_callback = function() {
        $favorite_photo.hide();
        $favorited_photo.show();
    };

    $favorite_photo.click(function(){
        var $this = $(this);
        Icosplay.favorite_photo($this.attr('photo_id'), favorite_photo_callback);
        return false;
    });

    var resize_photo_box = function() {
        var $photo_box = $('.photo');

    };
});