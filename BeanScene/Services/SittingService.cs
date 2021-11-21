using AutoMapper;
using BeanScene.Data;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace BeanScene.Services
{
    public class SittingService
    {
        private readonly ApplicationDbContext _context;

        public SittingService(ApplicationDbContext context)
        {
            _context = context;
        }

        //public async Task<IEnumerable<DateTime>> GetAvailableDates()
        //{
        //    return null;
        //}

        public async Task<IEnumerable<Service>> GetAvailableServicesWithSittings()
        {
            var services = await _context.Services.Include(s => s.Sitting).ToListAsync();
            return services;
        }

        // TODO: We should add a create & an upsert method.
    }
}
