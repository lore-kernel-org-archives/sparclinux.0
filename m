Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B102C7EE24
	for <sparclinux@archiver.kernel.org>; Fri, 28 Apr 2023 09:27:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345508AbjD1J1R (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Fri, 28 Apr 2023 05:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjD1J1Q (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Fri, 28 Apr 2023 05:27:16 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B52232709;
        Fri, 28 Apr 2023 02:27:14 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3BA8221A2D;
        Fri, 28 Apr 2023 09:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1682674033; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=H634jX8sSYMwnQT1vLr7vYP2Eo6TaCU+J3gzKVsIAq4=;
        b=VbHHcK4793S8Ps7niwJ/Fwfmq+pXThNJc0kyX1jeLNE6xy35UoTR3ljF9sLnSM3cZintOy
        YdHtZSHPLoPgN1oikxQp2DXNqWBiENQRuP0ROqwzpUBiK1jRzN3nwlptu1ijUTjf0zvy/d
        zq4KTdTSkchp187Tn9tNbgxtKTUcp6U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1682674033;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=H634jX8sSYMwnQT1vLr7vYP2Eo6TaCU+J3gzKVsIAq4=;
        b=DW2G43drDfPSAccNnQi6KBQ7vl1Fmv8Co40ZZveXyfpskVMHp3yPMtZ6tOE7+kr7M00llZ
        MhFKTW90T3B8rDAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C0F21138FA;
        Fri, 28 Apr 2023 09:27:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jkouLnCRS2ReFwAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Fri, 28 Apr 2023 09:27:12 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     deller@gmx.de, geert@linux-m68k.org, javierm@redhat.com,
        daniel@ffwll.ch, vgupta@kernel.org, chenhuacai@kernel.org,
        kernel@xen0n.name, davem@davemloft.net,
        James.Bottomley@HansenPartnership.com, arnd@arndb.de,
        sam@ravnborg.org
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arch@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-parisc@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 0/5] fbdev: Use regular I/O function for framebuffers
Date:   Fri, 28 Apr 2023 11:27:06 +0200
Message-Id: <20230428092711.406-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

(was: fbdev: Move framebuffer I/O helpers to <asm/fb.h>)

Fbdev provides helpers for framebuffer I/O, such as fb_readl(),
fb_writel() or fb_memcpy_to_fb(). The implementation of each helper
depends on the architecture, but they all come down to regular I/O
functions of similar names. So use the regular functions instead.

The first patch a simple whitespace cleanup.

Until now, <linux/fb.h> contained an include of <asm/io.h>. As this
will go away patches 2 to 4 prepare include statements in the various
drivers. Source files that use regular I/O helpers, such as readl(),
now include <linux/io.h>. Source files that use framebuffer I/O
helpers, such as fb_readl(), also include <linux/io.h>.

Patch 5 replaces the architecture-based if-else branching in 
<linux/fb.h> by define statements that map to Linux' I/O fucntions.

After this change has been merged and included in a few release
without complains, we can update the drivers to regular I/O functions
and remove the fbdev-specific defines.

The patchset has been built for a variety of platforms, such as x86-64,
arm, aarch64, ppc64, parisc, m64k, mips and sparc.

v2:
	* use Linux I/O helpers (Sam, Arnd)

Thomas Zimmermann (5):
  fbdev/matrox: Remove trailing whitespaces
  ipu-v3: Include <linux/io.h>
  fbdev: Include <linux/io.h> in various drivers
  fbdev: Include <linux/io.h> in drivers
  fbdev: Define framebuffer I/O from Linux' I/O functions

 drivers/gpu/ipu-v3/ipu-prv.h                |  1 +
 drivers/video/fbdev/arcfb.c                 |  1 +
 drivers/video/fbdev/arkfb.c                 |  1 +
 drivers/video/fbdev/aty/atyfb.h             |  2 +
 drivers/video/fbdev/aty/mach64_cursor.c     |  3 +-
 drivers/video/fbdev/chipsfb.c               |  1 +
 drivers/video/fbdev/cirrusfb.c              |  1 +
 drivers/video/fbdev/core/cfbcopyarea.c      |  2 +-
 drivers/video/fbdev/core/cfbfillrect.c      |  2 +
 drivers/video/fbdev/core/cfbimgblt.c        |  2 +
 drivers/video/fbdev/core/fbmem.c            |  1 +
 drivers/video/fbdev/core/svgalib.c          |  2 +-
 drivers/video/fbdev/hgafb.c                 |  2 +-
 drivers/video/fbdev/hitfb.c                 |  2 +-
 drivers/video/fbdev/kyro/fbdev.c            |  2 +-
 drivers/video/fbdev/matrox/matroxfb_accel.c |  8 ++-
 drivers/video/fbdev/matrox/matroxfb_base.h  |  6 +-
 drivers/video/fbdev/pm2fb.c                 |  1 +
 drivers/video/fbdev/pm3fb.c                 |  1 +
 drivers/video/fbdev/pvr2fb.c                |  1 +
 drivers/video/fbdev/s3fb.c                  |  1 +
 drivers/video/fbdev/sstfb.c                 |  2 +-
 drivers/video/fbdev/tdfxfb.c                |  2 +-
 drivers/video/fbdev/tridentfb.c             |  1 +
 drivers/video/fbdev/vga16fb.c               |  2 +-
 drivers/video/fbdev/vt8623fb.c              |  1 +
 drivers/video/fbdev/wmt_ge_rops.c           |  2 +
 include/linux/fb.h                          | 63 +++++----------------
 28 files changed, 52 insertions(+), 64 deletions(-)

-- 
2.40.0

