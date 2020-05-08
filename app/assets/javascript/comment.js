Vue.component('comment-component', {
  props: {
    comment: {
      type: Object,
    }
  },
  methods: {
    destroyComment: async function() {
      if(confirm('削除して宜しいですか？')) {
        try {
          await axios.delete(`/api/v1/comments/${this.comment.id}`)
          location.href = `/articles/${this.comment.article_id}`
        } catch(error){
        }
      }
    }
  },
  template: `
    <div class="comments">
      <div class="card">
        <div class="commenter-name">{{ comment.commenter_name }}</div>
        <div class="body">{{ comment.body }}</div>
      </div>
      <button class="btn comment" @click="destroyComment">削除</button>
    </div>
  `
})
