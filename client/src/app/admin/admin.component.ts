import { Component } from '@angular/core';
import { RouterLink, RouterModule, RouterOutlet } from '@angular/router';
import { AdminSettingsComponent } from "./admin-settings/admin-settings.component";

@Component({
  selector: 'app-admin',
  standalone: true,
  imports: [RouterModule, AdminSettingsComponent],
  templateUrl: './admin.component.html',
  styleUrl: './admin.component.css',
})
export class AdminComponent {}
