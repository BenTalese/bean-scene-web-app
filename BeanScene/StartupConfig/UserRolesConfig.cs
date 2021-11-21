using BeanScene.Data;
using Microsoft.AspNetCore.Identity;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace BeanScene.StartupConfig
{
    public class UserRolesConfig
    {
        public UserRolesConfig(IServiceProvider serviceProvider)
        {
            createRoles(serviceProvider).Wait();
            createDefaultManager(serviceProvider).Wait();
            createDefaultEmployee(serviceProvider).Wait();
        }


        private async Task createRoles(IServiceProvider serviceProvider)
        {
            var roleManager = serviceProvider.GetRequiredService<RoleManager<IdentityRole>>();
            string[] roleNames = { nameof(Role.Manager), nameof(Role.Employee), nameof(Role.Member) };

            foreach (string roleName in roleNames)
            {
                var roleExists = await roleManager.RoleExistsAsync(roleName);
                if (!roleExists)
                {
                    await roleManager.CreateAsync(new IdentityRole(roleName));
                }
            }
        }

        private async Task createDefaultManager(IServiceProvider serviceProvider)
        {
            var userManager = serviceProvider.GetRequiredService<UserManager<IdentityUser>>();

            var manager = await userManager.FindByNameAsync("Manager");

            if (manager == null)
            {
                var powerUser = new IdentityUser
                {
                    UserName = "Manager",
                    Email = "manager@email.com",
                };
                string password = "Manage123#";

                var createPowerUser = await userManager.CreateAsync(powerUser, password);
                if (createPowerUser.Succeeded)
                {
                    await userManager.AddToRoleAsync(powerUser, nameof(Role.Manager));
                }
            }
        }

        private async Task createDefaultEmployee(IServiceProvider serviceProvider)
        {
            var userManager = serviceProvider.GetRequiredService<UserManager<IdentityUser>>();

            var employee = await userManager.FindByNameAsync("Employee");

            if (employee == null)
            {
                var managersMinion = new IdentityUser
                {
                    UserName = "Employee",
                    Email = "employee@email.com",
                };
                string password = "Employ123#";

                var createManagersMinion = await userManager.CreateAsync(managersMinion, password);
                if (createManagersMinion.Succeeded)
                {
                    await userManager.AddToRoleAsync(managersMinion, nameof(Role.Employee));
                }
            }
        }
    }
}
