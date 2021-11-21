using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace BeanScene.Areas.Admin.Models.AreaModels
{
    public class EditTable
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public int Seats { get; set; }
        public int AreaId { get; set; }
    }
}
