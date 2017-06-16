////// Morris bar chart
//    Morris.Bar({
//        element: 'morris-bar-chart',
//        data: [{
//            y: '2010',
//            Flat: 100,
//            Buyer: 90,
//            Purchases: 60
//        }, {
//            y: '2011',
//            Flat: 75,
//            Buyer: 65,
//            Purchases: 40
//        }, {
//            y: '2012',
//            Flat: 50,
//            Buyer: 40,
//            Purchases: 30
//        }, {
//            y: '2013',
//            Flat: 75,
//            Buyer: 65,
//            Purchases: 40
//        }, {
//            y: '2014',
//            Flat: 50,
//            Buyer: 40,
//            Purchases: 30
//        }, {
//            y: '2015',
//            Flat: 75,
//            Buyer: 65,
//            Purchases: 40
//        },{
//            y: '2016',
//            Flat: 75,
//            Buyer: 65,
//            Purchases: 40
//        },{
//            y: '2017',
//            Flat: 100,
//            Buyer: 90,
//            Purchases: 40
//        }, {
//            y: '2018',
//            Flat: 75,
//            Buyer: 65,
//            Purchases: 40
//        },{
//            y: '2019',
//            Flat: 75,
//            Buyer: 65,
//            Purchases: 40
//        },{
//            y: '2020',
//            Flat: 100,
//            Buyer: 90,
//            Purchases: 40
//        }, {
//            y: '2021',
//            Flat: 75,
//            Buyer: 65,
//            Purchases: 40
//        },{
//            y: '2022',
//            Flat: 75,
//            Buyer: 30,
//            Purchases: 40
//        },{
//            y: '2023',
//            Flat: 100,
//            Buyer: 50,
//            Purchases: 40
//        }, {
//            y: '2024',
//            Flat: 75,
//            Buyer: 65,
//            Purchases: 40
//        },{
//            y: '2025',
//            Flat: 75,
//            Buyer: 65,
//            Purchases: 40
//        },{
//            y: '2026',
//            Flat: 100,
//            Buyer: 90,
//            Purchases: 40
//        },{
//            y: '2027',
//            Flat: 75,
//            Buyer: 30,
//            Purchases: 40
//        },{
//            y: '2028',
//            Flat: 100,
//            Buyer: 50,
//            Purchases: 40
//        }, {
//            y: '2029',
//            Flat: 75,
//            Buyer: 65,
//            Purchases: 40
//        },{
//            y: '2030',
//            Flat: 75,
//            Buyer: 65,
//            Purchases: 40
//        },{
//            y: '2031',
//            Flat: 100,
//            Buyer: 90,
//            Purchases: 40
//        },{
//            y: '2032',
//            Flat: 75,
//            Buyer: 30,
//            Purchases: 40
//        },{
//            y: '2033',
//            Flat: 100,
//            Buyer: 50,
//            Purchases: 40
//        }, {
//            y: '2034',
//            Flat: 75,
//            Buyer: 65,
//            Purchases: 40
//        },{
//            y: '2035',
//            Flat: 75,
//            Buyer: 65,
//            Purchases: 40
//        },{
//            y: '2036',
//            Flat: 100,
//            Buyer: 90,
//            Purchases: 40
//        }],
//        xkey: 'y',
//        ykeys: ['Flat', 'Buyer', 'Purchases'],
//        labels: ['Flat', 'Buyer', 'Purchases'],
//        barColors:['#00bfc7', '#fb9678', '#9675ce'],
//        hideHover: 'auto',
//       
//        gridLineColor: '#eef0f2',
//        resize: true
//    });
//
//// This is for the sparkline chart
//
//   var sparklineLogin = function() { 
//        
//        $('#sparkline2dash').sparkline([6, 10, 9, 11, 9, 10, 12], {
//            type: 'bar',
//            height: '154',
//            barWidth: '4',
//            resize: true,
//            barSpacing: '10',
//            barColor: '#25a6f7'
//        });
//       $('#sales1').sparkline([6, 10, 9, 11, 9, 10, 12], {
//            type: 'bar',
//            height: '154',
//            barWidth: '4',
//            resize: true,
//            barSpacing: '10',
//            barColor: '#fff'
//        });
//        
//   }
//    var sparkResize;
// 
//        $(window).resize(function(e) {
//            clearTimeout(sparkResize);
//            sparkResize = setTimeout(sparklineLogin, 500);
//        });
//        sparklineLogin();
//
