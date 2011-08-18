$(function(){
   var $selected_city = $('#selected_city');
    var $cities = $('.cities');

    $selected_city.toggle(function(){
        $cities.show();
    }, function(){
        $cities.hide();
    });
});