import { Component } from '@angular/core';
import { MetricService } from '../core/metric/metric.service';
import { FormBuilder, FormControl, FormGroup, Validators } from '@angular/forms';
import { Metric } from '../core/metric/metric.types';

@Component({
  selector: 'app-add-metric',
  templateUrl: './add-metric.component.html',
  styleUrls: [ './add-metric.component.scss' ]
})
export class AddMetricComponent {

  createMetricForm: FormGroup;

  constructor(
    private _metricService: MetricService,
    private _formBuilder: FormBuilder,
  ) {
    this.createMetricForm = this._formBuilder.group({
      metricName: new FormControl('', [ Validators.required ]),
      metricValue: new FormControl('', [ Validators.required, Validators.pattern("^[0-9]*.[0-9]*$") ]),
      metricValidAt: new FormControl(new Date().toISOString(), [ Validators.required, Validators.pattern("^\\d{4}-\\d\\d-\\d\\dT\\d\\d:\\d\\d:\\d\\d(.\\d+)?(([+-]\\d\\d:\\d\\d)|Z)?$") ]),
    })
  }

  createMetric() {
    if (this.createMetricForm.valid) {
      this._metricService.create(
        this.createMetricForm.value['metricName'],
        this.createMetricForm.value['metricValue'],
        this.createMetricForm.value['metricValidAt'],
      ).subscribe((metric: Metric) => {
        return metric
      })
    }
  }
}
