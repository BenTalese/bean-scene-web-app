using Microsoft.Extensions.DependencyInjection;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace BeanScene.StartupConfig
{
    public class AutoMapperConfig
    {
        public AutoMapperConfig(IServiceCollection services)
        {
            services.AddAutoMapper(cfg =>
            {
                cfg.CreateMap<Areas.Identity.Pages.Account.RegisterModel.InputModel, Data.Customer>()
                    .ForMember(dest => dest.Id, opt => opt.Ignore());

                cfg.CreateMap<Data.Customer, Data.Customer>()
                    .ForMember(dest => dest.Id, opt => opt.Ignore());

                cfg.CreateMap<Data.Customer, Pages.BookingModel.InputModel>().ReverseMap();

                cfg.CreateMap<Pages.BookingModel.InputModel, Data.Booking>()
                    .ForMember(dest => dest.StartTime, opt => opt.Ignore());

                cfg.CreateMap<Areas.Admin.Models.BookingModels.Create, Data.Booking>()
                    .ForMember(dest => dest.StartTime, opt => opt.Ignore());

                cfg.CreateMap<Areas.Admin.Models.BookingModels.Create, Data.Customer>()
                    .ForMember(dest => dest.Id, opt => opt.Ignore());

                cfg.CreateMap<Pages.FeedbackModel.InputModel, Data.Feedback>();

                cfg.CreateMap<Areas.Identity.Pages.Account.ExternalLoginModel.InputModel, Data.Customer>()
                    .ForMember(dest => dest.Id, opt => opt.Ignore());
            });
        }
    }
}
