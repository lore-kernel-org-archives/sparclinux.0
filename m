From: Rob Gardner <rob.gardner@oracle.com>
Date: Tue, 29 Aug 2017 23:36:03 +0000
Subject: [RFC 2/2] sparc64: Oracle DAX driver
Message-Id: <1504049763-51918-3-git-send-email-rob.gardner@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

DAX is a coprocessor which resides on the SPARC M7 (DAX1) and M8
(DAX2) processor chips, and has direct access to the CPU's L3 caches
as well as physical memory. It can perform several operations on data
streams with various input and output formats.  This driver provides a
transport mechanism and does not have knowledge of the various opcodes
and data formats. A user space library provides high level services
and translates these into low level commands which are then passed
into the driver and subsequently the hypervisor and the coprocessor.
The library is the recommended way for applications to use the
coprocessor, and the driver interface is not intended for general use.

Signed-off-by: Rob Gardner <rob.gardner@oracle.com>
Signed-off-by: Jonathan Helman <jonathan.helman@oracle.com>
Signed-off-by: Sanath Kumar <sanath.s.kumar@oracle.com>
---
 Documentation/sparc/oracle_dax.txt   |  210 ++++++++
 arch/sparc/include/uapi/asm/oradax.h |   91 ++++
 drivers/sbus/char/Kconfig            |    8 +
 drivers/sbus/char/Makefile           |    1 +
 drivers/sbus/char/oradax.c           |  951 ++++++++++++++++++++++++++++++++++
 5 files changed, 1261 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/sparc/oracle_dax.txt
 create mode 100644 arch/sparc/include/uapi/asm/oradax.h
 create mode 100644 drivers/sbus/char/oradax.c

diff --git a/Documentation/sparc/oracle_dax.txt b/Documentation/sparc/oracle_dax.txt
new file mode 100644
index 0000000..3265081
--- /dev/null
+++ b/Documentation/sparc/oracle_dax.txt
@@ -0,0 +1,210 @@
+Oracle Data Analytics Accelerator (DAX)
+---------------------------------------
+
+DAX is a coprocessor which resides on the SPARC M7 (DAX1) and M8
+(DAX2) processor chips, and has direct access to the CPU's L3 caches
+as well as physical memory. It can perform several operations on data
+streams with various input and output formats.  A driver provides a
+transport mechanism and does not have knowledge of the various opcodes
+and data formats. A user space library (insert link here) provides
+high level services and translates these into low level commands which
+are then passed into the driver and subsequently the Hypervisor and
+the coprocessor.  The library is the recommended way for applications
+to use the coprocessor, and the driver interface is not intended for
+general use.  This document describes the general flow of the driver,
+its structures, and its programmatic interface.
+
+
+High Level Overview
+-------------------
+
+A coprocessor request is described by a Command Control Block
+(CCB). The CCB contains an opcode and various parameters. The opcode
+specifies what operation is to be done, and the parameters specify
+options, flags, sizes, and addresses.  The CCB (or an array of CCBs)
+is passed to the Hypervisor, which handles queueing and scheduling of
+requests to the available coprocessor execution units. A status code
+returned indicates if the request was submitted successfully or if
+there was an error.  One of the addresses given in each CCB is a
+pointer to a "completion area", which is a 128 byte memory block that
+is written by the coprocessor to provide execution status. No
+interrupt is generated upon completion; the completion area must be
+polled by software to find out when a transaction has finished, but
+the M7 and later processors provide a mechanism to pause the virtual
+processor until the completion status has been updated by the
+coprocessor. This is done using the monitored load and mwait
+instructions, which are described in more detail later.  The DAX
+coprocessor was designed so that after a request is submitted, the
+kernel is no longer involved in the processing of it.  The polling is
+done at the user level, which results in almost zero latency between
+completion of a request and resumption of execution of the requesting
+thread.
+
+
+Addressing Memory
+-----------------
+
+The kernel does not have access to physical memory in the Sun4v
+architecture, as there is an additional level of memory virtualization
+present. This intermediate level is called "real" memory, and the
+kernel treats this as if it were physical.  The Hypervisor handles the
+translations between real memory and physical so that each logical
+domain (LDOM) can have a partition of physical memory that is isolated
+from that of other LDOMs.  When the kernel sets up a virtual mapping,
+it specifies a virtual address and the real address to which it should
+be mapped.
+
+The DAX coprocessor can only operate on physical memory, so before a
+request can be fed to the coprocessor, all the addresses in a CCB must
+be converted into physical addresses. The kernel cannot do this since
+it has no visibility into physical addresses. So a CCB may contain
+either the virtual or real addresses of the buffers or a combination
+of them. An "address type" field is available for each address that
+may be given in the CCB. In all cases, the Hypervisor will translate
+all the addresses to physical before dispatching to hardware.
+
+
+The Driver API
+--------------
+
+An application makes requests to the driver via the write() system
+call, and gets results (if any) via read(). The completion areas are
+made accessible via mmap(), and are read-only for the application.
+
+The request may either be an immediate command or an array of CCBs to
+be submitted to the hardware.
+
+Each open instance of the device is exclusive to the thread that
+opened it, and must be used by that thread for all subsequent
+operations. The driver open function creates a new context for the
+thread and initializes it for use.  This context contains pointers and
+values used internally by the driver to keep track of submitted
+requests. The completion area buffer is also allocated, and this is
+large enough to contain the completion areas for many concurrent
+requests.  When the device is closed, any outstanding transactions are
+flushed and the context is cleaned up.
+
+On a DAX1 system (M7), the device will be called "oradax1", while on a
+DAX2 system (M8) it will be "oradax2". If an application requires one
+or the other, it should simply attempt to open the appropriate
+device. Only one of the devices will exist on any given system, so the
+name can be used to determine what the platform supports.
+
+The immediate commands are CCB_DEQUEUE, CCB_KILL, and CCB_INFO. For
+all of these, success is indicated by a return value from write()
+equal to the number of bytes given in the call. Otherwise -1 is
+returned and errno is set.
+
+CCB_DEQUEUE
+
+Tells the driver to clean up resources associated with past
+requests. Since no interrupt is generated upon the completion of a
+request, the driver must be told when it may reclaim resources.  No
+further status information is returned, so the user should not
+subsequently call read().
+
+CCB_KILL
+
+Kills a CCB during execution. The CCB is guaranteed to not continue
+executing once this call returns successfully. On success, read() must
+be called to retrieve the result of the action.
+
+CCB_INFO
+
+Retrieves information about a currently executing CCB. Note that some
+Hypervisors might return 'notfound' when the CCB is in 'inprogress'
+state. To ensure a CCB in the 'notfound' state will never be executed,
+CCB_KILL must be invoked on that CCB. Upon success, read() must be
+called to retrieve the details of the action.
+
+Submission of an array of CCBs for execution
+
+A write() whose length is a multiple of the CCB size is treated as a
+submit operation. The file offset is treated as the index of the
+completion area to use, and may be set via lseek() or using the
+pwrite() system call. If -1 is returned then errno is set to indicate
+the error. Otherwise, the return value is the length of the array that
+was actually accepted by the coprocessor. If the accepted length is
+equal to the requested length, then the operation was completely
+successful and there is no further status needed; hence, the user
+should not subsequently call read(). Partial acceptance of the CCB
+array is indicated by a return value less than the requested length,
+and read() must be called to retrieve further status information.  The
+status will reflect the error caused by the first CCB that was not
+accepted, and status_data will provide additional data in some cases.
+
+MMAP
+
+The mmap() function provides access to the completion area allocated
+in the driver.  Note that the completion area is not writeable by the
+user process.
+
+
+Completion of a Request
+-----------------------
+
+The first byte in each completion area is the command status which is
+updated by the coprocessor hardware. Software may take advantage of
+new M7/M8 processor capabilities to efficiently poll this status byte.
+First, a "monitored load" is achieved via a Load from Alternate Space
+(ldxa, lduba, etc.) with ASI 0x84 (ASI_MONITOR_PRIMARY).  Second, a
+"monitored wait" is achieved via the mwait instruction. This
+instruction is like pause in that it suspends execution of the virtual
+processor, but in addition will terminate early when one of several
+events occur. If the block of data containing the monitored location
+is modified, then the mwait terminates. This allows software to resume
+execution immediately (without a context switch or kernel to user
+transition) after a transaction completes. Thus the latency between
+transaction completion and resumption of execution may be just a few
+nanoseconds.
+
+
+Application Life Cycle of a DAX Submission
+------------------------------------------
+
+ - open dax device
+ - call mmap() to get the completion area address
+ - allocate a CCB and fill in the opcode, flags, parameter, addresses, etc.
+ - submit CCB via write()
+ - go into a loop executing monitored load + monitored wait and
+   terminate when the command status indicates the request is complete
+   (CCB_KILL or CCB_INFO may be used any time as necessary)
+ - perform a CCB_DEQUEUE
+ - call munmap() for completion area
+ - close the dax device
+
+
+Memory Constraints
+------------------
+
+The DAX hardware operates only on physical addresses. Therefore, it is
+not aware of virtual memory mappings and the discontiguities that may
+exist in the physical memory that a virtual buffer maps to. There is
+no I/O TLB or any scatter/gather mechanism. All buffers, whether input
+or output, must reside in a physically contiguous region of memory.
+
+The Hypervisor translates all addresses within a CCB to physical
+before handing off the CCB to DAX. The Hypervisor determines the
+virtual page size for each virtual address given, and uses this to
+program a size limit for each address. This prevents the coprocessor
+from reading or writing beyond the bound of the virtual page, even
+though it is accessing physical memory directly. A simpler way of
+saying this is that a DAX operation will never "cross" a virtual page
+boundary. If an 8k virtual page is used, then the data is strictly
+limited to 8k. If a user's buffer is larger than 8k, then a larger
+page size must be used, or the transaction size will be truncated to
+8k.
+
+Huge pages. A user may allocate huge pages using standard
+interfaces. Memory buffers residing on huge pages may be used to
+achieve much larger DAX transaction sizes, but the rules must still be
+followed, and no transaction will cross a page boundary, even a huge
+page.  A major caveat is that Linux on Sparc presents 8Mb as one of
+the huge page sizes. Sparc does not actually provide a 8Mb hardware
+page size, and this size is synthesized by pasting together two 4Mb
+pages. The reasons for this are historical, and it creates an issue
+because only half of this 8Mb page can actually be used for any given
+buffer in a DAX request, and it must be either the first half or the
+second half; it cannot be a 4Mb chunk in the middle, since that
+crosses a (hardware) page boundary. Note that this entire issue may be
+hidden by higher level libraries.
diff --git a/arch/sparc/include/uapi/asm/oradax.h b/arch/sparc/include/uapi/asm/oradax.h
new file mode 100644
index 0000000..7229519
--- /dev/null
+++ b/arch/sparc/include/uapi/asm/oradax.h
@@ -0,0 +1,91 @@
+/*
+ * Copyright (c) 2017, Oracle and/or its affiliates. All rights reserved.
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 3 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+/*
+ * Oracle DAX driver API definitions
+ */
+
+#ifndef _ORADAX_H
+#define	_ORADAX_H
+
+#include <linux/types.h>
+
+#define	CCB_KILL 0
+#define	CCB_INFO 1
+#define	CCB_DEQUEUE 2
+
+struct dax_command {
+	__u16 command;		/* CCB_KILL/INFO/DEQUEUE */
+	__u16 ca_offset;	/* offset into mmapped completion area */
+};
+
+struct ccb_kill_result {
+	__u16 action;		/* action taken to kill ccb */
+};
+
+struct ccb_info_result {
+	__u16 state;		/* state of enqueued ccb */
+	__u16 inst_num;		/* dax instance number of enqueued ccb */
+	__u16 q_num;		/* queue number of enqueued ccb */
+	__u16 q_pos;		/* ccb position in queue */
+};
+
+struct ccb_exec_result {
+	__u64	status_data;	/* additional status data (e.g. bad VA) */
+	__u32	status;		/* one of DAX_SUBMIT_* */
+};
+
+union ccb_result {
+	struct ccb_exec_result exec;
+	struct ccb_info_result info;
+	struct ccb_kill_result kill;
+};
+
+#define	DAX_MMAP_LEN		(16 * 1024)
+#define	DAX_MAX_CCBS		15
+#define	DAX_CCB_BUF_MAXLEN	(DAX_MAX_CCBS * 64)
+#define	DAX_NAME		"oradax"
+
+/* CCB_EXEC status */
+#define	DAX_SUBMIT_OK			0
+#define	DAX_SUBMIT_ERR_RETRY		1
+#define	DAX_SUBMIT_ERR_WOULDBLOCK	2
+#define	DAX_SUBMIT_ERR_BUSY		3
+#define	DAX_SUBMIT_ERR_THR_INIT		4
+#define	DAX_SUBMIT_ERR_ARG_INVAL	5
+#define	DAX_SUBMIT_ERR_CCB_INVAL	6
+#define	DAX_SUBMIT_ERR_NO_CA_AVAIL	7
+#define	DAX_SUBMIT_ERR_CCB_ARR_MMU_MISS	8
+#define	DAX_SUBMIT_ERR_NOMAP		9
+#define	DAX_SUBMIT_ERR_NOACCESS		10
+#define	DAX_SUBMIT_ERR_TOOMANY		11
+#define	DAX_SUBMIT_ERR_UNAVAIL		12
+#define	DAX_SUBMIT_ERR_INTERNAL		13
+
+/* CCB_INFO states - must match HV_CCB_STATE_* definitions */
+#define	DAX_CCB_COMPLETED	0
+#define	DAX_CCB_ENQUEUED	1
+#define	DAX_CCB_INPROGRESS	2
+#define	DAX_CCB_NOTFOUND	3
+
+/* CCB_KILL actions - must match HV_CCB_KILL_* definitions */
+#define	DAX_KILL_COMPLETED	0
+#define	DAX_KILL_DEQUEUED	1
+#define	DAX_KILL_KILLED		2
+#define	DAX_KILL_NOTFOUND	3
+
+#endif /* _ORADAX_H */
diff --git a/drivers/sbus/char/Kconfig b/drivers/sbus/char/Kconfig
index 5ba684f..a785aa7 100644
--- a/drivers/sbus/char/Kconfig
+++ b/drivers/sbus/char/Kconfig
@@ -70,5 +70,13 @@ config DISPLAY7SEG
 	  another UltraSPARC-IIi-cEngine boardset with a 7-segment display,
 	  you should say N to this option.
 
+config ORACLE_DAX
+	tristate "Oracle Data Analytics Accelerator"
+	default m if SPARC64
+	help
+	 Driver for Oracle Data Analytics Accelerator, which is
+	 a coprocessor that performs database operations in hardware.
+	 It is available on M7 and M8 based systems only.
+
 endmenu
 
diff --git a/drivers/sbus/char/Makefile b/drivers/sbus/char/Makefile
index 78b6183..cdb5565 100644
--- a/drivers/sbus/char/Makefile
+++ b/drivers/sbus/char/Makefile
@@ -16,3 +16,4 @@ obj-$(CONFIG_SUN_OPENPROMIO)		+= openprom.o
 obj-$(CONFIG_TADPOLE_TS102_UCTRL)	+= uctrl.o
 obj-$(CONFIG_SUN_JSFLASH)		+= jsflash.o
 obj-$(CONFIG_BBC_I2C)			+= bbc.o
+obj-$(CONFIG_ORACLE_DAX) 		+= oradax.o
diff --git a/drivers/sbus/char/oradax.c b/drivers/sbus/char/oradax.c
new file mode 100644
index 0000000..2edfffc
--- /dev/null
+++ b/drivers/sbus/char/oradax.c
@@ -0,0 +1,951 @@
+/*
+ * Copyright (c) 2017, Oracle and/or its affiliates. All rights reserved.
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 3 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+/*
+ * Oracle Data Analytics Accelerator (DAX)
+ *
+ * DAX is a coprocessor which resides on the SPARC M7 (DAX1) and M8
+ * (DAX2) processor chips, and has direct access to the CPU's L3
+ * caches as well as physical memory. It can perform several
+ * operations on data streams with various input and output formats.
+ * The driver provides a transport mechanism and does not have
+ * knowledge of the various opcodes and data formats. A user space
+ * library provides high level services and translates these into low
+ * level commands which are then passed into the driver and
+ * subsequently the hypervisor and the coprocessor.  The library is
+ * the recommended way for applications to use the coprocessor, and
+ * the driver interface is not intended for general use.
+ *
+ * See Documentation/sparc/oracle_dax.txt for more details.
+ */
+
+#include <linux/uaccess.h>
+#include <linux/module.h>
+#include <linux/delay.h>
+#include <linux/cdev.h>
+#include <linux/slab.h>
+#include <linux/mm.h>
+
+#include <asm/hypervisor.h>
+#include <asm/mdesc.h>
+#include <asm/oradax.h>
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Driver for Oracle Data Analytics Accelerator");
+
+#define	DAX_DBG_FLG_BASIC	0x01
+#define	DAX_DBG_FLG_STAT	0x02
+#define	DAX_DBG_FLG_INFO	0x04
+#define	DAX_DBG_FLG_ALL		0xff
+
+#define	dax_err(fmt, ...)      pr_err("%s: " fmt "\n", __func__, ##__VA_ARGS__)
+#define	dax_info(fmt, ...)     pr_info("%s: " fmt "\n", __func__, ##__VA_ARGS__)
+
+#define	dax_dbg(fmt, ...)	do {					\
+					if (dax_debug & DAX_DBG_FLG_BASIC)\
+						dax_info(fmt, ##__VA_ARGS__); \
+				} while (0)
+#define	dax_stat_dbg(fmt, ...)	do {					\
+					if (dax_debug & DAX_DBG_FLG_STAT) \
+						dax_info(fmt, ##__VA_ARGS__); \
+				} while (0)
+#define	dax_info_dbg(fmt, ...)	do { \
+					if (dax_debug & DAX_DBG_FLG_INFO) \
+						dax_info(fmt, ##__VA_ARGS__); \
+				} while (0)
+
+#define	DAX1_MINOR		1
+#define	DAX1_MAJOR		1
+#define	DAX2_MINOR		0
+#define	DAX2_MAJOR		2
+
+#define	DAX1_STR    "ORCL,sun4v-dax"
+#define	DAX2_STR    "ORCL,sun4v-dax2"
+
+#define	DAX_CA_ELEMS		(DAX_MMAP_LEN / sizeof(struct compl_area))
+
+#define	DAX_CCB_USEC		100
+#define	DAX_CCB_RETRIES		10000
+
+/* stream types */
+enum {
+	DEST,
+	SRC0,
+	SRC1,
+	TBL,
+	NUM_STREAM_TYPES
+};
+
+/* CCB address types */
+#define	CCB_AT_IMM		0	/* immediate */
+#define	CCB_AT_VA_ALT		1	/* secondary context */
+#define	CCB_AT_RA		2	/* real address */
+#define	CCB_AT_VA		3	/* virtual address */
+
+/* CCB dword index values */
+#define	CCB_DWORD_CTL		0
+#define	CCB_DWORD_COMPL		1
+#define	CCB_DWORD_INPUT		2
+#define	CCB_DWORD_DAC		3
+#define	CCB_DWORD_SEC_INPUT	4
+#define	CCB_DWORD_RSVD		5
+#define	CCB_DWORD_OUTPUT	6
+#define	CCB_DWORD_TBL		7
+#define	DWORDS_PER_CCB		8
+
+/* CCB header sync flags */
+#define	CCB_SYNC_SERIAL		BIT(0)
+#define	CCB_SYNC_COND		BIT(1)
+#define	CCB_SYNC_LONGCCB	BIT(2)
+
+/* Completion area cmd_status */
+#define	CCB_CMD_STAT_IN_PROGRESS	0
+#define	CCB_CMD_STAT_COMPLETED		1
+#define	CCB_CMD_STAT_FAILED		2
+#define	CCB_CMD_STAT_KILLED		3
+#define	CCB_CMD_STAT_NOT_RUN		4
+#define	CCB_CMD_STAT_NO_OUTPUT		5
+#define	CCB_CMD_STAT_PIPE_ERR_SRC	6
+#define	CCB_CMD_STAT_PIPE_ERR_DST	7
+
+/* Completion area err_mask of user visible errors */
+#define	CCB_CMD_ERR_BOF			0x1	/* buffer overflow */
+#define	CCB_CMD_ERR_DECODE		0x2	/* CCB decode error */
+#define	CCB_CMD_ERR_POF			0x3	/* page overflow */
+#define	CCB_CMD_ERR_KILL		0x7	/* command was killed */
+#define	CCB_CMD_ERR_TO			0x8	/* command timeout */
+#define	CCB_CMD_ERR_MCD			0x9	/* MCD error */
+#define	CCB_CMD_ERR_DATA_FMT		0xA	/* data format error */
+#define	CCB_CMD_ERR_NO_RETRY		0xE	/* other error, don't retry */
+#define	CCB_CMD_ERR_RETRY		0xF	/* other error, do retry */
+#define	CCB_CMD_ERR_PARTIAL_SYM		0x80	/* partial symbol warning */
+
+#define	IS_LONG_CCB(ccb)	\
+	((ccb)->hdr.sync_flags & CCB_SYNC_LONGCCB)
+
+struct ccb_hdr {
+	u32	rsvd:4;
+	u32	sync_flags:4;
+	u32	rsvd2:11;
+	/* use CCB_AT_* macros for at_* fields */
+	u32	at_tbl:2;
+	u32	at_dst:3;
+	u32	at_src1:3;
+	u32	at_src0:3;
+	u32	at_cmpl:2;
+};
+
+union ccb {
+	u64			dwords[DWORDS_PER_CCB];
+	struct ccb_hdr		hdr;
+};
+
+struct compl_area {
+	u8	cmd_status;	/* user may mwait on this address */
+	u8	err_mask;	/* user visible error notification */
+	u8	rsvd[2];	/* reserved */
+	u32	rsvd2;		/* reserved */
+	u32	output_sz;	/* Bytes of output */
+	u32	rsvd3;		/* reserved */
+	u64	run_time;	/* run time in OCND2 cycles */
+	u64	run_stats;	/* nothing reported for DAX1 nor in DAX2 */
+	u32	n_processed;	/* input elements processed */
+	u32	rsvd4[5];	/* reserved */
+	u64	command_rv;	/* command return value */
+	u64	rsvd5[8];	/* reserved */
+};
+
+/* per thread CCB context */
+struct dax_ctx {
+	union ccb		*ccb_buf;
+	u64			ccb_buf_ra;	/* cached RA of ccb_buf  */
+	struct compl_area	*ca_buf;
+	u64			ca_buf_ra;	/* cached RA of ca_buf   */
+	struct page		*pages[DAX_CA_ELEMS][NUM_STREAM_TYPES];
+						/* array of locked pages */
+	struct task_struct	*owner;		/* thread that owns ctx  */
+	struct task_struct	*client;	/* requesting thread     */
+	union ccb_result	result;
+	u32			ccb_count;
+	u32			fail_count;
+};
+
+/* driver public entry points */
+static int dax_open(struct inode *inode, struct file *file);
+static ssize_t dax_read(struct file *filp, char __user *buf,
+			size_t count, loff_t *ppos);
+static ssize_t dax_write(struct file *filp, const char __user *buf,
+			 size_t count, loff_t *ppos);
+static int dax_devmap(struct file *f, struct vm_area_struct *vma);
+static int dax_close(struct inode *i, struct file *f);
+
+static const struct file_operations dax_fops = {
+	.owner	=	THIS_MODULE,
+	.open	=	dax_open,
+	.read	=	dax_read,
+	.write	=	dax_write,
+	.mmap	=	dax_devmap,
+	.release =	dax_close,
+};
+
+static int dax_ccb_exec(struct dax_ctx *ctx, const char __user *buf,
+			size_t count, loff_t *ppos);
+static int dax_ccb_info(u64 ca, struct ccb_info_result *info);
+static int dax_ccb_kill(u64 ca, u16 *kill_res);
+
+static struct cdev c_dev;
+static struct class *cl;
+static dev_t first;
+
+static int dax_debug;
+module_param(dax_debug, int, 0644);
+MODULE_PARM_DESC(dax_debug, "Debug flags");
+
+static int __init dax_attach(void)
+{
+	unsigned long dummy, hv_rv, major, minor, minor_requested, max_ccbs;
+	struct mdesc_handle *hp = mdesc_grab();
+	char *prop, *dax_name;
+	bool found = false;
+	int len, ret = 0;
+	u64 pn;
+
+	if (hp = NULL) {
+		dax_err("Unable to grab mdesc");
+		return -ENODEV;
+	}
+
+	mdesc_for_each_node_by_name(hp, pn, "virtual-device") {
+		prop = (char *)mdesc_get_property(hp, pn, "name", &len);
+		if (prop = NULL)
+			continue;
+		if (strncmp(prop, "dax", strlen("dax")))
+			continue;
+		dax_dbg("Found node 0x%llx = %s", pn, prop);
+
+		prop = (char *)mdesc_get_property(hp, pn, "compatible", &len);
+		if (prop = NULL)
+			continue;
+		dax_dbg("Found node 0x%llx = %s", pn, prop);
+		found = true;
+		break;
+	}
+
+	if (!found) {
+		dax_err("No DAX device found");
+		ret = -ENODEV;
+		goto done;
+	}
+
+	if (strncmp(prop, DAX2_STR, strlen(DAX2_STR)) = 0) {
+		dax_name = DAX_NAME "2";
+		major = DAX2_MAJOR;
+		minor_requested = DAX2_MINOR;
+		dax_dbg("MD indicates DAX2 coprocessor");
+	} else if (strncmp(prop, DAX1_STR, strlen(DAX1_STR)) = 0) {
+		dax_name = DAX_NAME "1";
+		major = DAX1_MAJOR;
+		minor_requested = DAX1_MINOR;
+		dax_dbg("MD indicates DAX1 coprocessor");
+	} else {
+		dax_err("Unknown dax type: %s", prop);
+		ret = -ENODEV;
+		goto done;
+	}
+
+	minor = minor_requested;
+	dax_dbg("Registering DAX HV api with major %ld minor %ld", major,
+		minor);
+	if (sun4v_hvapi_register(HV_GRP_DAX, major, &minor)) {
+		dax_err("hvapi_register failed");
+		ret = -ENODEV;
+		goto done;
+	} else {
+		dax_dbg("Max minor supported by HV = %ld (major %ld)", minor,
+			major);
+		minor = min(minor, minor_requested);
+		dax_dbg("registered DAX major %ld minor %ld", major, minor);
+	}
+
+	/* submit a zero length ccb array to query coprocessor queue size */
+	hv_rv = sun4v_ccb_submit(0, 0, HV_CCB_QUERY_CMD, 0, &max_ccbs, &dummy);
+	if (hv_rv != 0) {
+		dax_err("get_hwqueue_size failed with status=%ld and max_ccbs=%ld",
+			hv_rv, max_ccbs);
+		ret = -ENODEV;
+		goto done;
+	}
+
+	if (max_ccbs != DAX_MAX_CCBS) {
+		dax_err("HV reports unsupported max_ccbs=%ld", max_ccbs);
+		ret = -ENODEV;
+		goto done;
+	}
+
+	if (alloc_chrdev_region(&first, 0, 1, DAX_NAME) < 0) {
+		dax_err("alloc_chrdev_region failed");
+		ret = -ENXIO;
+		goto done;
+	}
+
+	cl = class_create(THIS_MODULE, DAX_NAME);
+	if (cl = NULL) {
+		dax_err("class_create failed");
+		ret = -ENXIO;
+		goto class_error;
+	}
+
+	if (device_create(cl, NULL, first, NULL, dax_name) = NULL) {
+		dax_err("device_create failed");
+		ret = -ENXIO;
+		goto device_error;
+	}
+
+	cdev_init(&c_dev, &dax_fops);
+	if (cdev_add(&c_dev, first, 1) = -1) {
+		dax_err("cdev_add failed");
+		ret = -ENXIO;
+		goto cdev_error;
+	}
+
+	pr_info("Attached DAX module\n");
+	goto done;
+
+cdev_error:
+	device_destroy(cl, first);
+device_error:
+	class_destroy(cl);
+class_error:
+	unregister_chrdev_region(first, 1);
+done:
+	mdesc_release(hp);
+	return ret;
+}
+module_init(dax_attach);
+
+static void __exit dax_detach(void)
+{
+	pr_info("Cleaning up DAX module\n");
+	cdev_del(&c_dev);
+	device_destroy(cl, first);
+	class_destroy(cl);
+	unregister_chrdev_region(first, 1);
+}
+module_exit(dax_detach);
+
+/* map completion area */
+static int dax_devmap(struct file *f, struct vm_area_struct *vma)
+{
+	struct dax_ctx *ctx = (struct dax_ctx *)f->private_data;
+	size_t len = vma->vm_end - vma->vm_start;
+
+	dax_dbg("len=0x%lx, flags=0x%lx", len, vma->vm_flags);
+
+	if (ctx->owner != current) {
+		dax_dbg("devmap called from wrong thread");
+		return -EINVAL;
+	}
+
+	if (len != DAX_MMAP_LEN) {
+		dax_dbg("len(%lu) != DAX_MMAP_LEN(%d)", len, DAX_MMAP_LEN);
+		return -EINVAL;
+	}
+
+	/* completion area is mapped read-only for user */
+	if (vma->vm_flags & VM_WRITE)
+		return -EPERM;
+	vma->vm_flags &= ~VM_MAYWRITE;
+
+	if (remap_pfn_range(vma, vma->vm_start, ctx->ca_buf_ra >> PAGE_SHIFT,
+			    len, vma->vm_page_prot))
+		return -EAGAIN;
+
+	dax_dbg("mmapped completion area at uva 0x%lx", vma->vm_start);
+	return 0;
+}
+
+/* Unlock user pages. Called during dequeue or device close */
+static void dax_unlock_pages(struct dax_ctx *ctx, int ccb_index, int nelem)
+{
+	int i, j;
+
+	for (i = ccb_index; i < ccb_index + nelem; i++) {
+		for (j = 0; j < NUM_STREAM_TYPES; j++) {
+			struct page *p = ctx->pages[i][j];
+
+			if (p) {
+				dax_dbg("freeing page %p", p);
+				if (j = DEST)
+					set_page_dirty(p);
+				put_page(p);
+				ctx->pages[i][j] = NULL;
+			}
+		}
+	}
+}
+
+static int dax_lock_page(unsigned long va, struct page **p)
+{
+	int ret;
+
+	dax_dbg("uva 0x%lx", va);
+
+	ret = get_user_pages_fast(va, 1, 1, p);
+	if (ret = 1) {
+		dax_dbg("locked page %p, for VA 0x%lx", *p, va);
+		return 0;
+	}
+
+	dax_dbg("get_user_pages failed, va=0x%lx, ret=%d", va, ret);
+	return -1;
+}
+
+static int dax_lock_pages(struct dax_ctx *ctx, int idx,
+			  int nelem, u64 *err_va)
+{
+	int i;
+
+	for (i = 0; i < nelem; i++) {
+		union ccb *ccbp = &ctx->ccb_buf[i];
+
+		/*
+		 * For each address in the CCB whose type is virtual,
+		 * lock the page and change the type to virtual alternate
+		 * context. On error, return the offending address in
+		 * err_va.
+		 */
+		if (ccbp->hdr.at_dst = CCB_AT_VA) {
+			dax_dbg("output");
+			if (dax_lock_page(ccbp->dwords[CCB_DWORD_OUTPUT],
+					  &ctx->pages[i + idx][DEST]) != 0) {
+				*err_va = ccbp->dwords[CCB_DWORD_OUTPUT];
+				goto error;
+			}
+			ccbp->hdr.at_dst = CCB_AT_VA_ALT;
+		}
+
+		if (ccbp->hdr.at_src0 = CCB_AT_VA) {
+			dax_dbg("input");
+			if (dax_lock_page(ccbp->dwords[CCB_DWORD_INPUT],
+					  &ctx->pages[i + idx][SRC0]) != 0) {
+				*err_va = ccbp->dwords[CCB_DWORD_INPUT];
+				goto error;
+			}
+			ccbp->hdr.at_src0 = CCB_AT_VA_ALT;
+		}
+
+		if (ccbp->hdr.at_src1 = CCB_AT_VA) {
+			dax_dbg("sec input");
+			if (dax_lock_page(ccbp->dwords[CCB_DWORD_SEC_INPUT],
+					  &ctx->pages[i + idx][SRC1]) != 0) {
+				*err_va = ccbp->dwords[CCB_DWORD_SEC_INPUT];
+				goto error;
+			}
+			ccbp->hdr.at_src1 = CCB_AT_VA_ALT;
+		}
+
+		if (ccbp->hdr.at_tbl = CCB_AT_VA) {
+			dax_dbg("tbl");
+			if (dax_lock_page(ccbp->dwords[CCB_DWORD_TBL],
+					  &ctx->pages[i + idx][TBL]) != 0) {
+				*err_va = ccbp->dwords[CCB_DWORD_TBL];
+				goto error;
+			}
+			ccbp->hdr.at_tbl = CCB_AT_VA_ALT;
+		}
+
+		/* skip over 2nd 64 bytes of long CCB */
+		if (IS_LONG_CCB(ccbp))
+			i++;
+	}
+	return DAX_SUBMIT_OK;
+
+error:
+	dax_unlock_pages(ctx, idx, nelem);
+	return DAX_SUBMIT_ERR_NOACCESS;
+}
+
+static void dax_ccb_wait(struct dax_ctx *ctx, int idx)
+{
+	int ret, nretries;
+	u16 kill_res;
+
+	dax_dbg("idx=%d", idx);
+
+	for (nretries = 0; nretries < DAX_CCB_RETRIES; nretries++) {
+		if (ctx->ca_buf[idx].cmd_status = CCB_CMD_STAT_IN_PROGRESS)
+			udelay(DAX_CCB_USEC);
+		else
+			return;
+	}
+	dax_dbg("ctx (%p): CCB[%d] timed out, wait usec=%d, retries=%d. Killing ccb",
+		(void *)ctx, idx, DAX_CCB_USEC, DAX_CCB_RETRIES);
+
+	ret = dax_ccb_kill(ctx->ca_buf_ra + idx * sizeof(struct compl_area),
+			   &kill_res);
+	dax_dbg("Kill CCB[%d] %s", idx, ret ? "failed" : "succeeded");
+}
+
+static int dax_close(struct inode *ino, struct file *f)
+{
+	struct dax_ctx *ctx = (struct dax_ctx *)f->private_data;
+	int i;
+
+	f->private_data = NULL;
+
+	for (i = 0; i < DAX_CA_ELEMS; i++) {
+		if (ctx->ca_buf[i].cmd_status = CCB_CMD_STAT_IN_PROGRESS) {
+			dax_dbg("CCB[%d] not completed", i);
+			dax_ccb_wait(ctx, i);
+		}
+		dax_unlock_pages(ctx, i, 1);
+	}
+
+	kfree(ctx->ccb_buf);
+	kfree(ctx->ca_buf);
+	dax_stat_dbg("CCBs: %d good, %d bad", ctx->ccb_count, ctx->fail_count);
+	kfree(ctx);
+
+	return 0;
+}
+
+static ssize_t dax_read(struct file *f, char __user *buf,
+			size_t count, loff_t *ppos)
+{
+	struct dax_ctx *ctx = f->private_data;
+
+	if (ctx->client != current)
+		return -EUSERS;
+
+	ctx->client = NULL;
+
+	if (count != sizeof(union ccb_result))
+		return -EINVAL;
+	if (copy_to_user(buf, &ctx->result, sizeof(union ccb_result)))
+		return -EFAULT;
+	return count;
+}
+
+static ssize_t dax_write(struct file *f, const char __user *buf,
+			 size_t count, loff_t *ppos)
+{
+	struct dax_ctx *ctx = f->private_data;
+	struct dax_command hdr;
+	unsigned long ca;
+	int i, idx, ret;
+
+	if (ctx->client != NULL)
+		return -EINVAL;
+
+	if (count = 0 || count > DAX_MAX_CCBS * sizeof(union ccb))
+		return -EINVAL;
+
+	if (count % sizeof(union ccb) = 0)
+		return dax_ccb_exec(ctx, buf, count, ppos); /* CCB EXEC */
+
+	if (count != sizeof(struct dax_command))
+		return -EINVAL;
+
+	/* immediate command */
+	if (ctx->owner != current)
+		return -EUSERS;
+
+	if (copy_from_user(&hdr, buf, sizeof(hdr)))
+		return -EFAULT;
+
+	ca = ctx->ca_buf_ra + hdr.ca_offset;
+
+	switch (hdr.command) {
+	case CCB_KILL:
+		if (hdr.ca_offset >= DAX_MMAP_LEN) {
+			dax_dbg("invalid ca_offset (%d) >= ca_buflen (%d)",
+				hdr.ca_offset, DAX_MMAP_LEN);
+			return -EINVAL;
+		}
+
+		ret = dax_ccb_kill(ca, &ctx->result.kill.action);
+		if (ret != 0) {
+			dax_dbg("dax_ccb_kill failed (ret=%d)", ret);
+			return ret;
+		}
+
+		dax_info_dbg("killed (ca_offset %d)", hdr.ca_offset);
+		idx = hdr.ca_offset / sizeof(struct compl_area);
+		ctx->ca_buf[idx].cmd_status = CCB_CMD_STAT_KILLED;
+		ctx->ca_buf[idx].err_mask = CCB_CMD_ERR_KILL;
+		ctx->client = current;
+		return count;
+
+	case CCB_INFO:
+		if (hdr.ca_offset >= DAX_MMAP_LEN) {
+			dax_dbg("invalid ca_offset (%d) >= ca_buflen (%d)",
+				hdr.ca_offset, DAX_MMAP_LEN);
+			return -EINVAL;
+		}
+
+		ret = dax_ccb_info(ca, &ctx->result.info);
+		if (ret != 0) {
+			dax_dbg("dax_ccb_info failed (ret=%d)", ret);
+			return ret;
+		}
+
+		dax_info_dbg("info succeeded on ca_offset %d", hdr.ca_offset);
+		ctx->client = current;
+		return count;
+
+	case CCB_DEQUEUE:
+		for (i = 0; i < DAX_CA_ELEMS; i++) {
+			if (ctx->ca_buf[i].cmd_status !+			    CCB_CMD_STAT_IN_PROGRESS)
+				dax_unlock_pages(ctx, i, 1);
+		}
+		return count;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static int dax_open(struct inode *inode, struct file *f)
+{
+	struct dax_ctx *ctx = NULL;
+	int i;
+
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+	if (ctx = NULL)
+		goto done;
+
+	ctx->ccb_buf = kcalloc(DAX_MAX_CCBS, sizeof(union ccb), GFP_KERNEL);
+	if (ctx->ccb_buf = NULL)
+		goto done;
+
+	ctx->ccb_buf_ra = virt_to_phys(ctx->ccb_buf);
+	dax_dbg("ctx->ccb_buf=0x%p, ccb_buf_ra=0x%llx",
+		(void *)ctx->ccb_buf, ctx->ccb_buf_ra);
+
+	/* allocate CCB completion area buffer */
+	ctx->ca_buf = kzalloc(DAX_MMAP_LEN, GFP_KERNEL);
+	if (ctx->ca_buf = NULL)
+		goto alloc_error;
+	for (i = 0; i < DAX_CA_ELEMS; i++)
+		ctx->ca_buf[i].cmd_status = CCB_CMD_STAT_COMPLETED;
+
+	ctx->ca_buf_ra = virt_to_phys(ctx->ca_buf);
+	dax_dbg("ctx=0x%p, ctx->ca_buf=0x%p, ca_buf_ra=0x%llx",
+		(void *)ctx, (void *)ctx->ca_buf, ctx->ca_buf_ra);
+
+	ctx->owner = current;
+	f->private_data = ctx;
+	return 0;
+
+alloc_error:
+	kfree(ctx->ccb_buf);
+done:
+	if (ctx != NULL)
+		kfree(ctx);
+	return -ENOMEM;
+}
+
+static char *dax_hv_errno(unsigned long hv_ret, int *ret)
+{
+	switch (hv_ret) {
+	case HV_EBADALIGN:
+		*ret = -EFAULT;
+		return "HV_EBADALIGN";
+	case HV_ENORADDR:
+		*ret = -EFAULT;
+		return "HV_ENORADDR";
+	case HV_EINVAL:
+		*ret = -EINVAL;
+		return "HV_EINVAL";
+	case HV_EWOULDBLOCK:
+		*ret = -EAGAIN;
+		return "HV_EWOULDBLOCK";
+	case HV_ENOACCESS:
+		*ret = -EPERM;
+		return "HV_ENOACCESS";
+	default:
+		break;
+	}
+
+	*ret = -EIO;
+	return "UNKNOWN";
+}
+
+static int dax_ccb_kill(u64 ca, u16 *kill_res)
+{
+	unsigned long hv_ret;
+	int count, ret = 0;
+	char *err_str;
+
+	for (count = 0; count < DAX_CCB_RETRIES; count++) {
+		dax_dbg("attempting kill on ca_ra 0x%llx", ca);
+		hv_ret = sun4v_ccb_kill(ca, kill_res);
+
+		if (hv_ret = HV_EOK) {
+			dax_info_dbg("HV_EOK (ca_ra 0x%llx): %d", ca,
+				     *kill_res);
+		} else {
+			err_str = dax_hv_errno(hv_ret, &ret);
+			dax_dbg("%s (ca_ra 0x%llx)", err_str, ca);
+		}
+
+		if (ret != -EAGAIN)
+			return ret;
+		dax_info_dbg("ccb_kill count = %d", count);
+		udelay(DAX_CCB_USEC);
+	}
+
+	return -EAGAIN;
+}
+
+static int dax_ccb_info(u64 ca, struct ccb_info_result *info)
+{
+	unsigned long hv_ret;
+	char *err_str;
+	int ret = 0;
+
+	dax_dbg("attempting info on ca_ra 0x%llx", ca);
+	hv_ret = sun4v_ccb_info(ca, info);
+
+	if (hv_ret = HV_EOK) {
+		dax_info_dbg("HV_EOK (ca_ra 0x%llx): %d", ca, info->state);
+		if (info->state = DAX_CCB_ENQUEUED) {
+			dax_info_dbg("dax_unit %d, queue_num %d, queue_pos %d",
+				     info->inst_num, info->q_num, info->q_pos);
+		}
+	} else {
+		err_str = dax_hv_errno(hv_ret, &ret);
+		dax_dbg("%s (ca_ra 0x%llx)", err_str, ca);
+	}
+
+	return ret;
+}
+
+static void dax_prt_ccbs(union ccb *ccb, int nelem)
+{
+	int i, j;
+
+	dax_dbg("ccb buffer:");
+	for (i = 0; i < nelem; i++) {
+		dax_dbg(" %sccb[%d]", IS_LONG_CCB(&ccb[i]) ? "long " : "",  i);
+		for (j = 0; j < DWORDS_PER_CCB; j++)
+			dax_dbg("\tccb[%d].dwords[%d]=0x%llx",
+				i, j, ccb[i].dwords[j]);
+	}
+}
+
+/*
+ * Validates user CCB content.  Also sets completion address and address types
+ * for all addresses contained in CCB.
+ */
+static int dax_preprocess_usr_ccbs(struct dax_ctx *ctx, int idx, int nelem)
+{
+	int i;
+
+	/*
+	 * The user is not allowed to specify real address types in
+	 * the CCB header.  This must be enforced by the kernel before
+	 * submitting the CCBs to HV.  The only allowed values for all
+	 * address fields are VA or IMM
+	 */
+	for (i = 0; i < nelem; i++) {
+		union ccb *ccbp = &ctx->ccb_buf[i];
+		unsigned long ca_offset;
+
+		if (ccbp->hdr.at_dst != CCB_AT_VA &&
+		    ccbp->hdr.at_dst != CCB_AT_IMM) {
+			dax_dbg("invalid at_dst in user CCB[%d]", i);
+			return DAX_SUBMIT_ERR_CCB_INVAL;
+		}
+
+		if (ccbp->hdr.at_src0 != CCB_AT_VA &&
+		    ccbp->hdr.at_src0 != CCB_AT_IMM) {
+			dax_dbg("invalid at_src0 in user CCB[%d]", i);
+			return DAX_SUBMIT_ERR_CCB_INVAL;
+		}
+
+		if (ccbp->hdr.at_src1 != CCB_AT_VA &&
+		    ccbp->hdr.at_src1 != CCB_AT_IMM) {
+			dax_dbg("invalid at_src1 in user CCB[%d]", i);
+			return DAX_SUBMIT_ERR_CCB_INVAL;
+		}
+
+		if (ccbp->hdr.at_tbl != CCB_AT_VA &&
+		    ccbp->hdr.at_tbl != CCB_AT_IMM) {
+			dax_dbg("invalid at_tbl in user CCB[%d]", i);
+			return DAX_SUBMIT_ERR_CCB_INVAL;
+		}
+
+		/* set completion (real) address and address type */
+		ccbp->hdr.at_cmpl = CCB_AT_RA;
+		ca_offset = (idx + i) * sizeof(struct compl_area);
+		ccbp->dwords[CCB_DWORD_COMPL] = ctx->ca_buf_ra + ca_offset;
+		memset(&ctx->ca_buf[idx + i], 0, sizeof(struct compl_area));
+
+		dax_dbg("ccb[%d]=%p, ca_offset=0x%lx, compl RA=0x%llx",
+			i, ccbp, ca_offset, ctx->ca_buf_ra + ca_offset);
+
+		/* skip over 2nd 64 bytes of long CCB */
+		if (IS_LONG_CCB(ccbp))
+			i++;
+	}
+
+	return DAX_SUBMIT_OK;
+}
+
+static int dax_ccb_exec(struct dax_ctx *ctx, const char __user *buf,
+			size_t count, loff_t *ppos)
+{
+	unsigned long accepted_len, hv_rv;
+	int i, idx, nccbs, naccepted;
+
+	ctx->client = current;
+	idx = *ppos;
+	nccbs = count / sizeof(union ccb);
+
+	if (ctx->owner != current) {
+		dax_dbg("wrong thread");
+		ctx->result.exec.status = DAX_SUBMIT_ERR_THR_INIT;
+		return 0;
+	}
+	dax_dbg("args: ccb_buf_len=%ld, idx=%d", count, idx);
+
+	/* for given index and length, verify ca_buf range exists */
+	if (idx + nccbs >= DAX_CA_ELEMS) {
+		ctx->result.exec.status = DAX_SUBMIT_ERR_NO_CA_AVAIL;
+		return 0;
+	}
+
+	/*
+	 * Copy CCBs into kernel buffer to prevent modification by the
+	 * user in between validation and submission.
+	 */
+	if (copy_from_user(ctx->ccb_buf, buf, count)) {
+		dax_dbg("copyin of user CCB buffer failed");
+		ctx->result.exec.status = DAX_SUBMIT_ERR_CCB_ARR_MMU_MISS;
+		return 0;
+	}
+
+	/* check to see if ca_buf[idx] .. ca_buf[idx + nccbs] are available */
+	for (i = idx; i < idx + nccbs; i++) {
+		if (ctx->ca_buf[i].cmd_status = CCB_CMD_STAT_IN_PROGRESS) {
+			dax_dbg("CA range not available, dequeue needed");
+			ctx->result.exec.status = DAX_SUBMIT_ERR_NO_CA_AVAIL;
+			return 0;
+		}
+	}
+	dax_unlock_pages(ctx, idx, nccbs);
+
+	ctx->result.exec.status = dax_preprocess_usr_ccbs(ctx, idx, nccbs);
+	if (ctx->result.exec.status != DAX_SUBMIT_OK)
+		return 0;
+
+	ctx->result.exec.status = dax_lock_pages(ctx, idx, nccbs,
+						 &ctx->result.exec.status_data);
+	if (ctx->result.exec.status != DAX_SUBMIT_OK)
+		return 0;
+
+	if (dax_debug & DAX_DBG_FLG_BASIC)
+		dax_prt_ccbs(ctx->ccb_buf, nccbs);
+
+	hv_rv = sun4v_ccb_submit(ctx->ccb_buf_ra, count,
+				 HV_CCB_QUERY_CMD | HV_CCB_VA_SECONDARY, 0,
+				 &accepted_len, &ctx->result.exec.status_data);
+
+	switch (hv_rv) {
+	case HV_EOK:
+		/*
+		 * Hcall succeeded with no errors but the accepted
+		 * length may be less than the requested length.  The
+		 * only way the driver can resubmit the remainder is
+		 * to wait for completion of the submitted CCBs since
+		 * there is no way to guarantee the ordering semantics
+		 * required by the client applications.  Therefore we
+		 * let the user library deal with resubmissions.
+		 */
+		ctx->result.exec.status = DAX_SUBMIT_OK;
+		break;
+	case HV_EWOULDBLOCK:
+		/*
+		 * This is a transient HV API error. The user library
+		 * can retry.
+		 */
+		dax_dbg("hcall returned HV_EWOULDBLOCK");
+		ctx->result.exec.status = DAX_SUBMIT_ERR_WOULDBLOCK;
+		break;
+	case HV_ENOMAP:
+		/*
+		 * HV was unable to translate a VA. The VA it could
+		 * not translate is returned in the status_data param.
+		 */
+		dax_dbg("hcall returned HV_ENOMAP");
+		ctx->result.exec.status = DAX_SUBMIT_ERR_NOMAP;
+		break;
+	case HV_EINVAL:
+		/*
+		 * This is the result of an invalid user CCB as HV is
+		 * validating some of the user CCB fields.  Pass this
+		 * error back to the user. There is no supporting info
+		 * to isolate the invalid field.
+		 */
+		dax_dbg("hcall returned HV_EINVAL");
+		ctx->result.exec.status = DAX_SUBMIT_ERR_CCB_INVAL;
+		break;
+	case HV_ENOACCESS:
+		/*
+		 * HV found a VA that did not have the appropriate
+		 * permissions (such as the w bit). The VA in question
+		 * is returned in status_data param.
+		 */
+		dax_dbg("hcall returned HV_ENOACCESS");
+		ctx->result.exec.status = DAX_SUBMIT_ERR_NOACCESS;
+		break;
+	case HV_EUNAVAILABLE:
+		/*
+		 * The requested CCB operation could not be performed
+		 * at this time. Return the specific unavailable code
+		 * in the status_data field.
+		 */
+		dax_dbg("hcall returned HV_EUNAVAILABLE");
+		ctx->result.exec.status = DAX_SUBMIT_ERR_UNAVAIL;
+		break;
+	default:
+		ctx->result.exec.status = DAX_SUBMIT_ERR_INTERNAL;
+		dax_dbg("unknown hcall return value (%ld)", hv_rv);
+		break;
+	}
+
+	/* unlock pages associated with the unaccepted CCBs */
+	naccepted = accepted_len / sizeof(union ccb);
+	dax_unlock_pages(ctx, idx + naccepted, nccbs - naccepted);
+
+	/* mark unaccepted CCBs as not completed */
+	for (i = idx + naccepted; i < idx + nccbs; i++)
+		ctx->ca_buf[i].cmd_status = CCB_CMD_STAT_COMPLETED;
+
+	ctx->ccb_count += naccepted;
+	ctx->fail_count += nccbs - naccepted;
+
+	dax_dbg("hcall rv=%ld, accepted_len=%ld, status_data=0x%llx, ret status=%d",
+		hv_rv, accepted_len, ctx->result.exec.status_data,
+		ctx->result.exec.status);
+
+	if (count = accepted_len)
+		ctx->client = NULL; /* no read needed to complete protocol */
+	return accepted_len;
+}
-- 
1.7.1

