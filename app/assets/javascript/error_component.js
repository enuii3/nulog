Vue.component('error-component', {
  props: ['errors'],
  template: `
    <div>
      <div v-if="errors">
        <ul v-for="error in errors" :key="error">
          <li class="error-field">{{ error }}</></li>
        </ul>
      </div>
    </div>
  `
})
