From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
Date: Fri, 06 Jan 2017 19:38:58 +0000
Subject: [PATCH 0/2] sparc64: Recover from user generated non-resumable errors
Message-Id: <1483731540-8055-1-git-send-email-Liam.Howlett@Oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

The non-resumable errors from userspace has been able to cause kernel panics or
trap loops due to the setup and handling of the queued traps once in the
kernel.  This patch series addresses both of these issues by preventing the
panic by sending a SIGBUS error to the offending process and by zeroing the
queue memory before use.

Liam R. Howlett (2):
  sparc64: Don't panic on user mode non-resumable errors
  sparc64: Zero pages on allocation for mondo and error queues.

 arch/sparc/kernel/irq_64.c   |  2 +-
 arch/sparc/kernel/traps_64.c | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+), 1 deletion(-)

-- 
2.1.4

