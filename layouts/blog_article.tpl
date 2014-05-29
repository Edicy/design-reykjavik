<!DOCTYPE html>
<html class="{% if editmode %}editmode{% else %}public{% endif %}" lang="{{ page.language_code }}">
<head>
  {% include "html-head" %}

  <meta property="og:url" content="{{ site.url }}">
  <meta property="og:title" content="{{ site.name }}">
  <meta property="og:description" content="{{ page.description }}">{% comment %}<!-- TODO: Add correct value -->{% endcomment %}
  {% unless article.data.fb_image == nil or article.data.fb_image == "" %}<meta property="og:image" content="{{ site.url }}{{ photos_path }}/{{ article.data.fb_image }}">{% endunless %}{% comment %}<!-- TODO: Add image location data tag -->{% endcomment %}
</head>

<body class="post-page js-bgpicker-body-image" {% if site.data.body_image %}style="background-image: url('{{ site.data.body_image}}');"{% endif %}>
  {% if editmode %}<button class="bgpicker-btn js-bgpicker-body-settings" data-bg-image="{{ site.data.body_image }}" data-bg-color="{{ site.data.body_color }}"></button>{% endif %}
  <div class="background-color js-bgpicker-body-color"{% if site.data.body_color %} style="background-color: {{ site.data.body_color }};{% if site.data.body_image %} opacity: 0.5;{% endif %}"{% endif %}></div>

  <div class="container">
    {% include "header" %}
    {% include "menu-level-2" %}

    <main class="content" role="main">
      {% include "post-box" with "article" %}

      <section id="comments" class="comments content-formatted">
        {% case article.comments_count %}{% when 0 %}{% else %}<h2 class="comments-title">{{ "comments_for_count" | lc }}: <span class="edy-site-blog-comments-count">{{ article.comments_count }}</span></h2>{% endcase %}

        <div class="comment-messages content-formatted">
          {% for comment in article.comments reversed %}
            <div class="comment edy-site-blog-comment">
              <span class="comment-body">{{ comment.body_html }}</span>
              <span class="comment-author">({{ comment.author }},</span>
              <span class="comment-date">{{ comment.created_at | format_date: "long" }})</span>
              <span class="comment-delete">{% removebutton %}</span>
            </div>
          {% endfor %}
        </div>

        {% include "comment-form" %}
      </section>
    </main>

    {% include "footer" %}

  </div>

  {% include "javascripts" %}
  {% include "bg-picker" %}
</body>
</html>
