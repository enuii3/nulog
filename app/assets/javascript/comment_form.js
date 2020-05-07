Vue.component('comment-form-component', {
  props: {
    id: {
      type: Number,
    }
  },
  data: function() {
    return {
      comment: {
        body: "",
        commenter_name: "",
        user_id: null,
        article_id: this.id,
      },
    }
  },
  methods: {
    createComment: async function() {
      try {
        await axios.post('/api/v1/comments/', this.comment)
      } catch(error) {
        //エラー表示は別PRにて対応します。
      }
    },
  },
  template: `
    <form class="comments" @submit="createComment">
      <textarea rows="5"
        class="form-commenter-name"
        v-model="comment.commenter_name"
        placeholder="名前入力"
      ></textarea>
      <textarea rows="5"
        class="form-body"
        v-model="comment.body"
        placeholder="コメント入力"
      ></textarea>
      <button class="btn comment form" type="submit">投稿</button>
    </form>
  `
})
