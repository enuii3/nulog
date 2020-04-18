Vue.component('article-show-component', {
  props: {
    id: {
      type: Number,
    },
    post: {
      type: Object,
    },
  },
  data: function(){
    return {
      article: {},
      errors: [],
    }
  },
  mounted: async function() {
    try {
      if(this.post) return this.switchArticle
      this.switchIdForShowPath
      const res = await axios.get(`/api/v1/articles/${this.article.id}`)
      this.article = res.data
    } catch (error) {
      this.errors = error.response.data
    }
  },
  computed: {
    switchArticle: function(){
      this.article = this.post
    },
    switchIdForShowPath: function() {
      if(!this.article.id) this.article.id = this.id
    },
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
    linkToShow: function(article_id) {
      location.href=`/articles/${article_id}`
    },
  },
  template: `
    <div>
      <error-component :errors="errors" v-if="!post"></error-component>
      <div class="card">
        <h2>{{ article.title }}</h2>
        <p>{{ article.updated_at }}&emsp;{{ article.user_name }}</p>
        <p>{{ article.body }}</p>
      </div>

      <div v-if="post">
        <button class="right btn" @click="linkToShow(post.id)">記事詳細</button><br><br><br>
      </div>
      <div v-else>
        <button class="left btn" @click="destroyArticle">削除</button>
        <button class="right btn" @click="$emit('change-page')">編集</button>
      </div>
    </div>
  `
})
