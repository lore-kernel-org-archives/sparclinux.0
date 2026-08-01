Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C2A2E1722
	for <sparclinux@vger.kernel.org>; Sat,  1 Aug 2026 19:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785611173; cv=none; b=FyV4WWWFCkTE6VSzGv7+4WUsQWnBpoGKGrSPnm7O9llHqzPp08eW9qaWytXuvKUkPNOUqkCurpRTCYOqv2TjxQtVez5A/0MUk1f8PF4ofmrJNQUM6th+gzxGfA9BUTYp5DnmSgIRkyJnrnEHr4Fo/EwOzb1By7pBwdHL4BwMQGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785611173; c=relaxed/simple;
	bh=JfA63bVoJlhWlwNOcOQ1fpfE4UhF15SjUkvaUBaVdls=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=dxGnWNG9dRk729sPbbgfFm0GgpJBATXlxoIuN0EOmKxa0GVUitVt3IcoGHhd8CptXqCtOCdKL1hB/YLZUwCBoAbtp2aGUuWRK32Ma5zzyuI3Mdi6dx9NkrAziEEtmrix6T8z9//BXmXWMzvhRBM1rCOitWKone3T5zqQgBYtJ2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=KcR4Ag30; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KcR4Ag30"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F5921F00AC4;
	Sat,  1 Aug 2026 19:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1785611171;
	bh=/jRl03g1jUXCa0izU8Qj8LdKNePNcVRPBMQzxL9uDZY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=KcR4Ag30xihbWbkaxsf0xcyba3xjWFnNP9Weyb5yFkv2wbNyKZTmaiFuqT1hEXRuY
	 KCxABNWSCVmJGUNPlaIKSO7QeCnKoii7ICpYJAw3JS7JNhLGyI9rIgrOoySkFByWIh
	 6SJX+OmNTkHfuyvc30/9yDs4oANeZVzNmfhhCP2Q=
Date: Sat, 1 Aug 2026 12:06:10 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: alex@alexrp.com
Cc: linux-mm@kvack.org, Andreas Larsson <andreas@gaisler.com>,
 sparclinux@vger.kernel.org
Subject: Re: [Bug 221820] New: sparc64 mmap() returns EINVAL for
 non-MAP_FIXED hint within VA_EXCLUDE_START...END
Message-Id: <20260801120610.10908474cd8e554947a64417@linux-foundation.org>
In-Reply-To: <bug-221820-27@https.bugzilla.kernel.org/>
References: <bug-221820-27@https.bugzilla.kernel.org/>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


(switched to email.  Please respond via emailed reply-to-all, not via the
bugzilla web interface).


On Sat, 01 Aug 2026 09:41:47 +0000 bugzilla-daemon@kernel.org wrote:

> https://bugzilla.kernel.org/show_bug.cgi?id=221820
> 
>             Bug ID: 221820
>            Summary: sparc64 mmap() returns EINVAL for non-MAP_FIXED hint
>                     within VA_EXCLUDE_START...END
>            Product: Memory Management
>            Version: 2.5
>           Hardware: Sparc64
>                 OS: Linux
>             Status: NEW
>           Severity: normal
>           Priority: P3
>          Component: Other
>           Assignee: akpm@linux-foundation.org
>           Reporter: alex@alexrp.com
>         Regression: No
> 
> Repro:
> 
>     alexrp@niagara:~$ uname -a
>     Linux niagara 7.1.3.1-sparc64-smp #1 SMP Debian 7.1.3-1+sunvdc (2026-07-12)
> sparc64 GNU/Linux
>     alexrp@niagara:~$ cat bug.c
>     #include <errno.h>
>     #include <stdio.h>
>     #include <string.h>
>     #include <sys/mman.h>
>     #include <unistd.h>
>     int main() {
>         long pgsz = sysconf(_SC_PAGE_SIZE);
>         void *addr = mmap((void *)0xfff80000fffc6000, pgsz, PROT_READ |
> PROT_WRITE, \
>           MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
>         printf("%p (%s)\n", addr, strerror(errno));
>     }
>     alexrp@niagara:~$ cc bug.c
>     alexrp@niagara:~$ ./a.out
>     0xffffffffffffffff (Invalid argument)
> 
> I find this fairly surprising. I could understand if I had specified MAP_FIXED
> because in that case the kernel is unable to satisfy the requirements I've
> specified. But without MAP_FIXED, 0xfff80000fffc6000 is merely a hint and
> should be ignored if it falls within a VA range that the kernel considers
> off-limits.

Thanks.

That does seem wrong.  It works for me on x86_64 so yes, it does appear
to be a sparc thing.

The test code does have a few glitches which I don't think matter here, but below
is chatgpt's fixed-up version.  Could someone in sparcland please take a quick
look?

#include <errno.h>
#include <stdio.h>
#include <string.h>
#include <sys/mman.h>
#include <unistd.h>

int main(void)
{
    long pgsz = sysconf(_SC_PAGE_SIZE);

    void *addr = mmap((void *)0xfff80000fffc6000,
                      pgsz,
                      PROT_READ | PROT_WRITE,
                      MAP_PRIVATE | MAP_ANONYMOUS,
                      -1,
                      0);

    if (addr == MAP_FAILED) {
        fprintf(stderr, "mmap failed: %s\n", strerror(errno));
        return 1;
    }

    printf("mapped at %p\n", addr);

    munmap(addr, pgsz);
    return 0;
}
