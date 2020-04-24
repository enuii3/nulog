Vue.component('article-component', {
  props: {
    article: {
      type: Object,
    },
    commentLengthTruth: {
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
        <div v-if="commentLengthTruth">
          <p>コメント: {{ article.comments_length }}件</p>
        </div>
      </div>
    </div>
  `
})
