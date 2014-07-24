window.Modal = {
 initialize: function () {
   $(document).on('click', "[data-attribute=button]",  this.showVideo.bind(this));
   $(document).on('click',"[data-dismiss=modal]", this.closeVideo.bind(this));
 },

  showVideo: function (event) {
    event.preventDefault();
    var youtube_id = $(event.target).attr('data-id');
    var $html = JST['templates/modal']({youtube_id: youtube_id});
    $(document.body).append($html);
  },

  closeVideo: function (event){
    event.preventDefault();
    $(document).find("[data-attribute=modal]").remove();
  }
};