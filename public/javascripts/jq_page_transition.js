jQuery.noConflict();

jQuery(document).ready(function($) {
  $("body").css("display", "none");

  $("body").fadeIn(1000);

  $("a").click(function(e){
    e.preventDefault();
    nextPage = this.href;
    $("body").fadeOut(1000, redirectPage);
  });

  function redirectPage() {
    window.location = nextPage;
  }
});
