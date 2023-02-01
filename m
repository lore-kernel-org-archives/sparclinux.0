Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45607C38142
	for <sparclinux@archiver.kernel.org>; Wed,  1 Feb 2023 00:00:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbjBAAA4 (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Tue, 31 Jan 2023 19:00:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbjBAAAu (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Tue, 31 Jan 2023 19:00:50 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF1FC67D
        for <sparclinux@vger.kernel.org>; Tue, 31 Jan 2023 16:00:42 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id hx15so26992541ejc.11
        for <sparclinux@vger.kernel.org>; Tue, 31 Jan 2023 16:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lRCOdD9CD/IiFJ43pipYPy+q1tidOpGH1rcqkIGuMSQ=;
        b=fL59Ab7RHJP0bfIYtovRgam/bmLVqgi/HuOZuRtvXpi8XPCKPsz19TVQkwQ/4pcElK
         nbpNee2j9nRk73RFGNcIlDQDDv7dgJ9GC8xvsYkG1wEa43drPEZkLrJIAfsAF0ElYFBV
         ZenNmi1Qr0FBP87JP4qtwax7RH2E68mH3aIp0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lRCOdD9CD/IiFJ43pipYPy+q1tidOpGH1rcqkIGuMSQ=;
        b=gUBGn4gHgz5YS1VIdEI+KaxQbaLm3X7cy8mh5BGOPskU2z5cVIxVLh83BBrtvqjGdb
         q9yU8E3frN04vvsoGnWoLhuv/d9wP2MbiYI4aVfUa214rBFWLWeRmORVT8QLmULv3gZ2
         6APADorYfH2jtx3aynOUXOlHosqdkqC1cWSPlw5emY5dNoSuftuPVi6VVOd0Qsr/9+q9
         vnt6ufP5F6fA6uirbDmPiqL/W8Z2Xjm+AU12w2SkxIr0LXk//agkVCKRFVFZChlHKPd4
         8ffk1safpRJUId8alhF4CsyGMGHICe471V+w2/rbY6qE35dmEbymLYmiYZLA/6Ft4UEa
         mTlQ==
X-Gm-Message-State: AO0yUKWWt9N75w9pU5905cV4bI+N394jtPcEc6MH6PBppXRzz1HfvqBt
        pM5/q97j+S1nXoJBTJwzcn1EUKpl2hLMR0oA1Xc=
X-Google-Smtp-Source: AK7set/hIXkwF94wlBbaOn9/1p1wN6HekzG0muZDGyt16eyWZNfkz83u15mJqs9EBP7alv8Nxz77jg==
X-Received: by 2002:a17:906:cc5a:b0:88c:f8a1:fc4a with SMTP id mm26-20020a170906cc5a00b0088cf8a1fc4amr261958ejb.9.1675209640888;
        Tue, 31 Jan 2023 16:00:40 -0800 (PST)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id q6-20020a1709064cc600b0084d494b24dcsm9083928ejt.161.2023.01.31.16.00.40
        for <sparclinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 16:00:40 -0800 (PST)
Received: by mail-ej1-f43.google.com with SMTP id m2so46068802ejb.8
        for <sparclinux@vger.kernel.org>; Tue, 31 Jan 2023 16:00:40 -0800 (PST)
X-Received: by 2002:a17:906:184a:b0:878:70c8:14f0 with SMTP id
 w10-20020a170906184a00b0087870c814f0mr84229eje.20.1675209639791; Tue, 31 Jan
 2023 16:00:39 -0800 (PST)
MIME-Version: 1.0
References: <Y9lz6yk113LmC9SI@ZenIV> <CAHk-=whf73Vm2U3jyTva95ihZzefQbThZZxqZuKAF-Xjwq=G4Q@mail.gmail.com>
 <Y9mD1qp/6zm+jOME@ZenIV> <CAHk-=wjiwFzEGd_60H3nbgVB=R_8KTcfUJmXy=hSXCvLrXQRFA@mail.gmail.com>
 <Y9mM5wiEhepjJcN0@ZenIV>
In-Reply-To: <Y9mM5wiEhepjJcN0@ZenIV>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 31 Jan 2023 16:00:22 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjNwwnBckTo8HLSdsd1ndoAR=5RBoZhdOyzhsnDAYWL9g@mail.gmail.com>
Message-ID: <CAHk-=wjNwwnBckTo8HLSdsd1ndoAR=5RBoZhdOyzhsnDAYWL9g@mail.gmail.com>
Subject: Re: [RFC][PATCHSET] VM_FAULT_RETRY fixes
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Peter Xu <peterx@redhat.com>, linux-arch@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        Michal Simek <monstr@monstr.eu>,
        Dinh Nguyen <dinguyen@kernel.org>,
        openrisc@lists.librecores.org, linux-parisc@vger.kernel.org,
        linux-riscv@lists.infradead.org, sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Tue, Jan 31, 2023 at 1:49 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Everything else seems to be going with EFAULT.

So I think fo kernel faults it's always basically up to the exception
handler, and sending a signal regardless of that is just wrong.

Of course, an exception handler might choose to send a signal, but it
just shouldn't be the do_page_fault() handler that does it.

For user faults, I think the rule ends up being that "if there's no
mapping, or if there is a protection fault, then we should do
SIGSEGV".

If there's an actual mapping in place, and the mapping has the right
permissions for the access, but fails for some *other* reason, then we
send SIGBUS.

So a shared mmap past the end of the file (but within the area that
was used for mmap) would SIGBUS, while a write to a read-only mapping
would SIGSEGV.

Things like unaligned accesses also might SIGBUS rather than SIGSEGV.

And I'm not surprised that there are exceptions to the rule, because
almost nothing really cares. In most situations, it's a fatal error.
And even when catching them, the end result is generally the same
(either "print out helpful message and die", or "longjump to some safe
code").

So most of the time it's probably not going to matter all that much
which signal gets sent in practice.

            Linus
