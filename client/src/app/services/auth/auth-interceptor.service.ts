import { HttpRequest, HttpHandler, HttpEvent, HttpInterceptorFn, HttpHandlerFn } from '@angular/common/http';
import { AuthService } from './auth.service';
import { inject } from '@angular/core';
import { Observable, of, throwError } from 'rxjs';
import { catchError, switchMap } from 'rxjs/operators';
import { Router } from '@angular/router';

export function AuthInterceptor(req: HttpRequest<unknown>, next: HttpHandlerFn): Observable<HttpEvent<unknown>> {
  const router = inject(Router);
  const authService = inject(AuthService); // Injecting the service using inject() function
  const accessToken = localStorage.getItem('accessToken');

  let clonedReq = req;
  if (accessToken) {
    clonedReq = req.clone({
      setHeaders: {
        Authorization: `Bearer ${accessToken}`,
      },
    });
  }

  return next(clonedReq).pipe(
  catchError((error) => {
    if (error.status === 401) {
      console.error('Token expired or invalid');
      authService.logout();
      router.navigate(['/login']);
      // Stop further processing by returning an EMPTY observable or throwError
      return throwError(() => new Error('Unauthorized - Redirecting to login'));
      // OR
      // return EMPTY;
    }
    return throwError(() => new Error(error.message));
  })
);
};

const handleTokenExpiration = (req: HttpRequest<any>, next: HttpHandlerFn): Observable<HttpEvent<any>> => {
  const refreshToken = localStorage.getItem('refreshToken');
  if (refreshToken) {
    // Call refresh token API and update the token
    return inject(AuthService).refreshToken(refreshToken).pipe(
      switchMap((response: any) => {
        const newAccessToken = response.accessToken;
        localStorage.setItem('accessToken', newAccessToken);

        const clonedReq = req.clone({
          setHeaders: {
            Authorization: `Bearer ${newAccessToken}`,
          },
        });
        return next(clonedReq);
      }),
      catchError((err) => {
        console.error('Refresh token failed', err);
        inject(AuthService).logout();
        return throwError(() => new Error('Refresh token failed'));
      })
    );
  } else {
    inject(AuthService).logout();
    return throwError(() => new Error('No refresh token found'));
  }
};
