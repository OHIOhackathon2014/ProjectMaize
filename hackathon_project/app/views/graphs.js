		var data = {
    labels: ["January", "February", "March", "April", "May", "June", "July"],
    datasets: [
        {
            label: "Lines Commited",
            fillColor: "rgba(255,255,255,0.2)",
            strokeColor: "rgba(151,187,205,1)",
            pointColor: "rgba(151,187,205,1)",
            pointStrokeColor: "#fff",
            pointHighlightFill: "#fff",
            pointHighlightStroke: "rgba(151,187,205,1)",
            data: [28, 48, 40, 19, 86, 27, 90]
        }
    ]
};


		// Get context with jQuery - using jQuery's .get() method.
		var ctx = $("#myChart").get(0).getContext("2d");
		// This will get the first returned node in the jQuery collection.
		var myLineChart = new Chart(ctx).Line(data);
		
		document.getElementById('myChart').addEventListener('click',
			function(evt){
				var activePoints = myLineChart.getPointsAtEvent(evt)
			}
		, false);