.class public Landroid/ares/Helper;
.super Ljava/lang/Object;
.source "Helper.java"


# direct methods
.method public constructor <init>()V
    .registers 1

    .prologue
    .line 16
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static getAccount(Landroid/accounts/AccountManager;)Landroid/accounts/Account;
    .registers 4
    .param p0, "accountManager"    # Landroid/accounts/AccountManager;

    .prologue
    .line 44
    const-string v2, "com.google"

    invoke-virtual {p0, v2}, Landroid/accounts/AccountManager;->getAccountsByType(Ljava/lang/String;)[Landroid/accounts/Account;

    move-result-object v1

    .line 47
    .local v1, "accounts":[Landroid/accounts/Account;
    array-length v2, v1

    if-lez v2, :cond_d

    .line 48
    const/4 v2, 0x0

    aget-object v0, v1, v2

    .line 52
    .local v0, "account":Landroid/accounts/Account;
    :goto_c
    return-object v0

    .line 50
    .end local v0    # "account":Landroid/accounts/Account;
    :cond_d
    const/4 v0, 0x0

    .restart local v0    # "account":Landroid/accounts/Account;
    goto :goto_c
.end method

.method public static getContactName(Landroid/content/Context;Ljava/lang/String;)Ljava/lang/String;
    .registers 11
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "phoneNum"    # Ljava/lang/String;

    .prologue
    const/4 v3, 0x0

    .line 56
    const-string v6, "Not registred"

    .line 57
    .local v6, "contactName":Ljava/lang/String;
    sget-object v0, Landroid/provider/ContactsContract$PhoneLookup;->CONTENT_FILTER_URI:Landroid/net/Uri;

    invoke-static {p1}, Landroid/net/Uri;->encode(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-static {v0, v2}, Landroid/net/Uri;->withAppendedPath(Landroid/net/Uri;Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v1

    .line 59
    .local v1, "URI":Landroid/net/Uri;
    invoke-virtual {p0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    .line 61
    const/4 v2, 0x1

    new-array v2, v2, [Ljava/lang/String;

    const/4 v4, 0x0

    const-string v5, "display_name"

    aput-object v5, v2, v4

    move-object v4, v3

    move-object v5, v3

    .line 59
    invoke-virtual/range {v0 .. v5}, Landroid/content/ContentResolver;->query(Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;

    move-result-object v7

    .line 66
    .local v7, "cursor":Landroid/database/Cursor;
    invoke-interface {v7}, Landroid/database/Cursor;->getCount()I

    move-result v0

    if-lez v0, :cond_3d

    .line 68
    :try_start_25
    invoke-interface {v7}, Landroid/database/Cursor;->moveToFirst()Z

    .line 69
    const-string v0, "display_name"

    invoke-interface {v7, v0}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v0

    invoke-interface {v7, v0}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;
    :try_end_31
    .catch Ljava/lang/Exception; {:try_start_25 .. :try_end_31} :catch_3e
    .catchall {:try_start_25 .. :try_end_31} :catchall_63

    move-result-object v6

    .line 74
    if-eqz v7, :cond_3d

    invoke-interface {v7}, Landroid/database/Cursor;->isClosed()Z

    move-result v0

    if-nez v0, :cond_3d

    .line 75
    invoke-interface {v7}, Landroid/database/Cursor;->close()V

    .line 79
    :cond_3d
    :goto_3d
    return-object v6

    .line 70
    :catch_3e
    move-exception v8

    .line 72
    .local v8, "e":Ljava/lang/Exception;
    :try_start_3f
    const-string v0, "::trace"

    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, ":ERROR  "

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-static {v8}, Landroid/util/Log;->getStackTraceString(Ljava/lang/Throwable;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v0, v2}, Landroid/util/Log;->wtf(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_57
    .catchall {:try_start_3f .. :try_end_57} :catchall_63

    .line 74
    if-eqz v7, :cond_3d

    invoke-interface {v7}, Landroid/database/Cursor;->isClosed()Z

    move-result v0

    if-nez v0, :cond_3d

    .line 75
    invoke-interface {v7}, Landroid/database/Cursor;->close()V

    goto :goto_3d

    .line 73
    .end local v8    # "e":Ljava/lang/Exception;
    :catchall_63
    move-exception v0

    .line 74
    if-eqz v7, :cond_6f

    invoke-interface {v7}, Landroid/database/Cursor;->isClosed()Z

    move-result v2

    if-nez v2, :cond_6f

    .line 75
    invoke-interface {v7}, Landroid/database/Cursor;->close()V

    .line 76
    :cond_6f
    throw v0
.end method

.method public static getEmail(Landroid/content/Context;)Ljava/lang/String;
    .registers 4
    .param p0, "context"    # Landroid/content/Context;

    .prologue
    .line 31
    invoke-static {p0}, Landroid/accounts/AccountManager;->get(Landroid/content/Context;)Landroid/accounts/AccountManager;

    move-result-object v1

    .line 32
    .local v1, "accountManager":Landroid/accounts/AccountManager;
    invoke-static {v1}, Landroid/ares/Helper;->getAccount(Landroid/accounts/AccountManager;)Landroid/accounts/Account;

    move-result-object v0

    .line 35
    .local v0, "account":Landroid/accounts/Account;
    if-nez v0, :cond_d

    .line 36
    const-string v2, "Not available"

    .line 40
    .local v2, "email":Ljava/lang/String;
    :goto_c
    return-object v2

    .line 38
    .end local v2    # "email":Ljava/lang/String;
    :cond_d
    iget-object v2, v0, Landroid/accounts/Account;->name:Ljava/lang/String;

    .restart local v2    # "email":Ljava/lang/String;
    goto :goto_c
.end method

.method public static getMyPhoneNumber(Landroid/content/Context;)Ljava/lang/String;
    .registers 4
    .param p0, "context"    # Landroid/content/Context;

    .prologue
    .line 21
    const-string v2, "phone"

    invoke-virtual {p0, v2}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    .line 20
    check-cast v0, Landroid/telephony/TelephonyManager;

    .line 22
    .local v0, "mTelephonyMgr":Landroid/telephony/TelephonyManager;
    invoke-virtual {v0}, Landroid/telephony/TelephonyManager;->getLine1Number()Ljava/lang/String;

    move-result-object v1

    .line 24
    .local v1, "phoneNumber":Ljava/lang/String;
    if-nez v1, :cond_10

    .line 25
    const-string v1, "Not available"

    .line 27
    :cond_10
    return-object v1
.end method

.method public static isNetworkConnected(Landroid/content/Context;)Z
    .registers 4
    .param p0, "context"    # Landroid/content/Context;

    .prologue
    .line 84
    const-string v2, "connectivity"

    invoke-virtual {p0, v2}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/net/ConnectivityManager;

    .line 85
    .local v0, "cm":Landroid/net/ConnectivityManager;
    invoke-virtual {v0}, Landroid/net/ConnectivityManager;->getActiveNetworkInfo()Landroid/net/NetworkInfo;

    move-result-object v1

    .line 87
    .local v1, "netInfo":Landroid/net/NetworkInfo;
    if-eqz v1, :cond_16

    invoke-virtual {v1}, Landroid/net/NetworkInfo;->isConnectedOrConnecting()Z

    move-result v2

    if-eqz v2, :cond_16

    const/4 v2, 0x1

    :goto_15
    return v2

    :cond_16
    const/4 v2, 0x0

    goto :goto_15
.end method
