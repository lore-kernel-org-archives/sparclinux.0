Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E74AC433F5
	for <sparclinux@archiver.kernel.org>; Tue, 21 Sep 2021 02:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80F9660FC1
	for <sparclinux@archiver.kernel.org>; Tue, 21 Sep 2021 02:38:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351306AbhIUCjc (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Mon, 20 Sep 2021 22:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243769AbhIUCbL (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Mon, 20 Sep 2021 22:31:11 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA42C04A155
        for <sparclinux@vger.kernel.org>; Mon, 20 Sep 2021 13:11:53 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id e15so33649350lfr.10
        for <sparclinux@vger.kernel.org>; Mon, 20 Sep 2021 13:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VJRE9kS/QPf/0tOqznxzvGRA8erQC6C/9CuG+/yz+9U=;
        b=MjF/lwuc6mPv7nAhg2ZP9d30rlvilAFvjKmYIG8K/nAhbMgJRIcrN70sahLhELV4NY
         uJMN/H9Eb+TGaf8vH+d6MIDjEqr8JeeHKbNJeW1urY2uxDdTgMkADNmigKMnbr6Ri8D8
         J+BrPizNwPAYdm66/8hXK2c/1vjtRzwGGDMjU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VJRE9kS/QPf/0tOqznxzvGRA8erQC6C/9CuG+/yz+9U=;
        b=E3eFBA+4ojQKVoezCWeP22l/4zWbsY4VhQcLaoBJRiKlh8BKho0GZqMN76MOuht4sb
         SmZItzPa6PxQbjFEKL+FKy6580T9ERBDjLQ0KkaeBQs+oLP+krXtNvjvOt6gPkhchcE+
         Z2xrfnkiEQq0H6JCf4zNldbRhOYvFFTMzIc2Rbvjm7BrXZJCzXtUPXkQLlICg857kUKj
         Qt5I1/zoN7A68JkfHjnPOTPt+ss46DqANSIVhIyewYz3s+kAmbxeFKKlVxvJnnxgd/8C
         xVesCvp9P71GZ1Uty+bjJjgYWYEpkEB6r6RUYU10bTFy6ksAUMQqrbGqVz4zFiu3PjS7
         ZPmg==
X-Gm-Message-State: AOAM530HBi1zqXU/oOLoRAd7vvWFfnK5E3wQLqYQhVXxSlCi2XVbHJh9
        AqrrYGiTmvfXAmMMxWoe675/3kopJCe1gTyJ42A=
X-Google-Smtp-Source: ABdhPJzOLyn2QP7lkbb74ZwrNPrZAZPMGF7n6HeBzKwoqXkXBvyR0457ZAVk1ivBXuhxERi7QDUrOw==
X-Received: by 2002:ac2:4e04:: with SMTP id e4mr16667967lfr.262.1632168711101;
        Mon, 20 Sep 2021 13:11:51 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id o9sm210536lfl.280.2021.09.20.13.11.49
        for <sparclinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Sep 2021 13:11:49 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id p29so71670042lfa.11
        for <sparclinux@vger.kernel.org>; Mon, 20 Sep 2021 13:11:49 -0700 (PDT)
X-Received: by 2002:a2e:3309:: with SMTP id d9mr12260277ljc.249.1632168709492;
 Mon, 20 Sep 2021 13:11:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wirexiZR+VO=H3xemGKOMkh8OasmXaKXTKUmAKYCzi8AQ@mail.gmail.com>
 <20210920134424.GA346531@roeck-us.net> <CAHk-=wgheheFx9myQyy5osh79BAazvmvYURAtub2gQtMvLrhqQ@mail.gmail.com>
 <CAHk-=wgnSFePkt9_TxgdgFvMz6ZyofLFQLuV_Tc7MQVXYdgSng@mail.gmail.com> <715c52e6-9a71-6924-0643-407311ad56ba@physik.fu-berlin.de>
In-Reply-To: <715c52e6-9a71-6924-0643-407311ad56ba@physik.fu-berlin.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 20 Sep 2021 13:11:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjcCZW-Lu85djtfDSiQdOqH1hR=dDP5xHj6vhvMdBCMVA@mail.gmail.com>
Message-ID: <CAHk-=wjcCZW-Lu85djtfDSiQdOqH1hR=dDP5xHj6vhvMdBCMVA@mail.gmail.com>
Subject: Re: Linux 5.15-rc2
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-sparc <sparclinux@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Mon, Sep 20, 2021 at 12:14 PM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
>
> If you want to get feedback whether the kernel actually boots, let me know.

So having looked around more sparc64 actually looks to be ok as-is,
because it doesn't do any ioremap at all, and the PIO accesses are
done at physical address zero.

Sparc uses a special IO memory address space and can basically map all
of PCI that way, and it looks like the hardware does all the required
special things for the PIO range at address 0-0xffff.

So it turns out that the "missing iounmap()" is actually ok on sparc,
because it's a no-op anyway - because the ioremap() was just a pointer
cast with no actual remapping necessary.

And the generic IOMAP thing does assume that PIO is special, in ways
that sparc doesn't need. On x86, PIO is not remapped, but also uses
different instructions, so it's not just pointer games that could be
done at iomap/unmap case.

(And on many other architectures you need to do different
synchronization, even if you could perhaps otherwise make the
PIO-vs-MMIO be only about the pointer mapping - so "writeb()" and
"outb()" aren't just different in the addressing).

End result: the only downside of sparc not using the generic iomap is
likely that sparc will happily use a NULL __iomap pointer (error) and
basically use it as a PIO access. But since other architectures like
x86-64 would warn for that case (see 'bad_io_access()' in
lib/iomap.c), even that isn't actually a big deal - any such bugs
would have been found elsewhere.

And having looked at this, I'm starting to suspect that sparc oddity
is _why_ the fallback version in <asm-generic/io.h> was so broken. It
did the right thing on sparc, but leaks iomap remappings almost
anywhere else. But maybe sparc ended up being the only user of it?

           Linus
