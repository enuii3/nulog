Vue.component('comments-field-component', {
  props: {
    articleId: {
      type: Number,
      required: true,
    },
  },
  data: function() {
    return {
      comments: [], 
      comments_length: 5,
      limit: 5,
      offset: 0,
    }
  },
  methods: {
    isMore: async function() {
      this.offset = this.comments.length
      this.comments.length < 20 ? this.limit = 15 : this.limit = 20
    },
    handleCommentErrors: function(errors) {
      this.$emit('handle-comment-errors', errors)
    },
  },
  watch: {
    offset: {
      immediate: true,
      handler: async function(newComments, oldComments){
        try {
          const res = await axios.get(`/api/v1/comments/`, {
            params: {
              article_id: this.articleId,
              limit: this.limit,
              offset: this.offset,
            }
          })
          this.comments_length = res.data.length
          this.comments = this.comments.concat(res.data)
        } catch(error) {
        }
      }
    }
  },
  template: `
    <div class="comment-field">
      <ul class="none-list-style">
        <li v-for='comment in comments' :key='comment.id'>
          <comment-component :comment="comment"></comment-component>
        </li>
      </ul>
      <button class="right btn is-more" v-if="limit <= comments_length" @click="isMore">さらに表示</button>
      <comment-form-component :article-id="articleId" @handle-comment-errors="handleCommentErrors"></comment-form-component>
    </div>
  `
})
