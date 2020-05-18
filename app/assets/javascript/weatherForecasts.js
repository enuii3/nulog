Vue.component('weather-forecasts-component', {
  props: {
    isSignedInUser: {
      type: Boolean,
      default: false,
    }
  },
  data: function(){
    return {
      weatherForecasts: {},
      selectedCity: '',
      selectedPrefecture: '未選択',
      cities: [],
      prefectures: { 
        "道北": [
          { name: "稚内" },
          { name: "旭川" },
          { name: "留萌" },
        ],
        "道東": [
          { name: "網走" },
          { name: "北見" },
          { name: "紋別" },
          { name: "根室" },
          { name: "釧路" },
          { name: "帯広" },
        ],
        "道南": [
          { name: "室蘭" },
          { name: "浦河" },
        ], 
        "道央": [
          { name: "札幌" },
          { name: "岩見沢" },
          { name: "倶知安" },
        ],
        "道南": [
          { name: "函館" },
          { name: "江差" },
        ],
        "青森県": [
          { name: "青森" },
          { name: "むつ" },
          { name: "八戸" },
        ],
        "岩手県": [
          { name: "盛岡" },
          { name: "宮古" },
          { name: "大船渡" },
        ],
        "宮城県": [
          { name: "仙台" },
          { name: "白石" },
        ],
        "秋田県": [
          { name: "秋田" },
          { name: "横手" },
        ],
        "山形県": [
          { name: "山形" },
          { name: "米沢" },
          { name: "酒田" },
          { name: "新庄" },
        ],
        "福島県": [
          { name: "福島" },
          { name: "小名浜" },
          { name: "若松" },
        ],
        "茨城県": [
          { name: "水戸" },
          { name: "土浦" },
        ],
        "栃木県": [
          { name: "宇都宮" },
          { name: "大田原" },
        ],
        "群馬県": [
          { name: "前橋" },
          { name: "みなかみ" },
        ],
        "埼玉県": [
          { name: "さいたま" },
          { name: "熊谷" },
          { name: "秩父" },
        ],
        "千葉県": [
          { name: "千葉" },
          { name: "銚子" },
          { name: "館山" },
        ],
        "東京都": [
          { name: "東京" },
          { name: "大島" },
          { name: "八丈島" },
          { name: "父島" },
        ],
        "神奈川県": [
          { name: "横浜" },
          { name: "小田原" },
        ],
        "新潟県": [
          { name: "新潟" },
          { name: "長岡" },
          { name: "高田" },
          { name: "相川" },
        ],
        "富山県": [
          { name: "富山" },
          { name: "伏木" },
        ],
        "石川県": [
          { name: "金沢" },
          { name: "輪島" },
        ],
        "福井県": [
          { name: "福井" },
          { name: "敦賀" },
        ],
        "山梨県": [
          { name: "甲府" },
          { name: "河口湖" },
        ],
        "長野県": [
          { name: "長野" },
          { name: "松本" },
          { name: "飯田" },
        ],
        "岐阜県": [
          { name: "岐阜" },
          { name: "高山" },
        ],
        "静岡県": [
          { name: "静岡" },
          { name: "網代" },
          { name: "三島" },
          { name: "浜松" },
        ],
        "愛知県": [
          { name: "名古屋" },
          { name: "豊橋" },
        ],
        "三重県": [
          { name: "津" },
          { name: "尾鷲" },
        ],
        "滋賀県": [
          { name: "大津" },
          { name: "彦根" },
        ],
        "京都府": [
          { name: "京都" },
          { name: "舞鶴" },
        ],
        "大阪府": [
          { name: "大阪" },
        ],
        "兵庫県": [
          { name: "神戸" },
          { name: "豊岡" },
        ],
        "奈良県": [
          { name: "奈良" },
          { name: "風屋" },
        ],
        "和歌山県": [
          { name: "和歌山" },
          { name: "潮岬" },
        ],
        "鳥取県": [
          { name: "鳥取" },
          { name: "米子" },
        ],
        "島根県": [
          { name: "松江" },
          { name: "浜田" },
          { name: "西郷" },
        ],
        "岡山県": [
          { name: "岡山" },
          { name: "津山" },
        ],
        "広島県": [
          { name: "広島" },
          { name: "庄原" },
        ],
        "山口県": [
          { name: "下関" },
          { name: "山口" },
          { name: "柳井" },
          { name: "萩" },
        ],
        "徳島県": [
          { name: "徳島" },
          { name: "日和佐" },
        ],
        "香川県": [
          { name: "高松" },
        ],
        "愛媛県": [
          { name: "松山" },
          { name: "新居浜" },
          { name: "宇和島" },
        ],
        "高知県": [
          { name: "高知" },
          { name: "室戸岬" },
          { name: "清水" },
        ],
        "福岡県": [
          { name: "福岡" },
          { name: "八幡" },
          { name: "飯塚" },
          { name: "久留米" },
        ],
        "佐賀県": [
          { name: "佐賀" },
          { name: "伊万里" },
        ],
        "長崎県": [
          { name: "長崎" },
          { name: "佐世保" },
          { name: "厳原" },
          { name: "福江" },
        ],
        "熊本県": [
          { name: "熊本" },
          { name: "阿蘇乙姫" },
          { name: "牛深" },
          { name: "人吉" },
        ],
        "大分県": [
          { name: "大分" },
          { name: "中津" },
          { name: "日田" },
          { name: "佐伯" },
        ],
        "宮崎県": [
          { name: "宮崎" },
          { name: "延岡" },
          { name: "都城" },
          { name: "高千穂" },
        ],
        "鹿児島県": [
          { name: "鹿児島" },
          { name: "鹿屋" },
          { name: "種子島" },
          { name: "名瀬" },
        ],
        "沖縄県": [
          { name: "那覇" },
          { name: "名護" },
          { name: "久米島" },
          { name: "南大東" },
          { name: "宮古島" },
          { name: "石垣島" },
          { name: "与那国島" },
        ],
      },
    }
  },
  mounted: async function() {
    if(this.isSignedInUser) {
      try {
        const res = await axios.get('/api/v1/weather_forecasts') 
        if(res.data != null) {
          this.weatherForecasts = res.data
          this.selectedPrefecture = res.data.prefecture_name
          this.selectPrefecture()
          this.selectedCity = res.data.city_name
        }
      } catch(error) {
        this.$emit('handle-weather-forecasts-errors', error.response.data)
      }
    }
  },
  methods: {
    searchWeatherForecasts: async function(){
      try{
        const res = await axios.get('/api/v1/weather_forecasts', {
          params: {
            prefecture_name: this.selectedPrefecture,
            city_name: this.selectedCity,
          }
        })
        this.weatherForecasts = res.data
      } catch(error) {
        this.$emit('handle-weather-forecasts-errors', error.response.data)
      }
    },
    selectPrefecture: function(){
      this.cities = this.prefectures[this.selectedPrefecture]
    },
  },
  watch: { 
    selectedCity: function() {
      this.searchWeatherForecasts()
    }
  },
  template: `
    <div class="weather-news">
      <select v-model="selectedPrefecture" @change="selectPrefecture">
        <option disabled>未選択</option>
        <option
          v-for="(value, key) in prefectures"
          :key="key"
        >{{ key }}</option>
      </select>
      <select v-model="selectedCity" :disabled="selectedPrefecture == '未選択'">
        <option disabled>未選択</option>
        <option
          v-for="city in cities"
          :key="city.name"
        >{{ city.name }}</option>
      </select>
      <div class="weather-news" v-if="weatherForecasts.tomorrow_telop">
        明日
        {{ weatherForecasts.tomorrow_telop }}
        {{ weatherForecasts.tomorrow_celsius }}
        明後日
        {{ weatherForecasts.day_after_tomorrow_telop }}
        {{ weatherForecasts.day_after_tomorrow_celsius }}
        (<a :href="weatherForecasts.link" target="_blank">リンク</a>)
      </div>
      <div class="weather-news" v-else>未選択</div>
    </div>
  `
})
