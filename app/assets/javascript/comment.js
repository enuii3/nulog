Vue.component('comment-component', {
  props: {
    comment: {
      type: Object,
    }
  },
  data: function() {
    return {
      user_name: '',
    }
  },
  template: `
    <div class="comments">
      <div class="card">
        <div class="commenter-name">{{ comment.commenter_name }}</div>
        <div class="body">{{ comment.body }}</div>
      </div>
      <button class="btn comment">削除</button>
    </div>
  `
})
