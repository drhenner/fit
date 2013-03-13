/*!
 * jQuery BBQ: Back Button & Query Library - v1.2.1 - 2/17/2010
 * http://benalman.com/projects/jquery-bbq-plugin/
 * 
 * Copyright (c) 2010 "Cowboy" Ben Alman
 * Dual licensed under the MIT and GPL licenses.
 * http://benalman.com/about/license/
 */
// Script: jQuery BBQ: Back Button & Query Library
//
// *Version: 1.2.1, Last updated: 2/17/2010*
// 
// Project Home - http://benalman.com/projects/jquery-bbq-plugin/
// GitHub       - http://github.com/cowboy/jquery-bbq/
// Source       - http://github.com/cowboy/jquery-bbq/raw/master/jquery.ba-bbq.js
// (Minified)   - http://github.com/cowboy/jquery-bbq/raw/master/jquery.ba-bbq.min.js (4.0kb)
// 
// About: License
// 
// Copyright (c) 2010 "Cowboy" Ben Alman,
// Dual licensed under the MIT and GPL licenses.
// http://benalman.com/about/license/
// 
// About: Examples
// 
// These working examples, complete with fully commented code, illustrate a few
// ways in which this plugin can be used.
// 
// Basic AJAX     - http://benalman.com/code/projects/jquery-bbq/examples/fragment-basic/
// Advanced AJAX  - http://benalman.com/code/projects/jquery-bbq/examples/fragment-advanced/
// jQuery UI Tabs - http://benalman.com/code/projects/jquery-bbq/examples/fragment-jquery-ui-tabs/
// Deparam        - http://benalman.com/code/projects/jquery-bbq/examples/deparam/
// 
// About: Support and Testing
// 
// Information about what version or versions of jQuery this plugin has been
// tested with, what browsers it has been tested in, and where the unit tests
// reside (so you can test it yourself).
// 
// jQuery Versions - 1.3.2, 1.4.1, 1.4.2
// Browsers Tested - Internet Explorer 6-8, Firefox 2-3.7, Safari 3-4,
//                   Chrome 4-5, Opera 9.6-10.1.
// Unit Tests      - http://benalman.com/code/projects/jquery-bbq/unit/
// 
// About: Release History
// 
// 1.2.1 - (2/17/2010) Actually fixed the stale window.location Safari bug from
//         <jQuery hashchange event> in BBQ, which was the main reason for the
//         previous release!
// 1.2   - (2/16/2010) Integrated <jQuery hashchange event> v1.2, which fixes a
//         Safari bug, the event can now be bound before DOM ready, and IE6/7
//         page should no longer scroll when the event is first bound. Also
//         added the <jQuery.param.fragment.noEscape> method, and reworked the
//         <hashchange event (BBQ)> internal "add" method to be compatible with
//         changes made to the jQuery 1.4.2 special events API.
// 1.1.1 - (1/22/2010) Integrated <jQuery hashchange event> v1.1, which fixes an
//         obscure IE8 EmulateIE7 meta tag compatibility mode bug.
// 1.1   - (1/9/2010) Broke out the jQuery BBQ event.special <hashchange event>
//         functionality into a separate plugin for users who want just the
//         basic event & back button support, without all the extra awesomeness
//         that BBQ provides. This plugin will be included as part of jQuery BBQ,
//         but also be available separately. See <jQuery hashchange event>
//         plugin for more information. Also added the <jQuery.bbq.removeState>
//         method and added additional <jQuery.deparam> examples.
// 1.0.3 - (12/2/2009) Fixed an issue in IE 6 where location.search and
//         location.hash would report incorrectly if the hash contained the ?
//         character. Also <jQuery.param.querystring> and <jQuery.param.fragment>
//         will no longer parse params out of a URL that doesn't contain ? or #,
//         respectively.
// 1.0.2 - (10/10/2009) Fixed an issue in IE 6/7 where the hidden IFRAME caused
//         a "This page contains both secure and nonsecure items." warning when
//         used on an https:// page.
// 1.0.1 - (10/7/2009) Fixed an issue in IE 8. Since both "IE7" and "IE8
//         Compatibility View" modes erroneously report that the browser
//         supports the native window.onhashchange event, a slightly more
//         robust test needed to be added.
// 1.0   - (10/2/2009) Initial release
(function(e,t){"$:nomunge";function N(e){return typeof e=="string"}function C(e){var t=r.call(arguments,1);return function(){return e.apply(this,t.concat(r.call(arguments)))}}function k(e){return e.replace(/^[^#]*#?(.*)$/,"$1")}function L(e){return e.replace(/(?:^[^?#]*\?([^#]*).*$)?.*/,"$1")}function A(r,o,a,f,l){var c,h,p,d,g;return f!==n?(p=a.match(r?/^([^#]*)\#?(.*)$/:/^([^#?]*)\??([^#]*)(#?.*)/),g=p[3]||"",l===2&&N(f)?h=f.replace(r?S:E,""):(d=u(p[2]),f=N(f)?u[r?m:v](f):f,h=l===2?f:l===1?e.extend({},f,d):e.extend({},d,f),h=s(h),r&&(h=h.replace(x,i))),c=p[1]+(r?"#":h||!p[1]?"?":"")+h+g):c=o(a!==n?a:t[y][b]),c}function O(e,t,r){return t===n||typeof t=="boolean"?(r=t,t=s[e?m:v]()):t=N(t)?t.replace(e?S:E,""):t,u(t,r)}function M(t,r,i,o){return!N(i)&&typeof i!="object"&&(o=i,i=r,r=n),this.each(function(){var n=e(this),u=r||h()[(this.nodeName||"").toLowerCase()]||"",a=u&&n.attr(u)||"";n.attr(u,s[t](a,i,o))})}var n,r=Array.prototype.slice,i=decodeURIComponent,s=e.param,o,u,a,f=e.bbq=e.bbq||{},l,c,h,p=e.event.special,d="hashchange",v="querystring",m="fragment",g="elemUrlAttr",y="location",b="href",w="src",E=/^.*\?|#.*$/g,S=/^.*\#/,x,T={};s[v]=C(A,0,L),s[m]=o=C(A,1,k),o.noEscape=function(t){t=t||"";var n=e.map(t.split(""),encodeURIComponent);x=new RegExp(n.join("|"),"g")},o.noEscape(",/"),e.deparam=u=function(t,r){var s={},o={"true":!0,"false":!1,"null":null};return e.each(t.replace(/\+/g," ").split("&"),function(t,u){var a=u.split("="),f=i(a[0]),l,c=s,h=0,p=f.split("]["),d=p.length-1;/\[/.test(p[0])&&/\]$/.test(p[d])?(p[d]=p[d].replace(/\]$/,""),p=p.shift().split("[").concat(p),d=p.length-1):d=0;if(a.length===2){l=i(a[1]),r&&(l=l&&!isNaN(l)?+l:l==="undefined"?n:o[l]!==n?o[l]:l);if(d)for(;h<=d;h++)f=p[h]===""?c.length:p[h],c=c[f]=h<d?c[f]||(p[h+1]&&isNaN(p[h+1])?{}:[]):l;else e.isArray(s[f])?s[f].push(l):s[f]!==n?s[f]=[s[f],l]:s[f]=l}else f&&(s[f]=r?n:"")}),s},u[v]=C(O,0),u[m]=a=C(O,1),e[g]||(e[g]=function(t){return e.extend(T,t)})({a:b,base:b,iframe:w,img:w,input:w,form:"action",link:b,script:w}),h=e[g],e.fn[v]=C(M,v),e.fn[m]=C(M,m),f.pushState=l=function(e,r){N(e)&&/^#/.test(e)&&r===n&&(r=2);var i=e!==n,s=o(t[y][b],i?e:{},i?r:2);t[y][b]=s+(/#/.test(s)?"":"#")},f.getState=c=function(e,t){return e===n||typeof e=="boolean"?a(e):a(t)[e]},f.removeState=function(t){var r={};t!==n&&(r=c(),e.each(e.isArray(t)?t:arguments,function(e,t){delete r[t]})),l(r,2)},p[d]=e.extend(p[d],{add:function(t){function i(e){var t=e[m]=o();e.getState=function(e,r){return e===n||typeof e=="boolean"?u(t,e):u(t,r)[e]},r.apply(this,arguments)}var r;if(e.isFunction(t))return r=t,i;r=t.handler,t.handler=i}})})(jQuery,this),function(e,t,n){"$:nomunge";function h(e){return e=e||t[s][u],e.replace(/^[^#]*#?(.*)$/,"$1")}var r,i=e.event.special,s="location",o="hashchange",u="href",a=e.browser,f=document.documentMode,l=a.msie&&(f===n||f<8),c="on"+o in t&&!l;e[o+"Delay"]=100,i[o]=e.extend(i[o],{setup:function(){if(c)return!1;e(r.start)},teardown:function(){if(c)return!1;e(r.stop)}}),r=function(){function c(){a=f=function(e){return e},l&&(i=e('<iframe src="javascript:0"/>').hide().insertAfter("body")[0].contentWindow,f=function(){return h(i.document[s][u])},a=function(e,t){if(e!==t){var n=i.document;n.open().close(),n[s].hash="#"+e}},a(h()))}var n={},r,i,a,f;return n.start=function(){if(r)return;var n=h();a||c(),function i(){var l=h(),c=f(n);l!==n?(a(n=l,c),e(t).trigger(o)):c!==n&&(t[s][u]=t[s][u].replace(/#.*/,"")+"#"+c),r=setTimeout(i,e[o+"Delay"])}()},n.stop=function(){i||(r&&clearTimeout(r),r=0)},n}()}(jQuery,this);