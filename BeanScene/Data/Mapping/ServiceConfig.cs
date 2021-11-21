using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace BeanScene.Data.Mapping
{
    public class ServiceConfig
    {
        public ServiceConfig(ModelBuilder mb)
        {
            mb.Entity<Service>(s =>
            {
                s.Property(s => s.Date)
                .IsRequired();

                s.Property(s => s.MaxCapacity)
                .IsRequired();

                s.Property(s => s.State)
                .IsRequired()
                .HasConversion<string>()
                .HasMaxLength(30);
            });
        }
    }
}
