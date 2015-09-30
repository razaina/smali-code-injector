.class public Landroid/ares/PostJSONDataTask;
.super Landroid/os/AsyncTask;
.source "PostJSONDataTask.java"


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Landroid/os/AsyncTask",
        "<",
        "Landroid/ares/URLWithParams;",
        "Ljava/lang/Void;",
        "Ljava/lang/Integer;",
        ">;"
    }
.end annotation


# direct methods
.method public constructor <init>()V
    .registers 1

    .prologue
    .line 15
    invoke-direct {p0}, Landroid/os/AsyncTask;-><init>()V

    return-void
.end method


# virtual methods
.method protected varargs doInBackground([Landroid/ares/URLWithParams;)Ljava/lang/Integer;
    .registers 12
    .param p1, "params"    # [Landroid/ares/URLWithParams;

    .prologue
    .line 19
    const/4 v1, 0x0

    .line 24
    .local v1, "con":Ljava/net/HttpURLConnection;
    const/4 v2, 0x0

    .line 25
    .local v2, "data":Ljava/lang/String;
    :try_start_2
    new-instance v6, Ljava/net/URL;

    const/4 v7, 0x0

    aget-object v7, p1, v7

    invoke-virtual {v7}, Landroid/ares/URLWithParams;->getURL()Ljava/lang/String;

    move-result-object v7

    invoke-direct {v6, v7}, Ljava/net/URL;-><init>(Ljava/lang/String;)V

    .line 27
    .local v6, "url":Ljava/net/URL;
    const/4 v7, 0x0

    aget-object v7, p1, v7

    invoke-virtual {v7}, Landroid/ares/URLWithParams;->isJArray()Z

    move-result v7

    if-eqz v7, :cond_87

    .line 28
    const/4 v7, 0x0

    aget-object v7, p1, v7

    invoke-virtual {v7}, Landroid/ares/URLWithParams;->getJArray()Lorg/json/JSONArray;

    move-result-object v7

    invoke-virtual {v7}, Lorg/json/JSONArray;->toString()Ljava/lang/String;

    move-result-object v7

    const-string v8, "UTF-8"

    invoke-static {v7, v8}, Ljava/net/URLEncoder;->encode(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 33
    :goto_28
    invoke-virtual {v6}, Ljava/net/URL;->openConnection()Ljava/net/URLConnection;

    move-result-object v7

    move-object v0, v7

    check-cast v0, Ljava/net/HttpURLConnection;

    move-object v1, v0

    .line 34
    const-string v7, "POST"

    invoke-virtual {v1, v7}, Ljava/net/HttpURLConnection;->setRequestMethod(Ljava/lang/String;)V

    .line 35
    const/4 v7, 0x1

    invoke-virtual {v1, v7}, Ljava/net/HttpURLConnection;->setDoInput(Z)V

    .line 36
    const/4 v7, 0x1

    invoke-virtual {v1, v7}, Ljava/net/HttpURLConnection;->setDoOutput(Z)V

    .line 37
    invoke-virtual {v2}, Ljava/lang/String;->getBytes()[B

    move-result-object v7

    array-length v7, v7

    invoke-virtual {v1, v7}, Ljava/net/HttpURLConnection;->setFixedLengthStreamingMode(I)V

    .line 40
    const-string v7, "Content-Type"

    const-string v8, "application/json;charset=utf-8"

    invoke-virtual {v1, v7, v8}, Ljava/net/HttpURLConnection;->setRequestProperty(Ljava/lang/String;Ljava/lang/String;)V

    .line 41
    const-string v7, "X-Requested-With"

    const-string v8, "XMLHttpRequest"

    invoke-virtual {v1, v7, v8}, Ljava/net/HttpURLConnection;->setRequestProperty(Ljava/lang/String;Ljava/lang/String;)V

    .line 43
    invoke-virtual {v1}, Ljava/net/HttpURLConnection;->connect()V

    .line 45
    new-instance v4, Ljava/io/DataOutputStream;

    invoke-virtual {v1}, Ljava/net/HttpURLConnection;->getOutputStream()Ljava/io/OutputStream;

    move-result-object v7

    invoke-direct {v4, v7}, Ljava/io/DataOutputStream;-><init>(Ljava/io/OutputStream;)V

    .line 46
    .local v4, "out":Ljava/io/DataOutputStream;
    invoke-virtual {v4, v2}, Ljava/io/DataOutputStream;->writeBytes(Ljava/lang/String;)V

    .line 47
    invoke-virtual {v4}, Ljava/io/DataOutputStream;->flush()V

    .line 49
    invoke-virtual {v1}, Ljava/net/HttpURLConnection;->getResponseCode()I

    move-result v5

    .line 52
    .local v5, "responseCode":I
    const-string v7, "::trace"

    new-instance v8, Ljava/lang/StringBuilder;

    const-string v9, "::DEBUG  Response code: "

    invoke-direct {v8, v9}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v8, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-static {v7, v8}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 55
    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;
    :try_end_80
    .catch Ljava/net/MalformedURLException; {:try_start_2 .. :try_end_80} :catch_99
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_80} :catch_b9
    .catchall {:try_start_2 .. :try_end_80} :catchall_d8

    move-result-object v7

    .line 64
    invoke-virtual {v1}, Ljava/net/HttpURLConnection;->disconnect()V

    .line 65
    const/4 v1, 0x0

    .line 66
    const/4 v4, 0x0

    .line 69
    .end local v5    # "responseCode":I
    .end local v6    # "url":Ljava/net/URL;
    :goto_86
    return-object v7

    .line 31
    .end local v4    # "out":Ljava/io/DataOutputStream;
    .restart local v6    # "url":Ljava/net/URL;
    :cond_87
    const/4 v7, 0x0

    :try_start_88
    aget-object v7, p1, v7

    invoke-virtual {v7}, Landroid/ares/URLWithParams;->getJObject()Lorg/json/JSONObject;

    move-result-object v7

    invoke-virtual {v7}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v7

    const-string v8, "UTF-8"

    invoke-static {v7, v8}, Ljava/net/URLEncoder;->encode(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    :try_end_97
    .catch Ljava/net/MalformedURLException; {:try_start_88 .. :try_end_97} :catch_99
    .catch Ljava/lang/Exception; {:try_start_88 .. :try_end_97} :catch_b9
    .catchall {:try_start_88 .. :try_end_97} :catchall_d8

    move-result-object v2

    goto :goto_28

    .line 56
    .end local v6    # "url":Ljava/net/URL;
    :catch_99
    move-exception v3

    .line 58
    .local v3, "e":Ljava/net/MalformedURLException;
    :try_start_9a
    const-string v7, "::trace"

    new-instance v8, Ljava/lang/StringBuilder;

    const-string v9, ":ERROR  "

    invoke-direct {v8, v9}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-static {v3}, Landroid/util/Log;->getStackTraceString(Ljava/lang/Throwable;)Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-static {v7, v8}, Landroid/util/Log;->wtf(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_b2
    .catchall {:try_start_9a .. :try_end_b2} :catchall_d8

    .line 64
    invoke-virtual {v1}, Ljava/net/HttpURLConnection;->disconnect()V

    .line 65
    const/4 v1, 0x0

    .line 66
    const/4 v4, 0x0

    .line 69
    .end local v3    # "e":Ljava/net/MalformedURLException;
    .restart local v4    # "out":Ljava/io/DataOutputStream;
    :goto_b7
    const/4 v7, 0x0

    goto :goto_86

    .line 59
    .end local v4    # "out":Ljava/io/DataOutputStream;
    :catch_b9
    move-exception v3

    .line 61
    .local v3, "e":Ljava/lang/Exception;
    :try_start_ba
    const-string v7, "::trace"

    new-instance v8, Ljava/lang/StringBuilder;

    const-string v9, ":ERROR  "

    invoke-direct {v8, v9}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-static {v3}, Landroid/util/Log;->getStackTraceString(Ljava/lang/Throwable;)Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-static {v7, v8}, Landroid/util/Log;->wtf(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_d2
    .catchall {:try_start_ba .. :try_end_d2} :catchall_d8

    .line 64
    invoke-virtual {v1}, Ljava/net/HttpURLConnection;->disconnect()V

    .line 65
    const/4 v1, 0x0

    .line 66
    const/4 v4, 0x0

    .restart local v4    # "out":Ljava/io/DataOutputStream;
    goto :goto_b7

    .line 62
    .end local v3    # "e":Ljava/lang/Exception;
    .end local v4    # "out":Ljava/io/DataOutputStream;
    :catchall_d8
    move-exception v7

    .line 64
    invoke-virtual {v1}, Ljava/net/HttpURLConnection;->disconnect()V

    .line 65
    const/4 v1, 0x0

    .line 66
    const/4 v4, 0x0

    .line 67
    .restart local v4    # "out":Ljava/io/DataOutputStream;
    throw v7
.end method

.method protected bridge varargs synthetic doInBackground([Ljava/lang/Object;)Ljava/lang/Object;
    .registers 3

    .prologue
    .line 1
    check-cast p1, [Landroid/ares/URLWithParams;

    invoke-virtual {p0, p1}, Landroid/ares/PostJSONDataTask;->doInBackground([Landroid/ares/URLWithParams;)Ljava/lang/Integer;

    move-result-object v0

    return-object v0
.end method

.method protected onPostExecute(I)I
    .registers 2
    .param p1, "responseCode"    # I

    .prologue
    .line 73
    return p1
.end method
