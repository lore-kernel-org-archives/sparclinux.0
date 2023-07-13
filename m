Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23C86C0015E
	for <sparclinux@archiver.kernel.org>; Thu, 13 Jul 2023 16:55:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231783AbjGMQzc (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Thu, 13 Jul 2023 12:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbjGMQzb (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Thu, 13 Jul 2023 12:55:31 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D218026BB
        for <sparclinux@vger.kernel.org>; Thu, 13 Jul 2023 09:55:30 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1b8baa836a5so7421815ad.1
        for <sparclinux@vger.kernel.org>; Thu, 13 Jul 2023 09:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689267330; x=1691859330;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mkaGpz0HgmAYOX7U+wy0aaz4NPPSIRJNciFQzG/7LfI=;
        b=TZwe67oMehoOCnv+us7BR5JF/AE7LNBrg3r4pPZC7R7ZDhK9jO8UgFk1hggi+qRHiC
         ULJ1W2JSep57OckV9Rxdvk+fD9ZkqtvOm4L9za8ck5FAxDtBDN25sMyCM7JfUKCKKd6+
         6xNlHm6nOqyTfi2kF55UuYLEAUfJ+gleTI7oI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689267330; x=1691859330;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mkaGpz0HgmAYOX7U+wy0aaz4NPPSIRJNciFQzG/7LfI=;
        b=JnSN+hQRyDNf2RtnxjLKGvRL8xOM/wmfO9B846BXFnUC4Q1qZmFmCI7AlTaQQVvQl3
         iBXfXqIdASZV4EH3DUI5oMgDFA6JSt38FQyPDPVQ2g8PSzDweslR8d9PDxMPLXgMp1vc
         fCkqIAmROEZEJ0k1oLyIDcNbLFN7z4m//3fekoCGojt/xIGJ3VwqzQDXs1KL6O/c6JRL
         ABuGZxAX9NIz6u2AHdktWmn2/uP2CjnTNWn1PHaiqvqPa3kTyxcJszQ9g6AFoi/cKWil
         2Wbp6CAfH5cox1UZNcMwxRoJnFtRMrPQU2BuQXU+8hPxGQdIv/RN0NrkNJwzEEvRz8FS
         vjKg==
X-Gm-Message-State: ABy/qLaF+Yy4owgEmvvSI13FKJTvQ/TPFfe4kTe+aSjH4uSOexN1YFvp
        nFG/ZKfVbdYlpFB39D4Sc3trtA==
X-Google-Smtp-Source: APBJJlGUMvPiyI11Rk2nFE7Fa7XTV582GqL0E8iCmkPFcMQEFTVDRfoAVDOCrL2Q+fvQpoEFCrkVwA==
X-Received: by 2002:a17:902:dad2:b0:1b8:b3f7:4872 with SMTP id q18-20020a170902dad200b001b8b3f74872mr2684402plx.28.1689267330307;
        Thu, 13 Jul 2023 09:55:30 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id jh6-20020a170903328600b001b8b26fa6a9sm6211880plb.19.2023.07.13.09.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 09:55:29 -0700 (PDT)
Date:   Thu, 13 Jul 2023 09:55:29 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, arnd@kernel.org,
        davem@davemloft.net, peterz@infradead.org,
        Arnd Bergmann <arnd@arndb.de>, linux@roeck-us.net,
        geert@linux-m68k.org, mingo@kernel.org, andi.shyti@linux.intel.com,
        andrzej.hajda@intel.com, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sparc: mark __arch_xchg() as __always_inline
Message-ID: <202307130954.562F14E@keescook>
References: <ZJwdZ_cStUp0cXyS@FVFF77S0Q05N>
 <mhng-0bca249b-95f1-4e3f-b241-f37835e1c623@palmer-ri-x1c9a>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-0bca249b-95f1-4e3f-b241-f37835e1c623@palmer-ri-x1c9a>
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Thu, Jul 13, 2023 at 07:00:37AM -0700, Palmer Dabbelt wrote:
> On Wed, 28 Jun 2023 04:45:43 PDT (-0700), Mark Rutland wrote:
> > On Wed, Jun 28, 2023 at 11:49:18AM +0200, Arnd Bergmann wrote:
> > > From: Arnd Bergmann <arnd@arndb.de>
> > > 
> > > An otherwise correct change to the atomic operations uncovered an
> > > existing bug in the sparc __arch_xchg() function, which is calls
> > > __xchg_called_with_bad_pointer() when its arguments are unknown at
> > > compile time:
> > > 
> > > ERROR: modpost: "__xchg_called_with_bad_pointer" [lib/atomic64_test.ko] undefined!
> > > 
> > > This now happens because gcc determines that it's better to not inline the
> > > function. Avoid this by just marking the function as __always_inline
> > > to force the compiler to do the right thing here.
> > > 
> > > Reported-by: Guenter Roeck <linux@roeck-us.net>
> > > Link: https://lore.kernel.org/all/c525adc9-6623-4660-8718-e0c9311563b8@roeck-us.net/
> > > Fixes: d12157efc8e08 ("locking/atomic: make atomic*_{cmp,}xchg optional")
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > 
> > Aha; you saved me writing a patch! :)
> > 
> > We should probably do likewise for all the other bits like __cmpxchg(), but
> > either way:
> > 
> > Acked-by: Mark Rutland <mark.rutland@arm.com>
> 
> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
> 
> Though I'm not sure that means a whole lot over here ;)

I've carried some other sparc stuff before. I can send this to Linus
with other fixes.

-- 
Kees Cook
