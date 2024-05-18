Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C3639FC5;
	Sat, 18 May 2024 11:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716032500; cv=none; b=qWFw8Rb1ZQIslgosxd86OPTsg01xm0cXIOwmGCvwKBqcH8812lUkec/gP2V0xMl3ya5GmpiH4Odm4zzVWlU0hBsFrGi+XST/SUlTaZSNqq1huw6xLWFTOXN/8YDkvPdl11ZF3DPV34fIvUwlYJYYCSboPvewoTSCwzB/zYTueiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716032500; c=relaxed/simple;
	bh=ur57ZY+2aICTIPOpezi/vJnYRMVcdjk1kendQiZu52Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BwFYUJqmSKDw/W/7UylPN6lSVKKV7UsbOWpjSF7bwGMzvaL7OvAuvgcGe9wojIesP7faLJX4UWjdyhk+AacfYi8u2006kCAX0uW57md5zKRa+rx0Qrv9lhJRE1IicX+NdytQM2OCsJAY3yPbeizx7p/8y9femsZf4np/Nowvr1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LQidwy/2; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LQidwy/2"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1ecc23e6c9dso33170665ad.2;
        Sat, 18 May 2024 04:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716032498; x=1716637298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nGZELmCIhJ0Llb0Ot0Pxzsc4Vz/WbJAcy06wKqjrN/c=;
        b=LQidwy/20EWzDPdF5hI9iXbcDBJQwm5SQpdk+k2IteyN17Afgik0iBcz0+soW7eF7e
         SGKYK3oqJ9pSmjLgFIDp9B6jFFfb6umHPvpZSvFq7SAb9W2zQRGTrG1d3czCKWGgXUiB
         0X6rq2/l7FbW8GxTRvEuV84QGHmpMl1vdtAWIXmFJwabRiadBkIWet8/H7AbA6rIu4NN
         0URj39Qnb9mqV3fzFo8LmDdT3O3nTTy1Iq+8YdZUAOef4nzOcRM/mVb2g3Z8aNZRd1ik
         pEdkF29WeHZ3dETo0CmqXGrnsj/0yQqWKg+3ZEd8CN+TfITDZCpKy42Tcv1+bbSvGCne
         tQuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716032498; x=1716637298;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nGZELmCIhJ0Llb0Ot0Pxzsc4Vz/WbJAcy06wKqjrN/c=;
        b=EW3mTrthNyJDucjW5vzGbZvW1b98NqogpiUWT1dWhS/ogw1P5jIn1z796HCl46ODJ6
         xBdEYVnKr4GCP1F65j8jJu75aq7+9f3QKoGA2P5BzDa/J0DckJkLFS4lYejv3KgLa1Dc
         hgiXfr9KGnmTSz31HVgpnKNEkhoMKNdIlCbb77aHGgihtiF7fS9uAtfeUZKovrkFWPsK
         CbZeCrvHaUMvyLqYLcmpJK0mwlSPy7vXe841leVJqkwo9UGXeuS1V1OITcf+y77oyldC
         cUMC9xJaaGrhZgDkJoDSc5OeRbYhAwNQeJIf/qknMFRrRjAIK5lMnZ47QXMLGRb7zwFM
         I2lQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4FrpXGevclL+6/7+/DI9rRlsVYQypZdGs9GBVjE45XbsrV+aMzHLScZCAaMM+zRJmbd9uh477f71z4ll4hwEYlfkE7/MaLz4UCuoG8CbttHu/jktSV5YEjbQrkH+2DSCq2jO+wuyQYffp
X-Gm-Message-State: AOJu0YxMtt93OyCek1H5/tB2hdt3YxJ3mz9aSBHW+LrQ/ubhbAy16/Uv
	Fz6QcZ5CsKYuHvrOJzFmitnaIN54oqjRqSlRRzkcR7Dq+P262sxQ
X-Google-Smtp-Source: AGHT+IGcQGG/h1nEam/GJrnqHPM6nuFyMxbUTnxpQlFLWLE5zIiECwqVNtAcSOHXhY1243rDASNVSw==
X-Received: by 2002:a17:902:fc4f:b0:1e8:c962:4f6e with SMTP id d9443c01a7336-1ef43d27f6fmr274274915ad.20.1716032498514;
        Sat, 18 May 2024 04:41:38 -0700 (PDT)
Received: from localhost.localdomain ([122.161.51.212])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c035d8esm171800655ad.199.2024.05.18.04.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 May 2024 04:41:37 -0700 (PDT)
From: Shresth Prasad <shresthprasad7@gmail.com>
To: davem@davemloft.net,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Shresth Prasad <shresthprasad7@gmail.com>,
	Julia Lawall <julia.lawall@inria.fr>
Subject: [PATCH v3][next] tty: sunsu: Simplify device_node cleanup by using __free
Date: Sat, 18 May 2024 17:10:53 +0530
Message-ID: <20240518114051.18125-3-shresthprasad7@gmail.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add `__free` function attribute to `ap` and `match` pointer
initialisations which ensure that the pointers are freed as soon as they
go out of scope, thus removing the need to manually free them using
`of_node_put`.

This also removes the need for the `goto` statement and the `rc`
variable.

Suggested-by: Julia Lawall <julia.lawall@inria.fr>
Signed-off-by: Shresth Prasad <shresthprasad7@gmail.com>
---
Changes in v3:
    - Remove incorrect testing statement

I've tested the patch by cross compiling it for sparc systems and
booting the produced `image` file in `qemu-system-sparc`.

---
 drivers/tty/serial/sunsu.c | 37 +++++++++++--------------------------
 1 file changed, 11 insertions(+), 26 deletions(-)

diff --git a/drivers/tty/serial/sunsu.c b/drivers/tty/serial/sunsu.c
index 67a5fc70bb4b..0f463da5e7ce 100644
--- a/drivers/tty/serial/sunsu.c
+++ b/drivers/tty/serial/sunsu.c
@@ -1382,44 +1382,29 @@ static inline struct console *SUNSU_CONSOLE(void)
 
 static enum su_type su_get_type(struct device_node *dp)
 {
-	struct device_node *ap = of_find_node_by_path("/aliases");
-	enum su_type rc = SU_PORT_PORT;
+	struct device_node *ap __free(device_node) =
+			    of_find_node_by_path("/aliases");
 
 	if (ap) {
 		const char *keyb = of_get_property(ap, "keyboard", NULL);
 		const char *ms = of_get_property(ap, "mouse", NULL);
-		struct device_node *match;
 
 		if (keyb) {
-			match = of_find_node_by_path(keyb);
+			struct device_node *match __free(device_node) =
+					    of_find_node_by_path(keyb);
 
-			/*
-			 * The pointer is used as an identifier not
-			 * as a pointer, we can drop the refcount on
-			 * the of__node immediately after getting it.
-			 */
-			of_node_put(match);
-
-			if (dp == match) {
-				rc = SU_PORT_KBD;
-				goto out;
-			}
+			if (dp == match)
+				return SU_PORT_KBD;
 		}
 		if (ms) {
-			match = of_find_node_by_path(ms);
+			struct device_node *match __free(device_node) =
+					    of_find_node_by_path(ms);
 
-			of_node_put(match);
-
-			if (dp == match) {
-				rc = SU_PORT_MS;
-				goto out;
-			}
+			if (dp == match)
+				return SU_PORT_MS;
 		}
 	}
-
-out:
-	of_node_put(ap);
-	return rc;
+	return SU_PORT_PORT;
 }
 
 static int su_probe(struct platform_device *op)
-- 
2.44.0

