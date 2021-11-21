using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace BeanScene.Data.Mapping
{
    public class AreaConfig
    {
        public AreaConfig(ModelBuilder mb)
        {
            mb.Entity<Area>(a =>
            {
                a.Property(a => a.Name)
                .HasMaxLength(50);
            });
        }
    }
}
