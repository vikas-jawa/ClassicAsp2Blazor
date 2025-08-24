using Microsoft.AspNetCore.Components;
using Microsoft.AspNetCore.WebUtilities;

namespace ClassicAsp2Blazor.Components.Shared
{
    public abstract class ApplicationComponentBase : ComponentBase
    {

        [Inject] protected NavigationManager Navigation { get; set; } = default!;

        protected string? GetQueryString(string key)
        {
            var uri = Navigation.ToAbsoluteUri(Navigation.Uri);
            var queryParams = QueryHelpers.ParseQuery(uri.Query);

            if (queryParams.TryGetValue(key, out var value))
            {
                return value;
            }

            return null;
        }
    }
}
