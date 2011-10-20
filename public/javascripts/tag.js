var Tag = {
    content: new Array,
    SEPARATOR: ' ',

    add : function(tag_text) {
        if (this.content.length > 0 && this.content[0] === '') {
            this.content.shift();
        }
        this.content.push(tag_text);
        return this;
    },

    remove : function(tag_text) {
        var i;
        for (i = 0; i< this.content.length; i +=1) {
            if (tag_text === this.content[i]) {
                this.content.splice(i, 1);
            }
        }
        return this;
    },

    parseContent : function() {
        return this.content.join(this.SEPARATOR);
    },

    setContent: function(text) {
        this.content = text.split(this.SEPARATOR);
    },

    getContent: function() {
        return this.content;
    }
};

