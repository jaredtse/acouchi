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
import java.lang.reflect.Method;
import org.json.JSONArray;
import org.json.JSONObject;
import org.json.JSONException;
import java.util.ArrayList;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.io.Writer;

public class RobotiumBridge extends NanoHTTPD
{
  private Solo solo;
  private boolean serverRunning = true;
  private Lock lock = new ReentrantLock();
  private Condition endedCondition = lock.newCondition();

  public RobotiumBridge(Solo solo) throws IOException
  {
    super(7103, new File("."));
    this.solo = solo;
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
    if (uri.endsWith("/finish"))
    {
      try {
        serverRunning = false;
        stop();
        endedCondition.signal();
      }
      finally {
        lock.unlock();
      }
      return new NanoHTTPD.Response(HTTP_OK, MIME_HTML, "");
    }
    else if (uri.startsWith("/execute_method"))
    {
      String methodName = uri.replace("/execute_method/", "");
      return ExecuteMethod(methodName, params.getProperty("parameters"));
    }

    return new NanoHTTPD.Response(HTTP_OK, MIME_HTML, "RobotiumBridge");
  }

  private NanoHTTPD.Response ExecuteMethod(String methodName, String json)
  {
    try {
      JSONArray jsonArray = new JSONArray(json);
      Class[] parameterTypes = new Class[jsonArray.length()];
      Object[] parameters = new Object[jsonArray.length()];

      for (int i = 0; i < jsonArray.length(); i++) {
        JSONObject jsonObject = jsonArray.getJSONObject(i);

        parameterTypes[i] = getClassType(jsonObject.getString("type"));
        parameters[i] = getConvertedValue(jsonObject.getString("type"), jsonObject.getString("value"));
      }

      Method method = solo.getClass().getMethod(methodName, parameterTypes);
      return displayMethodResultAsJson(method.invoke(solo, parameters));
    } catch (Exception exception) {
      return showException(exception);
    }
  }

  private NanoHTTPD.Response displayMethodResultAsJson(Object result)
  {
    try {
      JSONObject object = new JSONObject();

      if (result == null) {
        object.put("emptyResult", true);
      } else {
        object.put("result", result);
      }

      return new NanoHTTPD.Response(HTTP_OK, MIME_HTML, object.toString());
    } catch (JSONException e) {
      return showException(e);
    }
  }

  private Class getClassType(String name) throws java.lang.ClassNotFoundException
  {
    if (name.equals("int")) return int.class;
    if (name.equals("long")) return long.class;
    if (name.equals("double")) return double.class;
    if (name.equals("boolean")) return boolean.class;
    return Class.forName(name);
  }

  private Object getConvertedValue(String name, String value)
  {
    if (name.equals("int")) return Integer.parseInt(value);
    if (name.equals("long")) return Long.parseLong(value);
    if (name.equals("double")) return Double.parseDouble(value);
    if (name.equals("boolean")) return Boolean.parseBoolean(value);
    if (name.equals("java.lang.Integer")) return Integer.parseInt(value);
    if (name.equals("java.lang.Long")) return Long.parseLong(value);
    if (name.equals("java.lang.Double")) return Double.parseDouble(value);
    if (name.equals("java.lang.Boolean")) return Boolean.parseBoolean(value);
    return value;
  }

  private NanoHTTPD.Response showException(Exception exception)
  {
    return new NanoHTTPD.Response(HTTP_OK, MIME_HTML, "exception: " + exception.toString() + "\n" + getStackTrace(exception));
  }

  private static String getStackTrace(Throwable aThrowable) {
    final Writer result = new StringWriter();
    final PrintWriter printWriter = new PrintWriter(result);
    aThrowable.printStackTrace(printWriter);
    return result.toString();
  }
}
