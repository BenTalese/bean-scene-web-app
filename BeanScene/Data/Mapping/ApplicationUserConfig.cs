using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace BeanScene.Data.Mapping
{
    public class ApplicationUserConfig
    {
        public ApplicationUserConfig(ModelBuilder mb)
        {
            mb.Entity<ApplicationUser>(au =>
            {
                au.HasIndex(au => au.Email)
                .IsUnique(true);
            });
        }
    }
}
