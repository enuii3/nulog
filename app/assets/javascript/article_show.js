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
      errors: [],
    }
  },
  mounted: async function() {
    try {
      const res = await axios.get(`/api/v1/articles/${this.id}`)
      this.article = res.data
    } catch (error) {
      this.errors = error.response.data
    }
  },
  methods: {
    destroyArticle: async function() {
      if(confirm('削除して宜しいですか？')) {
        try {
          await axios.delete(`/api/v1/articles/${this.id}`)
          location.href = '/articles/'
        } catch(error) {
          this.errors = error.response.data
        }
      }
    },
  },
  template: `
  <div>
    <error-component :errors="errors"></error-component>
    <div class="card">
      <h2>{{ article.title }}</h2>
      <p>{{ article.updated_at }}&emsp;{{ article.user_name }}</p>
      <p>{{ article.body }}</p>
    </div>
    <div class="button-area">
      <button class="left btn" @click="destroyArticle">削除</button>
      <button class="right btn" @click="$emit('change-page')">編集</button>
    </div>
  </div>`
})
