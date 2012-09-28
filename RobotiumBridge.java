import android.test.ActivityInstrumentationTestCase2;
import com.jayway.android.robotium.solo.Solo;

import java.util.Properties;
import java.io.File;
import java.io.IOException;

public class RobotiumBridge extends NanoHTTPD
{
  public RobotiumBridge() throws IOException
  {
    super(8080, new File("."));
  }

  public Response serve( String uri, String method, Properties header, Properties params, Properties files )
  {
    if (uri.endsWith("/ping"))
    {
      return new NanoHTTPD.Response( HTTP_OK, MIME_HTML, "pong");
    }
    else
    {
      return new NanoHTTPD.Response( HTTP_OK, MIME_HTML, "meh?");
    }
  }
}
