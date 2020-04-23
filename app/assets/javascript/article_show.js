Vue.component('article-show-component', {
  props: {
    id: {
      type: Number,
    },
    article: {
      type: Object,
    },
  },
  data: function(){
    return {
      articleShow: {},
      errors: [],
    }
  },
  mounted: async function() {
    try {
      if(this.article) return this.switchArticle()
      this.switchArticleId()
      const res = await axios.get(`/api/v1/articles/${this.articleShow.id}`)
      this.articleShow = res.data
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
    switchArticle: function(){
      this.articleShow = this.article
    },
    switchArticleId: function() {
      if(!this.articleShow.id) this.articleShow.id = this.id
    },
    linkToShow: function(article_id) {
      location.href=`/articles/${article_id}`
    },
  },
  template: `
    <div>
      <error-component :errors="errors" v-if="!article"></error-component>
      <div class="card">
        <h2>{{ articleShow.title }}</h2>
        <p>{{ articleShow.updated_at }}&emsp;{{ articleShow.user_name }}</p>
        <p>{{ articleShow.body }}</p>
      </div>

      <div v-if="article">
        <button class="right btn" @click="linkToShow(article.id)">記事詳細</button><br><br><br>
      </div>
      <div v-else>
        <button class="left btn" @click="destroyArticle">削除</button>
        <button class="right btn" @click="$emit('change-page')">編集</button>
      </div>
    </div>
  `
})
