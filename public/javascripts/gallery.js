$(function(){
    $thumb_back = $('.thumb_back');
    $thumb_forward = $('.thumb_forward');
    $gallery_thumb = $('#gallery_thumb');

    $thumb_back.click(function(){
        $gallery_thumb.animate({
           'margin-left': '-=550px'
        }, 2000);
        return false;
    });
});