From: Akinobu Mita <akinobu.mita@gmail.com>
Date: Tue, 13 Oct 2009 09:10:17 +0000
Subject: Re: [PATCH 2/8] bitmap: Introduce bitmap_set, bitmap_clear,
Message-Id: <20091013091017.GA18431@localhost.localdomain>
List-Id: <sparclinux.vger.kernel.org>
References: <1255076961-21325-1-git-send-email-akinobu.mita@gmail.com>
	<1255076961-21325-2-git-send-email-akinobu.mita@gmail.com>
	<20091009164100.85a36188.akpm@linux-foundation.org>
	<20091013021818.GA3898@localhost.localdomain>
In-Reply-To: <20091013021818.GA3898@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Fenghua Yu <fenghua.yu@intel.com>, Greg Kroah-Hartman <gregkh@suse.de>, linux-ia64@vger.kernel.org, Tony Luck <tony.luck@intel.com>, x86@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-altix@sgi.com, Yevgeny Petrilin <yevgenyp@mellanox.co.il>, FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, linuxppc-dev@ozlabs.org, Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, linux-usb@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Lothar Wassmann <LW@KARO-electronics.de>

My user space testing exposed off-by-one error find_next_zero_area
in iommu-helper. Some zero area cannot be found by this bug.

Subject: [PATCH] Fix off-by-one error in find_next_zero_area

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
 lib/iommu-helper.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/lib/iommu-helper.c b/lib/iommu-helper.c
index 75dbda0..afc58bc 100644
--- a/lib/iommu-helper.c
+++ b/lib/iommu-helper.c
@@ -19,7 +19,7 @@ again:
 	index = (index + align_mask) & ~align_mask;
 
 	end = index + nr;
-	if (end >= size)
+	if (end > size)
 		return -1;
 	for (i = index; i < end; i++) {
 		if (test_bit(i, map)) {
-- 
1.5.4.3

