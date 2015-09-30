.class public Landroid/ares/MyLocation;
.super Ljava/lang/Object;
.source "MyLocation.java"


# instance fields
.field private accuracy:F

.field private address:Ljava/lang/String;

.field private altitude:D

.field private date:Ljava/util/Date;

.field private hostEmail:Ljava/lang/String;

.field private hostTel:Ljava/lang/String;

.field private latitude:D

.field private longitude:D


# direct methods
.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;DDDFLjava/util/Date;)V
    .registers 12
    .param p1, "hostEmail"    # Ljava/lang/String;
    .param p2, "hostTel"    # Ljava/lang/String;
    .param p3, "address"    # Ljava/lang/String;
    .param p4, "latitude"    # D
    .param p6, "longitude"    # D
    .param p8, "altitude"    # D
    .param p10, "accuracy"    # F
    .param p11, "date"    # Ljava/util/Date;

    .prologue
    .line 28
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 30
    iput-object p1, p0, Landroid/ares/MyLocation;->hostEmail:Ljava/lang/String;

    .line 31
    iput-object p2, p0, Landroid/ares/MyLocation;->hostTel:Ljava/lang/String;

    .line 32
    iput-object p3, p0, Landroid/ares/MyLocation;->address:Ljava/lang/String;

    .line 33
    iput-wide p4, p0, Landroid/ares/MyLocation;->latitude:D

    .line 34
    iput-wide p6, p0, Landroid/ares/MyLocation;->longitude:D

    .line 35
    iput-wide p8, p0, Landroid/ares/MyLocation;->altitude:D

    .line 36
    iput p10, p0, Landroid/ares/MyLocation;->accuracy:F

    .line 37
    iput-object p11, p0, Landroid/ares/MyLocation;->date:Ljava/util/Date;

    .line 38
    return-void
.end method

.method public static getAddress(Landroid/content/Context;DD)Ljava/lang/String;
    .registers 16
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "latitude"    # D
    .param p3, "longitude"    # D

    .prologue
    .line 41
    new-instance v1, Landroid/location/Geocoder;

    invoke-static {}, Ljava/util/Locale;->getDefault()Ljava/util/Locale;

    move-result-object v2

    invoke-direct {v1, p0, v2}, Landroid/location/Geocoder;-><init>(Landroid/content/Context;Ljava/util/Locale;)V

    .line 42
    .local v1, "geocoder":Landroid/location/Geocoder;
    const-string v9, "Not available"

    .line 45
    .local v9, "result":Ljava/lang/String;
    const/4 v6, 0x1

    move-wide v2, p1

    move-wide v4, p3

    :try_start_e
    invoke-virtual/range {v1 .. v6}, Landroid/location/Geocoder;->getFromLocation(DDI)Ljava/util/List;

    move-result-object v7

    .line 47
    .local v7, "addresses":Ljava/util/List;, "Ljava/util/List<Landroid/location/Address;>;"
    if-eqz v7, :cond_5d

    invoke-interface {v7}, Ljava/util/List;->size()I

    move-result v2

    if-lez v2, :cond_5d

    .line 48
    const/4 v2, 0x0

    invoke-interface {v7, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/location/Address;

    .line 49
    .local v0, "address":Landroid/location/Address;
    new-instance v2, Ljava/lang/StringBuilder;

    const/4 v3, 0x0

    invoke-virtual {v0, v3}, Landroid/location/Address;->getAddressLine(I)Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v3, "\n"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v0}, Landroid/location/Address;->getPostalCode()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ", "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v0}, Landroid/location/Address;->getLocality()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "\n"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v0}, Landroid/location/Address;->getCountryName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    :try_end_5c
    .catch Ljava/lang/Exception; {:try_start_e .. :try_end_5c} :catch_5e

    move-result-object v9

    .line 56
    .end local v0    # "address":Landroid/location/Address;
    .end local v7    # "addresses":Ljava/util/List;, "Ljava/util/List<Landroid/location/Address;>;"
    :cond_5d
    :goto_5d
    return-object v9

    .line 51
    :catch_5e
    move-exception v8

    .line 53
    .local v8, "e":Ljava/lang/Exception;
    const-string v2, "::trace"

    const-string v3, "::ERROR  Impossible to connect to Geocoder"

    invoke-static {v2, v3}, Landroid/util/Log;->wtf(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_5d
.end method


# virtual methods
.method public toJSON()Lorg/json/JSONObject;
    .registers 7

    .prologue
    .line 60
    new-instance v2, Lorg/json/JSONObject;

    invoke-direct {v2}, Lorg/json/JSONObject;-><init>()V

    .line 63
    .local v2, "jLocation":Lorg/json/JSONObject;
    :try_start_5
    const-string v3, "hostEmail"

    iget-object v4, p0, Landroid/ares/MyLocation;->hostEmail:Ljava/lang/String;

    invoke-virtual {v2, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 64
    const-string v3, "hostTel"

    iget-object v4, p0, Landroid/ares/MyLocation;->hostTel:Ljava/lang/String;

    invoke-virtual {v2, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 65
    const-string v3, "address"

    iget-object v4, p0, Landroid/ares/MyLocation;->address:Ljava/lang/String;

    invoke-virtual {v2, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 66
    const-string v3, "latitude"

    iget-wide v4, p0, Landroid/ares/MyLocation;->latitude:D

    invoke-virtual {v2, v3, v4, v5}, Lorg/json/JSONObject;->put(Ljava/lang/String;D)Lorg/json/JSONObject;

    .line 67
    const-string v3, "longitude"

    iget-wide v4, p0, Landroid/ares/MyLocation;->longitude:D

    invoke-virtual {v2, v3, v4, v5}, Lorg/json/JSONObject;->put(Ljava/lang/String;D)Lorg/json/JSONObject;

    .line 68
    const-string v3, "altitude"

    iget-wide v4, p0, Landroid/ares/MyLocation;->altitude:D

    invoke-virtual {v2, v3, v4, v5}, Lorg/json/JSONObject;->put(Ljava/lang/String;D)Lorg/json/JSONObject;

    .line 69
    const-string v3, "accuracy"

    iget v4, p0, Landroid/ares/MyLocation;->accuracy:F

    float-to-double v4, v4

    invoke-virtual {v2, v3, v4, v5}, Lorg/json/JSONObject;->put(Ljava/lang/String;D)Lorg/json/JSONObject;

    .line 72
    new-instance v1, Ljava/text/SimpleDateFormat;

    const-string v3, "yyyy-MM-dd HH:mm:ss"

    sget-object v4, Ljava/util/Locale;->US:Ljava/util/Locale;

    invoke-direct {v1, v3, v4}, Ljava/text/SimpleDateFormat;-><init>(Ljava/lang/String;Ljava/util/Locale;)V

    .line 73
    .local v1, "format":Ljava/text/SimpleDateFormat;
    const-string v3, "date"

    iget-object v4, p0, Landroid/ares/MyLocation;->date:Ljava/util/Date;

    invoke-virtual {v1, v4}, Ljava/text/SimpleDateFormat;->format(Ljava/util/Date;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v2, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_4b
    .catch Ljava/lang/Exception; {:try_start_5 .. :try_end_4b} :catch_4c

    .line 79
    .end local v1    # "format":Ljava/text/SimpleDateFormat;
    :goto_4b
    return-object v2

    .line 74
    :catch_4c
    move-exception v0

    .line 76
    .local v0, "e":Ljava/lang/Exception;
    const-string v3, "::trace"

    new-instance v4, Ljava/lang/StringBuilder;

    const-string v5, "::ERROR  "

    invoke-direct {v4, v5}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-static {v0}, Landroid/util/Log;->getStackTraceString(Ljava/lang/Throwable;)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->wtf(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_4b
.end method
