Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E43C6FA99
	for <sparclinux@archiver.kernel.org>; Tue,  7 Mar 2023 01:33:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjCGBdR (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Mon, 6 Mar 2023 20:33:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbjCGBco (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Mon, 6 Mar 2023 20:32:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0571855079
        for <sparclinux@vger.kernel.org>; Mon,  6 Mar 2023 17:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678152652;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A8ahPZDaVvcIaob1vmzodN2QF3Hw6BRjjqbc38rwl/Q=;
        b=O+5u2ExgaOEshTO2YlxXEqsOYa9P8aLq+BzqYmkLgDP4hjQfWutktreaxOZGpZwr43cMke
        9yPlGUQ9I3qKMYepfg9uo34rtnrrRWjhZyV4eYuEaC7QA8N9UrWqm5sPzup6mCSHHMo1Mx
        ZL83l03NTiRK36rVWF+00Z6FDBfOcaE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-607-q-PJP5gANaiVF8sVjYLtpg-1; Mon, 06 Mar 2023 20:30:49 -0500
X-MC-Unique: q-PJP5gANaiVF8sVjYLtpg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9974385CBE0;
        Tue,  7 Mar 2023 01:30:48 +0000 (UTC)
Received: from localhost (ovpn-12-63.pek2.redhat.com [10.72.12.63])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D0E44492C3E;
        Tue,  7 Mar 2023 01:30:47 +0000 (UTC)
Date:   Tue, 7 Mar 2023 09:30:43 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-sh@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        linux-mm@kvack.org, Luis Chamberlain <mcgrof@kernel.org>,
        linux-parisc@vger.kernel.org, linux-alpha@vger.kernel.org,
        sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 2/2] arch/*/io.h: remove ioremap_uc in some
 architectures
Message-ID: <ZAaTw+841xBsz/m9@MiWiFi-R3L-srv>
References: <20230303102817.212148-1-bhe@redhat.com>
 <20230303102817.212148-3-bhe@redhat.com>
 <87sfej1rie.fsf@mpe.ellerman.id.au>
 <CAMuHMdXoM24uAZGcjBtscNMOSY_+4u08PEOR7gOfCH7jvCceDg@mail.gmail.com>
 <5dec69d0-0bc9-4f6c-8d0d-ee5422783100@app.fastmail.com>
 <87jzzt1ioc.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87jzzt1ioc.fsf@mpe.ellerman.id.au>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On 03/07/23 at 11:58am, Michael Ellerman wrote:
> "Arnd Bergmann" <arnd@arndb.de> writes:
> > On Sun, Mar 5, 2023, at 10:29, Geert Uytterhoeven wrote:
> >> On Sun, Mar 5, 2023 at 10:23 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
> >>> Maybe that exact code path is only reachable on x86/ia64? But if so
> >>> please explain why.
> >>>
> >>> Otherwise it looks like this series could break that driver on powerpc
> >>> at least.
> >>
> >> Indeed.
> >
> > When I last looked into this, I sent a patch to use ioremap()
> > on non-x86:
> >
> > https://lore.kernel.org/all/20191111192258.2234502-1-arnd@arndb.de/
> 
> OK thanks.
> 
> Baoquan can you add that patch to the start of this series if/when you
> post the next version?

Sure, will do. Wondering if we need make change to cover powerpc other
than x86 and ia64 in Arnd's patch as you and Geert pointed out.

