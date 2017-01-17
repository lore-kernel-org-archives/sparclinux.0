From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
Date: Tue, 17 Jan 2017 15:59:01 +0000
Subject: [PATCH v3 0/2] sparc64: Recover from userspace non-resumable PIO & MEM errors
Message-Id: <1484668743-9205-1-git-send-email-Liam.Howlett@Oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

A non-resumable error from userspace is able to cause a kernel panic or trap
loop due to the setup and handling of the queued traps once in the kernel.
This patch series addresses both of these issues.

The queues are fixed by simply zeroing the memory before use.

PIO errors from userspace will result in a SIGBUS being sent to the user
process.

The MEM errors form userspace will result in a SIGKILL and also cause the
offending pages to be claimed so they are no longer used in future tasks.
SIGKILL is used to ensure that the process does not try to coredump and result
in an attempt to read the memory again from within kernel space.  Although
there is a HV call to scrub the memory (mem_scrub), there is no easy way to
guarantee that the real memory address(es) are not used by other tasks.
Clearing the error with mem_scrub would zero the memory and cause the other
processes to proceed with bad data.

The handling of other non-resumable errors remain unchanged and will cause a
panic.


Changelog v2 to v3:
  Fix newline in an expression as an argument.
  Remove extra new line.

Changelog v1 to v2:
  Only handle PIO and MEM non-resumable errors from userspace and leave other
  error handling unchanged.
  Move the userspace non-resumable error handling in its own function.

Liam R. Howlett (2):
  sparc64: Zero pages on allocation for mondo and error queues.
  sparc64: Handle PIO & MEM non-resumable errors.

 arch/sparc/kernel/irq_64.c   |  2 +-
 arch/sparc/kernel/traps_64.c | 73 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 74 insertions(+), 1 deletion(-)

-- 
2.1.4

