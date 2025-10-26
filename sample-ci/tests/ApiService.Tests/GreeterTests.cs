using Xunit;
using ApiService;

namespace ApiService.Tests;
public class GreeterTests
{
    [Fact]
    public void Greet_ReturnsExpectedMessage()
    {
        var g = new Greeter();
        var msg = g.Greet("Rakesh");
        Assert.Equal("Hello, Rakesh", msg);
    }
}
