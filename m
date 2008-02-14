From: David Miller <davem@davemloft.net>
Date: Thu, 14 Feb 2008 01:09:38 +0000
Subject: [PATCH 0/4]: Respun LMB patches.
Message-Id: <20080213.170938.34536425.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linuxppc-dev@ozlabs.org
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


I've taken into consideration the various feedback, and
ported the bug fix and other LMB patches posted recently
in an effort to keep the patch churn by others down wrt.
my moving of these files.

1) Use HAVE_LMB as suggested by Sam.

2) Fix potential build errors wrt. asm/prom.h dependencies.

   My algorithm was:

   a) If the file only included asm/lmb.h I added an include
      of both linux/lmb.c and asm/prom.h

   b) If the file already includes asm/prom.h, I merely
      changed the asm/lmb.h to linux/lmb.h

   Header include mimimizations can be done as followon patches.

3) Integrate Kumar Gala's initial region fix.

4) Integrate Becky Bruce's large physical addressing change,
   but using u64 instead of phys_addr_t.

It's all at:

	master.kernel.org:/pub/scm/linux/kernel/git/davem/lmb-2.6.git

like before.
