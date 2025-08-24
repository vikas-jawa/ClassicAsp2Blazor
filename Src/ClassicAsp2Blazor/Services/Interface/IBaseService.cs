using System.Data;

namespace ClassicAsp2Blazor.Services.Interface
{
    public interface IBaseService
    {
        IDbConnection CreateConnection();
    }
}
