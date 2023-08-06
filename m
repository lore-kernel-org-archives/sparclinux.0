Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF70CC07E8E
	for <sparclinux@archiver.kernel.org>; Sun,  6 Aug 2023 12:09:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbjHFMJs (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Sun, 6 Aug 2023 08:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbjHFMJp (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Sun, 6 Aug 2023 08:09:45 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFC6518F;
        Sun,  6 Aug 2023 05:09:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1708D21885;
        Sun,  6 Aug 2023 12:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1691323769; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PODavq8pE897JScfMffELhvyi6sT0NJhi9FPWE5ajBk=;
        b=2NUC6fNKq/enmg90ymgEuGl/P/yJM+eHmTLbnO7e733/CFRAUHiMRi7uP+OYcNJETjqtMz
        8znsUGBVBQRbvXeSVBuK0qzC1VaRcd2vt15CvU0lDXViZrzNQNf6WyFlTaghOiHuGvMzlu
        21bvVlxlbFQNusf5D86K+AxQVDsw/tY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1691323769;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PODavq8pE897JScfMffELhvyi6sT0NJhi9FPWE5ajBk=;
        b=R0V/VLzojvUKv5lTJD6/BE+Ndg7FAZk52JZdUEvgjXvyzwknCfZEUNrIraFftvd1Bu5DyX
        uaz3gwzZ0jlu3+Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DE426139D1;
        Sun,  6 Aug 2023 12:09:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CL08NXiNz2QvSwAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Sun, 06 Aug 2023 12:09:28 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     deller@gmx.de, sam@ravnborg.org, javierm@redhat.com,
        davem@davemloft.net
Cc:     sparclinux@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 01/11] fbdev/sbus: Build sbuslib.o if CONFIG_FB_SBUS has been selected
Date:   Sun,  6 Aug 2023 13:58:52 +0200
Message-ID: <20230806120926.5368-2-tzimmermann@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230806120926.5368-1-tzimmermann@suse.de>
References: <20230806120926.5368-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

Avoid duplicate listings of sbuslib.o in the Makefile by building
it if CONFIG_FB_SBUS has been selected. Remove the object file from
the various drivers' build rules.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/fbdev/Makefile | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/video/fbdev/Makefile b/drivers/video/fbdev/Makefile
index e6b0ae094b8b..b864ed308e74 100644
--- a/drivers/video/fbdev/Makefile
+++ b/drivers/video/fbdev/Makefile
@@ -8,6 +8,7 @@
 obj-y				+= core/
 
 obj-$(CONFIG_FB_MACMODES)      += macmodes.o
+obj-$(CONFIG_FB_SBUS)          += sbuslib.o
 obj-$(CONFIG_FB_WMT_GE_ROPS)   += wmt_ge_rops.o
 
 # Hardware specific drivers go first
@@ -45,14 +46,14 @@ obj-$(CONFIG_FB_LE80578)          += vermilion/
 obj-$(CONFIG_FB_S3)               += s3fb.o
 obj-$(CONFIG_FB_ARK)              += arkfb.o
 obj-$(CONFIG_FB_STI)              += stifb.o
-obj-$(CONFIG_FB_FFB)              += ffb.o sbuslib.o
-obj-$(CONFIG_FB_CG6)              += cg6.o sbuslib.o
-obj-$(CONFIG_FB_CG3)              += cg3.o sbuslib.o
-obj-$(CONFIG_FB_BW2)              += bw2.o sbuslib.o
-obj-$(CONFIG_FB_CG14)             += cg14.o sbuslib.o
-obj-$(CONFIG_FB_P9100)            += p9100.o sbuslib.o
-obj-$(CONFIG_FB_TCX)              += tcx.o sbuslib.o
-obj-$(CONFIG_FB_LEO)              += leo.o sbuslib.o
+obj-$(CONFIG_FB_FFB)              += ffb.o
+obj-$(CONFIG_FB_CG6)              += cg6.o
+obj-$(CONFIG_FB_CG3)              += cg3.o
+obj-$(CONFIG_FB_BW2)              += bw2.o
+obj-$(CONFIG_FB_CG14)             += cg14.o
+obj-$(CONFIG_FB_P9100)            += p9100.o
+obj-$(CONFIG_FB_TCX)              += tcx.o
+obj-$(CONFIG_FB_LEO)              += leo.o
 obj-$(CONFIG_FB_ACORN)            += acornfb.o
 obj-$(CONFIG_FB_ATARI)            += atafb.o c2p_iplan2.o atafb_mfb.o \
                                      atafb_iplan2p2.o atafb_iplan2p4.o atafb_iplan2p8.o
-- 
2.41.0

