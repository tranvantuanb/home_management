var StatisticChart = {
  options: {
    title: {
      text: '',
      x: -80 //center
    },

    xAxis: {
      categories: []
    },

    yAxis: {
      title: {
        text: I18n.t("amount"),
        style: {
          color: Highcharts.getOptions().colors[1]
        }
      }
    },
    tooltip: {
      valueSuffix: ' VND'
    },
    legend: {
      layout: I18n.t("vertical"),
      align: I18n.t("right"),
      verticalAlign: I18n.t("middle"),
    },
    plotOptions: {
      line: {
        dataLabels: {
          enabled: true
        },
        enableMouseTracking: true
      }
    },
    series: []
  },

  initialize: function() {
    StatisticChart.options.series = [];
    $.getJSON('/admin/statistic.json', function(data) {
      for (let i = 0; i < data[1].length; i ++) {
        StatisticChart.options.series.push({
          name: data[1][i].name,
          data: data[1][i].data
        });
      }
      StatisticChart.options.xAxis.categories = data[2].months;
      StatisticChart.options.title.text = I18n.t("cost_statistics") + data[0].year
      StatisticChart.draw_chart();
    });
  },

  draw_chart: function() {
    Highcharts.chart('chart-container', StatisticChart.options);
  }
}

function init_chart_basic_line() {
  StatisticChart.initialize();
};
