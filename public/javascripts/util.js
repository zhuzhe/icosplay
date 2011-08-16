var Util = {
    array_dif : function(arr1, arr2) {
        var arr1_hash = {};
        var result = [];
        var i;
        for (i = 0; i < arr1.length; i++) {
            arr1_hash[arr1[i]] = true;
        }
        for (i = 0; i < arr2.length; i++) {
            var key2 = arr2[i];
            if (arr1_hash[key2]) {
                arr1_hash[key2] = false;
            }
        }
        for (var key in arr1_hash) {

            if (arr1_hash[key]) {
                result.push(key);
            }
        }
        return result;
    },

     array_same : function(arr1, arr2) {
        var arr1_hash = {};
        var result = [];
        var SAME = 'SAME';
        var i;
        for (i = 0; i < arr1.length; i++) {
            arr1_hash[arr1[i]] = true;
        }
        for (i = 0; i < arr2.length; i++) {
            var key2 = arr2[i];
            if (arr1_hash[key2]) {
                arr1_hash[key2] = SAME;
            }
        }
        for (var key in arr1_hash) {
            if (arr1_hash[key] === SAME) {
                result.push(key);
            }
        }
        return result;
    }
};