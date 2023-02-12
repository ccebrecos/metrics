import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { MetricsComponent } from './metrics/metrics.component';

const routes: Routes = [
  { path: '', redirectTo: 'metrics', pathMatch: 'full' },
  { path: 'metrics', component: MetricsComponent }
];

@NgModule({
  imports: [ RouterModule.forRoot(routes) ],
  exports: [ RouterModule ]
})
export class AppRoutingModule {
}
