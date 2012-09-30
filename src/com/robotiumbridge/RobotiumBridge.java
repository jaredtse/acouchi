package com.robotiumbridge;
import com.jayway.android.robotium.solo.Solo;

import java.util.Properties;
import java.io.File;
import java.io.IOException;

public class RobotiumBridge extends NanoHTTPD
{
  public RobotiumBridge() throws IOException
  {
    super(7102, new File("/"));
  }

  public Response serve( String uri, String method, Properties header, Properties params, Properties files )
  {
    if (uri.endsWith("/ping"))
    {
      return new NanoHTTPD.Response( HTTP_OK, MIME_HTML, "pong");
    }
    else
    {
      try {
        doSomething();
      }
      catch (java.lang.ClassNotFoundException exception)
      {
        return new NanoHTTPD.Response(HTTP_OK, MIME_HTML, "error :(");
      }
      return new NanoHTTPD.Response( HTTP_OK, MIME_HTML, "meh?");
    }
  }
  private void doSomething() throws java.lang.ClassNotFoundException
  {
    TestCase testCase = new TestCase();
    testCase.testDisplayBlackBox();
  }
}
