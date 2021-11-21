using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace BeanScene.Data.Mapping
{
    public class BookingConfig
    {
        public BookingConfig(ModelBuilder mb)
        {
            mb.Entity<Booking>(b =>
            {
                b.Property(b => b.StartTime)
                .IsRequired();

                b.Property(b => b.Duration)
                .IsRequired()
                .HasDefaultValue(90);

                // TODO: this should have a constraint as an admin option (max 12 guests)
                b.Property(b => b.Guests)
                .IsRequired()
                .HasDefaultValue(1);

                b.Property(b => b.Notes)
                .HasMaxLength(200);

                b.Property(b => b.Source)
                .IsRequired()
                .HasConversion<string>()
                .HasMaxLength(20);

                b.Property(b => b.Status)
                .IsRequired()
                .HasConversion<string>()
                .HasMaxLength(20);
            });
        }
    }
}
