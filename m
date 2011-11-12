From: Rob Landley <rob@landley.net>
Date: Sat, 12 Nov 2011 17:22:34 +0000
Subject: Sparc-32 doesn't work in 3.1.
Message-Id: <4EBEAB5A.5020809@landley.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Aboriginal Linux <aboriginal@lists.landley.net>, linux-kernel@vger.kernel.org, davem@davemloft.net, tytso@mit.edu, sparclinux@vger.kernel.org

Still trying to ship an Aboriginal Linux release with the 3.1 kernel,
but the sparc target broke, as in QEMU's OpenBios goes:

  Boot time fixup v1.6. 4/Mar/98 Jakub Jelinek (jj@ultra.linux.cz).
  Patching kernel for srmmu[Fujitsu TurboSparc]/iommu
  Fixup i f029ddfc doesn't refer to a valid instruction at
  f00de648[95eea000]
  halt, power off

And doesn't even boot Linux.  A sparc-objdump -a on vmlinux says that
chunk has:

f00de63c:       84 0b 60 ff     and  %o5, 0xff, %g2
f00de640:       91 32 20 10     srl  %o0, 0x10, %o0
f00de644:       85 28 a0 08     sll  %g2, 8, %g2
f00de648:       98 0a 20 ff     and  %o0, 0xff, %o4
f00de64c:       03 00 00 3f     sethi  %hi(0xfc00), %g1
f00de650:       82 10 63 00     or  %g1, 0x300, %g1     ! ff00
<cputypvallen+0xfef4>
f00de654:       90 0a 00 01     and  %o0, %g1, %o0

Which means nothing to me.

I bisected it to this:

commit 9933fc0ac1ac14b795819cd63d05ea92112f690a
Author: Theodore Ts'o <tytso@mit.edu>
Date:   Mon Aug 1 08:45:02 2011 -0400

    ext4: introduce ext4_kvmalloc(), ext4_kzalloc(), and ext4_kvfree()

    Introduce new helper functions which try kmalloc, and then fall back
   to vmalloc if necessary, and use them for allocating and deallocating
    s_flex_groups.

    Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>

The commit before that builds fine, this one doesn't.

I think it's triggering bad behavior in arch/sparc/mm/btfixup.c (at
least that's where the "valid instruction" error message comes from),
but I have no idea what this file is doing, and it was last touched in
2008.  (I'm building with gcc 4.2.1 and binutils 2.17, both of which
were last touched around 2006, so that's not new either...)

Rob
