/*
 * jQuery Anystretch
 * Version 1.1
 * https://github.com/danmillar/jquery-anystretch
 *
 * Add a dynamically-resized background image to the body
 * of a page or any other block level element within it
 *
 * Copyright (c) 2012 Dan Millar (@danmillar / decode.uk.com)
 * Dual licensed under the MIT and GPL licenses.
 *
 * This is a fork of jQuery Backstretch (v1.2)
 * Copyright (c) 2011 Scott Robbin (srobbin.com)
*/
(function(e){e.fn.anystretch=function(t,n,r){var i=this.selector.length?!1:!0;return this.each(function(s){function g(){if(t){var n;i||u.css({position:f.elPosition,background:"none"}),a.length==0?a=e("<div />").attr("class","anystretch").css({left:0,top:0,position:i?"fixed":"absolute",overflow:"hidden",zIndex:i?-999999:-999998,margin:0,padding:0,height:"100%",width:"100%"}):a.find("img").addClass("deleteable"),n=e("<img />").css({position:"absolute",display:"none",margin:0,padding:0,border:"none",zIndex:-999999}).bind("load",function(t){var n=e(this),i,s;n.css({width:"auto",height:"auto"}),i=this.width||e(t.target).width(),s=this.height||e(t.target).height(),c=i/s,y(function(){n.fadeIn(f.speed,function(){a.find(".deleteable").remove(),typeof r=="function"&&r()})})}).appendTo(a),u.children(".anystretch").length==0&&(i?e("body").append(a):u.append(a)),a.data("settings",f),n.attr("src",t),e(window).resize(y)}}function y(t){try{m={left:0,top:0},p=b(),d=p/c,d>=w()?(v=(d-w())/2,f.positionY=="center"||f.centeredY?e.extend(m,{top:"-"+v+"px"}):f.positionY=="bottom"&&e.extend(m,{top:"auto",bottom:"0px"})):(d=w(),p=d*c,v=(p-b())/2,f.positionX=="center"||f.centeredX?e.extend(m,{left:"-"+v+"px"}):f.positionX=="right"&&e.extend(m,{left:"auto",right:"0px"})),a.children("img:not(.deleteable)").width(p).height(d).filter("img").css(m)}catch(n){}typeof t=="function"&&t()}function b(){return i?u.width():u.innerWidth()}function w(){return i?u.height():u.innerHeight()}var o={positionX:"center",positionY:"center",speed:0,elPosition:"relative"},u=e(this),a=i?e(".anystretch"):u.children(".anystretch"),f=a.data("settings")||o,l=a.data("settings"),c,h,p,d,v,m;return n&&typeof n=="object"&&e.extend(f,n),n&&typeof n=="function"&&(r=n),e(document).ready(g),this})},e.anystretch=function(t,n,r){var i="onorientationchange"in window?e(document):e(window);i.anystretch(t,n,r)}})(jQuery);