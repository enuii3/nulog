Vue.component('header-component', {
  props: {
    isSignedInUser: {
      type: Boolean,
      default: false,
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
          <weather-forecasts-component :is-signed-in-user="isSignedInUser"></weather-forecasts-component>
        </li>
      </ul>
    </header>
  `
})
