using BeanScene.Data.Mapping;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Text;
using BeanScene.Areas.Admin.Models.Staff;

namespace BeanScene.Data
{
    public class ApplicationDbContext : IdentityDbContext
    {
        public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options)
            : base(options)
        {
        }

        public DbSet<Area> Areas { get; set; }
        public DbSet<Booking> Bookings { get; set; }
        public DbSet<Customer> Customers { get; set; }
        public DbSet<Feedback> Feedback { get; set; }
        public DbSet<Service> Services { get; set; }
        public DbSet<Sitting> Sittings { get; set; }
        public DbSet<Table> Tables { get; set; }

        protected override void OnModelCreating(ModelBuilder mb)
        {
            base.OnModelCreating(mb);

            new ApplicationUserConfig(mb);
            new AreaConfig(mb);
            new BookingConfig(mb);
            new CustomerConfig(mb);
            new FeedbackConfig(mb);
            new ServiceAreaConfig(mb);
            new ServiceConfig(mb);
            new SittingConfig(mb);
            new TableConfig(mb);
            new TableReservationConfig(mb);
        }

        public DbSet<BeanScene.Areas.Admin.Models.Staff.Delete> Delete { get; set; }
    }
}
