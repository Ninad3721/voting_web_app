namespace VotingApplication.Application.Response
{
    //Common response structure for all the API responses
    public class ApiResponse<T>(int statusCode, T body, T error, string message)
    {
        //Status code returend by the request ex. 200, 400, 404
        public int StatusCode { get; set; } = statusCode;

        //Response body returned by the request ex.voterResponseDto , candidateResponseDto
        public T? Body { get; set; } = body;

        //Response error returned by the request
        public T Error { get; set; } = error;

        //Response message returned, can be error message or success message
        public string Message { get; set; } = message;
    }
}