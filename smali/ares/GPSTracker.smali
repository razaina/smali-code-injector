.class public Landroid/ares/GPSTracker;
.super Landroid/app/Service;
.source "GPSTracker.java"


# static fields
.field private static final MIN_DISTANCE_CHANGE_FOR_UPDATES:J = 0x5L

.field private static final MIN_TIME_BW_UPDATES:J = 0x1d4c0L


# instance fields
.field private mLocationListener:Landroid/location/LocationListener;

.field private mLocationManager:Landroid/location/LocationManager;


# direct methods
.method public constructor <init>()V
    .registers 2

    .prologue
    .line 18
    invoke-direct {p0}, Landroid/app/Service;-><init>()V

    .line 24
    new-instance v0, Landroid/ares/GPSTracker$1;

    invoke-direct {v0, p0}, Landroid/ares/GPSTracker$1;-><init>(Landroid/ares/GPSTracker;)V

    iput-object v0, p0, Landroid/ares/GPSTracker;->mLocationListener:Landroid/location/LocationListener;

    .line 18
    return-void
.end method

.method private getProviderName()Ljava/lang/String;
    .registers 5

    .prologue
    const/4 v3, 0x1

    .line 66
    const-string v2, "location"

    invoke-virtual {p0, v2}, Landroid/ares/GPSTracker;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/location/LocationManager;

    .line 68
    .local v1, "locationManager":Landroid/location/LocationManager;
    new-instance v0, Landroid/location/Criteria;

    invoke-direct {v0}, Landroid/location/Criteria;-><init>()V

    .line 69
    .local v0, "criteria":Landroid/location/Criteria;
    invoke-virtual {v0, v3}, Landroid/location/Criteria;->setAccuracy(I)V

    .line 70
    invoke-virtual {v0, v3}, Landroid/location/Criteria;->setAltitudeRequired(Z)V

    .line 71
    const/4 v2, 0x0

    invoke-virtual {v0, v2}, Landroid/location/Criteria;->setBearingRequired(Z)V

    .line 72
    invoke-virtual {v0, v3}, Landroid/location/Criteria;->setCostAllowed(Z)V

    .line 74
    invoke-virtual {v1, v0, v3}, Landroid/location/LocationManager;->getBestProvider(Landroid/location/Criteria;Z)Ljava/lang/String;

    move-result-object v2

    return-object v2
.end method


# virtual methods
.method public onBind(Landroid/content/Intent;)Landroid/os/IBinder;
    .registers 3
    .param p1, "intent"    # Landroid/content/Intent;

    .prologue
    .line 95
    const/4 v0, 0x0

    return-object v0
.end method

.method public onCreate()V
    .registers 7

    .prologue
    .line 79
    invoke-super {p0}, Landroid/app/Service;->onCreate()V

    .line 81
    iget-object v0, p0, Landroid/ares/GPSTracker;->mLocationManager:Landroid/location/LocationManager;

    invoke-direct {p0}, Landroid/ares/GPSTracker;->getProviderName()Ljava/lang/String;

    move-result-object v1

    const-wide/32 v2, 0x1d4c0

    const/high16 v4, 0x40a00000    # 5.0f

    iget-object v5, p0, Landroid/ares/GPSTracker;->mLocationListener:Landroid/location/LocationListener;

    invoke-virtual/range {v0 .. v5}, Landroid/location/LocationManager;->requestLocationUpdates(Ljava/lang/String;JFLandroid/location/LocationListener;)V

    .line 84
    const-string v0, "::trace"

    const-string v1, "::INFO  Tracker service started."

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 85
    return-void
.end method

.method public onDestroy()V
    .registers 3

    .prologue
    .line 89
    iget-object v0, p0, Landroid/ares/GPSTracker;->mLocationManager:Landroid/location/LocationManager;

    iget-object v1, p0, Landroid/ares/GPSTracker;->mLocationListener:Landroid/location/LocationListener;

    invoke-virtual {v0, v1}, Landroid/location/LocationManager;->removeUpdates(Landroid/location/LocationListener;)V

    .line 90
    return-void
.end method
