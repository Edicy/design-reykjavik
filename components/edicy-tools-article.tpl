{% editorjsblock %}
  <script src='{{ site.static_asset_host }}/libs/edicy-tools/latest/edicy-tools.js'></script>
  <script>
    $(window).on('load', function(window) {
      var articleCover = new Edicy.BgPicker($('.article-cover-settings').eq(0), {
        picture: true,
        color: true,
        showAlpha: true,
        target_width: $('.post-header-wrapper').width(),

        preview: function(data) {
          if (data.image && data.imageSizes) {
            if (data.image.replace(/.*\/photos/g,'/photos') !== articleCover.prevBgImage) {
              var img = $('<img>'), canvas = $('<canvas>'),
                  url = (data.imageSizes ? data.imageSizes[data.imageSizes.length - 1].url : data.image);
              img.attr('src', url.replace(/.*\/photos/g,'/photos'));
              img.on('load', function() {
                ColorExtract.extract(img[0], canvas[0], function(data) {
                  articleCover.bgColor = data.bgColor;
                  site.handleHeaderColorScheme(site.getCombinedLightness(articleCover.bgColor, articleCover.fgColor));
                });
              });
              articleCover.prevBgImage = data.image.replace(/.*\/photos/g,'/photos');

              var image_url = site.getPhotoByWidth(data.imageSizes, $('.post-header-wrapper').width());
              $('.article-cover-image').css({'background-image' : 'url("' + image_url + '")'});
            }
          } else if (data.image && data.image !== '') {
            // Fix Safari from constantly loading a new image on Bg picker slider change
            var articleCoverBgImage = data.image.split('/').pop();

            $('.article-cover-image').css({'background-image' : 'url(images/"' + articleCoverBgImage + '")'});
          } else {
            $('.article-cover-image').css({'background-image' : 'none'});
            articleCover.bgColor = [255,255,255,0];
          }

          if (data.color && data.color !== '') {
            articleCover.fgColor = data.color;
            site.handleHeaderColorScheme(site.getCombinedLightness(articleCover.bgColor, articleCover.fgColor));
            $('.article-cover-color').css({'background' : data.color});
          } else {
            articleCover.fgColor = [255,255,255,0];
            $('.article-cover-color').css({'background' : 'transparent'});
          }
        },

        commit: function(data) {
          var cover_type = (site.getCombinedLightness(articleCover.bgColor, articleCover.fgColor) > 0.6) ? 'light' : 'dark';
          var normalizeValue = function(value) {
            if (value == null || (typeof value == 'string' && value.match(/^[\\'"]+$/))) {
              return '';
            } else {
              return value;
            }
          };

          Edicy.articles.currentArticle.setData({
            'cover_image': data.image || '',
            'cover_image_sizes': normalizeValue(data.imageSizes),
            'cover_color': data.color || '',
            'cover_type': cover_type
          });
        }
      });
      $('.article-cover-settings').css({'left': 0, 'top': 0}).show();
    });

    site.bindCustomTexteditorStyles('{{ "button" | lc: editor_locale }}');
  </script>
{% endeditorjsblock %}
{% unless article_cover_image_sizes == '' or article_cover_image_sizes == nil %}
<script type="text/javascript">
  $('.article-cover-image').css({'background-image' : 'url("' + site.getPhotoByWidth(JSON.parse('{{ article_cover_image_sizes }}'), $('.post-header-wrapper').width()) + '")'});
</script>
{% endunless %}
