using Microsoft.AspNetCore.Identity;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace BeanScene.StartupConfig
{
    public class ExternalAuthConfig
    {
        public ExternalAuthConfig(IServiceCollection services, IConfiguration configuration)
        {
            services.AddAuthentication()
                .AddGoogle(options =>
                {
                    options.ClientId = Environment.GetEnvironmentVariable("bean_scene_google_client_id");
                    options.ClientSecret = Environment.GetEnvironmentVariable("bean_scene_google_client_secret");
                });
                /*.AddFacebook(options =>
                {
                    string appId = Environment.GetEnvironmentVariable("bean_scene_facebook_app_id");
                    string appSecret = Environment.GetEnvironmentVariable("bean_scene_facebook_app_secret");
                    options.AppId = appId;
                    options.AppSecret = appSecret;
                });*/
        }
    }
}
