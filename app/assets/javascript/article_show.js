Vue.component('article-show-component', {
  props: {
    id: {
      type: Number,
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
    handleCommentErrors: function(errors){
      this.errors = errors
    }
  },
  template: `
    <div>
      <error-component :errors="errors"></error-component>
      <article-component :article="article" @handle-comment-errors="handleCommentErrors"></article-component>
      <button class="left btn article" @click="destroyArticle">削除</button>
      <button class="right btn article" @click="$emit('change-page')">編集</button>
    </div>
  `
})
