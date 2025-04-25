import { HttpRequest, HttpHandler, HttpEvent, HttpInterceptorFn, HttpHandlerFn } from '@angular/common/http';
import { AuthService } from './auth.service';
import { inject } from '@angular/core';
import { Observable, of, throwError } from 'rxjs';
import { catchError, switchMap } from 'rxjs/operators';

export function AuthInterceptor(req: HttpRequest<unknown>, next: HttpHandlerFn): Observable<HttpEvent<unknown>> {
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
        return handleTokenExpiration(req, next);
      }
      return throwError(() => new Error(error));
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
