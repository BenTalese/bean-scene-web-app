using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace BeanScene.Data.Mapping
{
    public class FeedbackConfig
    {
        public FeedbackConfig(ModelBuilder mb)
        {
            mb.Entity<Feedback>(f =>
            {
                f.Property(f => f.Title)
                .HasMaxLength(100);

                f.Property(f => f.Reason)
                .HasConversion<string>()
                .HasMaxLength(30);

                f.Property(f => f.Comments)
                .HasMaxLength(500);

                f.Property(f => f.Rating)
                .HasPrecision(5);

                f.Property(f => f.Name)
                .HasMaxLength(100);

                f.Property(f => f.Email)
                .HasMaxLength(255);

                f.Property(f => f.Phone)
                .HasMaxLength(10);
            });
        }
    }
}
