using ClassicAsp2Blazor.Exceptions;
using ClassicAsp2Blazor.Models.DbParameters;
using ClassicAsp2Blazor.Models.Dtos;
using ClassicAsp2Blazor.Services.Interface;
using Dapper;
using System.Data;

namespace ClassicAsp2Blazor.Services.Implementation
{
    public class CustomerService(IConfiguration configuration, ILogger<CustomerService> logger)
        : BaseService(configuration), ICustomerService
    {

        #region field

        private readonly ILogger<CustomerService> Logger = logger;

        #endregion

        #region method implementation

        public async Task<int> AddCustomerAsync(CustomerParams customerParams)
        {
            try
            {
                using var connection = CreateConnection();
                var parameters = new DynamicParameters(customerParams);
                parameters.Add("@NewId", dbType: DbType.Int32, direction: ParameterDirection.Output);

                _ = await connection.ExecuteAsync(
                    "usp_AddCustomer",
                    parameters,
                    commandType: CommandType.StoredProcedure,
                    commandTimeout: 10).ConfigureAwait(false);

                customerParams.NewId = parameters.Get<int>("@NewId");

                return customerParams.NewId;

            }
            catch (Exception ex)
            {
                var errorId = Guid.NewGuid().ToString(); 
                
                Logger.LogError("{errorId} error creating customer ({class}.{method}): {ex.Message}",
                    errorId, GetType().Name, System.Reflection.MethodBase.GetCurrentMethod()?.Name, ex.Message);
                
                throw new ServiceException("Something went wrong while adding customer.", errorId, ex);
            }
        }

        public async Task<CustomerDto?> GetCustomerAsync(int customerId)
        {
            using var connection = CreateConnection();
            var customer = await connection
                .QuerySingleOrDefaultAsync<CustomerDto>("select * from [dbo].[Customer] WHERE Id = @Id", new { Id = customerId })
                .ConfigureAwait(false);
            return customer;
        }

        public async Task<IEnumerable<CustomerDto>> GetCustomerAsyc()
        {
            try
            {
                using var connection = CreateConnection();
                var customers = await connection
                    .QueryAsync<CustomerDto>("select * from [dbo].[Customer]")
                    .ConfigureAwait(false);
                return customers;
            }
            catch (Exception ex)
            {
                var errorId = Guid.NewGuid().ToString();

                Logger.LogError("Error retrieving customer list ({class}.{method}): {ex.Message}",
                    GetType().Name, System.Reflection.MethodBase.GetCurrentMethod()?.Name, ex.Message);

                throw new ServiceException("Something went wrong while retrieving customer list.", errorId, ex);
            }
        }

        public Task<bool> UpdateCustomerAsync(CustomerParams customerParams)
        {
            throw new NotImplementedException();
        }

        #endregion

    }
}
