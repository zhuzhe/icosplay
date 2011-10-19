$(function(){
   var $selected_city = $('#selected_city');
    var $cities = $('.cities');

    $selected_city.toggle(function(){
        $cities.slideDown();
    }, function(){
        $cities.slideUp();
    });
});