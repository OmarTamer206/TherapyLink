import { Component } from '@angular/core';
import { Routes } from '@angular/router';
import { AdminDashboardComponent } from '../admin/admin-dashboard/admin-dashboard.component';
import { AdminPatientComponent } from '../admin/admin-patient/admin-patient.component';
import { AdminRefundComponent } from '../admin/admin-refund/admin-refund.component';
import { AdminSessionsComponent } from '../admin/admin-sessions/admin-sessions.component';
import { AdminSettingsComponent } from '../admin/admin-settings/admin-settings.component';
import { AdminWorkforceComponent } from '../admin/admin-workforce/admin-workforce.component';
import { AdminComponent } from '../admin/admin.component';
import { DoctorComponent } from '../doctor/doctor.component';
import { EmergencyTeamChatComponent } from '../emergency-team/emergency-team-chat/emergency-team-chat.component';
import { EmergencyTeamDashboardComponent } from '../emergency-team/emergency-team-dashboard/emergency-team-dashboard.component';
import { EmergencyTeamOperationsComponent } from '../emergency-team/emergency-team-operations/emergency-team-operations.component';
import { EmergencyTeamSettingsComponent } from '../emergency-team/emergency-team-settings/emergency-team-settings.component';
import { EmergencyTeamComponent } from '../emergency-team/emergency-team.component';
import { LifeCoachComponent } from '../life-coach/life-coach.component';
import { LoginComponent } from '../login/login.component';
import { ManagerDashboardComponent } from '../manager/manager-dashboard/manager-dashboard.component';
import { ManagerManageAdminRegisterPageComponent } from '../manager/manager-manage-admin-register-page/manager-manage-admin-register-page.component';
import { ManagerReportsGeneratorComponent } from '../manager/manager-reports-generator/manager-reports-generator.component';
import { ManagerComponent } from '../manager/manager.component';
import { SignupComponent } from '../signup/signup.component';

@Component({
  selector: 'app-patient',
  standalone: true,
  imports: [],
  templateUrl: './patient.component.html',
  styleUrl: './patient.component.css',
})
export class PatientComponent {}

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
    children: [
      {
        path: 'patient/home',
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
      {
        path: 'emergency-team',
        component: EmergencyTeamComponent,
        children: [
          {
            path: 'emergency-team-dashboard',
            component: EmergencyTeamDashboardComponent,
          },
          {
            path: 'emergency-team-operations',
            component: EmergencyTeamOperationsComponent,
          },
          {
            path: 'emergency-team-chat',
            component: EmergencyTeamChatComponent,
          },
          {
            path: 'emergency-team-settings',
            component: EmergencyTeamSettingsComponent,
          },
        ],
      },
      // Uncomment and configure if you need a NotFound component for unknown routes
      // {
      //   path: '**',
      //   component: NotFoundComponent,
      // },
    ],
  },
];
