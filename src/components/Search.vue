<!-- SearchComponent.vue -->
<template>
  <div class="search-container">
    <div class="input-container">
      <div class="select-container">
        <select type="text" @change="option1" v-model="metro" class="select-option">
          <option v-for="option in metroOptions" :value="option.codeNm" :key="option.codeNm">{{ option.codeNm }}</option>
        </select>
        <select type="text" v-model="city" class="select-option">
          <option v-for="option in cityOptions" :value="option.city" :key="option.city">{{ option.city }}</option>
        </select>
        <select type="text" v-model="cntr" class="select-option">
          <option v-for="option in cntrOptions" :value="option.codeNm" :key="option.codeNm">{{ option.codeNm }}</option>
        </select>
        <select type="text" v-model="year" class="select-option">
          <option v-for="option in yearOptions" :value="option" :key="option">{{ option }}</option>
        </select>
        <select type="text" v-model="month" class="select-option">
          <option v-for="option in monthOptions" :value="option" :key="option">{{ option }}</option>
        </select>
      </div>
      <input type="text" v-model="searchTerm" placeholder="검색어를 입력하세요" @input="handleInput" />
      <button @click="handleSearch">검색</button>
    </div>
    <div class="content-container" v-if="Object.keys(responseData).length !== 0">
      <div class="frame">
        <div class="frame-title">Frame 1</div>
        <div class="frame-content">
          <div class="power-usage" v-if="Object.keys(responseData).length !== 0">
            <p>내 전력량 : {{ responseData.myPower }}</p>
            <p>평균 전력량 : {{ responseData.averagePower }}</p>
            <p>전년도 평균 전력량 : {{ responseData.prevAveragePower }}</p>
            <p>비율 : {{ responseData.powerRatio }}</p>
          </div>
        </div>
      </div>
      <div class="frame">
        <Bar :data="chartData" />
      </div>
      <div class="frame">
        <div class="frame-title">Frame 3</div>
        <div class="frame-content">
        <canvas ref="chartCanvas"></canvas>
        </div>
        <!-- Add your content for the third frame here -->
      </div>
    </div>
    <ul>
      <li v-for="result in searchResults" :key="result.id">{{ result.title }}</li>
    </ul>
  </div>
</template>


<script>
import axios from 'axios'
import { cityList } from '../assets/city';
import { metroList } from '../assets/metro';
import { contractList } from '../assets/contract'
import { monthList } from '@/assets/month';
import { yearList } from '@/assets/year';
import { Bar } from 'vue-chartjs'
import { Chart as ChartJS, Title, Tooltip, Legend, BarElement, CategoryScale, LinearScale } from 'chart.js'

ChartJS.register(Title, Tooltip, Legend, BarElement, CategoryScale, LinearScale)

export default {
  
  name: 'BarChart',
  components: { Bar },
  data() {
    return {
      metroOptions : metroList,
      cityOptions: '',
      cntrOptions: contractList,
      yearOptions: yearList,
      monthOptions: monthList,
      metro: '',
      city:'',
      cntr: '',
      searchTerm: '',
      responseData: {},
      loaded: false,
      chartData: null
    };
  },
  methods: {
    handleInput() {
      // 검색어가 변경될 때마다 검색 로직을 수행하는 함수
      // 실제 검색 로직을 구현해야 합니다.
      // 검색 결과를 this.searchResults에 할당하면 템플릿에서 사용할 수 있습니다.
    },
    handleSearch() {
      // 검색 버튼 클릭 시 검색 로직을 수행하는 함수
      // 실제 검색 로직을 구현해야 합니다.
      // 검색 결과를 this.searchResults에 할당하면 템플릿에서 사용할 수 있습니다.
      
      if (!this.searchTerm) return;
      let data = JSON.stringify({
        "myPowerUsage": this.searchTerm,
        "metro": this.metro,
        "cntr":  this.cntr,
        "city": this.city,
        "year": this.year,
        "month": this.month
      });

      let config = {
        method: 'post',
        maxBodyLength: Infinity,
        url: '/api/power-usage',
        headers: { 
          'Content-Type': 'application/json'
        },
        data : data
      };

      axios.request(config)
      .then((response) => {
        this.loaded = true
        this.responseData = response.data
        this.chartData =  {
          labels: [ '내 전력 사용량', '평균 전력사용량', '전년도 평균 전력사용량'],
          datasets: [
            {
              label: this.metro + ' ' + this.city + ' ' +'전력사용량',
              backgroundColor: '#f87979',
              data: [response.data.myPower, response.data.averagePower, response.data.prevAveragePower]
            }
          ]
        };
      })
      .catch((error) => {
        console.log(error);
        alert('해당 데이터가 존재하지 않습니다.');
      });
    },
    option1() {
      // this.cityOptions : cityList
      this.cityOptions = cityList.filter(item => item.metro == this.metro);
    },
  }
};
</script>
<style scoped lang="scss">
.search-container {
  display: flex;
  flex-direction: column;
  align-items: center;
  padding: 30px;
  font-family: 'Jua', sans-serif;
}

.input-container {
  display: flex;
  align-items: center;
  width: 100%;
  max-width: 1000px;
}

.select-container {
  height: 100%;
  display: flex;
  align-items: center;
  margin-right: 10px;
}

.select-option {
  height: 100%;
  width: 110px;
  padding: 10px;
  margin-left: 5px;
  border: 1px solid gray;
  border-radius: 4px;
  background-color: white;
}

input {
  flex: 1;
  padding: 10px;
  border: 1px solid gray;
  border-radius: 4px;
}

button {
  margin-left: 10px;
  padding: 10px 20px;
  background-color: #007bff;
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
}

.content-container {
  display: flex;
  margin-top: 20px;
  width: 100%;
}

.frame {
  flex: 1;
  border: 1px solid #ccc;
  border-radius: 4px;
  margin-right: 10px;
}

.frame-title {
  background-color: #f8f8f8;
  padding: 10px;
  border-bottom: 1px solid #ccc;
  font-weight: bold;
}

.frame-content {
  padding: 10px;
}

.power-usage {
  font-size: 16px;
  background-color: #f8f8f8;
  padding: 10px;
  border-radius: 4px;
}

</style>