using System.ComponentModel.DataAnnotations;

namespace ClassicAsp2Blazor.Models.ViewModel
{
    public class CustomerViewModel
    {
        [Required(ErrorMessage = "First name is required")]
        public string FirstName { get; set; } = string.Empty;

        [Required(ErrorMessage = "Last name is required")]
        public string LastName { get; set; } = string.Empty;

        [Required(ErrorMessage = "Address is required")]
        public string Address { get; set; } = string.Empty;

        [Phone(ErrorMessage = "Invalid phone number format")]
        public string Telephone { get; set; } = string.Empty;
    }
}
