$(function() {
    var $tags = $('.tag');
    var $tag = $('#tag');
    var SELECTED_CLASS =  'selected';

    $tags.toggle(function() {
        $tag.focus();
        $(this).addClass(SELECTED_CLASS);
        $tag.val(Tag.add($(this).text()).parseContent() + Tag.SEPARATOR);
    }, function() {
        $tag.focus();
        $(this).removeClass(SELECTED_CLASS);
        $tag.val(Tag.remove($(this).text()).parseContent());
    });

    $tag.keyup(function() {
        Tag.setContent($(this).val());
        sync_tags();
        return false;
    });

    var sync_tags = function() {
        $tags.attr('class', 'tag');
        for (var i = 0; i < Tag.getContent().length; i += 1) {
             $tags.each(function(){
                 if ($(this).text() === Tag.getContent()[i]) {
                     $(this).addClass(SELECTED_CLASS);
                 }
             })
        }
    };
});