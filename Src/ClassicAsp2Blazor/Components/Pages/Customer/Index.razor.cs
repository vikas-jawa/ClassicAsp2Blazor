using ClassicAsp2Blazor.Components.Shared;
using ClassicAsp2Blazor.Exceptions;
using ClassicAsp2Blazor.Models;
using ClassicAsp2Blazor.Models.DbParameters;
using ClassicAsp2Blazor.Models.Dtos;
using ClassicAsp2Blazor.Models.ViewModel;
using ClassicAsp2Blazor.Services.Interface;
using Microsoft.AspNetCore.Components;

namespace ClassicAsp2Blazor.Components.Pages.Customer
{
    public partial class IndexBase : ApplicationComponentBase
    {

        #region Dependency Injection

        [Inject] private ILogger<IndexBase> Logger { get; set; } = default!;
        [Inject] private ICustomerService CustomerService { get; set; } = default!;

        #endregion

        #region Fields

        internal CustomerViewModel Customer = new();
        internal bool submitted = false;
        internal int customerId = 0;

        #endregion

        #region Properties

        internal List<CustomerDto> Customers { get; set; } = [];

        #endregion

        #region Lifecycle

        protected override async Task OnInitializedAsync()
        {
            Customers = [.. (await GetCustomersAsync())];
        }

        #endregion

        #region Event Handlers

        internal async Task HandleValidSubmit()
        {
            if (!Customer.IsValid(out _))
                return;

            try
            {
                var custParams = new CustomerParams
                {
                    FirstName = Customer.FirstName,
                    LastName = Customer.LastName,
                    Address = Customer.Address,
                    Telephone = Customer.Telephone,
                };

                customerId = await CustomerService.AddCustomerAsync(custParams);
                submitted = true;

                Customers = [.. (await GetCustomersAsync())];
                Customer = new CustomerViewModel();
            }
            catch (ServiceException ex)
            {
                Navigation.NavigateTo($"/Error/{ex.ErrorId}");
            }
            catch (Exception ex)
            {
                var errorId = Guid.NewGuid().ToString();
                Logger.LogError(ex, "{errorId}", errorId);
                Navigation.NavigateTo($"/Error/{errorId}");
            }
        }

        #endregion

        #region Private Methods

        private async Task<IEnumerable<CustomerDto>> GetCustomersAsync()
        {
            try
            {
                return await CustomerService.GetCustomerAsyc();
            }
            catch (Exception ex)
            {
                Logger.LogError(ex, "Error fetching customer list in {class}", GetType().Name);
                return [];
            }
        }

        #endregion

    }
}
