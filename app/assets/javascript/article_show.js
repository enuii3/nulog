Vue.component('article-show-component', {
  props: {
    id: {
      type: Number,
      required: true,
    }
  },
  data: function(){
    return {
      article: {},
    }
  },
  mounted: async function() {
    try {
      const res = await axios.get(`/api/v1/articles/${this.id}`)
      this.article = res.data
    } catch (error) {

    }
  },
  methods: {
    // 記事削除機能は後日実装
    alertDestroy: function() {
      alert('削除ボタンが押下されました')
    },
  },
  template: `
  <div>
    <div class="card">
      <h2>{{ article.title }}</h2>
      <p>{{ article.updated_at }}&emsp;{{ article.user_name }}</p>
      <p>{{ article.body }}</p>
    </div>
    <div class="button-area">
      <!-- 削除昨日は後日実装 -->
      <button class="left btn" @click="alertDestroy">削除</button>
      <button class="right btn" @click="$emit('change-page')">編集</button>
    </div>
  </div>`
})
