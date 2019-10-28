From: Tuowen Zhao <ztuowen@gmail.com>
Date: Mon, 28 Oct 2019 20:46:00 +0000
Subject: Fwd: [PATCH v5 1/4] sparc64: implement ioremap_uc
Message-Id: <5c5b9dec7ea401fffa13446af2a528cbaf6e1046.camel@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20191016210629.1005086-2-ztuowen@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org, "davem@davemloft.net" <davem@davemloft.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "lee.jones@linaro.org" <lee.jones@linaro.org>, andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com, acelan.kao@canonical.com, mcgrof@kernel.org

Adding sparc list. Sorry, first time missed the list.

Looking for some reviews.

Patch set: Fix MTRR bug for intel-lpss-pci
https://lkml.org/lkml/2019/10/16/1230

Tuowen

-------- Forwarded Message --------
From: Tuowen Zhao <ztuowen@gmail.com>
To: lee.jones@linaro.org, linux-kernel@vger.kernel.org
Cc: andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com,
acelan.kao@canonical.com, mcgrof@kernel.org, davem@davemloft.net, 
Tuowen Zhao <ztuowen@gmail.com>, kbuild test robot <lkp@intel.com>
Subject: [PATCH v5 1/4] sparc64: implement ioremap_uc
Date: Wed, 16 Oct 2019 15:06:27 -0600

On sparc64, the whole physical IO address space is accessible using
physically addressed loads and stores. *_uc does nothing like the
others.

Cc: <stable@vger.kernel.org>
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Tuowen Zhao <ztuowen@gmail.com>
---
 arch/sparc/include/asm/io_64.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sparc/include/asm/io_64.h
b/arch/sparc/include/asm/io_64.h
index 688911051b44..f4afa301954a 100644
--- a/arch/sparc/include/asm/io_64.h
+++ b/arch/sparc/include/asm/io_64.h
@@ -407,6 +407,7 @@ static inline void __iomem *ioremap(unsigned long
offset, unsigned long size)
 }
 
 #define ioremap_nocache(X,Y)		ioremap((X),(Y))
+#define ioremap_uc(X,Y)			ioremap((X),(Y))
 #define ioremap_wc(X,Y)			ioremap((X),(Y))
 #define ioremap_wt(X,Y)			ioremap((X),(Y))
 
-- 
2.23.0
