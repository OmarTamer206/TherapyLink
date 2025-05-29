import { Injectable } from '@angular/core';
import {
  CanActivate,
  ActivatedRouteSnapshot,
  RouterStateSnapshot,
  Router,
  UrlTree
} from '@angular/router';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class AuthGuard implements CanActivate {

  constructor(private router: Router) {}

  canActivate(
    route: ActivatedRouteSnapshot,
    state: RouterStateSnapshot
  ):
    | boolean
    | UrlTree
    | Observable<boolean | UrlTree>
    | Promise<boolean | UrlTree> {

    // Get token from localStorage (or your auth service)
    const token = localStorage.getItem('accessToken');
    if (!token) {
      // No token? redirect to login
      this.router.navigate(['/login']);
      return false;
    }

    // Decode JWT payload to get role
    const payload = JSON.parse(atob(token.split('.')[1]));
    const userRole = payload.role;

    // Get allowed roles from route data
    const allowedRoles: string[] = route.data['role'];

    if (!allowedRoles || allowedRoles.length === 0) {
      // No roles specified, allow access
      return true;
    }

    if (allowedRoles.includes(userRole)) {
      // Role allowed, grant access
      return true;
    } else {
      // Role not allowed, redirect to unauthorized page or home
      this.router.navigate(['/forbidden']);
      return false;
    }
  }
}
