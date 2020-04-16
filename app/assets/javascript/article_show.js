Vue.component('article-show-component', {
  props: {
    id: {
      type: Number,
    },
    propArticle: {
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
      this.article.id ? '' : this.article.id = this.id
      const res = await axios.get(`/api/v1/articles/${this.article.id}`)
      this.article = res.data
    } catch (error) {
      this.errors = error.response.data
    }
  },
  computed: {
    switchArticle: function(){
      this.propArticle ? this.article = this.propArticle : ''
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
    linkToShow: function(article_id) {
      location.href=`/articles/${article_id}`
    },
  },
  template: `
    <div>
      <error-component :errors="errors" v-if="!propArticle"></error-component>
        <div class="card" v-bind="switchArticle">
          <h2>{{ article.title }}</h2>
          <p>{{ article.updated_at }}&emsp;{{ article.user_name }}</p>
          <p>{{ article.body }}</p>
        </div>

      <div v-if="propArticle">
        <button class="right btn" @click="linkToShow(propArticle.id)">記事詳細</button><br><br><br>
      </div>
      <div v-else>
        <button class="left btn" @click="destroyArticle">削除</button>
        <button class="right btn" @click="$emit('change-page')">編集</button>
      </div>
    </div>
  `
})
