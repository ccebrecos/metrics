import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { MetricsComponent } from './metrics/metrics.component';
import { AddMetricComponent } from './add-metric/add-metric.component';

const routes: Routes = [
  { path: '', redirectTo: 'metrics', pathMatch: 'full' },
  { path: 'metrics', component: MetricsComponent },
  { path: 'create', component: AddMetricComponent },
];

@NgModule({
  imports: [ RouterModule.forRoot(routes) ],
  exports: [ RouterModule ]
})
export class AppRoutingModule {
}
