import { bootstrapApplication } from '@angular/platform-browser';
import { appConfig } from './app/app.config';
import { AppComponent } from './app/app.component';
import {HTTP_INTERCEPTORS, provideHttpClient, withInterceptors } from '@angular/common/http';
import { AuthInterceptor } from './app/services/auth/auth-interceptor.service';


bootstrapApplication(AppComponent, {
  providers: [
    ...appConfig.providers,  // Spread existing providers from appConfig
    provideHttpClient(
      withInterceptors([AuthInterceptor])
    ),  // Add HttpClientModule globally

  ],
})
  .catch((err) => console.error(err));
