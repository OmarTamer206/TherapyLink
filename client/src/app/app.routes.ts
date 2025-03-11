import { Routes } from '@angular/router';
import { ManagerComponent } from './manager/manager.component';
import { ManagerHomeComponent } from './manager/manager-home/manager-home.component';

export const routes: Routes = [
  {
    path: 'manager',
    component: ManagerComponent,
    children: [
      {
        path: 'home',
        component: ManagerHomeComponent,
      },
    ],
  },
];
