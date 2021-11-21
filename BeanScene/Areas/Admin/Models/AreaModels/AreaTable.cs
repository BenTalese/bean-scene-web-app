using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace BeanScene.Areas.Admin.Models.AreaModels
{
    public class AreaTable
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string Prefix { get; set; }
        public int Seats { get; set; }
        public List<int> Tables { get; set; }
        public int TableCount { get; set; }
        public bool TableCreationFinished { get; set; }
    }
}
