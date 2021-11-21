using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace BeanScene.Areas.Admin.Models.AreaModels
{
    public class Edit
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public List<AreaEditTable> Tables { get; set; }
    }

    public class AreaEditTable
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public int Seats { get; set; }
    }
}
