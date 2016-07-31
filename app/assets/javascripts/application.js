// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require turbolinks
//= require_tree .




/// jquery and js swipe funtionality 
// $(document).on('swipeleft', '.ui-page', function(event){    
//     if(event.handled !== true) // This will prevent event triggering more then once
//     {    
//         var nextpage = $.mobile.activePage.next('[data-role="page"]');
//         // swipe using id of next page if exists
//         if (nextpage.length > 0) {
//             $.mobile.changePage(nextpage, {transition: "slide", reverse: false}, true, true);
//         }
//         event.handled = true;
//     }
//     return false;         
// });

// $(document).on('swiperight', '.ui-page', function(event){     
//     if(event.handled !== true) // This will prevent event triggering more then once
//     {      
//         var prevpage = $(this).prev('[data-role="page"]');
//         if (prevpage.length > 0) {
//             $.mobile.changePage(prevpage, {transition: "slide", reverse: true}, true, true);
//         }
//         event.handled = true;
//     }
//     return false;            
// });

// HTML for scripts above////
// <body>
//   <div data-role="page" id="article1">
//     <div data-role="header" data-theme="b" data-position="fixed" data-id="footer">
//       <h1>Articles</h1>
//     </div>
//     <div data-role="content">
//       <p>Article 1</p>
//     </div>
//   </div>

//   <div data-role="page" id="article2">
//     <div data-role="header" data-theme="b" data-position="fixed" data-id="footer">
//       <a href="#article1" data-icon="home" data-iconpos="notext">Home</a>
//       <h1>Articles</h1>
//     </div>
//     <div data-role="content">
//       <p>Article 2</p>
//     </div>
//   </div>

//   <div data-role="page" id="article3">
//     <div data-role="header" data-theme="b" data-position="fixed" data-id="footer">
//       <a href="#article1" data-icon="home" data-iconpos="notext">Home</a>
//       <h1>Articles</h1>
//     </div>
//     <div data-role="content">
//       <p>Article 3</p>
//     </div>