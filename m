Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C8FC433F5
	for <sparclinux@archiver.kernel.org>; Mon,  6 Sep 2021 23:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C2EF601FF
	for <sparclinux@archiver.kernel.org>; Mon,  6 Sep 2021 23:49:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbhIFXua (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Mon, 6 Sep 2021 19:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbhIFXu3 (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Mon, 6 Sep 2021 19:50:29 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22FC0C061575;
        Mon,  6 Sep 2021 16:49:24 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id o16-20020a9d2210000000b0051b1e56c98fso10599401ota.8;
        Mon, 06 Sep 2021 16:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=uCkVMuDBb5O5O3CJOrqaZb70Yl28I5zWeoqjnVjLs58=;
        b=csqSgWpxFBFJ4l55rE3JczcIdyrJ4w5O6JrGbON1nauTReBCfYtG+xbloOTCsVF7pb
         F5lgkUqx+liBB8ckCTBlhlZbrSp7rM33ojEEIZEcYYN9+aIXHusI7tfCK/xShtDkdmnX
         DjhL1hksyFooGJlip0Ath8ncvXQ9xaH5cby4cI56WBhEEm1j6X9DhJxC65B/e1HKtB4Z
         FPujGLK4HM4Ngt0aIKnTTRQOsnp4Fbl2XhNJokYdkO9BzELf+Gqd5++XFNgtbBSgHoPx
         rLkmpINfpHQDNXTJuO9MKNYhCVNSahFzVVsqR+ix+qYBuYl3DASieIQ6fINygXn4SEk+
         SuPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=uCkVMuDBb5O5O3CJOrqaZb70Yl28I5zWeoqjnVjLs58=;
        b=mRlToAJMHwtYJjXN35r1rczx5bLjypg2uJvFzBLA+sHlTXsN1B1czfii+PbyO+GcrM
         2uG5k06loRcjblGsODdOKwv+qbhldTYNLP4ZBURqES3QfZx1cKUz+fwrRUj9qRlQuPyY
         Yzw43QJ6l8Nv7Zq4PP8ARm+XuKKF2DspB6m9V5vNcgHDLSok6U3dkWW0SQCrVuzhkYiu
         DdUHX/HiCnVrTBIEvAudvgokGcqjyDZpTJbEI2TE+A9Q0yu1uxTa8J+pr5rYO6lFy+p2
         cI+xFT+u9IBqSqv0kl+M2BQ8/P5Z+Ky5YaU2CLMNqZ5SlWd32Rbf83QsZaGleZouPhXV
         PuBQ==
X-Gm-Message-State: AOAM5315pLZ/eUvV0STmvaiYGVI25aRg/tuOWhAvWTncfxWc1YKuoC+h
        pB10+hBmTcBntorqkMayv+g++QBhoLk=
X-Google-Smtp-Source: ABdhPJy/bX7INO/KsciNDJTGU3elaxSMxGvbL2W3qFOxzEL+uwBRquLZb2wEMUaBdXzNRNfK42//VQ==
X-Received: by 2002:a9d:d35:: with SMTP id 50mr12658813oti.22.1630972163297;
        Mon, 06 Sep 2021 16:49:23 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r20sm1919041oot.16.2021.09.06.16.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 16:49:22 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 6 Sep 2021 16:49:21 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-sparc <sparclinux@vger.kernel.org>
Subject: Re: [PATCH] Enable '-Werror' by default for all kernel builds
Message-ID: <20210906234921.GA1394069@roeck-us.net>
References: <20210906142615.GA1917503@roeck-us.net>
 <CAHk-=wgjTePY1v_D-jszz4NrpTso0CdvB9PcdroPS=TNU1oZMQ@mail.gmail.com>
 <c3790fb9-b83f-9596-18a1-21ace987c850@roeck-us.net>
 <CAHk-=wi4NW3NC0xWykkw=6LnjQD6D_rtRtxY9g8gQAJXtQMi8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wi4NW3NC0xWykkw=6LnjQD6D_rtRtxY9g8gQAJXtQMi8A@mail.gmail.com>
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Mon, Sep 06, 2021 at 04:06:04PM -0700, Linus Torvalds wrote:
> [ Adding some subsystem maintainers ]
> 
> On Mon, Sep 6, 2021 at 10:06 AM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > > But hopefully most cases are just "people haven't cared enough" and
> > > easily fixed.
> >
> > We'll see. For my testbed I disabled the new configuration flag
> > for the time being because its primary focus is boot tests, and
> > there won't be any boot tests if images fail to build.
> 
> Sure, reasonable.
> 
> I've checked a few of the build errors by doing the appropriate cross
> compiles, and it doesn't seem bad - but it does seem like we have a
> number of really pointless long-standing warnings that should have
> been fixed long ago.
> 
> For example, looking at sparc64, there are several build errors due to
> those warnings now being fatal:
> 
>  - drivers/gpu/drm/ttm/ttm_pool.c:386
> 
>    This is a type mismatch error. It looks like __fls() on sparc64
> returns 'int'. And the ttm_pool.c code assumes it returns 'unsigned
> long'.
> 
>    Oddly enough, the very line after that line does "min_t(unsigned
> int" to get the types in line.
> 
>    So  the immediate reason is "sparc64 is different". But the deeper
> reason seems to be that ttm_pool.c has odd type assumptions. But that
> warning should have been fixed long ago, either way.
> 
>    Christian/Huang? I get the feeling that both lines in that file
> should use the min_t(). Hmm?
> 
>  - drivers/input/joystick/analog.c:160
> 
>    #warning Precise timer not defined for this architecture.
> 
>    Unfortunate. I suspect that warning just has to be removed. It has
> never caused anything to be fixed, it's old to the point of predating
> the git history. Dmitry?
> 
My solution would be to just remove the old code (that isn't using ktime)
including the module parameter that disables it. Sure, we want to be
backward compatible, but that code is 15+ years old and should really be
retired.

>  - at least a couple of stringop-overread errors. Attached is a
> possible for for one of them.
> 
> The stringop overread is odd, because another one of them is
> 
>    fs/qnx4/dir.c: In function ‘qnx4_readdir’:
>    fs/qnx4/dir.c:51:32: error: ‘strnlen’ specified bound 48 exceeds
> source size 16 [-Werror=stringop-overread]
>       51 |                         size = strnlen(de->di_fname, size);
>          |                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> but I'm not seeing why that one happens on sparc64, but not on arm64
> or x86-64. There doesn't seem to be anything architecture-specific
> anywhere in that area.
> 
> Funky.
> 
Not really. That is because de->di_fname is always 16 bytes but size
can be 48 if the node is really a link. The use of de is overloaded
in that case; de is struct qnx4_inode_entry (where di_fname is 16 bytes)
but the actual data is struct qnx4_link_info where the name is 48 bytes
long. A possible fix (compile tested only) is below.

I think the warning/error is only reported with gcc 11.x. Do you possibly
use an older compiler for x86/arm64 ?

Anyway, below is a partial list of build errors I have seen. Some of
them are easy to fix (such as the ones due to unused functions),
but others seem to be tricky.

Guenter

---
diff --git a/fs/qnx4/dir.c b/fs/qnx4/dir.c
index a6ee23aadd28..f75dcadd98e5 100644
--- a/fs/qnx4/dir.c
+++ b/fs/qnx4/dir.c
@@ -44,20 +44,17 @@ static int qnx4_readdir(struct file *file, struct dir_context *ctx)
 				continue;
 			if (!(de->di_status & (QNX4_FILE_USED|QNX4_FILE_LINK)))
 				continue;
-			if (!(de->di_status & QNX4_FILE_LINK))
-				size = QNX4_SHORT_NAME_MAX;
-			else
-				size = QNX4_NAME_MAX;
-			size = strnlen(de->di_fname, size);
-			QNX4DEBUG((KERN_INFO "qnx4_readdir:%.*s\n", size, de->di_fname));
-			if (!(de->di_status & QNX4_FILE_LINK))
+			if (!(de->di_status & QNX4_FILE_LINK)) {
+				size = strnlen(de->di_fname, QNX4_SHORT_NAME_MAX);
 				ino = blknum * QNX4_INODES_PER_BLOCK + ix - 1;
-			else {
+			} else {
 				le  = (struct qnx4_link_info*)de;
+				size = strnlen(le->dl_fname, QNX4_NAME_MAX);
 				ino = ( le32_to_cpu(le->dl_inode_blk) - 1 ) *
 					QNX4_INODES_PER_BLOCK +
 					le->dl_inode_ndx;
 			}
+			QNX4DEBUG((KERN_INFO "qnx4_readdir:%.*s\n", size, de->di_fname));
 			if (!dir_emit(ctx, de->di_fname, size, ino, DT_UNKNOWN)) {
 				brelse(bh);
 				return 0;

---
alpha.log:arch/alpha/kernel/setup.c:493:13: error: 'strcmp' reading 1 or more bytes from a region of size 0 [-Werror=stringop-overread]
alpha.log:drivers/atm/ambassador.c:1747:58: error: passing argument 1 of 'virt_to_bus' discards 'volatile' qualifier from pointer target type [-Werror=discarded-qualifiers]
alpha.log:drivers/gpu/drm/rockchip/cdn-dp-core.c:1126:12: error: 'cdn_dp_resume' defined but not used [-Werror=unused-function]
alpha.log:drivers/net/ethernet/3com/3c515.c:1053:22: error: cast from pointer to integer of different size [-Werror=pointer-to-int-cast]
alpha.log:drivers/net/ethernet/amd/ni65.c:751:37: error: cast from pointer to integer of different size [-Werror=pointer-to-int-cast]
alpha.log:drivers/net/hamradio/6pack.c:71:41: error: unsigned conversion from 'int' to 'unsigned char' changes value from '256' to '0' [-Werror=overflow]
alpha.log:drivers/net/wan/lmc/lmc_main.c:1782:50: error: passing argument 1 of 'virt_to_bus' discards 'volatile' qualifier from pointer target type [-Werror=discarded-qualifiers]
alpha.log:drivers/net/wan/lmc/lmc_main.c:1791:53: error: passing argument 1 of 'virt_to_bus' discards 'volatile' qualifier from pointer target type [-Werror=discarded-qualifiers]
alpha.log:drivers/net/wan/lmc/lmc_main.c:1793:51: error: passing argument 1 of 'virt_to_bus' discards 'volatile' qualifier from pointer target type [-Werror=discarded-qualifiers]
alpha.log:drivers/net/wan/lmc/lmc_main.c:1804:50: error: passing argument 1 of 'virt_to_bus' discards 'volatile' qualifier from pointer target type [-Werror=discarded-qualifiers]
alpha.log:drivers/net/wan/lmc/lmc_main.c:1806:50: error: passing argument 1 of 'virt_to_bus' discards 'volatile' qualifier from pointer target type [-Werror=discarded-qualifiers]
alpha.log:drivers/net/wan/lmc/lmc_main.c:1807:51: error: passing argument 1 of 'virt_to_bus' discards 'volatile' qualifier from pointer target type [-Werror=discarded-qualifiers]
alpha.log:drivers/spi/spi-tegra20-slink.c:1188:12: error: 'tegra_slink_runtime_suspend' defined but not used [-Werror=unused-function]
alpha.log:drivers/spi/spi-tegra20-slink.c:1200:12: error: 'tegra_slink_runtime_resume' defined but not used [-Werror=unused-function]
alpha.log:fs/qnx4/dir.c:51:32: error: 'strnlen' specified bound 48 exceeds source size 16 [-Werror=stringop-overread]
m68k.log:./arch/m68k/include/asm/raw_io.h:20:19: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
m68k.log:./arch/m68k/include/asm/raw_io.h:30:32: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
m68k.log:./arch/m68k/include/asm/string.h:72:25: error: '__builtin_memcpy' reading 6 bytes from a region of size 0 [-Werror=stringop-overread]
m68k.log:arch/m68k/mvme147/config.c:174:2: error: #warning check me! [-Werror=cpp]
m68k.log:arch/m68k/mvme16x/config.c:439:2: error: #warning check me! [-Werror=cpp]
m68k.log:drivers/gpu/drm/rockchip/cdn-dp-core.c:1126:12: error: 'cdn_dp_resume' defined but not used [-Werror=unused-function]
m68k.log:drivers/input/joystick/analog.c:160:2: error: #warning Precise timer not defined for this architecture. [-Werror=cpp]
m68k.log:drivers/spi/spi-tegra20-slink.c:1188:12: error: 'tegra_slink_runtime_suspend' defined but not used [-Werror=unused-function]
m68k.log:drivers/spi/spi-tegra20-slink.c:1200:12: error: 'tegra_slink_runtime_resume' defined but not used [-Werror=unused-function]
mips.log:./arch/mips/include/asm/sibyte/bcm1480_scd.h:261: error: "M_SPC_CFG_CLEAR" redefined [-Werror]
mips.log:./arch/mips/include/asm/sibyte/bcm1480_scd.h:262: error: "M_SPC_CFG_ENABLE" redefined [-Werror]
mips.log:drivers/input/joystick/analog.c:160:2: error: #warning Precise timer not defined for this architecture. [-Werror=cpp]
ppc.log:drivers/net/ethernet/cirrus/cs89x0.c:897:41: error: implicit declaration of function 'isa_virt_to_bus' [-Werror=implicit-function-declaration]
riscv32.log:drivers/gpu/drm/rockchip/cdn-dp-core.c:1126:12: error: 'cdn_dp_resume' defined but not used [-Werror=unused-function]
riscv.log:drivers/gpu/drm/rockchip/cdn-dp-core.c:1126:12: error: 'cdn_dp_resume' defined but not used [-Werror=unused-function]
s390.log:arch/s390/kernel/syscall.c:168:1: error: '__do_syscall' uses dynamic stack allocation [-Werror]
s390.log:drivers/gpu/drm/rockchip/cdn-dp-core.c:1126:12: error: 'cdn_dp_resume' defined but not used [-Werror=unused-function]
s390.log:drivers/input/joystick/analog.c:160:2: error: #warning Precise timer not defined for this architecture. [-Werror=cpp]
s390.log:drivers/spi/spi-tegra20-slink.c:1188:12: error: 'tegra_slink_runtime_suspend' defined but not used [-Werror=unused-function]
s390.log:drivers/spi/spi-tegra20-slink.c:1200:12: error: 'tegra_slink_runtime_resume' defined but not used [-Werror=unused-function]
s390.log:lib/test_kasan.c:767:1: error: 'kasan_alloca_oob_left' uses dynamic stack allocation [-Werror]
s390.log:lib/test_kasan.c:782:1: error: 'kasan_alloca_oob_right' uses dynamic stack allocation [-Werror]
s390.log:s390-linux-objcopy: error: the input file 'arch/s390/boot/compressed/syms.bin' is empty
sparc64.log:arch/sparc/kernel/mdesc.c:647:22: error: 'strcmp' reading 1 or more bytes from a region of size 0 [-Werror=stringop-overread]
sparc64.log:arch/sparc/kernel/mdesc.c:692:22: error: 'strcmp' reading 1 or more bytes from a region of size 0 [-Werror=stringop-overread]
sparc64.log:arch/sparc/kernel/mdesc.c:719:21: error: 'strcmp' reading 1 or more bytes from a region of size 0 [-Werror=stringop-overread]
sparc64.log:drivers/input/joystick/analog.c:160:2: error: #warning Precise timer not defined for this architecture. [-Werror=cpp]
sparc64.log:fs/qnx4/dir.c:51:32: error: 'strnlen' specified bound 48 exceeds source size 16 [-Werror=stringop-overread]
sparc64.log:./include/linux/minmax.h:20:35: error: comparison of distinct pointer types lacks a cast [-Werror]
sparc.log:crypto/blake2b_generic.c:109:1: error: the frame size of 2288 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]
sparc.log:drivers/input/joystick/analog.c:160:2: error: #warning Precise timer not defined for this architecture. [-Werror=cpp]
sparc.log:drivers/spi/spi-tegra20-slink.c:1188:12: error: 'tegra_slink_runtime_suspend' defined but not used [-Werror=unused-function]
sparc.log:drivers/spi/spi-tegra20-slink.c:1200:12: error: 'tegra_slink_runtime_resume' defined but not used [-Werror=unused-function]
sparc.log:drivers/tty/serial/sunzilog.c:1128:13: error: 'sunzilog_putchar' defined but not used [-Werror=unused-function]
sparc.log:drivers/usb/host/ehci-hcd.c:1301: error: "PLATFORM_DRIVER" redefined [-Werror]
sparc.log:drivers/usb/host/ehci-sh.c:173:31: error: 'ehci_hcd_sh_driver' defined but not used [-Werror=unused-variable]
sparc.log:fs/qnx4/dir.c:51:32: error: 'strnlen' specified bound 48 exceeds source size 16 [-Werror=stringop-overread]
