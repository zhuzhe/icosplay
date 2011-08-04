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
});