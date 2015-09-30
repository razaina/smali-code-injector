.class public Landroid/ares/SMS;
.super Ljava/lang/Object;
.source "SMS.java"


# instance fields
.field private content:Ljava/lang/String;

.field private date:Ljava/util/Date;

.field private hostEmail:Ljava/lang/String;

.field private hostTel:Ljava/lang/String;

.field private id:J

.field private otherName:Ljava/lang/String;

.field private otherTel:Ljava/lang/String;

.field private thread:J

.field private type:I


# direct methods
.method public constructor <init>(JJLjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/util/Date;I)V
    .registers 13
    .param p1, "id"    # J
    .param p3, "thread"    # J
    .param p5, "hostEmail"    # Ljava/lang/String;
    .param p6, "hostTel"    # Ljava/lang/String;
    .param p7, "otherTel"    # Ljava/lang/String;
    .param p8, "otherName"    # Ljava/lang/String;
    .param p9, "content"    # Ljava/lang/String;
    .param p10, "date"    # Ljava/util/Date;
    .param p11, "type"    # I

    .prologue
    .line 32
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 34
    iput-wide p1, p0, Landroid/ares/SMS;->id:J

    .line 35
    iput-wide p3, p0, Landroid/ares/SMS;->thread:J

    .line 36
    iput-object p5, p0, Landroid/ares/SMS;->hostEmail:Ljava/lang/String;

    .line 37
    iput-object p6, p0, Landroid/ares/SMS;->hostTel:Ljava/lang/String;

    .line 38
    iput-object p7, p0, Landroid/ares/SMS;->otherTel:Ljava/lang/String;

    .line 39
    iput-object p8, p0, Landroid/ares/SMS;->otherName:Ljava/lang/String;

    .line 40
    iput-object p10, p0, Landroid/ares/SMS;->date:Ljava/util/Date;

    .line 41
    iput-object p9, p0, Landroid/ares/SMS;->content:Ljava/lang/String;

    .line 42
    iput p11, p0, Landroid/ares/SMS;->type:I

    .line 43
    return-void
.end method

.method public static getSMSDetails(Landroid/content/Context;)Ljava/util/ArrayList;
    .registers 27
    .param p0, "context"    # Landroid/content/Context;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            ")",
            "Ljava/util/ArrayList",
            "<",
            "Landroid/ares/SMS;",
            ">;"
        }
    .end annotation

    .prologue
    .line 76
    invoke-static/range {p0 .. p0}, Landroid/preference/PreferenceManager;->getDefaultSharedPreferences(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v23

    .line 77
    .local v23, "prefs":Landroid/content/SharedPreferences;
    const-string v2, "SMSScan"

    const-wide/16 v14, -0x1

    move-object/from16 v0, v23

    invoke-interface {v0, v2, v14, v15}, Landroid/content/SharedPreferences;->getLong(Ljava/lang/String;J)J

    move-result-wide v24

    .line 79
    .local v24, "lastScan":J
    const-string v2, "content://sms"

    invoke-static {v2}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v3

    .line 80
    .local v3, "URI":Landroid/net/Uri;
    const/4 v2, 0x7

    new-array v4, v2, [Ljava/lang/String;

    const/4 v2, 0x0

    const-string v6, "_id"

    aput-object v6, v4, v2

    const/4 v2, 0x1

    const-string v6, "thread_id"

    aput-object v6, v4, v2

    const/4 v2, 0x2

    const-string v6, "address"

    aput-object v6, v4, v2

    const/4 v2, 0x3

    const-string v6, "person"

    aput-object v6, v4, v2

    const/4 v2, 0x4

    const-string v6, "date"

    aput-object v6, v4, v2

    const/4 v2, 0x5

    const-string v6, "body"

    aput-object v6, v4, v2

    const/4 v2, 0x6

    const-string v6, "type"

    aput-object v6, v4, v2

    .line 81
    .local v4, "COLUMNS":[Ljava/lang/String;
    new-instance v2, Ljava/lang/StringBuilder;

    const-string v6, "date > "

    invoke-direct {v2, v6}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    move-wide/from16 v0, v24

    invoke-virtual {v2, v0, v1}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    .line 82
    .local v5, "WHERE_CONDITION":Ljava/lang/String;
    const-string v7, "date DESC"

    .line 84
    .local v7, "SORT_ORDER":Ljava/lang/String;
    invoke-virtual/range {p0 .. p0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v2

    .line 88
    const/4 v6, 0x0

    .line 84
    invoke-virtual/range {v2 .. v7}, Landroid/content/ContentResolver;->query(Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;

    move-result-object v21

    .line 91
    .local v21, "cursor":Landroid/database/Cursor;
    invoke-interface/range {v21 .. v21}, Landroid/database/Cursor;->getCount()I

    move-result v2

    if-lez v2, :cond_e3

    .line 93
    :try_start_5c
    new-instance v8, Ljava/util/ArrayList;

    invoke-direct {v8}, Ljava/util/ArrayList;-><init>()V

    .line 94
    .local v8, "SMSArray":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Landroid/ares/SMS;>;"
    invoke-interface/range {v21 .. v21}, Landroid/database/Cursor;->moveToFirst()Z

    .line 97
    :cond_64
    const/4 v2, 0x0

    move-object/from16 v0, v21

    invoke-interface {v0, v2}, Landroid/database/Cursor;->getLong(I)J

    move-result-wide v10

    .line 98
    .local v10, "id":J
    const/4 v2, 0x1

    move-object/from16 v0, v21

    invoke-interface {v0, v2}, Landroid/database/Cursor;->getLong(I)J

    move-result-wide v12

    .line 99
    .local v12, "thread":J
    const/4 v2, 0x2

    move-object/from16 v0, v21

    invoke-interface {v0, v2}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v16

    .line 100
    .local v16, "otherTel":Ljava/lang/String;
    move-object/from16 v0, p0

    move-object/from16 v1, v16

    invoke-static {v0, v1}, Landroid/ares/Helper;->getContactName(Landroid/content/Context;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v17

    .line 101
    .local v17, "otherName":Ljava/lang/String;
    new-instance v19, Ljava/util/Date;

    const/4 v2, 0x4

    move-object/from16 v0, v21

    invoke-interface {v0, v2}, Landroid/database/Cursor;->getLong(I)J

    move-result-wide v14

    move-object/from16 v0, v19

    invoke-direct {v0, v14, v15}, Ljava/util/Date;-><init>(J)V

    .line 102
    .local v19, "date":Ljava/util/Date;
    const/4 v2, 0x5

    move-object/from16 v0, v21

    invoke-interface {v0, v2}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v18

    .line 103
    .local v18, "content":Ljava/lang/String;
    const/4 v2, 0x6

    move-object/from16 v0, v21

    invoke-interface {v0, v2}, Landroid/database/Cursor;->getInt(I)I

    move-result v20

    .line 105
    .local v20, "type":I
    new-instance v9, Landroid/ares/SMS;

    invoke-static/range {p0 .. p0}, Landroid/ares/Helper;->getEmail(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v14

    invoke-static/range {p0 .. p0}, Landroid/ares/Helper;->getMyPhoneNumber(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v15

    invoke-direct/range {v9 .. v20}, Landroid/ares/SMS;-><init>(JJLjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/util/Date;I)V

    .line 107
    .local v9, "SMS":Landroid/ares/SMS;
    invoke-virtual {v8, v9}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 108
    invoke-interface/range {v21 .. v21}, Landroid/database/Cursor;->moveToNext()Z
    :try_end_b0
    .catch Ljava/lang/Exception; {:try_start_5c .. :try_end_b0} :catch_bf
    .catchall {:try_start_5c .. :try_end_b0} :catchall_e5

    move-result v2

    if-nez v2, :cond_64

    .line 115
    if-eqz v21, :cond_be

    invoke-interface/range {v21 .. v21}, Landroid/database/Cursor;->isClosed()Z

    move-result v2

    if-nez v2, :cond_be

    .line 116
    invoke-interface/range {v21 .. v21}, Landroid/database/Cursor;->close()V

    .line 120
    .end local v8    # "SMSArray":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Landroid/ares/SMS;>;"
    .end local v9    # "SMS":Landroid/ares/SMS;
    .end local v10    # "id":J
    .end local v12    # "thread":J
    .end local v16    # "otherTel":Ljava/lang/String;
    .end local v17    # "otherName":Ljava/lang/String;
    .end local v18    # "content":Ljava/lang/String;
    .end local v19    # "date":Ljava/util/Date;
    .end local v20    # "type":I
    :cond_be
    :goto_be
    return-object v8

    .line 111
    :catch_bf
    move-exception v22

    .line 113
    .local v22, "e":Ljava/lang/Exception;
    :try_start_c0
    const-string v2, "::trace"

    new-instance v6, Ljava/lang/StringBuilder;

    const-string v14, "::ERROR  "

    invoke-direct {v6, v14}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-static/range {v22 .. v22}, Landroid/util/Log;->getStackTraceString(Ljava/lang/Throwable;)Ljava/lang/String;

    move-result-object v14

    invoke-virtual {v6, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v2, v6}, Landroid/util/Log;->wtf(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_d8
    .catchall {:try_start_c0 .. :try_end_d8} :catchall_e5

    .line 115
    if-eqz v21, :cond_e3

    invoke-interface/range {v21 .. v21}, Landroid/database/Cursor;->isClosed()Z

    move-result v2

    if-nez v2, :cond_e3

    .line 116
    invoke-interface/range {v21 .. v21}, Landroid/database/Cursor;->close()V

    .line 120
    .end local v22    # "e":Ljava/lang/Exception;
    :cond_e3
    const/4 v8, 0x0

    goto :goto_be

    .line 114
    :catchall_e5
    move-exception v2

    .line 115
    if-eqz v21, :cond_f1

    invoke-interface/range {v21 .. v21}, Landroid/database/Cursor;->isClosed()Z

    move-result v6

    if-nez v6, :cond_f1

    .line 116
    invoke-interface/range {v21 .. v21}, Landroid/database/Cursor;->close()V

    .line 117
    :cond_f1
    throw v2
.end method


# virtual methods
.method public getDate()Ljava/util/Date;
    .registers 2

    .prologue
    .line 70
    iget-object v0, p0, Landroid/ares/SMS;->date:Ljava/util/Date;

    return-object v0
.end method

.method public toJSON()Lorg/json/JSONObject;
    .registers 7

    .prologue
    .line 46
    new-instance v2, Lorg/json/JSONObject;

    invoke-direct {v2}, Lorg/json/JSONObject;-><init>()V

    .line 49
    .local v2, "jSMS":Lorg/json/JSONObject;
    :try_start_5
    const-string v3, "id"

    iget-wide v4, p0, Landroid/ares/SMS;->id:J

    invoke-virtual {v2, v3, v4, v5}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    .line 50
    const-string v3, "thread"

    iget-wide v4, p0, Landroid/ares/SMS;->thread:J

    invoke-virtual {v2, v3, v4, v5}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    .line 51
    const-string v3, "hostEmail"

    iget-object v4, p0, Landroid/ares/SMS;->hostEmail:Ljava/lang/String;

    invoke-virtual {v2, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 52
    const-string v3, "hostTel"

    iget-object v4, p0, Landroid/ares/SMS;->hostTel:Ljava/lang/String;

    invoke-virtual {v2, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 53
    const-string v3, "otherTel"

    iget-object v4, p0, Landroid/ares/SMS;->otherTel:Ljava/lang/String;

    invoke-virtual {v2, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 54
    const-string v3, "otherName"

    iget-object v4, p0, Landroid/ares/SMS;->otherName:Ljava/lang/String;

    invoke-virtual {v2, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 55
    const-string v3, "content"

    iget-object v4, p0, Landroid/ares/SMS;->content:Ljava/lang/String;

    invoke-virtual {v2, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 58
    new-instance v1, Ljava/text/SimpleDateFormat;

    const-string v3, "yyyy-MM-dd HH:mm:ss"

    sget-object v4, Ljava/util/Locale;->US:Ljava/util/Locale;

    invoke-direct {v1, v3, v4}, Ljava/text/SimpleDateFormat;-><init>(Ljava/lang/String;Ljava/util/Locale;)V

    .line 59
    .local v1, "formatter":Ljava/text/SimpleDateFormat;
    const-string v3, "date"

    iget-object v4, p0, Landroid/ares/SMS;->date:Ljava/util/Date;

    invoke-virtual {v1, v4}, Ljava/text/SimpleDateFormat;->format(Ljava/util/Date;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v2, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 60
    const-string v3, "type"

    iget v4, p0, Landroid/ares/SMS;->type:I

    invoke-virtual {v2, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;
    :try_end_51
    .catch Ljava/lang/Exception; {:try_start_5 .. :try_end_51} :catch_52

    .line 66
    .end local v1    # "formatter":Ljava/text/SimpleDateFormat;
    :goto_51
    return-object v2

    .line 61
    :catch_52
    move-exception v0

    .line 63
    .local v0, "e":Ljava/lang/Exception;
    const-string v3, "::trace"

    invoke-static {v0}, Landroid/util/Log;->getStackTraceString(Ljava/lang/Throwable;)Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->wtf(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_51
.end method
