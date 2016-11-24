/* Custom scripts for forge.typo3.org */

/* "Join" button */
$(document).ready(function (){$('#joinProjectLink').click(function(){
  $('#joinProjectLink').css('visibility', 'hidden');
  $('#want-to-help').slideDown(0.2);
});})

/* auto_complete*/
function auto_complete(id){
$(id).keyup(function(){
  if($(this).val().length == 0){
    $(id + '_auto_complete').hide();
  }else{
  $.get($(this).data("url"), {term: $(this).val()}, function(data){
  $(id + '_auto_complete').html(data)
  $(id + '_auto_complete').show();
}, "html");
}
})
}
