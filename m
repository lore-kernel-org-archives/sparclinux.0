Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C50B8C433EF
	for <sparclinux@archiver.kernel.org>; Fri, 10 Jun 2022 16:33:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346465AbiFJQdy (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Fri, 10 Jun 2022 12:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349687AbiFJQde (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Fri, 10 Jun 2022 12:33:34 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3514F57105
        for <sparclinux@vger.kernel.org>; Fri, 10 Jun 2022 09:33:15 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id r3so13708026ybr.6
        for <sparclinux@vger.kernel.org>; Fri, 10 Jun 2022 09:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bhv02q67MOioDvIeN4y+a/ybeIh94RUFpBdk0EW721Q=;
        b=gTSqAdTJjftykkKV3LvI3BgIEdnFPO1tIX2Ja3yrYtQNH7qkYO5md+ofkXUFp0r5AW
         G6gcWOkM0lg+gYk1xVlJLK69IVjiD2uEY/paaLVpsJSAUJr3ix3CnTM3jTjnVHIGrITZ
         8qOTeStSyYFo4Xt1uIWq/JcAZJafn7HdU8yhoSTqaMMSwSE/odkOqaPLeyUKWL5sO4fY
         YvCEOzFgGYsioj0kFMpYKr9Y6KDxyzq/x30hfjgDctRhz4XpICUW+ZTe11KlQpTSKF0Q
         MmwpTmp6Vj4zz6mr/A1YZvGF2iMEYWObj9GWEHshf9njpmcmcbzr60kAblJRSOIE1DnE
         +7SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bhv02q67MOioDvIeN4y+a/ybeIh94RUFpBdk0EW721Q=;
        b=YlBzVYrOctZDl68lAC647tBiqea5LcU5CeRjuuuciRYcXEbgstGz0M7ikbqo9zaiLU
         uKapo+wJMXVL/xBw8WfeM4ioW2crseEKebpWhxoImnSOETkBODEOx3MXlQGd5cOZt77g
         5/euYYacI+c/Ci5Rgn0xBc5h+KRvp6jW4YD9jLFKM4qXie4/8LIAR7/Ctcg85yAypvmw
         ebJ5UhHcg3f5PQ1L9fPZ8yPQi3KIP9kKGRciZCUZ8QC6JEU9eZ3S7s2PbnCaiDf233d2
         fdv3NlaBjlAeVHOwaOSM9iutcUIOzxxVJ1rxVoxVPN57vRv6rKXyGxjRx89vmcMU0YXm
         pbTw==
X-Gm-Message-State: AOAM533GSPYIje0bNs0SbywMwl4mkb1T2GL9Gy4haJ/XboyF6ozU7JrC
        Gm0+BoPKNFr1PhIC2uomsgXMxoMkzgT14b4aS9LnQA==
X-Google-Smtp-Source: ABdhPJyJqY4ELta1f6MtdpBF9FmmN+1Swnl8abwrpU7Envy5QN/0+FxiY8CXqHJVU09kzIn9KX5saZ7waQDwoeJx/U8=
X-Received: by 2002:a05:6902:102c:b0:663:32b8:4b24 with SMTP id
 x12-20020a056902102c00b0066332b84b24mr37019234ybt.1.1654878793763; Fri, 10
 Jun 2022 09:33:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220610113427.908751-1-alexandr.lobakin@intel.com>
 <20220610113427.908751-3-alexandr.lobakin@intel.com> <YqNMO0ioGzJ1IkoA@smile.fi.intel.com>
 <22042c14bc6a437d9c6b235fbfa32c8a@intel.com>
In-Reply-To: <22042c14bc6a437d9c6b235fbfa32c8a@intel.com>
From:   Marco Elver <elver@google.com>
Date:   Fri, 10 Jun 2022 18:32:36 +0200
Message-ID: <CANpmjNNZAeMQjzNyXLeKY4cp_m-xJBU1vs7PgT+7_sJwxtEEAg@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] bitops: always define asm-generic non-atomic bitops
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Lobakin, Alexandr" <alexandr.lobakin@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Yury Norov <yury.norov@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matt Turner <mattst88@gmail.com>,
        Brian Cain <bcain@quicinc.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Kees Cook <keescook@chromium.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
        "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Fri, 10 Jun 2022 at 18:02, Luck, Tony <tony.luck@intel.com> wrote:
>
> > > +/**
> > > + * generic_test_bit - Determine whether a bit is set
> > > + * @nr: bit number to test
> > > + * @addr: Address to start counting from
> > > + */
> >
> > Shouldn't we add in this or in separate patch a big NOTE to explain that this
> > is actually atomic and must be kept as a such?
>
> "atomic" isn't really the right word. The volatile access makes sure that the
> compiler does the test at the point that the source code asked, and doesn't
> move it before/after other operations.

It's listed in Documentation/atomic_bitops.txt.

It is as "atomic" as READ_ONCE() or atomic_read() is. Though you are
right that the "atomicity" of reading one bit is almost a given,
because we can't really read half a bit.
The main thing is that the compiler keeps it "atomic" and e.g. doesn't
fuse the load with another or elide it completely, and then transforms
the code in concurrency-unfriendly ways.

Like READ_ONCE() and friends, test_bit(), unlike non-atomic bitops,
may also be used to dependency-order some subsequent marked (viz.
atomic) operations.

> But there is no such thing as an atomic test_bit() operation:
>
>         if (test_bit(5, addr)) {
>                 /* some other CPU nukes bit 5 */
>
>                 /* I know it was set when I looked, but now, could be anything */

The operation itself is atomic, because reading half a bit is
impossible. Whether or not that bit is modified concurrently is a
different problem.

Thanks,
-- Marco
