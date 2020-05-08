Vue.component('comment-form-component', {
  props: {
    articleId: {
      type: Number,
      required: true,
    }
  },
  data: function() {
    return {
      commenter_name: "",
      body: "",
      user_id: null,
      errors: [],
    }
  },
  methods: {
    createComment: async function() {
      try {
        await axios.post('/api/v1/comments/', {
          commenter_name: this.commenter_name,
          body: this.body,
          user_id: this.user_id,
          article_id: this.articleId,
        })
      } catch(error) {
        this.errors = error.response.data
        //エラー表示は別PRにて対応します。
      }
    },
  },
  template: `
    <form class="comments" @submit="createComment">
      <textarea rows="5"
        class="form-commenter-name"
        v-model="commenter_name"
        placeholder="名前入力"
      ></textarea>
      <textarea rows="5"
        class="form-body"
        v-model="body"
        placeholder="コメント入力"
      ></textarea>
      <button class="btn comment form" type="submit">投稿</button>
    </form>
  `
})
