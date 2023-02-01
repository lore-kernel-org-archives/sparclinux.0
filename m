Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3135C636CC
	for <sparclinux@archiver.kernel.org>; Wed,  1 Feb 2023 00:51:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231685AbjBAAu7 (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Tue, 31 Jan 2023 19:50:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231675AbjBAAu6 (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Tue, 31 Jan 2023 19:50:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 603761633C
        for <sparclinux@vger.kernel.org>; Tue, 31 Jan 2023 16:50:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675212611;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M3PuwOvU6J6nuZvtVe/S589vQXmh8GCRArFcGV4OQfw=;
        b=cCEdodcfUbhFxrJpd+1s9CZW45YIPdLHi/a1vE9806wd4Cc4KMmUqJmuZjHJjwFARGjQNX
        bFFqKvvq/WuJSW7e7je/Ar5nWt0emrKRpzJb9XWVlpT8BeF0X1sHUSlm5OD11MEQmi0JL6
        lIODeFTgSoY0VYzNTLm7pYl31fTq6KY=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-655-b1p0KpAGNoitPJM58-CRIg-1; Tue, 31 Jan 2023 19:50:10 -0500
X-MC-Unique: b1p0KpAGNoitPJM58-CRIg-1
Received: by mail-qt1-f200.google.com with SMTP id bs11-20020ac86f0b000000b003b9b4ec27c4so1300460qtb.19
        for <sparclinux@vger.kernel.org>; Tue, 31 Jan 2023 16:50:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M3PuwOvU6J6nuZvtVe/S589vQXmh8GCRArFcGV4OQfw=;
        b=Jhg24d8tH92c3HSvQ3AERHZHq54tMW+ZNdPRaF0jGfC0q1NXAvuiKfv664hxbPyRYg
         J8ekjryi6+fCzxOjWS9LJPsXnP/s6tkUsJAJJylrnkSPba0/O0Qf3SSoOjm4NH8efQ+T
         BDEC1U/O1nXe4b5LmBzVEV3oE42nTb6P7ps8CjK24t+AD/zQR8hOtfN61RRuZwNzi1RQ
         sWecYmFOBfl4ceNixXHPzE2Eu/EMtCeBF2KXFx8HAa3ewtaFq1YzJxgaOxFikERQJOMN
         UwTMVeLO+euGIhthZK1PxSmErdH6bSAwTlakMhoTi2RWMmbRCxmCagT3TmjquX+8E3Hj
         x3fg==
X-Gm-Message-State: AO0yUKWyyVu+ZMmv8U9Cx3tYtago2fA5egTYbIPHgby77VZLnSqwUmSB
        eHwrjq1AOdPfWE9L+qUCgtWqYOCvisDfkc0DsYoyZxrx0yJ3vYeGmaKSRgCRBufg+NxXiApbxiB
        3y5VmmS4SjbJzzBFskQBfzQ==
X-Received: by 2002:a0c:cd12:0:b0:537:7bd7:29d8 with SMTP id b18-20020a0ccd12000000b005377bd729d8mr1432009qvm.5.1675212609928;
        Tue, 31 Jan 2023 16:50:09 -0800 (PST)
X-Google-Smtp-Source: AK7set/MlnTC6C7olo0qdiEsPNhEql51dxyDlFlECbadqTZe8CjHAaRAUKN77oNmyjDdy8XaTsGJlg==
X-Received: by 2002:a0c:cd12:0:b0:537:7bd7:29d8 with SMTP id b18-20020a0ccd12000000b005377bd729d8mr1431989qvm.5.1675212609617;
        Tue, 31 Jan 2023 16:50:09 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id 10-20020a370b0a000000b007203bbbbb31sm4543664qkl.47.2023.01.31.16.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 16:50:08 -0800 (PST)
Date:   Tue, 31 Jan 2023 19:50:05 -0500
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        sparclinux@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>, Hev <r@hev.cc>,
        Anatoly Pugachev <matorola@gmail.com>,
        Raghavendra K T <raghavendra.kt@amd.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH v1] sparc/mm: don't unconditionally set HW writable bit
 when setting PTE dirty on 64bit
Message-ID: <Y9m3PaiU2+YtLIJR@x1n>
References: <20221212130213.136267-1-david@redhat.com>
 <671d9bbb-0f19-2710-00ef-47734085dddc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <671d9bbb-0f19-2710-00ef-47734085dddc@redhat.com>
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Tue, Jan 31, 2023 at 09:47:01AM +0100, David Hildenbrand wrote:
> On 12.12.22 14:02, David Hildenbrand wrote:
> > On sparc64, there is no HW modified bit, therefore, SW tracks via a SW
> > bit if the PTE is dirty via pte_mkdirty(). However, pte_mkdirty()
> > currently also unconditionally sets the HW writable bit, which is wrong.
> > 
> > pte_mkdirty() is not supposed to make a PTE actually writable, unless the
> > SW writable bit (pte_write()) indicates that the PTE is not
> > write-protected. Fortunately, sparc64 also defines a SW writable bit.
> > 
> > For example, this already turned into a problem in the context of
> > THP splitting as documented in commit 624a2c94f5b7 ("Partly revert "mm/thp:
> > carry over dirty bit when thp splits on pmd") and might be an issue during
> > page migration in mm/migrate.c:remove_migration_pte() as well where we:
> > 	if (folio_test_dirty(folio) && is_migration_entry_dirty(entry))
> > 		pte = pte_mkdirty(pte);
> > 
> > But more general, anything like:
> > 	maybe_mkwrite(pte_mkdirty(pte), vma)
> > code is broken on sparc64, because it will unconditionally set the HW
> > writable bit even if the SW writable bit is not set.
> > 
> > Simple reproducer that will result in a writable PTE after ptrace
> > access, to highlight the problem and as an easy way to verify if it has
> > been fixed:
> > 
> > --------------------------------------------------------------------------
> >   #include <fcntl.h>
> >   #include <signal.h>
> >   #include <unistd.h>
> >   #include <string.h>
> >   #include <errno.h>
> >   #include <stdlib.h>
> >   #include <sys/mman.h>
> > 
> >   static void signal_handler(int sig)
> >   {
> >           if (sig == SIGSEGV)
> >                   printf("[PASS] SIGSEGV generated\n");
> >           else
> >                   printf("[FAIL] wrong signal generated\n");
> >           exit(0);
> >   }
> > 
> >   int main(void)
> >   {
> >           size_t pagesize = getpagesize();
> >           char data = 1;
> >           off_t offs;
> >           int mem_fd;
> >           char *map;
> >           int ret;
> > 
> >           mem_fd = open("/proc/self/mem", O_RDWR);
> >           if (mem_fd < 0) {
> >                   fprintf(stderr, "open(/proc/self/mem) failed: %d\n", errno);
> >                   return 1;
> >           }
> > 
> >           map = mmap(NULL, pagesize, PROT_READ, MAP_PRIVATE|MAP_ANON, -1 ,0);
> >           if (map == MAP_FAILED) {
> >                   fprintf(stderr, "mmap() failed: %d\n", errno);
> >                   return 1;
> >           }
> > 
> >           printf("original: %x\n", *map);
> > 
> >           /* debug access */
> >           offs = lseek(mem_fd, (uintptr_t) map, SEEK_SET);
> >           ret = write(mem_fd, &data, 1);
> >           if (ret != 1) {
> >                   fprintf(stderr, "pwrite(/proc/self/mem) failed with %d: %d\n", ret, errno);
> >                   return 1;
> >           }
> >           if (*map != data) {
> >                   fprintf(stderr, "pwrite(/proc/self/mem) not visible\n");
> >                   return 1;
> >           }
> > 
> >           printf("ptrace: %x\n", *map);
> > 
> >           /* Install signal handler. */
> >           if (signal(SIGSEGV, signal_handler) == SIG_ERR) {
> >                   fprintf(stderr, "signal() failed\n");
> >                   return 1;
> >           }
> > 
> >           /* Ordinary access. */
> >           *map = 2;
> > 
> >           printf("access: %x\n", *map);
> > 
> >           printf("[FAIL] SIGSEGV not generated\n");
> > 
> >           return 0;
> >   }
> > --------------------------------------------------------------------------
> > 
> > Without this commit (sun4u in QEMU):
> > 	# ./reproducer
> > 	original: 0
> > 	ptrace: 1
> > 	access: 2
> > 	[FAIL] SIGSEGV not generated
> > 
> > Let's fix this by setting the HW writable bit only if both, the SW dirty
> > bit and the SW writable bit are set. This matches, for example, how
> > s390x handles pte_mkwrite() and pte_mkdirty() -- except, that they have
> > to clear the _PAGE_PROTECT bit.
> > 
> > We have to move pte_dirty() and pte_dirty() up. The code patching
> > mechanism and handling constants > 22bit is a bit special on sparc64.
> > 
> > With this commit (sun4u in QEMU):
> > 	# ./reproducer
> > 	original: 0
> > 	ptrace: 1
> > 	[PASS] SIGSEGV generated
> > 
> > This handling seems to have been in place forever.
> > 
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: "David S. Miller" <davem@davemloft.net>
> > Cc: Peter Xu <peterx@redhat.com>
> > Cc: Hev <r@hev.cc>
> > Cc: Anatoly Pugachev <matorola@gmail.com>
> > Cc: Raghavendra K T <raghavendra.kt@amd.com>
> > Cc: Thorsten Leemhuis <regressions@leemhuis.info>
> > Cc: Mike Kravetz <mike.kravetz@oracle.com>
> > Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> > Cc: Juergen Gross <jgross@suse.com>
> > Signed-off-by: David Hildenbrand <david@redhat.com>
> > ---
> 
> Ping

I agree with David that the current sparc64 impl of pte_mkdirty is
suspecious.

What David mentioned on page migration above is correct and has another
report here from Nick recently:

https://lore.kernel.org/all/CADyTPEzsvdRC15+Z5T3oryofwRYqHmHzwqRmJKJoHB3d7Tdayw@mail.gmail.com/

If this patch is hopefully correct (which I cannot tell as I know little on
sparc64) and can be merged, it'll be the cleanest solution, comparing to
what I provided here:

https://lore.kernel.org/all/Y9bvwz4FIOQ+D8c4@x1n/

And I assume it'll also fix things like the reproducer being attached on
wrongly applying write bit with FOLL_FORCE, so it fixes more than that.

I plan to keep posting that fix I referenced above for the breakage because
that'll still be the safest so far, but that can change if someone from
sparc64 can have a look at this and ack it.

Thanks,

-- 
Peter Xu

