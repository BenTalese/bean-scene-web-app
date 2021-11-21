using Microsoft.AspNetCore.Identity;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace BeanScene.StartupConfig
{
    public class IdentityConfig
    {
        public IdentityConfig(IServiceCollection services, IConfiguration configuration)
        {
            services.Configure<IdentityOptions>(options =>
            {
                // Password config settings
                IConfigurationSection password = configuration.GetSection("Identity:Password");
                options.Password.RequireDigit = boolOptionConverter(password["RequireDigit"]);
                options.Password.RequireLowercase = boolOptionConverter(password["RequireLowercase"]);
                options.Password.RequireUppercase = boolOptionConverter(password["RequireUppercase"]);
                options.Password.RequireNonAlphanumeric = boolOptionConverter(password["RequireNonAlphanumeric"]);
                options.Password.RequiredLength = intOptionConverter(password["RequiredLength"]);
                options.Password.RequiredUniqueChars = intOptionConverter(password["RequiredUniqueChars"]);


                // Lockout config settings
                IConfigurationSection lockout = configuration.GetSection("Identity:Lockout");
                options.Lockout.AllowedForNewUsers = boolOptionConverter(lockout["AllowedForNewUsers"]);
                options.Lockout.DefaultLockoutTimeSpan = timeOptionConverter(lockout["DefaultLockoutTimeSpan"]);
                options.Lockout.MaxFailedAccessAttempts = intOptionConverter(lockout["MaxFailedAccessAttempts"]);

                // Sign-in config settings
                IConfigurationSection signIn = configuration.GetSection("Identity:SignIn");
                options.SignIn.RequireConfirmedEmail = boolOptionConverter(signIn["RequireConfirmedEmail"]);
            });
        }

        private bool boolOptionConverter(string option)
        {
            try
            {
                return bool.Parse(option);
            }
            catch (FormatException)
            {
                // TODO: throw correct error / log
                //Console.WriteLine($"Unable to parse '{option}'");
                throw;
            }
        }

        private int intOptionConverter(string option)
        {
            try
            {
                return int.Parse(option);
            }
            catch (FormatException)
            {
                // TODO: throw correct error / log
                //Console.WriteLine($"Unable to parse '{option}'");
                throw;
            }
        }

        private TimeSpan timeOptionConverter(string option)
        {
            try
            {
                return TimeSpan.Parse(option);
            }
            catch (FormatException)
            {
                // TODO: throw correct error / log
                //Console.WriteLine($"Unable to parse '{option}'");
                throw;
            }
        }
    }
}
