Vue.component('article-component', {
  props: {
    title: {
      type: String,
      required: true,
      default: "",
    },
    body: {
      type: String,
      required: true,
      default: "",
    },
    errors: {
      type: Array,
      default: function() {
        return []
      }
    },
    newSubmit: {
      type: Boolean,
      default: false,
    },
    editSubmit: {
      type: Boolean,
      default: false,
    }
  },
  methods: {
    checkSubmit: function() {
      if (this.newSubmit) {
        this.$emit('create-article')
      } else if (this.editSubmit) {
        this.$emit('update-article')
      } else {

      } 
    },
  },
  template: `
    <div>
      <form @submit.prevent="checkSubmit"><br>
        <div v-if="errors">
          <ul v-for="error in errors" :key="error">
            <li class="error-field">{{ error }}</></li>
          </ul>
        </div>
        <div class="input-field">
          <input
            type="text"
            :value="title"
            @input="$emit('update:title', $event.target.value)"
            placeholder="記事本文"
          >
          <textarea
            rows="20"
            :value="body"
            @input="$emit('update:body', $event.target.value)"
            placeholder="記事本文"
          ></textarea>
        </div>
        <div class="button-area">
          <button class="left btn">キャンセル</button>
          <button type="submit" class="right btn">投稿</button>
        </div>
      </form>
    </div>`
})
