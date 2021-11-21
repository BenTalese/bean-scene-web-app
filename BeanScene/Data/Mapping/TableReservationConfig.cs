using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace BeanScene.Data.Mapping
{
    public class TableReservationConfig
    {
        public TableReservationConfig(ModelBuilder mb)
        {
            mb.Entity<Booking>(b =>
            {
                b.HasMany(b => b.Tables)
                .WithMany(t => t.Bookings)
                .UsingEntity(j => j.ToTable("TableReservation"));
            });
        }
    }
}
