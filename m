From: James Clarke <jrtc27@jrtc27.com>
Date: Mon, 29 May 2017 19:17:00 +0000
Subject: [PATCH v2 0/1] sparc: Machine description indices can vary
Message-Id: <20170529191701.29000-1-jrtc27@jrtc27.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Changes since v1:
 * Dropped "sparc: Remove corresponding sysfs file on device remove"
   - I initially thought this was a problem before writing the second patch,
     but now realise the second patch is what's needed.

James Clarke (1):
  sparc: Machine description indices can vary

 arch/sparc/include/asm/vio.h |  1 +
 arch/sparc/kernel/vio.c      | 68 +++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 65 insertions(+), 4 deletions(-)

-- 
2.11.0

