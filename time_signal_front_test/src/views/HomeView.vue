<script setup>
import { createApp } from "vue";
import Highcharts from "highcharts/highstock";
import * as echarts from 'echarts';
import data from '../ouput'
</script>

<template>
	<div id="app">
		<div id="main">123</div>
	</div>
</template>

<script>
createApp({
	data() {
		return {
			message: "Hello Vue!",
		};
	},
	mounted () {
		setTimeout(() => this.getChart(), 1000)
	},
	methods: {
		getChart() {
			var app = {};
			
			var chartDom = document.getElementById("main")
			var myChart = echarts.init(chartDom);
			var option;

			let xData = data['x'];
			let yData = data['y'];
			let dt = data['data'];
			dt = dt.sort((a,b) => a[1] - b[1])
			console.log(dt)
			option = {
				tooltip: {},
				xAxis: {
					type: "category",
					data: xData,
				},
				yAxis: {
					type: "category",
					data: yData,
				},
				visualMap: {
					min: 0,
					max: 1,
					calculable: true,
					realtime: false,
					inRange: {
						color: [
							"#313695",
							"#4575b4",
							"#74add1",
							"#abd9e9",
							"#e0f3f8",
							"#ffffbf",
							"#fee090",
							"#fdae61",
							"#f46d43",
							"#d73027",
							"#a50026",
						],
					},
				},
				series: [
					{
						name: "Gaussian",
						type: "heatmap",
						coordinateSystem: "cartesian2d",
						data: dt,
						emphasis: {
							itemStyle: {
								borderColor: "#333",
								borderWidth: 1,
							},
						},
						progressive: 1000,
						animation: true,
					},
				],
			};
			myChart.setOption(option)
		},
	},
}).mount("#app");
</script>

<style scoped>
#main {
	width: 500px;
	height: 500px;
}
</style>
