From: SF Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 25 Aug 2016 08:20:18 +0000
Subject: [PATCH 0/2] sparc: Fine-tuning for three function implementations
Message-Id: <0ca0235c-ddb9-0534-3bde-b4aaa48da92e@users.sourceforge.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>, Paolo Bonzini <pbonzini@redhat.com>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 25 Aug 2016 10:05:45 +0200

A few update suggestions were taken into account
from static source code analysis.

Markus Elfring (2):
  Use kmalloc_array()
  Delete an unnecessary initialisation in led_proc_write()

 arch/sparc/kernel/led.c          | 4 ++--
 arch/sparc/kernel/nmi.c          | 4 +++-
 arch/sparc/kernel/sys_sparc_64.c | 6 ++++--
 3 files changed, 9 insertions(+), 5 deletions(-)

-- 
2.9.3

