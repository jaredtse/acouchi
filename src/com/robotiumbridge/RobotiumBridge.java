package com.robotiumbridge;
import com.jayway.android.robotium.solo.Solo;

import java.util.Properties;
import java.io.File;
import java.io.IOException;

import java.util.concurrent.locks.Condition;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

import android.app.Instrumentation;
import android.app.Activity;

public class RobotiumBridge extends NanoHTTPD
{
  private Solo solo;
  private Instrumentation instrumentation;
  private Activity activity;
  private boolean serverRunning = true;
  private Lock lock = new ReentrantLock();
  private Condition endedCondition = lock.newCondition();

  public RobotiumBridge(Instrumentation instrumentation, Activity activity) throws IOException
  {
    super(7103, new File("."));
    instrumentation = instrumentation;
    activity = activity;
  }

  public void WaitUntilServerKilled() throws InterruptedException
  {
    lock.lock();
    try {
      while(serverRunning)
      {
        endedCondition.await();
      }
    }
    finally {
      lock.unlock();
    }
  }

  public Response serve(String uri, String method, Properties header, Properties params, Properties files )
  {
    if (uri.endsWith("/start"))
    {
      solo = new Solo(instrumentation, activity);
      return new NanoHTTPD.Response(HTTP_OK, MIME_HTML, "");
    }
    else if (uri.endsWith("/finish"))
    {
      try {
        solo.finishOpenedActivities();
        serverRunning = false;
        stop();
        endedCondition.signal();
      }
      finally {
        lock.unlock();
      }
      return new NanoHTTPD.Response(HTTP_OK, MIME_HTML, "");
    }
    else if (uri.endsWith("/execute_method"))
    {
      return new NanoHTTPD.Response(HTTP_OK, MIME_HTML, "executing");
    }

    return new NanoHTTPD.Response(HTTP_OK, MIME_HTML, "RobotiumBridge");
  }
}
