From: Vijay Kumar <vijay.ac.kumar@oracle.com>
Date: Fri, 11 Nov 2016 18:11:55 +0000
Subject: [PATCH v2 0/4] sparc64: Jump to boot prom from console on panic
Message-Id: <1478887919-10361-1-git-send-email-vijay.ac.kumar@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net, sparclinux@vger.kernel.org
Cc: karl.volz@oracle.com, rob.gardner@oracle.com, linux-kernel@vger.kernel.org

Currently Stop-A (L1A) does not make the kernel switch to OBP on panic. This
patchset addresses this issue. Also, now we can cause a jump to OBP by sending
'break' twice from sunhv console. On bare metal, one can send a break by
typing Esc + 'B' + Sysrq (or whatever). On LDOM, press Ctrl + ] in telnet,
and then "send break" at the telnet prompt.

      sparc64: Set cpu state to offline when stopped
      sparc64: Migrate hvcons irq to panicked cpu
      sparc64: Send break twice from console to return to boot prom
      Documentation/sparc: Steps for sending break on sunhv console

 Documentation/sparc/console.txt |    9 +++++++++
 arch/sparc/include/asm/setup.h  |    1 +
 arch/sparc/kernel/smp_64.c      |    9 ++++++++-
 drivers/tty/serial/sunhv.c      |   12 +++++++++++-
 kernel/panic.c                  |    3 ++-
 5 files changed, 31 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/sparc/console.txt



--
1.7.1
