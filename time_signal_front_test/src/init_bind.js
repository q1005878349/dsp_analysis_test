import Highcharts from 'highcharts/highstock';

let H = Highcharts

var Series = H.Series,
		each = H.each;
	/**
         * Create a hidden canvas to draw the graph on. The contents is later copied over
         * to an SVG image element.
         */
	Series.prototype.getContext = function () {
		if (!this.canvas) {
			this.canvas = document.createElement('canvas');
			this.canvas.setAttribute('width', this.chart.chartWidth);
			this.canvas.setAttribute('height', this.chart.chartHeight);
			this.image = this.chart.renderer.image('', 0, 0, this.chart.chartWidth, this.chart.chartHeight).add(this.group);
			this.ctx = this.canvas.getContext('2d');
		}
		return this.ctx;
	};
	/**
         * Draw the canvas image inside an SVG image
         */
	Series.prototype.canvasToSVG = function () {
		this.image.attr({ href: this.canvas.toDataURL('image/png') });
	};
	/**
         * Wrap the drawPoints method to draw the points in canvas instead of the slower SVG,
         * that requires one shape each point.
         */
	H.wrap(H.seriesTypes.heatmap.prototype, 'drawPoints', function () {
		var ctx = this.getContext();
		if (ctx) {
			// draw the columns
			each(this.points, function (point) {
				var plotY = point.plotY,
					shapeArgs,
					pointAttr;
				if (plotY !== undefined && !isNaN(plotY) && point.y !== null) {
					shapeArgs = point.shapeArgs;
					pointAttr = (point.pointAttr && point.pointAttr['']) || point.series.pointAttribs(point);
					ctx.fillStyle = pointAttr.fill;
					ctx.fillRect(shapeArgs.x, shapeArgs.y, shapeArgs.width, shapeArgs.height);
				}
			});
			this.canvasToSVG();
		} else {
			this.chart.showLoading('Your browser doesn\'t support HTML5 canvas, <br>please use a modern browser');
			// Uncomment this to provide low-level (slow) support in oldIE. It will cause script errors on
			// charts with more than a few thousand points.
			// arguments[0].call(this);
		}
	});
	H.seriesTypes.heatmap.prototype.directTouch = false; // Use k-d-tree