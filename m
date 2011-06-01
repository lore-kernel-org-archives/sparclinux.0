From: Kjetil Oftedal <oftedal@gmail.com>
Date: Wed, 01 Jun 2011 20:29:31 +0000
Subject: [PATCH 0/3] Bugfixes for sun4d after genirq changes
Message-Id: <Pine.LNX.4.64.1106012201440.16937@oizys.tordivel.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


This patch set fixes some sun4d specific bugs introduced by the changes 
performed during the introduction of genirq for sparc32 
(6baa9b20a68a88c2fd751cbe8d7652009379351b)
These changes allows for sun4d based systems to boot without crashing or 
enter eternal loops:
- Restructuring of sun4d_build_device_irq
- Bugfixes in communication with interrupt controllers
- Add irq support for bootbus devices


Kjetil Oftedal

---
 arch/sparc/kernel/sun4d_irq.c |  126 
++++++++++++++++++++++++++---------------
 1 files changed, 81 insertions(+), 45 deletions(-)

