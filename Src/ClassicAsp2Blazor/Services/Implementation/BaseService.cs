using ClassicAsp2Blazor.Services.Interface;
using Microsoft.Data.SqlClient;
using System.Data;

namespace ClassicAsp2Blazor.Services.Implementation
{
    public class BaseService : IBaseService
    {

        #region fields

        protected readonly string _connectionString = default!;
        protected readonly SqlConnection _connection;

        #endregion

        #region constructor

        public BaseService(IConfiguration configuration)
        {
            ArgumentNullException.ThrowIfNull(configuration);

            _connectionString = configuration.GetConnectionString("DefaultConnection")
                ?? throw new InvalidOperationException("Connection string 'DefaultConnection' is missing.");

            _connection = new SqlConnection(_connectionString);
        }

        #endregion

        #region public base methods

        public IDbConnection CreateConnection()
        {
            return new SqlConnection(_connectionString);
        }

        #endregion

    }
}
