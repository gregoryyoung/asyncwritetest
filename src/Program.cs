using System;
using System.Net;
using EventStore.ClientAPI;
namespace test {
    public class Program
    {
        public static void Main(string[] args)
        {
            var settings = ConnectionSettings.Create();
            settings.LimitConcurrentOperationsTo(1);
            var connection = EventStoreConnection.Create(settings, 
                new IPEndPoint(IPAddress.Parse("127.0.0.1"), 1113));

            connection.ConnectAsync().Wait();

            for (int i = 0; i < 20000; i++)
            {
                connection.AppendToStreamAsync("TestStream", 
                    ExpectedVersion.Any,
                    new EventData(Guid.NewGuid(), "Type" + i, false, new byte[] { }, new byte[] { }));
            }
            while (true) { }
        }
    }
}
