<!-- SearchComponent.vue -->
<template>
  <div class="search-container">
    <div class="input-container">
      <input type="text" v-model="searchTerm" placeholder="검색어를 입력하세요" @input="handleInput" />
      <button @click="handleSearch">검색</button>
    </div>
    <div class="content-container">
      <div class="frame">
        <div class="frame-title">Frame 1</div>
        <div class="frame-content">
          <div class="power-usage" v-if="Object.keys(powerUsage).length !== 0">
            <p>내 전력량 : {{ powerUsage.myPower }}</p>
            <p>평균 전력량 : {{ powerUsage.averagePower }}</p>
          </div>
        </div>
      </div>
      <div class="frame">
        <div class="frame-title">Frame 2</div>
        <ul class="frame-content">
          <li v-for="result in searchResults" :key="result.id">{{ result.title }}</li>
        </ul>
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
import { Chart } from 'chart.js';

export default {
  
  mounted() {
    // 컴포넌트가 마운트된 후에 차트를 그립니다.
    this.drawChart();
  },
  data() {
    return {
      searchTerm: '',
      searchResults: [],
      powerUsage: {}
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
      axios.get(`/api/power-usage?`, {
        params: {
          myPowerUsage: this.searchTerm
        }
      }
       
      ).then((res) => {
        this.powerUsage = res.data
        console.log(this.powerUsage)
      }).catch(error => {
          console.error('API 호출 중 오류가 발생했습니다.', error);
      });
    },
    drawChart() {
      // 차트를 그리는 로직을 구현합니다.
      const chartCanvas = this.$refs.chartCanvas;

      // API 호출을 통해 데이터를 가져옵니다.
      // 예시 데이터
      const chartData = {
        labels: ['데이터1', '데이터2', '데이터3'],
        datasets: [
          {
            label: '데이터셋',
            data: [10, 20, 30],
            backgroundColor: ['#ff6384', '#36a2eb', '#ffce56'],
          },
        ],
      };

      // 차트 생성
      new Chart(chartCanvas, {
        type: 'bar',
        data: chartData,
        options: {
          responsive: true,
          scales: {
            y: {
              beginAtZero: true,
            },
          },
        },
      });
    }
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