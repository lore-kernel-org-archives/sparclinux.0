Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E42C0729B
	for <sparclinux@archiver.kernel.org>; Sun,  6 Aug 2023 12:09:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbjHFMJr (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Sun, 6 Aug 2023 08:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbjHFMJp (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Sun, 6 Aug 2023 08:09:45 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4FED19A6;
        Sun,  6 Aug 2023 05:09:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 47A8921886;
        Sun,  6 Aug 2023 12:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1691323769; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j2+PHwE+3jp4+JdnY7LWD1BPEcLGx5ZnrGntxzI+QlQ=;
        b=GdjqUsNPpw51d8yQimIODI2kZ8ufoWTol0brHjtuYHe4+rkECzT3/huiS7CBAzg1EqJlkg
        DAFEuju8bYZ3EJOTXafRDXVbzKmySxIGOZo7+fKQ8c/dvprNTEzX2P7FBmX59C+8LzqAkN
        o1tPj6VanrGLJFGDPLt5M2/txnnsFv4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1691323769;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j2+PHwE+3jp4+JdnY7LWD1BPEcLGx5ZnrGntxzI+QlQ=;
        b=M3RQmdNpbSBOSvNECEYrUPdHIqZzNwxeS4NmUr6grcAZ6KoiTgRciTySru66vi64cSWYlm
        B8v+49xJWAZZZeAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1AF65139C4;
        Sun,  6 Aug 2023 12:09:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SKOqBXmNz2QvSwAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Sun, 06 Aug 2023 12:09:29 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     deller@gmx.de, sam@ravnborg.org, javierm@redhat.com,
        davem@davemloft.net
Cc:     sparclinux@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 02/11] fbdev/sbus: Forward declare all necessary structures in header
Date:   Sun,  6 Aug 2023 13:58:53 +0200
Message-ID: <20230806120926.5368-3-tzimmermann@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230806120926.5368-1-tzimmermann@suse.de>
References: <20230806120926.5368-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

In sbuslib.h, declare all of the header file's structs at the
top. No functional changes.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/fbdev/sbuslib.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/sbuslib.h b/drivers/video/fbdev/sbuslib.h
index a6b9a2467646..02ac1282903b 100644
--- a/drivers/video/fbdev/sbuslib.h
+++ b/drivers/video/fbdev/sbuslib.h
@@ -3,6 +3,11 @@
 #ifndef _SBUSLIB_H
 #define _SBUSLIB_H
 
+struct device_node;
+struct fb_info;
+struct fb_var_screeninfo;
+struct vm_area_struct;
+
 struct sbus_mmap_map {
 	unsigned long voff;
 	unsigned long poff;
@@ -14,7 +19,6 @@ struct sbus_mmap_map {
 
 extern void sbusfb_fill_var(struct fb_var_screeninfo *var,
 			    struct device_node *dp, int bpp);
-struct vm_area_struct;
 extern int sbusfb_mmap_helper(struct sbus_mmap_map *map,
 			      unsigned long physbase, unsigned long fbsize,
 			      unsigned long iospace,
-- 
2.41.0

