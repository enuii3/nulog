Vue.component('article-component', {
  props: {
    article: {
      type: Object,
    }
  },
  template: `
    <div>
      <div class="card">
        <h2>{{ article.title }}</h2>
        <p>{{ article.updated_at }}&emsp;{{ article.user_name }}</p>
        <p>{{ article.body }}</p>
      </div>
    </div>
  `
})
