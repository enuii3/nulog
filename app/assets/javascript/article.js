Vue.component('article-component', {
  props: {
    article: {
      type: Object,
    },
    visibleCommentCount: {
      type: Boolean,
      default: false
    }
  },
  template: `
    <div>
      <div class="card">
        <h2>{{ article.title }}</h2>
        <p>{{ article.updated_at }}&emsp;{{ article.user_name }}</p>
        <p>{{ article.body }}</p>
        <div v-if="visibleCommentCount">
          <p>コメント: {{ article.comments_count }}件</p>
        </div>
      </div>
    </div>
  `
})
