import { Routes } from '@angular/router';
import { ManagerComponent } from './manager/manager.component';
import { ManagerHomeComponent } from './manager/manager-home/manager-home.component';
import { LoginComponent } from './login/login.component';
import { SignupComponent } from './signup/signup.component';
import { PatientComponent } from './patient/patient.component';
import { DoctorComponent } from './doctor/doctor.component';
import { LifeCoachComponent } from './life-coach/life-coach.component';
import { AdminComponent } from './admin/admin.component';
import { NotFoundComponent } from './not-found/not-found.component';

export const routes: Routes = [
  {
    path: '',
    redirectTo: 'login',
    pathMatch: 'full',
  },
  {
    path: 'login',
    component: LoginComponent,
  },
  {
    path: 'signup',
    component: SignupComponent,
  },
  {
    path: 'patient',
    component: PatientComponent,
  },
  {
    path: 'doctor',
    component: DoctorComponent,
  },
  {
    path: 'life_coach',
    component: LifeCoachComponent,
  },
  {
    path: 'admin',
    component: AdminComponent,
  },
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
  // {
  //   path: '**',
  //   component: NotFoundComponent,
  // },
];
