
(function($){

   /* Theme Specific Variables
   ----------------------------*/
   $.supersized.themeVars = {

    // Internal Variables
    progress_delay    : false,        // Delay after resize before resuming slideshow
    thumb_page      :   false,        // Thumbnail page
    thumb_interval    :   false,        // Thumbnail interval
    image_path      : 'img/',       // Default image path

    // General Elements
    play_button     : '#pauseplay',   // Play/Pause button
    next_slide      : '#nextslide',   // Next slide button
    prev_slide      : '#prevslide',   // Prev slide button
    next_thumb      : '#nextthumb',   // Next slide thumb button
    prev_thumb      : '#prevthumb',   // Prev slide thumb button

    slide_caption   : '#slidecaption',  // Slide caption
    slide_current   : '.slidenumber',   // Current slide number
    slide_total     : '.totalslides',   // Total Slides
    slide_list      : '#slide-list',    // Slide jump list

    thumb_tray      : '#thumb-tray',    // Thumbnail tray
    thumb_list      : '#thumb-list',    // Thumbnail list
    thumb_forward   : '#thumb-forward', // Cycles forward through thumbnail list
    thumb_back      : '#thumb-back',    // Cycles backwards through thumbnail list
    tray_arrow      : '#tray-arrow',    // Thumbnail tray button arrow
    tray_button     : '#tray-button',   // Thumbnail tray button

    progress_bar    : '#progress-bar'   // Progress bar

   };

   /* Theme Specific Options
   ----------------------------*/
   $.supersized.themeOptions = {

    progress_bar    : 1,    // Timer for each slide
    mouse_scrub     : 0   // Thumbnails move with mouse

   };


})(jQuery);
