$(function() {

    var gallery;
    var $gallery = $('#gallery');
    var $inc = $('#inc');

    $gallery.galleria({
        width:800,
        height:700,

        extend: function(options) {
            this.bind('image', function(e) {
//                Album.share($(e.imageTarget).attr('src'));

            });
        }
    });

    gallery = Galleria.get(0);

    $inc.click(function() {
        var $this = $(this);
        $.post('/photos/' + $(gallery.getActiveImage()).attr('id') + '/inc', {}, function(){
            $this.css('color', 'silver');
        });

        return false;
    });


});


var Album = {
    share: function(pic) {
        var _w = 32 , _h = 32;
        var param = {
            url:location.href,
            type:'1',
            count:'', /**是否显示分享数，1显示(可选)*/
            appkey:'', /**您申请的应用appkey,显示分享来源(可选)*/
            title:'', /**分享的文字内容(可选，默认为所在页面的title)*/
            pic:'', /**分享图片的路径(可选)*/
            ralateUid:'', /**关联用户的UID，分享微博会@该用户(可选)*/
            rnd:new Date().valueOf()
        };

        param.pic = 'http://blog.omy.sg/annalim/files/2009/07/cosplay02lilith_2.jpg';
        var temp = [];
        for (var p in param) {
            temp.push(p + '=' + encodeURIComponent(param[p] || ''))
        }

        $('#sina').html('<iframe allowTransparency="true" frameborder="0" scrolling="no" src="http://hits.sinajs.cn/A1/weiboshare.html?' +
                temp.join('&') + '" width="' + _w + '" height="' + _h + '"></iframe>');
    }
};