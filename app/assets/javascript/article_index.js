Vue.component('article-index-component', {
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
  template: `
    <div>
      <error-component :errors="errors"></error-component>
      <ul class="none-list-style">
        <li v-for='article in articles' :key='article.id'>
          <article-show-component :prop-article="article"></article-show-component>
        </li>
      </ul>
    </div>
  `
})
