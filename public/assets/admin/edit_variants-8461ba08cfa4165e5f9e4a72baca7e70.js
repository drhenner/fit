var Hadean=window.Hadean||{};typeof Hadean.Admin=="undefined"&&(Hadean.Admin={});var kk=null;typeof Hadean.Admin.products=="undefined"&&(Hadean.Admin.products={initialize:function(){jQuery(document).on("click",".add_variant_child",function(){Hadean.Admin.products.addVariant()}),jQuery(document).on("click",".remove_variant_child",function(){Hadean.Admin.products.removeVariant(this)})},addVariant:function(){var e=$("#variants_fields_template").html(),t=new RegExp("new_variants","g"),n=(new Date).getTime();return $("#variants_container").append(e.replace(t,n)),!1},removeVariant:function(e){kk=e,jQuery(e).closest(".new_variant_container").html("")}},jQuery(function(){Hadean.Admin.products.initialize()}));