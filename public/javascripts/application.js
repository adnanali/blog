// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(".new_comment").live("ajax:loading", function(xhr) {
  $(this).find(".field_error").removeClass("field_error");
});


$(".new_comment").live("ajax:failure", function(xhr, status, error) {
  var prefix = xhr.target.id;
  prefix = prefix.substr(0, prefix.lastIndexOf("_"));
  
  var errors = eval(status.responseText);
  for (var i = 0; i < errors.length; i++) {
    var e = errors[i];
    var field = prefix + "_" + errors[i][0];
    var parent = $("#" + field).parent();
    parent.addClass("field_error");
  }

});

$(".new_comment").live("ajax:after", function(xhr) {

});

$.fn.clearForm = function() {
  return this.each(function() {
 var type = this.type, tag = this.tagName.toLowerCase();
 if (tag == 'form')
   return $(':input',this).clearForm();
 if (type == 'text' || type == 'password' || tag == 'textarea')
   this.value = '';
 else if (type == 'checkbox' || type == 'radio')
   this.checked = false;
 else if (tag == 'select')
   this.selectedIndex = -1;
  });
};
