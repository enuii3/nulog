Vue.component('article-index-component', {
  props: {
    weatherForecastsErrors: {
      type: Array,
    }
  },
  data: function(){
    return {
      articles: [],
      errors: [],
    }
  },
  mounted: async function() {
    try {
      const res = await axios.get('/api/v1/articles')
      this.articles = res.data
    } catch (error) {
      this.errors = error.response.data
    }
  },
  methods: {
    linkToShow: function(article_id) {
      location.href=`/articles/${article_id}`
    },
  },
  watch: {
    weatherForecastsErrors: function(){
      this.errors = this.weatherForecastsErrors
    }
  },
  template: `
    <div>
      <error-component :errors="errors"></error-component>
      <ul class="none-list-style">
        <li v-for='article in articles' :key='article.id'>
          <article-component :article="article" :visibleCommentCount="true"></article-component>
          <button class="right btn article" @click="linkToShow(article.id)">記事詳細</button><br><br><br>
        </li>
      </ul>
    </div>
  `
})
