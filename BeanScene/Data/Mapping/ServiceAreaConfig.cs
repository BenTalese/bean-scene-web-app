using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace BeanScene.Data.Mapping
{
    public class ServiceAreaConfig
    {
        public ServiceAreaConfig(ModelBuilder mb)
        {
            mb.Entity<Service>(s =>
            {
                s.HasMany(s => s.Areas)
                .WithMany(a => a.Services)
                .UsingEntity(j => j.ToTable("ServiceArea"));
            });
        }
    }
}
