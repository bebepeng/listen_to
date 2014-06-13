function viewchart(titles, songLikes, songViews) {
  $('#view-count-chart').highcharts({
    chart: {
      type: 'bar'
    },
    title: {
      text: 'Youtube Videos by Viewer Statistics'
    },
    subtitle: {
      text: 'Source: Youtube.com'
    },
    xAxis: {
      categories: titles,
      title: {
        text: 'Song Title'
      }
    },
    yAxis: {
      min: 0,
      title: {
        text: 'Viewer Statistics (viewers)',
        align: 'high'
      },
      labels: {
        overflow: 'justify'
      }
    },
    tooltip: {
      valueSuffix: ' viewers'
    },
    plotOptions: {
      bar: {
        dataLabels: {
          enabled: true
        }
      }
    },
    credits: {
      enabled: false
    },
    series: [
      {
        name: 'likes',
        data: songLikes
      },
      {
        name: 'total views',
        data: songViews
      }
    ]
  });
}