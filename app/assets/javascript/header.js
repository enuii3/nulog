Vue.component('header-component', {
  props: {
    isSignedInUser: {
      type: Boolean,
      default: false,
    }
  },
  methods: {
    handleWeatherForecastsErrors: function(errors){
      this.$emit('handle-weather-forecasts-errors', errors)
    }
  },
  template: `
    <header>
      <h1 class="logo">nulog</h1>
      <ul class="nav-list">
        <li class="nav-list-item">
          <a href="/sign_out" class="articles-link" v-if="isSignedInUser">ログアウト</a>
          <a href="/sign_in" class="articles-link" v-else>ログイン</a>
        </li>
        <li class="nav-list-item">
          <a href="/articles/new" class="articles-link">記事投稿</a>
        </li>
        <li class="nav-list-item">
          <a href="/" class="articles-link">記事一覧</a>
        </li>
        <li class="nav-list-item">
          <weather-forecasts-component
            :is-signed-in-user="isSignedInUser"
            @handle-weather-forecasts-errors="handleWeatherForecastsErrors"
          ></weather-forecasts-component>
        </li>
      </ul>
    </header>
  `
})
