using ClassicAsp2Blazor.Models.DbParameters;
using ClassicAsp2Blazor.Models.Dtos;

namespace ClassicAsp2Blazor.Services.Interface
{
    public interface ICustomerService
    {
        Task<int> AddCustomerAsync(CustomerParams customerParams);
        Task<CustomerDto?> GetCustomerAsync(int customerId);
        Task<IEnumerable<CustomerDto>> GetCustomerAsyc();
        Task<bool> UpdateCustomerAsync(CustomerParams customerParams);
    }
}
