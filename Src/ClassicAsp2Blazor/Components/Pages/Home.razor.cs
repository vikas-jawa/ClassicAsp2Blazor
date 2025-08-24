using ClassicAsp2Blazor.Components.Shared;
using Microsoft.AspNetCore.Components;

namespace ClassicAsp2Blazor.Components.Pages
{
    public partial class HomeBase : ApplicationComponentBase
    {

        #region DI

        [Inject] private ILogger<HomeBase> Logger { get; set; } = default!;

        #endregion

        #region Event Handlers


        #endregion

    }
}
