Vue.component('article-form-component', {
  props: {
    id: {
      type: Number,
      require: true,
    },
    createSubmit: {
      type: Boolean,
      require: true,
      default: false,
    }, 
    updateSubmit: {
      type: Boolean,
      require: true,
      default: false,
    }, 
  },
  data: function() {
    return {
      article: {
        user_id: 1,
        title: "",
        body: "",
      },
      errors: [],
    }
  },
  mounted: async function() {
    try {
      const res = await axios.get(`/api/v1/articles/${this.id}/edit`) 
      this.article = res.data
    } catch (error){

    }
  },
  methods: {
    createArticle: async function() {
      try {
        const res = await axios.post('/api/v1/articles', this.article)
        location.href = `/articles/${res.data.id}`
      } catch (error) {
        this.errors = error.response.data
      }
    },
    updateArticle: async function() {
      try {
        const res = await axios.patch(`/api/v1/articles/${this.article.id}`, this.article)
        this.$emit('change-page')
      } catch (error) {
        this.errors = error.response.data
      }
    },
    submitEvent: function() {
      if (this.createSubmit) {
        this.createArticle()
      } else if (this.updateSubmit) {
        this.updateArticle()
      } else {

      }
    },
  },
  template: `
    <div>
      <form @submit.prevent="submitEvent"><br>
        <div v-if="errors">
          <ul v-for="error in errors" :key="error">
            <li class="error-field">{{ error }}</></li>
          </ul>
        </div>
        <div class="input-field">
          <input type="text"
            v-model="article.title"
            placeholder="記事タイトル"
          >
          <textarea rows="20"
            v-model="article.body"
            placeholder="記事本文"
          ></textarea>
        </div>
        <div class="button-area">
          <button class="left btn">キャンセル</button>
          <button class="right btn" type="submit">投稿</button>
        </div>
      </form>
    </div>
  `
})
