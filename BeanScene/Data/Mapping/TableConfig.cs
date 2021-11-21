using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace BeanScene.Data.Mapping
{
    public class TableConfig
    {
        public TableConfig(ModelBuilder mb)
        {
            mb.Entity<Table>(t =>
            {
                t.Property(t => t.Prefix)
                .HasMaxLength(1);
            });
        }
    }
}
