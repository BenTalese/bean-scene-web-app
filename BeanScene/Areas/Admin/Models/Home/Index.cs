using BeanScene.Data;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace BeanScene.Areas.Admin.Models.Home
{
    public class Index
    {
        public bool ServiceOnDate { get; set; }
        public Service Service { get; set; }
    }
}
