import { Component } from '@angular/core';
import { Metric } from '../core/metric/metric.types';
import { MetricService } from '../core/metric/metric.service';
import { Chart } from 'chart.js/auto';
import { FormBuilder, FormControl, FormGroup, Validators } from '@angular/forms';

@Component({
  selector: 'app-metrics',
  templateUrl: './metrics.component.html',
  styleUrls: [ './metrics.component.scss' ]
})
export class MetricsComponent {
  metrics: Metric[] = [];

  groupings = [
    {
      label: '1 minute',
      value: 'PT1M',
    },
    {
      label: '5 minutes',
      value: 'PT2M',
    },
    {
      label: '1 hour',
      value: 'PT1H',
    },
    {
      label: '1 day',
      value: 'P1D',
    }
  ];
  chart: any;

  selectMetricForm: FormGroup;

  constructor(
    private _metricService: MetricService,
    private _formBuilder: FormBuilder,
  ) {
    this.selectMetricForm = this._formBuilder.group({
      metricName: new FormControl('', [ Validators.required ]),
      metricGrouping: new FormControl(this.groupings[0].value),
    });
  }

  triggerQuery() {
    this.chart?.destroy();
    this.getMetrics(this.selectMetricForm.value['metricName'], this.selectMetricForm.value['metricGrouping']);
  }

  getMetrics(name: string, grouping: string): void {
    this._metricService.getAll(name, grouping).subscribe((metrics: Metric[]) => {
      this.metrics = metrics;

      this.chart = new Chart("metrics", {
        type: 'line',
        data: {
          labels: this.metrics.map((m) => new Date(m.valid_at).toLocaleString()),
          datasets: [
            {
              label: this.metrics[0].name,
              data: this.metrics.map((m) => m.value),
              backgroundColor: '#FF355E',
              borderColor: '#FF355E',
              hoverBorderColor: '#07A2AD',
              tension: 0.3,
            }
          ]
        }
      });
    })
  }
}
