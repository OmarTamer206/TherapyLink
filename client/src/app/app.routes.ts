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
import { EmergencyTeamComponent } from './emergency-team/emergency-team.component';
import { EmergencyTeamDashboardComponent } from './emergency-team/emergency-team-dashboard/emergency-team-dashboard.component';
import { EmergencyTeamChatComponent } from './emergency-team/emergency-team-chat/emergency-team-chat.component';
import { EmergencyTeamSettingsComponent } from './emergency-team/emergency-team-settings/emergency-team-settings.component';
import { HomeComponent } from './patient/home/home.component';
import { DoctorDashboardComponent } from './doctor/doctor-dashboard/doctor-dashboard.component';
import { ScheduleManagementComponent } from './doctor/schedule-management/schedule-management.component';
import { PatientAnalyticsComponent } from './doctor/patient-analytics/patient-analytics.component';
import { ReportsComponent } from './doctor/reports/reports.component';
import { ProfileComponent } from './doctor/profile/profile.component';
import { SessionComponent } from './doctor/session/session.component';
import { DashboardComponent } from './life-coach/dashboard/dashboard.component';
import { lifeScheduleManagementComponent } from './life-coach/schedule-management/schedule-management.component';
import { lifePatientAnalyticsComponent } from './life-coach/patient-analytics/patient-analytics.component';
import { lifeReportsComponent } from './life-coach/reports/reports.component';
import { lifeProfileComponent } from './life-coach/profile/profile.component';
import { lifeSessionComponent } from './life-coach/session/session.component';
import { ChatbotComponent } from './patient/chatbot/chatbot.component';
import { DoctorAppointmentComponent } from './patient/doctor-appointment/doctor-appointment.component';
import { DoctorCheckoutComponent } from './patient/doctor-checkout/doctor-checkout.component';
import { DoctorsPageComponent } from './patient/doctors-page/doctors-page.component';
import { EditProfileComponent } from './patient/edit-profile/edit-profile.component';
import { JournalComponent } from './patient/journal/journal.component';
import { LifeCoachAppointmentComponent } from './patient/life-coach-appointment/life-coach-appointment.component';
import { LifeCoachCheckoutComponent } from './patient/life-coach-checkout/life-coach-checkout.component';
import { LifeCoachPageComponent } from './patient/life-coach-page/life-coach-page.component';
import { OldSessionComponent } from './patient/old-session/old-session.component';
import { SessionPageComponent } from './patient/session-page/session-page.component';
import { SessionsLogComponent } from './patient/sessions-log/sessions-log.component';
import { ManagerSettingsComponent } from './manager/manager-settings/manager-settings.component';
import { PatientProfileComponent } from './patient/profile/profile.component';
import { ChatSectionComponent } from './chat-section/chat-section.component';
import { SessionEndedComponent } from './patient/session-ended/session-ended.component';
import { LifeCoachSessionEndedComponent } from './life-coach/session-ended/session-ended.component';
import { EmergencySessionComponent } from './emergency-team/emergency-session/emergency-session.component';
import { EmergencySessionPatientComponent } from './patient/emergency-session/emergency-session.component';
import { ForbiddenComponent } from './forbidden/forbidden.component';
import { AuthGuard } from './guards/auth.guard';
import { ChatMobileComponent } from './chat-mobile/chat-mobile.component';
import { OldChatMobileComponent } from './old-chat-mobile/old-chat-mobile.component';
import { CallMobileComponent } from './call-mobile/call-mobile.component';
import { EmergencyCallMobileComponent } from './emergency-call-mobile/emergency-call-mobile.component';

export const routes: Routes = [
  {
    path: '',
    redirectTo: 'login',
    pathMatch: 'full',
  },
  {
    path: 'patient',
    redirectTo: 'patient/home',
    pathMatch: 'full',
  },
  {
    path: 'doctor',
    redirectTo: 'doctor/dashboard',
    pathMatch: 'full',
  },
  {
    path: 'life-coach',
    redirectTo: 'life-coach/dashboard',
    pathMatch: 'full',
  },
  {
    path: 'emergency-team',
    redirectTo: 'emergency-team/emergency-team-dashboard',
    pathMatch: 'full',
  },
  {
    path: 'admin',
    redirectTo: 'admin/dashboard',
    pathMatch: 'full',
  },
  {
    path: 'manager',
    redirectTo: 'manager/dashboard',
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
    canActivate:[AuthGuard],
    data:{role : ["patient"]},
    children: [
      { path: 'home', component: HomeComponent },
      {
        path: 'chatbot',
        component: ChatbotComponent,
      },
      {
        path: 'doctor-appointment',
        component: DoctorAppointmentComponent,
      },
      {
        path: 'doctor-checkout',
        component: DoctorCheckoutComponent,
      },
      {
        path: 'doctors-page',
        component: DoctorsPageComponent,
      },
      {
        path: 'edit-profile',
        component: EditProfileComponent,
      },
      {
        path: 'journal',
        component: JournalComponent,
      },
      {
        path: 'life-coach-appointment',
        component: LifeCoachAppointmentComponent,
      },
      {
        path: 'life-coach-checkout',
        component: LifeCoachCheckoutComponent,
      },
      {
        path: 'life-coach-page',
        component: LifeCoachPageComponent,
      },
      {
        path: 'old-session',
        component: OldSessionComponent,
      },
      {
        path: 'session-ended',
        component: SessionEndedComponent,
      },
      {
        path: 'profile',
        component: PatientProfileComponent,
      },
      {
        path: 'session-page',
        component: SessionPageComponent,
      },
      {
        path: 'session-log',
        component: SessionsLogComponent,
      },
      {
        path: 'emergency-session',
        component: EmergencySessionPatientComponent,
      },
    ],
  },

  {
    path: 'doctor',
    component: DoctorComponent,
    canActivate:[AuthGuard],
    data:{role : ["doctor"]},
    children: [
      {
        path: 'dashboard',
        component: DoctorDashboardComponent,
      },
      {
        path: 'schedule-management',
        component: ScheduleManagementComponent,
      },
      {
        path: 'patient-analytics',
        component: PatientAnalyticsComponent,
      },
      {
        path: 'reports',
        component: ReportsComponent,
      },
      {
        path: 'profile',
        component: ProfileComponent,
      },
      {
        path: 'session/:id',
        component: SessionComponent,
      },
    ],
  },

  {
    path: 'life-coach',
    component: LifeCoachComponent,
    canActivate:[AuthGuard],
    data:{role : ["life_coach"]},
    children: [
      {
        path: 'dashboard',
        component: DashboardComponent,
      },
      {
        path: 'schedule-management',
        component: lifeScheduleManagementComponent,
      },
      {
        path: 'patient-analytics',
        component: lifePatientAnalyticsComponent,
      },
      {
        path: 'reports',
        component: lifeReportsComponent,
      },
      {
        path: 'profile',
        component: lifeProfileComponent,
      },
      {
        path: 'session/:id',
        component: lifeSessionComponent,
      },
      {
        path: 'session-ended',
        component: LifeCoachSessionEndedComponent,
      },
    ],
  },
  {
    path: 'admin',
    component: AdminComponent,
    canActivate:[AuthGuard],
    data:{role : ["admin"]},
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
    canActivate:[AuthGuard],
    data:{role : ["manager"]},
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
      {
        path: 'edit-profile',
        component: ManagerSettingsComponent,
      },
    ],
  },
  {
    path: 'emergency-team',
    component: EmergencyTeamComponent,
    canActivate:[AuthGuard],
    data:{role : ["emergency_team"]},
    children: [
      {
        path: 'emergency-team-dashboard',
        component: EmergencyTeamDashboardComponent,
      },

      {
        path: 'emergency-team-chat',
        component: EmergencyTeamChatComponent,
      },
      {
        path: 'emergency-team-settings',
        component: EmergencyTeamSettingsComponent,
      },
      {
        path: 'emergency-team-session',
        component: EmergencySessionComponent,
      },
    ],
  }
  ,
  {
    path: "chat/:chatId/:userId/:userType/:receiverId/:receiverType",
    component: ChatMobileComponent
  },
  {
    path: "call/:call_ID/:userId/:userType/:userName",
    component: CallMobileComponent
  },
  {
    path: "emergency-call/:userId",
    component: EmergencyCallMobileComponent
  },
  {
    path: "old-chat/:chatId/:userId",
    component: OldChatMobileComponent
  },
  {
    path: "forbidden",
    component: ForbiddenComponent
  },
  {
    path: '**',
    component: NotFoundComponent,
  },
];
