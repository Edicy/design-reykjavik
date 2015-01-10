<!DOCTYPE html>
<html>

<head>
  {% include "SiteHeader" %}
</head>

<body id="front">

  <div id="holder">
    {% include "MobileMenus" %}
    <div class="wrap">
      <div id="header" class="cfx">
        <div id="logo">{% editable site.header %}</div>
        <div class="inner">
          {% include "Langmenu" %}
          {% include "Mainmenu" %}
        </div>
      </div>

      <div id="container" class="cfx">
        <div id="content" class="cfx">
          <div class="content-left slogan">
              <div class="cfx" data-search-indexing-allowed="true">{% content name="slogan" %}</div>
          </div>

          <div class="content-right">
            <div class="cfx" data-search-indexing-allowed="true">
            {% content %}
            </div>
            
            <div class="cfx" data-search-indexing-allowed="true">
            {% contentblock name="default-content" %}
              <div>
              <br/>
                <img src="{{ images_path }}/reykjavik_photo01.jpg" alt="Reykjavik" >
              </div>
            {% endcontentblock %}
            </div>
          </div>
          
          <div class="content-left content-left-last">
            {% include "LatestNews" %}
          </div>
        </div>
      </div>

    </div>
  </div>

  <div id="footer">
    <div class="wrap cfx">
      
      <div class="inner">
        <div class="cfx">
          {% xcontent name="footer" %}
        </div>
      </div>
      
      {% include "Search" %}
    </div>
  </div>

  {% include "JS" %}
</body>
</html>
