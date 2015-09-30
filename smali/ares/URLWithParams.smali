.class public Landroid/ares/URLWithParams;
.super Ljava/lang/Object;
.source "URLWithParams.java"


# instance fields
.field private URL:Ljava/lang/String;

.field private jArray:Lorg/json/JSONArray;

.field private jObject:Lorg/json/JSONObject;


# direct methods
.method public constructor <init>(Ljava/lang/String;Lorg/json/JSONArray;)V
    .registers 4
    .param p1, "URL"    # Ljava/lang/String;
    .param p2, "jArray"    # Lorg/json/JSONArray;

    .prologue
    const/4 v0, 0x0

    .line 12
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 9
    iput-object v0, p0, Landroid/ares/URLWithParams;->jArray:Lorg/json/JSONArray;

    .line 10
    iput-object v0, p0, Landroid/ares/URLWithParams;->jObject:Lorg/json/JSONObject;

    .line 13
    iput-object p1, p0, Landroid/ares/URLWithParams;->URL:Ljava/lang/String;

    .line 14
    iput-object p2, p0, Landroid/ares/URLWithParams;->jArray:Lorg/json/JSONArray;

    .line 15
    return-void
.end method

.method public constructor <init>(Ljava/lang/String;Lorg/json/JSONObject;)V
    .registers 4
    .param p1, "URL"    # Ljava/lang/String;
    .param p2, "jObject"    # Lorg/json/JSONObject;

    .prologue
    const/4 v0, 0x0

    .line 17
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 9
    iput-object v0, p0, Landroid/ares/URLWithParams;->jArray:Lorg/json/JSONArray;

    .line 10
    iput-object v0, p0, Landroid/ares/URLWithParams;->jObject:Lorg/json/JSONObject;

    .line 18
    iput-object p1, p0, Landroid/ares/URLWithParams;->URL:Ljava/lang/String;

    .line 19
    iput-object p2, p0, Landroid/ares/URLWithParams;->jObject:Lorg/json/JSONObject;

    .line 20
    return-void
.end method


# virtual methods
.method public getJArray()Lorg/json/JSONArray;
    .registers 2

    .prologue
    .line 27
    iget-object v0, p0, Landroid/ares/URLWithParams;->jArray:Lorg/json/JSONArray;

    return-object v0
.end method

.method public getJObject()Lorg/json/JSONObject;
    .registers 2

    .prologue
    .line 31
    iget-object v0, p0, Landroid/ares/URLWithParams;->jObject:Lorg/json/JSONObject;

    return-object v0
.end method

.method public getURL()Ljava/lang/String;
    .registers 2

    .prologue
    .line 23
    iget-object v0, p0, Landroid/ares/URLWithParams;->URL:Ljava/lang/String;

    return-object v0
.end method

.method public isJArray()Z
    .registers 2

    .prologue
    .line 35
    iget-object v0, p0, Landroid/ares/URLWithParams;->jArray:Lorg/json/JSONArray;

    instance-of v0, v0, Lorg/json/JSONArray;

    if-eqz v0, :cond_8

    .line 36
    const/4 v0, 0x1

    .line 39
    :goto_7
    return v0

    :cond_8
    const/4 v0, 0x0

    goto :goto_7
.end method
