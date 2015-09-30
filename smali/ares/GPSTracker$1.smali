.class Landroid/ares/GPSTracker$1;
.super Ljava/lang/Object;
.source "GPSTracker.java"

# interfaces
.implements Landroid/location/LocationListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Landroid/ares/GPSTracker;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Landroid/ares/GPSTracker;


# direct methods
.method constructor <init>(Landroid/ares/GPSTracker;)V
    .registers 2

    .prologue
    .line 1
    iput-object p1, p0, Landroid/ares/GPSTracker$1;->this$0:Landroid/ares/GPSTracker;

    .line 24
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onLocationChanged(Landroid/location/Location;)V
    .registers 5
    .param p1, "location"    # Landroid/location/Location;

    .prologue
    .line 28
    const-string v0, "::trace"

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "::INFO  onLocationChanged: "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 44
    return-void
.end method

.method public onProviderDisabled(Ljava/lang/String;)V
    .registers 5
    .param p1, "provider"    # Ljava/lang/String;

    .prologue
    .line 49
    const-string v0, "::trace"

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "::DEBUG  onProviderDisabled: "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 50
    return-void
.end method

.method public onProviderEnabled(Ljava/lang/String;)V
    .registers 5
    .param p1, "provider"    # Ljava/lang/String;

    .prologue
    .line 55
    const-string v0, "::trace"

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "::DEBUG  onProviderEnabled: "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 56
    return-void
.end method

.method public onStatusChanged(Ljava/lang/String;ILandroid/os/Bundle;)V
    .registers 7
    .param p1, "provider"    # Ljava/lang/String;
    .param p2, "status"    # I
    .param p3, "extras"    # Landroid/os/Bundle;

    .prologue
    .line 61
    const-string v0, "::trace"

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "::DEBUG  onStatusChanged: "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 62
    return-void
.end method
