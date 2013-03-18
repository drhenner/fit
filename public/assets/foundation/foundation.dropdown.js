/*jslint unparam: true, browser: true, indent: 2 */
(function(e,t,n,r){"use strict";Foundation.libs.dropdown={name:"dropdown",version:"4.0.6",settings:{activeClass:"open"},init:function(t,n,r){return this.scope=t||this.scope,Foundation.inherit(this,"throttle"),typeof n=="object"&&e.extend(!0,this.settings,n),typeof n!="string"?(this.settings.init||this.events(),this.settings.init):this[n].call(this,r)},events:function(){var n=this;e(this.scope).on("click.fndtn.dropdown","[data-dropdown]",function(t){t.preventDefault(),t.stopPropagation(),n.toggle(e(this))}),e("*, html, body").on("click.fndtn.dropdown",function(t){e(t.target).data("dropdown")||e("[data-dropdown-content]").css("left","-99999px").removeClass(n.settings.activeClass)}),e(t).on("resize.fndtn.dropdown",n.throttle(function(){n.resize.call(n)},50)).trigger("resize"),this.settings.init=!0},toggle:function(t,n){var r=e("#"+t.data("dropdown"));e("[data-dropdown-content]").not(r).css("left","-99999px").removeClass(this.settings.activeClass),r.hasClass(this.settings.activeClass)?r.css("left","-99999px").removeClass(this.settings.activeClass):this.css(r.addClass(this.settings.activeClass),t)},resize:function(){var t=e("[data-dropdown-content].open"),n=e("[data-dropdown='"+t.attr("id")+"']");t.length&&n.length&&this.css(t,n)},css:function(t,n){if(t.parent()[0]===e("body")[0])var r=n.offset();else var r=n.position();return this.small()?t.css({position:"absolute",width:"95%",left:"2.5%","max-width":"none",top:r.top+this.outerHeight(n)}):t.attr("style","").css({position:"absolute",top:r.top+this.outerHeight(n),left:r.left}),t},small:function(){return e(t).width()<768||e("html").hasClass("lt-ie9")},off:function(){e(this.scope).off(".fndtn.dropdown"),e("html, body").off(".fndtn.dropdown"),e(t).off(".fndtn.dropdown"),e("[data-dropdown-content]").off(".fndtn.dropdown"),this.settings.init=!1}}})(Foundation.zj,this,this.document);