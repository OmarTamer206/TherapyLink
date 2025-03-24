import { Routes } from '@angular/router';
import { ManagerComponent } from './manager/manager.component';
import { LoginComponent } from './login/login.component';
import { SignupComponent } from './signup/signup.component';
import { PatientComponent } from './patient/patient.component';
import { DoctorComponent } from './doctor/doctor.component';
import { LifeCoachComponent } from './life-coach/life-coach.component';
import { AdminComponent } from './admin/admin.component';
import { NotFoundComponent } from './not-found/not-found.component';
import { AdminDashboardComponent } from './admin/admin-dashboard/admin-dashboard.component';
import { ManagerDashboardComponent } from './manager/manager-dashboard/manager-dashboard.component';
import { ManagerManageAdminRegisterPageComponent } from './manager/manager-manage-admin-register-page/manager-manage-admin-register-page.component';
import { AdminSessionsComponent } from './admin/admin-sessions/admin-sessions.component';
import { ManagerReportsGeneratorComponent } from './manager/manager-reports-generator/manager-reports-generator.component';
import { AdminWorkforceComponent } from './admin/admin-workforce/admin-workforce.component';
import { AdminRefundComponent } from './admin/admin-refund/admin-refund.component';
import { AdminPatientComponent } from './admin/admin-patient/admin-patient.component';
import { AdminSettingsComponent } from './admin/admin-settings/admin-settings.component';

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
    children: [
      {
        path: 'dashboard',
        component: AdminDashboardComponent,
      },
      {
        path: 'admin-sessions',
        component: AdminSessionsComponent,
      },
      {
        path: 'admin-refund',
        component: AdminRefundComponent,
      },
      {
        path: 'admin-workforce',
        component: AdminWorkforceComponent,
      },
      {
        path: 'admin-patient',
        component: AdminPatientComponent,
      },
      {
        path: 'admin-settings',
        component: AdminSettingsComponent,
      },
    ],  
  },
  {
    path: 'manager',
    component: ManagerComponent,
    children: [
      {
        path: 'dashboard',
        component: ManagerDashboardComponent,
      },
      {
        path: 'manage-admins',
        component: ManagerManageAdminRegisterPageComponent,
      },
      {
        path: 'reports-generator',
        component: ManagerReportsGeneratorComponent,
      },
    ],
  },
  // {
  //   path: '**',
  //   component: NotFoundComponent,
  // },
];
