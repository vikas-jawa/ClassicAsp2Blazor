namespace ClassicAsp2Blazor.UnitTests
{
    public class SampleUnitTests
    {
        [Fact]
        public void Test_Always_Pass()
        {
            // arrange
            var expected_value = 2;

            // act
            var actual_value = 1 + 1;

            // assert
            Assert.Equal(expected_value, actual_value);
        }
    }
}