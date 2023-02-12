import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { map, Observable, ReplaySubject, tap } from 'rxjs';
import { Metric } from './metric.types';

@Injectable({
  providedIn: 'root',
})
export class MetricService {

  private _baseUrl = 'http://localhost:3000/v1/metrics'; // as PoC

  private _metrics: ReplaySubject<Metric[]> = new ReplaySubject<Metric[]>(1);

  constructor(private _httpClient: HttpClient) {
  }

  get metrics$(): Observable<Metric[]> {
    return this._metrics.asObservable();
  }

  getAll(name: string, grouping: string): Observable<Metric[]> {
    return this._httpClient.get<any>(this._baseUrl, { params: { name: name, grouping: grouping } }).pipe(
      map((res) => {
          return res.metrics
        }
      )
    );
  }

  create(name: string, value: string, valid_at: string): Observable<Metric> {
    return this._httpClient.post<any>(this._baseUrl, { metric: { name: name, value: value, valid_at: valid_at } }).pipe(
      map((res) => {
        return res.metric
      })
    );
  }
}
