using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace BeanScene.Data.Mapping
{
    public class SittingConfig
    {
        public SittingConfig(ModelBuilder mb)
        {
            mb.Entity<Sitting>(s =>
            {
                s.Property(s => s.MealType)
                .IsRequired()
                .HasConversion<string>()
                .HasMaxLength(30);

                s.Property(s => s.DayOfWeek)
                .IsRequired()
                .HasConversion<string>()
                .HasMaxLength(30);

                s.Property(s => s.StartTime)
                .IsRequired();

                s.Property(s => s.EndTime)
                .IsRequired();

                s.Property(s => s.IsActive)
                .HasDefaultValue(false);

                s.Property(s => s.TablesInside)
                .IsRequired();

                s.Property(s => s.TablesOutside)
                .IsRequired();

                s.Property(s => s.TablesBalcony)
                .IsRequired();
            });
        }
    }
}
