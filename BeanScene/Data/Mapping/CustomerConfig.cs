using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace BeanScene.Data.Mapping
{
    public class CustomerConfig
    {
        public CustomerConfig(ModelBuilder mb)
        {
            mb.Entity<Customer>(c =>
            {
                c.Property(c => c.FirstName)    // FirstName
                .IsRequired()
                .HasMaxLength(50);

                c.Property(c => c.LastName)     // LastName
                .IsRequired()
                .HasMaxLength(50);

                c.Property(c => c.Email)        // Email
                .IsRequired()
                .HasMaxLength(255);

                c.HasIndex(c => c.Email)
                .IsUnique(true);

                c.Property(c => c.Phone)        // Email
                .IsRequired()
                .HasMaxLength(10);

                c.Property(c => c.Tier)         // Tier (enum conversion)
                .HasConversion<string>()
                .HasMaxLength(30);

                c.Property(c => c.UserLogin)    // UserLogin (FK)
                .HasMaxLength(450);

                c.HasOne(c => c.ApplicationUser)    // ApplicationUser (relationship)
                .WithOne()
                .HasForeignKey<Customer>(c => c.UserLogin);
            });
        }
    }
}
