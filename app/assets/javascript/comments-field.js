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
      limit: 5,
      offset: 0,
      isReadMore: true,
    }
  },
  mounted: function(){
    this.readMoreComments()
  },
  methods: {
    readMoreComments: async function(){
      try {
        const res = await axios.get(`/api/v1/comments/`, {
          params: {
            article_id: this.articleId,
            limit: this.limit,
            offset: this.offset,
          }
        })
        if(this.limit > res.data.length) this.isReadMore = false
        this.comments = this.comments.concat(res.data)
      } catch(error) {
        this.errors = error.response.data
      }
    },
    countUpCommentsLength: function(){
      this.offset = this.comments.length
      this.comments.length < 20 ? this.limit = 15 : this.limit = 20
      this.readMoreComments()
    }
  },
  template: `
    <div class="comment-field">
      <ul class="none-list-style">
        <li v-for='comment in comments' :key='comment.id'>
          <comment-component :comment="comment"></comment-component>
        </li>
      </ul>
      <button class="right btn is-read-more"
       v-if="isReadMore"
       @click="countUpCommentsLength"
      >さらに表示</button>
      <comment-form-component :article-id="articleId"></comment-form-component>
    </div>
  `
})
