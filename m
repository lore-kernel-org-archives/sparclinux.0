From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Date: Mon, 22 Apr 2019 13:28:02 +0000
Subject: [PATCH v2 73/79] docs: sparc: convert to ReST
Message-Id: <c3fa91bf9974bf9029c76d0a9adb96c66b3876e4.1555938376.git.mchehab+samsung@kernel.org>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1555938375.git.mchehab+samsung@kernel.org>
In-Reply-To: <cover.1555938375.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Mauro Carvalho Chehab <mchehab@infradead.org>, linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org

Rename the sparc documentation files to ReST, add an
index for them and adjust in order to produce a nice html
output via the Sphinx build system.

There is an except from a document under oradax dir.
It doesn't seem to make much sense to convert this one
to ReST, so let's add it as an included document.

At its new index.rst, let's add a :orphan: while this is not linked to
the main index.rst file, in order to avoid build warnings.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/sparc/{adi.txt => adi.rst}      | 174 +++++++++---------
 .../sparc/{console.txt => console.rst}        |   4 +-
 Documentation/sparc/index.rst                 |  13 ++
 .../oradax/{oracle-dax.txt => oracle-dax.rst} |  58 +++---
 drivers/sbus/char/oradax.c                    |   2 +-
 5 files changed, 144 insertions(+), 107 deletions(-)
 rename Documentation/sparc/{adi.txt => adi.rst} (70%)
 rename Documentation/sparc/{console.txt => console.rst} (53%)
 create mode 100644 Documentation/sparc/index.rst
 rename Documentation/sparc/oradax/{oracle-dax.txt => oracle-dax.rst} (95%)

diff --git a/Documentation/sparc/adi.txt b/Documentation/sparc/adi.rst
similarity index 70%
rename from Documentation/sparc/adi.txt
rename to Documentation/sparc/adi.rst
index e1aed155fb89..857ad30f9569 100644
--- a/Documentation/sparc/adi.txt
+++ b/Documentation/sparc/adi.rst
@@ -1,3 +1,4 @@
+================
 Application Data Integrity (ADI)
 ================
 
@@ -44,12 +45,15 @@ provided by the hypervisor to the kernel.  Kernel returns the value of
 ADI block size to userspace using auxiliary vector along with other ADI
 info. Following auxiliary vectors are provided by the kernel:
 
+	======	===================== 	AT_ADI_BLKSZ	ADI block size. This is the granularity and
 			alignment, in bytes, of ADI versioning.
 	AT_ADI_NBITS	Number of ADI version bits in the VA
+	======	===================== 
 
-IMPORTANT NOTES:
+IMPORTANT NOTES
+======= 
 - Version tag values of 0x0 and 0xf are reserved. These values match any
   tag in virtual address and never generate a mismatch exception.
@@ -86,11 +90,12 @@ IMPORTANT NOTES:
 
 
 ADI related traps
------------------
+======== 
 With ADI enabled, following new traps may occur:
 
 Disrupting memory corruption
+----------------------------
 
 	When a store accesses a memory localtion that has TTE.mcd=1,
 	the task is running with ADI enabled (PSTATE.mcde=1), and the ADI
@@ -100,7 +105,7 @@ Disrupting memory corruption
 	first. Hypervisor creates a sun4v error report and sends a
 	resumable error (TT=0x7e) trap to the kernel. The kernel sends
 	a SIGSEGV to the task that resulted in this trap with the following
-	info:
+	info::
 
 		siginfo.si_signo = SIGSEGV;
 		siginfo.errno = 0;
@@ -110,6 +115,7 @@ Disrupting memory corruption
 
 
 Precise memory corruption
+-------------------------
 
 	When a store accesses a memory location that has TTE.mcd=1,
 	the task is running with ADI enabled (PSTATE.mcde=1), and the ADI
@@ -118,7 +124,7 @@ Precise memory corruption
 	MCD precise exception is enabled (MCDPERR=1), a precise
 	exception is sent to the kernel with TT=0x1a. The kernel sends
 	a SIGSEGV to the task that resulted in this trap with the following
-	info:
+	info::
 
 		siginfo.si_signo = SIGSEGV;
 		siginfo.errno = 0;
@@ -126,17 +132,19 @@ Precise memory corruption
 		siginfo.si_addr = addr;	/* address that caused trap */
 		siginfo.si_trapno = 0;
 
-	NOTE: ADI tag mismatch on a load always results in precise trap.
+	NOTE:
+		ADI tag mismatch on a load always results in precise trap.
 
 
 MCD disabled
+------------
 
 	When a task has not enabled ADI and attempts to set ADI version
 	on a memory address, processor sends an MCD disabled trap. This
 	trap is handled by hypervisor first and the hypervisor vectors this
 	trap through to the kernel as Data Access Exception trap with
 	fault type set to 0xa (invalid ASI). When this occurs, the kernel
-	sends the task SIGSEGV signal with following info:
+	sends the task SIGSEGV signal with following info::
 
 		siginfo.si_signo = SIGSEGV;
 		siginfo.errno = 0;
@@ -149,35 +157,35 @@ Sample program to use ADI
 -------------------------
 
 Following sample program is meant to illustrate how to use the ADI
-functionality.
+functionality::
 
-#include <unistd.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <elf.h>
-#include <sys/ipc.h>
-#include <sys/shm.h>
-#include <sys/mman.h>
-#include <asm/asi.h>
+  #include <unistd.h>
+  #include <stdio.h>
+  #include <stdlib.h>
+  #include <elf.h>
+  #include <sys/ipc.h>
+  #include <sys/shm.h>
+  #include <sys/mman.h>
+  #include <asm/asi.h>
 
-#ifndef AT_ADI_BLKSZ
-#define AT_ADI_BLKSZ	48
-#endif
-#ifndef AT_ADI_NBITS
-#define AT_ADI_NBITS	49
-#endif
+  #ifndef AT_ADI_BLKSZ
+  #define AT_ADI_BLKSZ	48
+  #endif
+  #ifndef AT_ADI_NBITS
+  #define AT_ADI_NBITS	49
+  #endif
 
-#ifndef PROT_ADI
-#define PROT_ADI	0x10
-#endif
+  #ifndef PROT_ADI
+  #define PROT_ADI	0x10
+  #endif
 
-#define BUFFER_SIZE     32*1024*1024UL
+  #define BUFFER_SIZE     32*1024*1024UL
 
-main(int argc, char* argv[], char* envp[])
-{
-        unsigned long i, mcde, adi_blksz, adi_nbits;
-        char *shmaddr, *tmp_addr, *end, *veraddr, *clraddr;
-        int shmid, version;
+  main(int argc, char* argv[], char* envp[])
+  {
+          unsigned long i, mcde, adi_blksz, adi_nbits;
+          char *shmaddr, *tmp_addr, *end, *veraddr, *clraddr;
+          int shmid, version;
 	Elf64_auxv_t *auxv;
 
 	adi_blksz = 0;
@@ -202,77 +210,77 @@ main(int argc, char* argv[], char* envp[])
 	printf("\tBlock size = %ld\n", adi_blksz);
 	printf("\tNumber of bits = %ld\n", adi_nbits);
 
-        if ((shmid = shmget(2, BUFFER_SIZE,
-                                IPC_CREAT | SHM_R | SHM_W)) < 0) {
-                perror("shmget failed");
-                exit(1);
-        }
+          if ((shmid = shmget(2, BUFFER_SIZE,
+                                  IPC_CREAT | SHM_R | SHM_W)) < 0) {
+                  perror("shmget failed");
+                  exit(1);
+          }
 
-        shmaddr = shmat(shmid, NULL, 0);
-        if (shmaddr = (char *)-1) {
-                perror("shm attach failed");
-                shmctl(shmid, IPC_RMID, NULL);
-                exit(1);
-        }
+          shmaddr = shmat(shmid, NULL, 0);
+          if (shmaddr = (char *)-1) {
+                  perror("shm attach failed");
+                  shmctl(shmid, IPC_RMID, NULL);
+                  exit(1);
+          }
 
 	if (mprotect(shmaddr, BUFFER_SIZE, PROT_READ|PROT_WRITE|PROT_ADI)) {
 		perror("mprotect failed");
 		goto err_out;
 	}
 
-        /* Set the ADI version tag on the shm segment
-         */
-        version = 10;
-        tmp_addr = shmaddr;
-        end = shmaddr + BUFFER_SIZE;
-        while (tmp_addr < end) {
-                asm volatile(
-                        "stxa %1, [%0]0x90\n\t"
-                        :
-                        : "r" (tmp_addr), "r" (version));
-                tmp_addr += adi_blksz;
-        }
+          /* Set the ADI version tag on the shm segment
+           */
+          version = 10;
+          tmp_addr = shmaddr;
+          end = shmaddr + BUFFER_SIZE;
+          while (tmp_addr < end) {
+                  asm volatile(
+                          "stxa %1, [%0]0x90\n\t"
+                          :
+                          : "r" (tmp_addr), "r" (version));
+                  tmp_addr += adi_blksz;
+          }
 	asm volatile("membar #Sync\n\t");
 
-        /* Create a versioned address from the normal address by placing
+          /* Create a versioned address from the normal address by placing
 	 * version tag in the upper adi_nbits bits
-         */
-        tmp_addr = (void *) ((unsigned long)shmaddr << adi_nbits);
-        tmp_addr = (void *) ((unsigned long)tmp_addr >> adi_nbits);
-        veraddr = (void *) (((unsigned long)version << (64-adi_nbits))
-                        | (unsigned long)tmp_addr);
+           */
+          tmp_addr = (void *) ((unsigned long)shmaddr << adi_nbits);
+          tmp_addr = (void *) ((unsigned long)tmp_addr >> adi_nbits);
+          veraddr = (void *) (((unsigned long)version << (64-adi_nbits))
+                          | (unsigned long)tmp_addr);
 
-        printf("Starting the writes:\n");
-        for (i = 0; i < BUFFER_SIZE; i++) {
-                veraddr[i] = (char)(i);
-                if (!(i % (1024 * 1024)))
-                        printf(".");
-        }
-        printf("\n");
+          printf("Starting the writes:\n");
+          for (i = 0; i < BUFFER_SIZE; i++) {
+                  veraddr[i] = (char)(i);
+                  if (!(i % (1024 * 1024)))
+                          printf(".");
+          }
+          printf("\n");
 
-        printf("Verifying data...");
+          printf("Verifying data...");
 	fflush(stdout);
-        for (i = 0; i < BUFFER_SIZE; i++)
-                if (veraddr[i] != (char)i)
-                        printf("\nIndex %lu mismatched\n", i);
-        printf("Done.\n");
+          for (i = 0; i < BUFFER_SIZE; i++)
+                  if (veraddr[i] != (char)i)
+                          printf("\nIndex %lu mismatched\n", i);
+          printf("Done.\n");
 
-        /* Disable ADI and clean up
-         */
+          /* Disable ADI and clean up
+           */
 	if (mprotect(shmaddr, BUFFER_SIZE, PROT_READ|PROT_WRITE)) {
 		perror("mprotect failed");
 		goto err_out;
 	}
 
-        if (shmdt((const void *)shmaddr) != 0)
-                perror("Detach failure");
-        shmctl(shmid, IPC_RMID, NULL);
+          if (shmdt((const void *)shmaddr) != 0)
+                  perror("Detach failure");
+          shmctl(shmid, IPC_RMID, NULL);
 
-        exit(0);
+          exit(0);
 
-err_out:
-        if (shmdt((const void *)shmaddr) != 0)
-                perror("Detach failure");
-        shmctl(shmid, IPC_RMID, NULL);
-        exit(1);
-}
+  err_out:
+          if (shmdt((const void *)shmaddr) != 0)
+                  perror("Detach failure");
+          shmctl(shmid, IPC_RMID, NULL);
+          exit(1);
+  }
diff --git a/Documentation/sparc/console.txt b/Documentation/sparc/console.rst
similarity index 53%
rename from Documentation/sparc/console.txt
rename to Documentation/sparc/console.rst
index 5aa735a44e02..73132db83ece 100644
--- a/Documentation/sparc/console.txt
+++ b/Documentation/sparc/console.rst
@@ -1,5 +1,5 @@
-Steps for sending 'break' on sunhv console:
-=====================+Steps for sending 'break' on sunhv console
+=====================
 
 On Baremetal:
    1. press   Esc + 'B'
diff --git a/Documentation/sparc/index.rst b/Documentation/sparc/index.rst
new file mode 100644
index 000000000000..91f7d6643dd5
--- /dev/null
+++ b/Documentation/sparc/index.rst
@@ -0,0 +1,13 @@
+:orphan:
+
+=========
+Sparc Architecture
+=========
+
+.. toctree::
+   :maxdepth: 1
+
+   console
+   adi
+
+   oradax/oracle-dax
diff --git a/Documentation/sparc/oradax/oracle-dax.txt b/Documentation/sparc/oradax/oracle-dax.rst
similarity index 95%
rename from Documentation/sparc/oradax/oracle-dax.txt
rename to Documentation/sparc/oradax/oracle-dax.rst
index 9d53ac93286f..d1e14d572918 100644
--- a/Documentation/sparc/oradax/oracle-dax.txt
+++ b/Documentation/sparc/oradax/oracle-dax.rst
@@ -1,5 +1,6 @@
+=================== Oracle Data Analytics Accelerator (DAX)
----------------------------------------
+=================== 
 DAX is a coprocessor which resides on the SPARC M7 (DAX1) and M8
 (DAX2) processor chips, and has direct access to the CPU's L3 caches
@@ -17,6 +18,7 @@ code sufficient to write user or kernel applications that use DAX
 functionality.
 
 The user library is open source and available at:
+
     https://oss.oracle.com/git/gitweb.cgi?p=libdax.git
 
 The Hypervisor interface to the coprocessor is described in detail in
@@ -26,7 +28,7 @@ Specification" version 3.0.20+15, dated 2017-09-25.
 
 
 High Level Overview
--------------------
+========= 
 A coprocessor request is described by a Command Control Block
 (CCB). The CCB contains an opcode and various parameters. The opcode
@@ -52,7 +54,7 @@ thread.
 
 
 Addressing Memory
------------------
+======== 
 The kernel does not have access to physical memory in the Sun4v
 architecture, as there is an additional level of memory virtualization
@@ -77,7 +79,7 @@ the request.
 
 
 The Driver API
---------------
+=======
 
 An application makes requests to the driver via the write() system
 call, and gets results (if any) via read(). The completion areas are
@@ -108,6 +110,7 @@ equal to the number of bytes given in the call. Otherwise -1 is
 returned and errno is set.
 
 CCB_DEQUEUE
+-----------
 
 Tells the driver to clean up resources associated with past
 requests. Since no interrupt is generated upon the completion of a
@@ -116,12 +119,14 @@ further status information is returned, so the user should not
 subsequently call read().
 
 CCB_KILL
+--------
 
 Kills a CCB during execution. The CCB is guaranteed to not continue
 executing once this call returns successfully. On success, read() must
 be called to retrieve the result of the action.
 
 CCB_INFO
+--------
 
 Retrieves information about a currently executing CCB. Note that some
 Hypervisors might return 'notfound' when the CCB is in 'inprogress'
@@ -130,6 +135,7 @@ CCB_KILL must be invoked on that CCB. Upon success, read() must be
 called to retrieve the details of the action.
 
 Submission of an array of CCBs for execution
+---------------------------------------------
 
 A write() whose length is a multiple of the CCB size is treated as a
 submit operation. The file offset is treated as the index of the
@@ -146,6 +152,7 @@ status will reflect the error caused by the first CCB that was not
 accepted, and status_data will provide additional data in some cases.
 
 MMAP
+----
 
 The mmap() function provides access to the completion area allocated
 in the driver.  Note that the completion area is not writeable by the
@@ -153,7 +160,7 @@ user process, and the mmap call must not specify PROT_WRITE.
 
 
 Completion of a Request
------------------------
+=========== 
 The first byte in each completion area is the command status which is
 updated by the coprocessor hardware. Software may take advantage of
@@ -172,7 +179,7 @@ and resumption of execution may be just a few nanoseconds.
 
 
 Application Life Cycle of a DAX Submission
-------------------------------------------
+=====================
 
  - open dax device
  - call mmap() to get the completion area address
@@ -187,7 +194,7 @@ Application Life Cycle of a DAX Submission
 
 
 Memory Constraints
-------------------
+=========
 
 The DAX hardware operates only on physical addresses. Therefore, it is
 not aware of virtual memory mappings and the discontiguities that may
@@ -226,7 +233,7 @@ CCB Structure
 -------------
 A CCB is an array of 8 64-bit words. Several of these words provide
 command opcodes, parameters, flags, etc., and the rest are addresses
-for the completion area, output buffer, and various inputs:
+for the completion area, output buffer, and various inputs::
 
    struct ccb {
        u64   control;
@@ -252,7 +259,7 @@ The first word (control) is examined by the driver for the following:
 
 
 Example Code
-------------
+======
 
 The DAX is accessible to both user and kernel code.  The kernel code
 can make hypercalls directly while the user code must use wrappers
@@ -265,7 +272,7 @@ arch/sparc/include/uapi/asm/oradax.h must be included.
 
 First, the proper device must be opened. For M7 it will be
 /dev/oradax1 and for M8 it will be /dev/oradax2. The simplest
-procedure is to attempt to open both, as only one will succeed:
+procedure is to attempt to open both, as only one will succeed::
 
 	fd = open("/dev/oradax1", O_RDWR);
 	if (fd < 0)
@@ -273,7 +280,7 @@ procedure is to attempt to open both, as only one will succeed:
 	if (fd < 0)
 	       /* No DAX found */
 
-Next, the completion area must be mapped:
+Next, the completion area must be mapped::
 
       completion_area = mmap(NULL, DAX_MMAP_LEN, PROT_READ, MAP_SHARED, fd, 0);
 
@@ -295,7 +302,7 @@ is the input bitmap inverted.
 
 For details of all the parameters and bits used in this CCB, please
 refer to section 36.2.1.3 of the DAX Hypervisor API document, which
-describes the Scan command in detail.
+describes the Scan command in detail::
 
 	ccb->control =       /* Table 36.1, CCB Header Format */
 		  (2L << 48)     /* command = Scan Value */
@@ -326,7 +333,7 @@ describes the Scan command in detail.
 
 The CCB submission is a write() or pwrite() system call to the
 driver. If the call fails, then a read() must be used to retrieve the
-status:
+status::
 
 	if (pwrite(fd, ccb, 64, 0) != 64) {
 		struct ccb_exec_result status;
@@ -337,7 +344,7 @@ status:
 After a successful submission of the CCB, the completion area may be
 polled to determine when the DAX is finished. Detailed information on
 the contents of the completion area can be found in section 36.2.2 of
-the DAX HV API document.
+the DAX HV API document::
 
 	while (1) {
 		/* Monitored Load */
@@ -355,7 +362,7 @@ the DAX HV API document.
 A completion area status of 1 indicates successful completion of the
 CCB and validity of the output bitmap, which may be used immediately.
 All other non-zero values indicate error conditions which are
-described in section 36.2.2.
+described in section 36.2.2::
 
 	if (completion_area[0] != 1) {	/* section 36.2.2, 1 = command ran and succeeded */
 		/* completion_area[0] contains the completion status */
@@ -364,7 +371,7 @@ described in section 36.2.2.
 
 After the completion area has been processed, the driver must be
 notified that it can release any resources associated with the
-request. This is done via the dequeue operation:
+request. This is done via the dequeue operation::
 
 	struct dax_command cmd;
 	cmd.command = CCB_DEQUEUE;
@@ -375,13 +382,14 @@ request. This is done via the dequeue operation:
 Finally, normal program cleanup should be done, i.e., unmapping
 completion area, closing the dax device, freeing memory etc.
 
-[Kernel example]
+Kernel example
+--------------
 
 The only difference in using the DAX in kernel code is the treatment
 of the completion area. Unlike user applications which mmap the
 completion area allocated by the driver, kernel code must allocate its
 own memory to use for the completion area, and this address and its
-type must be given in the CCB:
+type must be given in the CCB::
 
 	ccb->control |=      /* Table 36.1, CCB Header Format */
 	        (3L << 32);     /* completion area address type = primary virtual */
@@ -389,9 +397,11 @@ type must be given in the CCB:
 	ccb->completion = (unsigned long) completion_area;   /* Completion area address */
 
 The dax submit hypercall is made directly. The flags used in the
-ccb_submit call are documented in the DAX HV API in section 36.3.1.
+ccb_submit call are documented in the DAX HV API in section 36.3.1/
 
-#include <asm/hypervisor.h>
+::
+
+  #include <asm/hypervisor.h>
 
 	hv_rv = sun4v_ccb_submit((unsigned long)ccb, 64,
 				 HV_CCB_QUERY_CMD |
@@ -405,7 +415,7 @@ ccb_submit call are documented in the DAX HV API in section 36.3.1.
 	}
 
 After the submission, the completion area polling code is identical to
-that in user land:
+that in user land::
 
 	while (1) {
 		/* Monitored Load */
@@ -427,3 +437,9 @@ that in user land:
 
 The output bitmap is ready for consumption immediately after the
 completion status indicates success.
+
+Excer[t from UltraSPARC Virtual Machine Specification
+==========================+
+ .. include:: dax-hv-api.txt
+    :literal:
diff --git a/drivers/sbus/char/oradax.c b/drivers/sbus/char/oradax.c
index 790aa148670d..8090dc9a1514 100644
--- a/drivers/sbus/char/oradax.c
+++ b/drivers/sbus/char/oradax.c
@@ -30,7 +30,7 @@
  * the recommended way for applications to use the coprocessor, and
  * the driver interface is not intended for general use.
  *
- * See Documentation/sparc/oradax/oracle-dax.txt for more details.
+ * See Documentation/sparc/oradax/oracle-dax.rst for more details.
  */
 
 #include <linux/uaccess.h>
-- 
2.20.1
