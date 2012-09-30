package com.robotiumbridge;
import com.jayway.android.robotium.solo.Solo;

import java.util.Properties;
import java.io.File;
import java.io.IOException;

//deleteme
import java.io.PrintWriter;
import java.io.StringWriter;


public class RobotiumBridge extends NanoHTTPD
{
  public RobotiumBridge() throws IOException
  {
    super(7103, new File("."));
  }

  public Response serve( String uri, String method, Properties header, Properties params, Properties files )
  {
    if (uri.endsWith("/ping"))
    {
      return new NanoHTTPD.Response( HTTP_OK, MIME_HTML, "pong");
    }
    else
    {
      try
      {
        return new NanoHTTPD.Response(HTTP_OK, MIME_HTML, executeRequest());
      }
      catch (java.lang.ClassNotFoundException exception)
      {
        return new NanoHTTPD.Response(HTTP_OK, MIME_HTML, "error :(");
      }
    }
  }

  private String executeRequest() throws java.lang.ClassNotFoundException
  {
    return "meh";
    // try
    // {
    //   TestCase testCase = new TestCase();
    //   testCase.runTests();
    //   return "that worked";
    // }
    // catch (java.lang.Exception exception)
    // {
    //   StringWriter sw = new StringWriter();
    //   PrintWriter pw = new PrintWriter(sw);
    //   exception.printStackTrace(pw);
    //   return exception.getMessage() + "\n" + sw.toString();
    // }
  }
}
