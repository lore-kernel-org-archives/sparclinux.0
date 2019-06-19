From: Anatoly Pugachev <matorola@gmail.com>
Date: Wed, 19 Jun 2019 07:53:42 +0000
Subject: Re: [PATCH] sparc: Remove redundant copy of the LGPL-2.0
Message-Id: <20190619075342.GA11485@yogzotot>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="0F1p//8PRICkK4MW"
List-Id: <sparclinux.vger.kernel.org>
References: <20190527163253.27203-1-thuth@redhat.com>
 <20190613.141247.955308190761079084.davem@davemloft.net>
 <CALMQjD-dAX8hU6sNxDWtdxc7CddO3KDd9Fu_J74tZ-6pn5_Z5Q@mail.gmail.com>
 <20190613.151456.1482983218638838740.davem@davemloft.net>
In-Reply-To: <20190613.151456.1482983218638838740.davem@davemloft.net>
To: David Miller <davem@davemloft.net>
Cc: oftedal@gmail.com, thuth@redhat.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Philippe Ombredanne <pombredanne@nexb.com>, Kate Stewart <kstewart@linuxfoundation.org>


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 13, 2019 at 03:14:56PM -0700, David Miller wrote:
> > On 13/06/2019, David Miller <davem@davemloft.net> wrote:
> >> From: Thomas Huth <thuth@redhat.com>
> >> Date: Mon, 27 May 2019 18:32:53 +0200
> >>
> >>> We already provide the LGPL-2.0 text in LICENSES/preferred/LGPL-2.0,
> >>> so there is no need for this additional copy here.
> >>>
> >>> Signed-off-by: Thomas Huth <thuth@redhat.com>
> >>
> >> Applied.
> >>
> > 
> > Shouldn't the SPDX license identifiers in in arch/sparc/lib be adjusted to
> > reflect the original intent of LGPL licensing?
> 
> Yes, can someone cook up a quick patch for me for that?
> 
> Thanks.

David,

can you please review this quick one? 

Thanks.

--0F1p//8PRICkK4MW
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="0001-Update-arch-sparc-lib-to-LGPL-2.0-to-be-in-order-wit.patch"

Update arch/sparc/lib/* to LGPL-2.0+ to be in order with original arch/sparc/lib/COPYING.LIB

sed -i 's/SPDX-License-Identifier: \(.*\) */SPDX-License-Identifier: LGPL-2.0+ *\//' arch/sparc/lib/*

Fixes: b24413180f56 ("License cleanup: add SPDX GPL-2.0 license identifier to files with no license")
Signed-off-by: Anatoly Pugachev <matorola@gmail.com>
CC: Kate Stewart <kstewart@linuxfoundation.org>
CC: Philippe Ombredanne <pombredanne@nexb.com>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: David S. Miller <davem@davemloft.net>
---
 arch/sparc/lib/GENbzero.S            | 2 +-
 arch/sparc/lib/GENcopy_from_user.S   | 2 +-
 arch/sparc/lib/GENcopy_to_user.S     | 2 +-
 arch/sparc/lib/GENmemcpy.S           | 2 +-
 arch/sparc/lib/GENpage.S             | 2 +-
 arch/sparc/lib/GENpatch.S            | 2 +-
 arch/sparc/lib/Makefile              | 2 +-
 arch/sparc/lib/NG2copy_from_user.S   | 2 +-
 arch/sparc/lib/NG2copy_to_user.S     | 2 +-
 arch/sparc/lib/NG2memcpy.S           | 2 +-
 arch/sparc/lib/NG2patch.S            | 2 +-
 arch/sparc/lib/NG4clear_page.S       | 2 +-
 arch/sparc/lib/NG4copy_from_user.S   | 2 +-
 arch/sparc/lib/NG4copy_page.S        | 2 +-
 arch/sparc/lib/NG4copy_to_user.S     | 2 +-
 arch/sparc/lib/NG4memcpy.S           | 2 +-
 arch/sparc/lib/NG4memset.S           | 2 +-
 arch/sparc/lib/NG4patch.S            | 2 +-
 arch/sparc/lib/NGbzero.S             | 2 +-
 arch/sparc/lib/NGcopy_from_user.S    | 2 +-
 arch/sparc/lib/NGcopy_to_user.S      | 2 +-
 arch/sparc/lib/NGmemcpy.S            | 2 +-
 arch/sparc/lib/NGpage.S              | 2 +-
 arch/sparc/lib/NGpatch.S             | 2 +-
 arch/sparc/lib/PeeCeeI.c             | 2 +-
 arch/sparc/lib/U1copy_from_user.S    | 2 +-
 arch/sparc/lib/U1copy_to_user.S      | 2 +-
 arch/sparc/lib/U1memcpy.S            | 2 +-
 arch/sparc/lib/U3copy_from_user.S    | 2 +-
 arch/sparc/lib/U3copy_to_user.S      | 2 +-
 arch/sparc/lib/U3memcpy.S            | 2 +-
 arch/sparc/lib/U3patch.S             | 2 +-
 arch/sparc/lib/VISsave.S             | 2 +-
 arch/sparc/lib/ashldi3.S             | 2 +-
 arch/sparc/lib/ashrdi3.S             | 2 +-
 arch/sparc/lib/atomic32.c            | 2 +-
 arch/sparc/lib/atomic_64.S           | 2 +-
 arch/sparc/lib/bitext.c              | 2 +-
 arch/sparc/lib/bitops.S              | 2 +-
 arch/sparc/lib/blockops.S            | 2 +-
 arch/sparc/lib/bzero.S               | 2 +-
 arch/sparc/lib/checksum_32.S         | 2 +-
 arch/sparc/lib/checksum_64.S         | 2 +-
 arch/sparc/lib/clear_page.S          | 2 +-
 arch/sparc/lib/cmpdi2.c              | 2 +-
 arch/sparc/lib/copy_in_user.S        | 2 +-
 arch/sparc/lib/copy_page.S           | 2 +-
 arch/sparc/lib/copy_user.S           | 2 +-
 arch/sparc/lib/csum_copy.S           | 2 +-
 arch/sparc/lib/csum_copy_from_user.S | 2 +-
 arch/sparc/lib/csum_copy_to_user.S   | 2 +-
 arch/sparc/lib/divdi3.S              | 2 +-
 arch/sparc/lib/ffs.S                 | 2 +-
 arch/sparc/lib/hweight.S             | 2 +-
 arch/sparc/lib/iomap.c               | 2 +-
 arch/sparc/lib/ipcsum.S              | 2 +-
 arch/sparc/lib/libgcc.h              | 2 +-
 arch/sparc/lib/locks.S               | 2 +-
 arch/sparc/lib/lshrdi3.S             | 2 +-
 arch/sparc/lib/mcount.S              | 2 +-
 arch/sparc/lib/memcmp.S              | 2 +-
 arch/sparc/lib/memcpy.S              | 2 +-
 arch/sparc/lib/memmove.S             | 2 +-
 arch/sparc/lib/memscan_32.S          | 2 +-
 arch/sparc/lib/memscan_64.S          | 2 +-
 arch/sparc/lib/memset.S              | 2 +-
 arch/sparc/lib/muldi3.S              | 2 +-
 arch/sparc/lib/multi3.S              | 2 +-
 arch/sparc/lib/strlen.S              | 2 +-
 arch/sparc/lib/strncmp_32.S          | 2 +-
 arch/sparc/lib/strncmp_64.S          | 2 +-
 arch/sparc/lib/ucmpdi2.c             | 2 +-
 arch/sparc/lib/udivdi3.S             | 2 +-
 arch/sparc/lib/xor.S                 | 2 +-
 74 files changed, 74 insertions(+), 74 deletions(-)

diff --git a/arch/sparc/lib/GENbzero.S b/arch/sparc/lib/GENbzero.S
index 63d618857d49..534347838dc2 100644
--- a/arch/sparc/lib/GENbzero.S
+++ b/arch/sparc/lib/GENbzero.S
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: LGPL-2.0+ */
 /* GENbzero.S: Generic sparc64 memset/clear_user.
  *
  * Copyright (C) 2007 David S. Miller (davem@davemloft.net)
diff --git a/arch/sparc/lib/GENcopy_from_user.S b/arch/sparc/lib/GENcopy_from_user.S
index 6891a5678ea3..eede85e30109 100644
--- a/arch/sparc/lib/GENcopy_from_user.S
+++ b/arch/sparc/lib/GENcopy_from_user.S
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: LGPL-2.0+ */
 /* GENcopy_from_user.S: Generic sparc64 copy from userspace.
  *
  * Copyright (C) 2007 David S. Miller (davem@davemloft.net)
diff --git a/arch/sparc/lib/GENcopy_to_user.S b/arch/sparc/lib/GENcopy_to_user.S
index df75b532a934..f8adb9c9c9b2 100644
--- a/arch/sparc/lib/GENcopy_to_user.S
+++ b/arch/sparc/lib/GENcopy_to_user.S
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: LGPL-2.0+ */
 /* GENcopy_to_user.S: Generic sparc64 copy to userspace.
  *
  * Copyright (C) 2007 David S. Miller (davem@davemloft.net)
diff --git a/arch/sparc/lib/GENmemcpy.S b/arch/sparc/lib/GENmemcpy.S
index 114340a0d36e..d3620502c462 100644
--- a/arch/sparc/lib/GENmemcpy.S
+++ b/arch/sparc/lib/GENmemcpy.S
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: LGPL-2.0+ */
 /* GENmemcpy.S: Generic sparc64 memcpy.
  *
  * Copyright (C) 2007 David S. Miller (davem@davemloft.net)
diff --git a/arch/sparc/lib/GENpage.S b/arch/sparc/lib/GENpage.S
index c143c4d1de3f..63131c2a8351 100644
--- a/arch/sparc/lib/GENpage.S
+++ b/arch/sparc/lib/GENpage.S
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: LGPL-2.0+ */
 /* GENpage.S: Generic clear and copy page.
  *
  * Copyright (C) 2007 (davem@davemloft.net)
diff --git a/arch/sparc/lib/GENpatch.S b/arch/sparc/lib/GENpatch.S
index 1ec1f02c8b7b..b46247fa19c4 100644
--- a/arch/sparc/lib/GENpatch.S
+++ b/arch/sparc/lib/GENpatch.S
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: LGPL-2.0+ */
 /* GENpatch.S: Patch Ultra-I routines with generic variant.
  *
  * Copyright (C) 2007 David S. Miller <davem@davemloft.net>
diff --git a/arch/sparc/lib/Makefile b/arch/sparc/lib/Makefile
index 063556fe2cb1..9a9c645a6c44 100644
--- a/arch/sparc/lib/Makefile
+++ b/arch/sparc/lib/Makefile
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0
+# SPDX-License-Identifier: LGPL-2.0+ */
 # Makefile for Sparc library files..
 #
 
diff --git a/arch/sparc/lib/NG2copy_from_user.S b/arch/sparc/lib/NG2copy_from_user.S
index e57bc514f538..9dbe02516c95 100644
--- a/arch/sparc/lib/NG2copy_from_user.S
+++ b/arch/sparc/lib/NG2copy_from_user.S
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: LGPL-2.0+ */
 /* NG2copy_from_user.S: Niagara-2 optimized copy from userspace.
  *
  * Copyright (C) 2007 David S. Miller (davem@davemloft.net)
diff --git a/arch/sparc/lib/NG2copy_to_user.S b/arch/sparc/lib/NG2copy_to_user.S
index 367c0bf01518..c1ca5373e7b1 100644
--- a/arch/sparc/lib/NG2copy_to_user.S
+++ b/arch/sparc/lib/NG2copy_to_user.S
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: LGPL-2.0+ */
 /* NG2copy_to_user.S: Niagara-2 optimized copy to userspace.
  *
  * Copyright (C) 2007 David S. Miller (davem@davemloft.net)
diff --git a/arch/sparc/lib/NG2memcpy.S b/arch/sparc/lib/NG2memcpy.S
index bcb21b3a82f1..86a173f0ea98 100644
--- a/arch/sparc/lib/NG2memcpy.S
+++ b/arch/sparc/lib/NG2memcpy.S
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: LGPL-2.0+ */
 /* NG2memcpy.S: Niagara-2 optimized memcpy.
  *
  * Copyright (C) 2007 David S. Miller (davem@davemloft.net)
diff --git a/arch/sparc/lib/NG2patch.S b/arch/sparc/lib/NG2patch.S
index 72431b24491a..c01ce6d14d3d 100644
--- a/arch/sparc/lib/NG2patch.S
+++ b/arch/sparc/lib/NG2patch.S
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: LGPL-2.0+ */
 /* NG2patch.S: Patch Ultra-I routines with Niagara-2 variant.
  *
  * Copyright (C) 2007 David S. Miller <davem@davemloft.net>
diff --git a/arch/sparc/lib/NG4clear_page.S b/arch/sparc/lib/NG4clear_page.S
index 97e2678d042a..28ff057d5e8c 100644
--- a/arch/sparc/lib/NG4clear_page.S
+++ b/arch/sparc/lib/NG4clear_page.S
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: LGPL-2.0+ */
 /* NG4copy_page.S: Niagara-4 optimized clear page.
  *
  * Copyright (C) 2012 (davem@davemloft.net)
diff --git a/arch/sparc/lib/NG4copy_from_user.S b/arch/sparc/lib/NG4copy_from_user.S
index 0cac15a6db3c..a429778080f5 100644
--- a/arch/sparc/lib/NG4copy_from_user.S
+++ b/arch/sparc/lib/NG4copy_from_user.S
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: LGPL-2.0+ */
 /* NG4copy_from_user.S: Niagara-4 optimized copy from userspace.
  *
  * Copyright (C) 2012 David S. Miller (davem@davemloft.net)
diff --git a/arch/sparc/lib/NG4copy_page.S b/arch/sparc/lib/NG4copy_page.S
index 581062f8ba5f..7de338031544 100644
--- a/arch/sparc/lib/NG4copy_page.S
+++ b/arch/sparc/lib/NG4copy_page.S
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: LGPL-2.0+ */
 /* NG4copy_page.S: Niagara-4 optimized copy page.
  *
  * Copyright (C) 2012 (davem@davemloft.net)
diff --git a/arch/sparc/lib/NG4copy_to_user.S b/arch/sparc/lib/NG4copy_to_user.S
index c5c9abb3cb77..cb08c5dd822e 100644
--- a/arch/sparc/lib/NG4copy_to_user.S
+++ b/arch/sparc/lib/NG4copy_to_user.S
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: LGPL-2.0+ */
 /* NG4copy_to_user.S: Niagara-4 optimized copy to userspace.
  *
  * Copyright (C) 2012 David S. Miller (davem@davemloft.net)
diff --git a/arch/sparc/lib/NG4memcpy.S b/arch/sparc/lib/NG4memcpy.S
index 7ad58ebe0d00..4f1521ed13a6 100644
--- a/arch/sparc/lib/NG4memcpy.S
+++ b/arch/sparc/lib/NG4memcpy.S
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: LGPL-2.0+ */
 /* NG4memcpy.S: Niagara-4 optimized memcpy.
  *
  * Copyright (C) 2012 David S. Miller (davem@davemloft.net)
diff --git a/arch/sparc/lib/NG4memset.S b/arch/sparc/lib/NG4memset.S
index f81ee5419e2c..2b029e148f48 100644
--- a/arch/sparc/lib/NG4memset.S
+++ b/arch/sparc/lib/NG4memset.S
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: LGPL-2.0+ */
 /* NG4memset.S: Niagara-4 optimized memset/bzero.
  *
  * Copyright (C) 2012 David S. Miller (davem@davemloft.net)
diff --git a/arch/sparc/lib/NG4patch.S b/arch/sparc/lib/NG4patch.S
index 37866175c921..396585dfdb07 100644
--- a/arch/sparc/lib/NG4patch.S
+++ b/arch/sparc/lib/NG4patch.S
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: LGPL-2.0+ */
 /* NG4patch.S: Patch Ultra-I routines with Niagara-4 variant.
  *
  * Copyright (C) 2012 David S. Miller <davem@davemloft.net>
diff --git a/arch/sparc/lib/NGbzero.S b/arch/sparc/lib/NGbzero.S
index 19327614d57d..e0d717ab4555 100644
--- a/arch/sparc/lib/NGbzero.S
+++ b/arch/sparc/lib/NGbzero.S
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: LGPL-2.0+ */
 /* NGbzero.S: Niagara optimized memset/clear_user.
  *
  * Copyright (C) 2006 David S. Miller (davem@davemloft.net)
diff --git a/arch/sparc/lib/NGcopy_from_user.S b/arch/sparc/lib/NGcopy_from_user.S
index 9abc49fcdbbe..e185ff95fb3c 100644
--- a/arch/sparc/lib/NGcopy_from_user.S
+++ b/arch/sparc/lib/NGcopy_from_user.S
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: LGPL-2.0+ */
 /* NGcopy_from_user.S: Niagara optimized copy from userspace.
  *
  * Copyright (C) 2006, 2007 David S. Miller (davem@davemloft.net)
diff --git a/arch/sparc/lib/NGcopy_to_user.S b/arch/sparc/lib/NGcopy_to_user.S
index 9cbe2f18e5cc..7ad1444158a8 100644
--- a/arch/sparc/lib/NGcopy_to_user.S
+++ b/arch/sparc/lib/NGcopy_to_user.S
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: LGPL-2.0+ */
 /* NGcopy_to_user.S: Niagara optimized copy to userspace.
  *
  * Copyright (C) 2006, 2007 David S. Miller (davem@davemloft.net)
diff --git a/arch/sparc/lib/NGmemcpy.S b/arch/sparc/lib/NGmemcpy.S
index 8e4d22a6ba0b..8e2ad36108f3 100644
--- a/arch/sparc/lib/NGmemcpy.S
+++ b/arch/sparc/lib/NGmemcpy.S
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: LGPL-2.0+ */
 /* NGmemcpy.S: Niagara optimized memcpy.
  *
  * Copyright (C) 2006, 2007 David S. Miller (davem@davemloft.net)
diff --git a/arch/sparc/lib/NGpage.S b/arch/sparc/lib/NGpage.S
index 88fec7818065..5f26ebee2a6b 100644
--- a/arch/sparc/lib/NGpage.S
+++ b/arch/sparc/lib/NGpage.S
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: LGPL-2.0+ */
 /* NGpage.S: Niagara optimize clear and copy page.
  *
  * Copyright (C) 2006 (davem@davemloft.net)
diff --git a/arch/sparc/lib/NGpatch.S b/arch/sparc/lib/NGpatch.S
index e9f843f1063e..2921434b9c93 100644
--- a/arch/sparc/lib/NGpatch.S
+++ b/arch/sparc/lib/NGpatch.S
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: LGPL-2.0+ */
 /* NGpatch.S: Patch Ultra-I routines with Niagara variant.
  *
  * Copyright (C) 2006 David S. Miller <davem@davemloft.net>
diff --git a/arch/sparc/lib/PeeCeeI.c b/arch/sparc/lib/PeeCeeI.c
index cde4c9a51b2e..abf80deda8f9 100644
--- a/arch/sparc/lib/PeeCeeI.c
+++ b/arch/sparc/lib/PeeCeeI.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: LGPL-2.0+ */
 /*
  * PeeCeeI.c: The emerging standard...
  *
diff --git a/arch/sparc/lib/U1copy_from_user.S b/arch/sparc/lib/U1copy_from_user.S
index bf08d1c78836..4a5e10b9a55f 100644
--- a/arch/sparc/lib/U1copy_from_user.S
+++ b/arch/sparc/lib/U1copy_from_user.S
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: LGPL-2.0+ */
 /* U1copy_from_user.S: UltraSparc-I/II/IIi/IIe optimized copy from userspace.
  *
  * Copyright (C) 1999, 2000, 2004 David S. Miller (davem@redhat.com)
diff --git a/arch/sparc/lib/U1copy_to_user.S b/arch/sparc/lib/U1copy_to_user.S
index 15169851e7ab..1b083a6dcdca 100644
--- a/arch/sparc/lib/U1copy_to_user.S
+++ b/arch/sparc/lib/U1copy_to_user.S
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: LGPL-2.0+ */
 /* U1copy_to_user.S: UltraSparc-I/II/IIi/IIe optimized copy to userspace.
  *
  * Copyright (C) 1999, 2000, 2004 David S. Miller (davem@redhat.com)
diff --git a/arch/sparc/lib/U1memcpy.S b/arch/sparc/lib/U1memcpy.S
index a6f4ee391897..464ec91cc709 100644
--- a/arch/sparc/lib/U1memcpy.S
+++ b/arch/sparc/lib/U1memcpy.S
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: LGPL-2.0+ */
 /* U1memcpy.S: UltraSPARC-I/II/IIi/IIe optimized memcpy.
  *
  * Copyright (C) 1997, 2004 David S. Miller (davem@redhat.com)
diff --git a/arch/sparc/lib/U3copy_from_user.S b/arch/sparc/lib/U3copy_from_user.S
index 9c891e9edc7b..33baf4c64a32 100644
--- a/arch/sparc/lib/U3copy_from_user.S
+++ b/arch/sparc/lib/U3copy_from_user.S
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: LGPL-2.0+ */
 /* U3copy_from_user.S: UltraSparc-III optimized copy from userspace.
  *
  * Copyright (C) 1999, 2000, 2004 David S. Miller (davem@redhat.com)
diff --git a/arch/sparc/lib/U3copy_to_user.S b/arch/sparc/lib/U3copy_to_user.S
index da424608272c..b4606cfd504a 100644
--- a/arch/sparc/lib/U3copy_to_user.S
+++ b/arch/sparc/lib/U3copy_to_user.S
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: LGPL-2.0+ */
 /* U3copy_to_user.S: UltraSparc-III optimized copy to userspace.
  *
  * Copyright (C) 1999, 2000, 2004 David S. Miller (davem@redhat.com)
diff --git a/arch/sparc/lib/U3memcpy.S b/arch/sparc/lib/U3memcpy.S
index 9248d59c734c..fbc787e238b3 100644
--- a/arch/sparc/lib/U3memcpy.S
+++ b/arch/sparc/lib/U3memcpy.S
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: LGPL-2.0+ */
 /* U3memcpy.S: UltraSparc-III optimized memcpy.
  *
  * Copyright (C) 1999, 2000, 2004 David S. Miller (davem@redhat.com)
diff --git a/arch/sparc/lib/U3patch.S b/arch/sparc/lib/U3patch.S
index 9a888088f3c9..2484ae03acc1 100644
--- a/arch/sparc/lib/U3patch.S
+++ b/arch/sparc/lib/U3patch.S
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: LGPL-2.0+ */
 /* U3patch.S: Patch Ultra-I routines with Ultra-III variant.
  *
  * Copyright (C) 2004 David S. Miller <davem@redhat.com>
diff --git a/arch/sparc/lib/VISsave.S b/arch/sparc/lib/VISsave.S
index 9c8eb2017d5b..77b0c082a0fd 100644
--- a/arch/sparc/lib/VISsave.S
+++ b/arch/sparc/lib/VISsave.S
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: LGPL-2.0+ */
 /*
  * VISsave.S: Code for saving FPU register state for
  *            VIS routines. One should not call this directly,
diff --git a/arch/sparc/lib/ashldi3.S b/arch/sparc/lib/ashldi3.S
index 2d72de88af90..54e5c0bb8574 100644
--- a/arch/sparc/lib/ashldi3.S
+++ b/arch/sparc/lib/ashldi3.S
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: LGPL-2.0+ */
 /*
  * ashldi3.S:	GCC emits these for certain drivers playing
  *		with long longs.
diff --git a/arch/sparc/lib/ashrdi3.S b/arch/sparc/lib/ashrdi3.S
index 05dfda9f5005..d854d86f32d5 100644
--- a/arch/sparc/lib/ashrdi3.S
+++ b/arch/sparc/lib/ashrdi3.S
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: LGPL-2.0+ */
 /*
  * ashrdi3.S:	The filesystem code creates all kinds of references to
  *              this little routine on the sparc with gcc.
diff --git a/arch/sparc/lib/atomic32.c b/arch/sparc/lib/atomic32.c
index 281fa634bb1a..21c82b03c74d 100644
--- a/arch/sparc/lib/atomic32.c
+++ b/arch/sparc/lib/atomic32.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: LGPL-2.0+ */
 /*
  * atomic32.c: 32-bit atomic_t implementation
  *
diff --git a/arch/sparc/lib/atomic_64.S b/arch/sparc/lib/atomic_64.S
index 456b65a30ecf..537fa06812b5 100644
--- a/arch/sparc/lib/atomic_64.S
+++ b/arch/sparc/lib/atomic_64.S
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: LGPL-2.0+ */
 /* atomic.S: These things are too big to do inline.
  *
  * Copyright (C) 1999, 2007 2012 David S. Miller (davem@davemloft.net)
diff --git a/arch/sparc/lib/bitext.c b/arch/sparc/lib/bitext.c
index 32a5c1d9459c..3d0f5ef38a54 100644
--- a/arch/sparc/lib/bitext.c
+++ b/arch/sparc/lib/bitext.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: LGPL-2.0+ */
 /*
  * bitext.c: kernel little helper (of bit shuffling variety).
  *
diff --git a/arch/sparc/lib/bitops.S b/arch/sparc/lib/bitops.S
index 9d647f977618..25b9dc43227c 100644
--- a/arch/sparc/lib/bitops.S
+++ b/arch/sparc/lib/bitops.S
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: LGPL-2.0+ */
 /* bitops.S: Sparc64 atomic bit operations.
  *
  * Copyright (C) 2000, 2007 David S. Miller (davem@davemloft.net)
diff --git a/arch/sparc/lib/blockops.S b/arch/sparc/lib/blockops.S
index 76ddd1ff6833..ecf99ba0ad79 100644
--- a/arch/sparc/lib/blockops.S
+++ b/arch/sparc/lib/blockops.S
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: LGPL-2.0+ */
 /*
  * blockops.S: Common block zero optimized routines.
  *
diff --git a/arch/sparc/lib/bzero.S b/arch/sparc/lib/bzero.S
index 87fec4cbe10c..16b0a814dffc 100644
--- a/arch/sparc/lib/bzero.S
+++ b/arch/sparc/lib/bzero.S
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: LGPL-2.0+ */
 /* bzero.S: Simple prefetching memset, bzero, and clear_user
  *          implementations.
  *
diff --git a/arch/sparc/lib/checksum_32.S b/arch/sparc/lib/checksum_32.S
index 6a5469c97246..f6e919b8b0a2 100644
--- a/arch/sparc/lib/checksum_32.S
+++ b/arch/sparc/lib/checksum_32.S
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: LGPL-2.0+ */
 /* checksum.S: Sparc optimized checksum code.
  *
  *  Copyright(C) 1995 Linus Torvalds
diff --git a/arch/sparc/lib/checksum_64.S b/arch/sparc/lib/checksum_64.S
index 9700ef1730df..2f44cda0a825 100644
--- a/arch/sparc/lib/checksum_64.S
+++ b/arch/sparc/lib/checksum_64.S
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: LGPL-2.0+ */
 /* checksum.S: Sparc V9 optimized checksum code.
  *
  *  Copyright(C) 1995 Linus Torvalds
diff --git a/arch/sparc/lib/clear_page.S b/arch/sparc/lib/clear_page.S
index 8a6c783a6301..e60f7a192741 100644
--- a/arch/sparc/lib/clear_page.S
+++ b/arch/sparc/lib/clear_page.S
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: LGPL-2.0+ */
 /* clear_page.S: UltraSparc optimized clear page.
  *
  * Copyright (C) 1996, 1998, 1999, 2000, 2004 David S. Miller (davem@redhat.com)
diff --git a/arch/sparc/lib/cmpdi2.c b/arch/sparc/lib/cmpdi2.c
index 333367fe7353..a20fa931ae78 100644
--- a/arch/sparc/lib/cmpdi2.c
+++ b/arch/sparc/lib/cmpdi2.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: LGPL-2.0+ */
 #include <linux/module.h>
 
 #include "libgcc.h"
diff --git a/arch/sparc/lib/copy_in_user.S b/arch/sparc/lib/copy_in_user.S
index 66e90bf528e2..4860fd722384 100644
--- a/arch/sparc/lib/copy_in_user.S
+++ b/arch/sparc/lib/copy_in_user.S
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: LGPL-2.0+ */
 /* copy_in_user.S: Copy from userspace to userspace.
  *
  * Copyright (C) 1999, 2000, 2004 David S. Miller (davem@redhat.com)
diff --git a/arch/sparc/lib/copy_page.S b/arch/sparc/lib/copy_page.S
index c088e871e8e3..270aca1339b8 100644
--- a/arch/sparc/lib/copy_page.S
+++ b/arch/sparc/lib/copy_page.S
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: LGPL-2.0+ */
 /* clear_page.S: UltraSparc optimized copy page.
  *
  * Copyright (C) 1996, 1998, 1999, 2000, 2004 David S. Miller (davem@redhat.com)
diff --git a/arch/sparc/lib/copy_user.S b/arch/sparc/lib/copy_user.S
index dc72f2b970b7..f1f9e2a0a74e 100644
--- a/arch/sparc/lib/copy_user.S
+++ b/arch/sparc/lib/copy_user.S
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: LGPL-2.0+ */
 /* copy_user.S: Sparc optimized copy_from_user and copy_to_user code.
  *
  *  Copyright(C) 1995 Linus Torvalds
diff --git a/arch/sparc/lib/csum_copy.S b/arch/sparc/lib/csum_copy.S
index 26c644ba3ecb..60431ae92a90 100644
--- a/arch/sparc/lib/csum_copy.S
+++ b/arch/sparc/lib/csum_copy.S
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: LGPL-2.0+ */
 /* csum_copy.S: Checksum+copy code for sparc64
  *
  * Copyright (C) 2005 David S. Miller <davem@davemloft.net>
diff --git a/arch/sparc/lib/csum_copy_from_user.S b/arch/sparc/lib/csum_copy_from_user.S
index d20b9594f0c7..0af547ae0e25 100644
--- a/arch/sparc/lib/csum_copy_from_user.S
+++ b/arch/sparc/lib/csum_copy_from_user.S
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: LGPL-2.0+ */
 /* csum_copy_from_user.S: Checksum+copy from userspace.
  *
  * Copyright (C) 2005 David S. Miller (davem@davemloft.net)
diff --git a/arch/sparc/lib/csum_copy_to_user.S b/arch/sparc/lib/csum_copy_to_user.S
index d71c0c81e8ab..adb9b313030d 100644
--- a/arch/sparc/lib/csum_copy_to_user.S
+++ b/arch/sparc/lib/csum_copy_to_user.S
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: LGPL-2.0+ */
 /* csum_copy_to_user.S: Checksum+copy to userspace.
  *
  * Copyright (C) 2005 David S. Miller (davem@davemloft.net)
diff --git a/arch/sparc/lib/divdi3.S b/arch/sparc/lib/divdi3.S
index a7389409d9fa..e7b8500b650d 100644
--- a/arch/sparc/lib/divdi3.S
+++ b/arch/sparc/lib/divdi3.S
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* SPDX-License-Identifier: LGPL-2.0+ */
 /* Copyright (C) 1989, 1992, 1993, 1994, 1995 Free Software Foundation, Inc.
 
 This file is part of GNU CC.
diff --git a/arch/sparc/lib/ffs.S b/arch/sparc/lib/ffs.S
index 5a11d864fa05..8fffa7cc178f 100644
--- a/arch/sparc/lib/ffs.S
+++ b/arch/sparc/lib/ffs.S
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: LGPL-2.0+ */
 #include <linux/linkage.h>
 #include <asm/export.h>
 
diff --git a/arch/sparc/lib/hweight.S b/arch/sparc/lib/hweight.S
index 0ddbbb031822..d478e8e0cf86 100644
--- a/arch/sparc/lib/hweight.S
+++ b/arch/sparc/lib/hweight.S
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: LGPL-2.0+ */
 #include <linux/linkage.h>
 #include <asm/export.h>
 
diff --git a/arch/sparc/lib/iomap.c b/arch/sparc/lib/iomap.c
index c9da9f139694..794a82610010 100644
--- a/arch/sparc/lib/iomap.c
+++ b/arch/sparc/lib/iomap.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: LGPL-2.0+ */
 /*
  * Implement the sparc iomap interfaces
  */
diff --git a/arch/sparc/lib/ipcsum.S b/arch/sparc/lib/ipcsum.S
index 531d89c9d5d9..c343b486172e 100644
--- a/arch/sparc/lib/ipcsum.S
+++ b/arch/sparc/lib/ipcsum.S
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: LGPL-2.0+ */
 #include <linux/linkage.h>
 #include <asm/export.h>
 
diff --git a/arch/sparc/lib/libgcc.h b/arch/sparc/lib/libgcc.h
index 79845c941b87..38c098d0e519 100644
--- a/arch/sparc/lib/libgcc.h
+++ b/arch/sparc/lib/libgcc.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: LGPL-2.0+ */
 #ifndef __ASM_LIBGCC_H
 #define __ASM_LIBGCC_H
 
diff --git a/arch/sparc/lib/locks.S b/arch/sparc/lib/locks.S
index 9a1289a3fb28..483b9d8c4fbf 100644
--- a/arch/sparc/lib/locks.S
+++ b/arch/sparc/lib/locks.S
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: LGPL-2.0+ */
 /*
  * locks.S: SMP low-level lock primitives on Sparc.
  *
diff --git a/arch/sparc/lib/lshrdi3.S b/arch/sparc/lib/lshrdi3.S
index 509ca6682da8..37c03ffd9c12 100644
--- a/arch/sparc/lib/lshrdi3.S
+++ b/arch/sparc/lib/lshrdi3.S
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: LGPL-2.0+ */
 #include <linux/linkage.h>
 #include <asm/export.h>
 
diff --git a/arch/sparc/lib/mcount.S b/arch/sparc/lib/mcount.S
index deba6fa0bc78..3001ae2715a2 100644
--- a/arch/sparc/lib/mcount.S
+++ b/arch/sparc/lib/mcount.S
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: LGPL-2.0+ */
 /*
  * Copyright (C) 2000 Anton Blanchard (anton@linuxcare.com)
  *
diff --git a/arch/sparc/lib/memcmp.S b/arch/sparc/lib/memcmp.S
index a18076ef5af1..57ac480d3068 100644
--- a/arch/sparc/lib/memcmp.S
+++ b/arch/sparc/lib/memcmp.S
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: LGPL-2.0+ */
 /* Sparc optimized memcmp code.
  *
  * Copyright (C) 1997 Jakub Jelinek (jj@sunsite.mff.cuni.cz)
diff --git a/arch/sparc/lib/memcpy.S b/arch/sparc/lib/memcpy.S
index ee823d8c9215..f630bfeede5b 100644
--- a/arch/sparc/lib/memcpy.S
+++ b/arch/sparc/lib/memcpy.S
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: LGPL-2.0+ */
 /* memcpy.S: Sparc optimized memcpy and memmove code
  * Hand optimized from GNU libc's memcpy and memmove
  * Copyright (C) 1991,1996 Free Software Foundation
diff --git a/arch/sparc/lib/memmove.S b/arch/sparc/lib/memmove.S
index 3132b6316144..82e575ac2dd9 100644
--- a/arch/sparc/lib/memmove.S
+++ b/arch/sparc/lib/memmove.S
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: LGPL-2.0+ */
 /* memmove.S: Simple memmove implementation.
  *
  * Copyright (C) 1997, 2004 David S. Miller (davem@redhat.com)
diff --git a/arch/sparc/lib/memscan_32.S b/arch/sparc/lib/memscan_32.S
index c4c2d5b3a2e9..dfcc6452be9f 100644
--- a/arch/sparc/lib/memscan_32.S
+++ b/arch/sparc/lib/memscan_32.S
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: LGPL-2.0+ */
 /*
  * memscan.S: Optimized memscan for the Sparc.
  *
diff --git a/arch/sparc/lib/memscan_64.S b/arch/sparc/lib/memscan_64.S
index 36dd638905c3..893704a83510 100644
--- a/arch/sparc/lib/memscan_64.S
+++ b/arch/sparc/lib/memscan_64.S
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: LGPL-2.0+ */
 /*
  * memscan.S: Optimized memscan for Sparc64.
  *
diff --git a/arch/sparc/lib/memset.S b/arch/sparc/lib/memset.S
index b89d42b29e34..a9415328be77 100644
--- a/arch/sparc/lib/memset.S
+++ b/arch/sparc/lib/memset.S
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: LGPL-2.0+ */
 /* linux/arch/sparc/lib/memset.S: Sparc optimized memset, bzero and clear_user code
  * Copyright (C) 1991,1996 Free Software Foundation
  * Copyright (C) 1996,1997 Jakub Jelinek (jj@sunsite.mff.cuni.cz)
diff --git a/arch/sparc/lib/muldi3.S b/arch/sparc/lib/muldi3.S
index 53054dee66d6..35f3304e0cbe 100644
--- a/arch/sparc/lib/muldi3.S
+++ b/arch/sparc/lib/muldi3.S
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* SPDX-License-Identifier: LGPL-2.0+ */
 /* Copyright (C) 1989, 1992, 1993, 1994, 1995 Free Software Foundation, Inc.
 
 This file is part of GNU CC.
diff --git a/arch/sparc/lib/multi3.S b/arch/sparc/lib/multi3.S
index 2f187b299345..df04d4e4ccbf 100644
--- a/arch/sparc/lib/multi3.S
+++ b/arch/sparc/lib/multi3.S
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: LGPL-2.0+ */
 #include <linux/linkage.h>
 #include <asm/export.h>
 
diff --git a/arch/sparc/lib/strlen.S b/arch/sparc/lib/strlen.S
index dd111bbad5df..88b67cc7075e 100644
--- a/arch/sparc/lib/strlen.S
+++ b/arch/sparc/lib/strlen.S
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: LGPL-2.0+ */
 /* strlen.S: Sparc optimized strlen code
  * Hand optimized from GNU libc's strlen
  * Copyright (C) 1991,1996 Free Software Foundation
diff --git a/arch/sparc/lib/strncmp_32.S b/arch/sparc/lib/strncmp_32.S
index 794733f036b6..9a1036dd6f27 100644
--- a/arch/sparc/lib/strncmp_32.S
+++ b/arch/sparc/lib/strncmp_32.S
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: LGPL-2.0+ */
 /*
  * strncmp.S: Hand optimized Sparc assembly of GCC output from GNU libc
  *            generic strncmp routine.
diff --git a/arch/sparc/lib/strncmp_64.S b/arch/sparc/lib/strncmp_64.S
index 3d37d65f674c..429466f32a6f 100644
--- a/arch/sparc/lib/strncmp_64.S
+++ b/arch/sparc/lib/strncmp_64.S
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: LGPL-2.0+ */
 /*
  * Sparc64 optimized strncmp code.
  *
diff --git a/arch/sparc/lib/ucmpdi2.c b/arch/sparc/lib/ucmpdi2.c
index 82c1cccb1264..1fc2391730c1 100644
--- a/arch/sparc/lib/ucmpdi2.c
+++ b/arch/sparc/lib/ucmpdi2.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: LGPL-2.0+ */
 #include <linux/module.h>
 #include "libgcc.h"
 
diff --git a/arch/sparc/lib/udivdi3.S b/arch/sparc/lib/udivdi3.S
index 7a1117ec7696..39ca6744ba56 100644
--- a/arch/sparc/lib/udivdi3.S
+++ b/arch/sparc/lib/udivdi3.S
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* SPDX-License-Identifier: LGPL-2.0+ */
 /* Copyright (C) 1989, 1992, 1993, 1994, 1995 Free Software Foundation, Inc.
 
 This file is part of GNU CC.
diff --git a/arch/sparc/lib/xor.S b/arch/sparc/lib/xor.S
index f6af7c7ee6fc..9f280f502640 100644
--- a/arch/sparc/lib/xor.S
+++ b/arch/sparc/lib/xor.S
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: LGPL-2.0+ */
 /*
  * arch/sparc64/lib/xor.S
  *
-- 
2.20.1


--0F1p//8PRICkK4MW--
