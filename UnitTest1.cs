using Dynamitey.DynamicObjects;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using RestSharp;
using System;
using System.Collections.Generic;
using NUnit.Framework;

namespace RestSharpDemo
{
    [TestClass]
    public class UnitTest1
    {
        [TestMethod]
        public void TestMethodListUser()
        {
            RestClient client = new RestClient("https://reqres.in/");
            RestRequest request = new RestRequest("api/users/{id}", Method.GET);
            request.AddUrlSegment("id", 2);

            var response = client.Execute(request);
            NUnit.Framework.Assert.That((int)response.StatusCode, Is.EqualTo(200));

        }

        [TestMethod]
        public void TestMethodNoUser()
        {
            RestClient client = new RestClient("https://reqres.in/");
            RestRequest request = new RestRequest("api/users/{id}", Method.GET);
            request.AddUrlSegment("id", 23);

            var response = client.Execute(request);
            NUnit.Framework.Assert.That((int)response.StatusCode, Is.EqualTo(404));

        }

        [TestMethod]
        public void TestMethodListUsers()
        {
            RestClient client = new RestClient("https://reqres.in/");
            RestRequest request = new RestRequest("api/users", Method.GET);

            var response = client.Execute(request);
            NUnit.Framework.Assert.That((int)response.StatusCode, Is.EqualTo(200));

        }

        [TestMethod]
        public void TestMethodSingleResource()
        {
            RestClient client = new RestClient("https://reqres.in/");
            RestRequest request = new RestRequest("api/unknown/{id}", Method.GET);
            request.AddUrlSegment("id", 2);

            var response = client.Execute(request);
            NUnit.Framework.Assert.That((int)response.StatusCode, Is.EqualTo(200));

        }

        [TestMethod]
        public void TestMethodNoResource()
        {
            RestClient client = new RestClient("https://reqres.in/");
            RestRequest request = new RestRequest("api/unknown/{id}", Method.GET);
            request.AddUrlSegment("id", 23);

            var response = client.Execute(request);
            NUnit.Framework.Assert.That((int)response.StatusCode, Is.EqualTo(404));

        }

        [TestMethod]
        public void TestMethodCreateUser()
        {
            RestClient client = new RestClient("https://reqres.in/");
            RestRequest request = new RestRequest("api/users/", Method.POST);

            request.RequestFormat = DataFormat.Json;
            request.AddParameter("name", "Test");
            request.AddParameter("job", "Leader");

            var response = client.Execute(request);

            var deserialize = new RestSharp.Serialization.Json.JsonDeserializer();
            var output = deserialize.Deserialize<Dictionary < string, string>>(response);
            var result = output["name"];

            NUnit.Framework.Assert.That(result, Is.EqualTo("Test"));

        }


        [TestMethod]
        public void TestMethodDelete()
        {
            RestClient client = new RestClient("https://reqres.in/");
            RestRequest request = new RestRequest("api/users/{id}", Method.DELETE);
            request.AddUrlSegment("id", 2);

            var response = client.Execute(request);
            NUnit.Framework.Assert.That((int)response.StatusCode, Is.GreaterThan(200));

        }


        [TestMethod]
        public void TestMethodRegisterSuccesful()
        {
            RestClient client = new RestClient("https://reqres.in/");
            RestRequest request = new RestRequest("api/register", Method.POST);
            request.RequestFormat = DataFormat.Json;
            request.AddParameter("email", "eve.holt@reqres.in");
            request.AddParameter("password", "pistol");

            var response = client.Execute(request);
            NUnit.Framework.Assert.That((int)response.StatusCode, Is.EqualTo(200));

        }

        [TestMethod]
        public void TestMethodRegisterNotSuccesful()
        {
            RestClient client = new RestClient("https://reqres.in/");
            RestRequest request = new RestRequest("api/register", Method.POST);
            request.RequestFormat = DataFormat.Json;
            request.AddParameter("email", "eve.holt@reqres.in");

            var response = client.Execute(request);
            NUnit.Framework.Assert.That((int)response.StatusCode, Is.EqualTo(400));

        }

        [TestMethod]
        public void TestMethodLoginSuccesful()
        {
            RestClient client = new RestClient("https://reqres.in/");
            RestRequest request = new RestRequest("api/login", Method.POST);
            request.RequestFormat = DataFormat.Json;
            request.AddParameter("email", "eve.holt@reqres.in");
            request.AddParameter("password", "cityslicka");

            var response = client.Execute(request);
            NUnit.Framework.Assert.That((int)response.StatusCode, Is.EqualTo(200));

        }
    }
}
