From: Anatoly Pugachev <matorola@gmail.com>
Date: Mon, 03 Aug 2020 09:45:16 +0000
Subject: Re: [sparc64] unable to build v5.8 / master on sparc64 , bisect attached
Message-Id: <CADxRZqzd1qGV17Q1QuQAb4O7Yu5HP1Aa_DE1wGqfOt4hSy5hOg@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <CADxRZqzyxzN9yC79kjhtdpL9QT6ybgTsSCb3G1U8zJHZy-W_9w@mail.gmail.com>
 <de07ba39-4cd4-0174-3331-92cb7148a653@physik.fu-berlin.de>
In-Reply-To: <de07ba39-4cd4-0174-3331-92cb7148a653@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Sparc kernel list <sparclinux@vger.kernel.org>, Linux Kernel list <linux-kernel@vger.kernel.org>

On Mon, Aug 3, 2020 at 12:24 PM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
>
> Hi Anatoly!
>
> On 8/3/20 11:18 AM, Anatoly Pugachev wrote:
> > # bad: [bcf876870b95592b52519ed4aafcf9d95999bc9c] Linux 5.8
> > git bisect bad bcf876870b95592b52519ed4aafcf9d95999bc9c
> > # good: [92ed301919932f777713b9172e525674157e983d] Linux 5.8-rc7
> > git bisect good 92ed301919932f777713b9172e525674157e983d
> > # bad: [0ae3495b6502cf93634cbd027cb2f6f9f83a406f] Merge tag
> > 'for-linus-2020-08-01' of
> > git://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux
> > git bisect bad 0ae3495b6502cf93634cbd027cb2f6f9f83a406f
> > # bad: [aa54ea903abb02303bf55855fb51e3fcee135d70] ARM: percpu.h: fix build error
> > git bisect bad aa54ea903abb02303bf55855fb51e3fcee135d70
> > # good: [c2f3850df7f95537e79c561f7be49df2e4ad8060] Merge tag
> > 'drm-fixes-2020-07-29' of git://anongit.freedesktop.org/drm/drm into
> > master
> > git bisect good c2f3850df7f95537e79c561f7be49df2e4ad8060
> > # bad: [0513b9d75c07cbcdfda3778b636d3d131d679eb1] Merge tag
> > 'io_uring-5.8-2020-07-30' of git://git.kernel.dk/linux-block
> > git bisect bad 0513b9d75c07cbcdfda3778b636d3d131d679eb1
> > # good: [d3590ebf6f91350192737dd1d1b219c05277f067] Merge tag
> > 'audit-pr-20200729' of
> > git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit
> > git bisect good d3590ebf6f91350192737dd1d1b219c05277f067
> > # good: [4ae6dbd683860b9edc254ea8acf5e04b5ae242e5] io_uring: fix
> > lockup in io_fail_links()
> > git bisect good 4ae6dbd683860b9edc254ea8acf5e04b5ae242e5
> > # bad: [1c9df907da83812e4f33b59d3d142c864d9da57f] random: fix circular
> > include dependency on arm64 after addition of percpu.h
> > git bisect bad 1c9df907da83812e4f33b59d3d142c864d9da57f
>
> Did you find the offending commit?

the last one v5.8-rc7-41-g1c9df907da83 ? In commit log it tells about
"x86_64, arm64, arm, and mips" and nothing about sparc,
probably forgotten, i'm not an expert , but the following code change
fixes kernel compilation for me:

linux-2.6$ git diff
diff --git a/arch/sparc/include/asm/percpu.h b/arch/sparc/include/asm/percpu.h
index 0cd704ef5ff9..fe284c508f01 100644
--- a/arch/sparc/include/asm/percpu.h
+++ b/arch/sparc/include/asm/percpu.h
@@ -1,6 +1,9 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #ifndef ___ASM_SPARC_PERCPU_H
 #define ___ASM_SPARC_PERCPU_H
+
+#include <linux/threads.h>
+
 #if defined(__sparc__) && defined(__arch64__)
 #include <asm/percpu_64.h>
 #else
