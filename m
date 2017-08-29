From: Rob Gardner <rob.gardner@oracle.com>
Date: Tue, 29 Aug 2017 23:36:02 +0000
Subject: [RFC 1/2] sparc64: Oracle DAX infrastructure
Message-Id: <1504049763-51918-2-git-send-email-rob.gardner@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

This patch adds hypercall function stubs and C templates for
ccb_submit/info/kill which provide coprocessor services for the Oracle
Data Analytics Accelerator, registration for the DAX api group, and
all the various associated constants.

Signed-off-by: Rob Gardner <rob.gardner@oracle.com>
Signed-off-by: Jonathan Helman <jonathan.helman@oracle.com>
Signed-off-by: Sanath Kumar <sanath.s.kumar@oracle.com>
---
 arch/sparc/include/asm/hypervisor.h |  138 +++++++++++++++++++++++++++++++++++
 arch/sparc/kernel/hvapi.c           |    1 +
 arch/sparc/kernel/hvcalls.S         |   57 ++++++++++++++
 3 files changed, 196 insertions(+), 0 deletions(-)

diff --git a/arch/sparc/include/asm/hypervisor.h b/arch/sparc/include/asm/hypervisor.h
index 73cb897..401fafe 100644
--- a/arch/sparc/include/asm/hypervisor.h
+++ b/arch/sparc/include/asm/hypervisor.h
@@ -75,6 +75,10 @@
 #define HV_ETOOMANY			15 /* Too many items specified     */
 #define HV_ECHANNEL			16 /* Invalid LDC channel          */
 #define HV_EBUSY			17 /* Resource busy                */
+#define HV_EUNAVAILABLE			23 /* Resource or operation not
+					    * currently available, but may
+					    * become available in the future
+					    */
 
 /* mach_exit()
  * TRAP:	HV_FAST_TRAP
@@ -922,6 +926,139 @@ unsigned long sun4v_mmu_map_perm_addr(unsigned long vaddr,
  */
 #define HV_FAST_MEM_SYNC		0x32
 
+/* Coprocessor services
+ *
+ * M7 and later processors provide an on-chip coprocessor which
+ * accelerates database operations, and is known internally as
+ * DAX.
+ */
+
+/* ccb_submit()
+ * TRAP:	HV_FAST_TRAP
+ * FUNCTION:	HV_CCB_SUBMIT
+ * ARG0:	address of CCB array
+ * ARG1:	size (in bytes) of CCB array being submitted
+ * ARG2:	flags
+ * ARG3:	reserved
+ * RET0:	status (success or error code)
+ * RET1:	size (in bytes) of CCB array that was accepted (might be less
+ *		than arg1)
+ * RET2:	status data
+ *		if status = ENOMAP or ENOACCESS, identifies the VA in question
+ *		if status = EUNAVAILBLE, unavailable code
+ * RET3:	reserved
+ *
+ * ERRORS:	EOK		successful submission (check size)
+ *		EWOULDBLOCK	could not finish submissions, try again
+ *		EBADALIGN	array not 64B aligned or size not 64B multiple
+ *		ENORADDR	invalid RA for array or in CCB
+ *		ENOMAP		could not translate address (see status data)
+ *		EINVAL		invalid ccb or arguments
+ *		ETOOMANY	too many ccbs with all-or-nothing flag
+ *		ENOACCESS	guest has no access to submit ccbs or address
+ *				in CCB does not have correct permissions (check
+ *				status data)
+ *		EUNAVAILABLE	ccb operation could not be performed at this
+ *				time (check status data)
+ *				Status data codes:
+ *					0 - exact CCB could not be executed
+ *					1 - CCB opcode cannot be executed
+ *					2 - CCB version cannot be executed
+ *					3 - vcpu cannot execute CCBs
+ *					4 - no CCBs can be executed
+ */
+
+#define HV_CCB_SUBMIT               0x34
+#ifndef __ASSEMBLY__
+unsigned long sun4v_ccb_submit(unsigned long ccb_buf,
+			       unsigned long len,
+			       unsigned long flags,
+			       unsigned long reserved,
+			       void *submitted_len,
+			       void *status_data);
+#endif
+
+/* flags (ARG2) */
+#define HV_CCB_QUERY_CMD		BIT(1)
+#define HV_CCB_ARG0_TYPE_REAL		0UL
+#define HV_CCB_ARG0_TYPE_PRIMARY	BIT(4)
+#define HV_CCB_ARG0_TYPE_SECONDARY	BIT(5)
+#define HV_CCB_ARG0_TYPE_NUCLEUS	GENMASK(5, 4)
+#define HV_CCB_ARG0_PRIVILEGED		BIT(6)
+#define HV_CCB_ALL_OR_NOTHING		BIT(7)
+#define HV_CCB_QUEUE_INFO		BIT(8)
+#define HV_CCB_VA_REJECT		0UL
+#define HV_CCB_VA_SECONDARY		BIT(13)
+#define HV_CCB_VA_NUCLEUS		GENMASK(13, 12)
+#define HV_CCB_VA_PRIVILEGED		BIT(14)
+#define HV_CCB_VA_READ_ADI_DISABLE	BIT(15)	/* DAX2 only */
+
+/* ccb_info()
+ * TRAP:	HV_FAST_TRAP
+ * FUNCTION:	HV_CCB_INFO
+ * ARG0:	real address of CCB completion area
+ * RET0:	status (success or error code)
+ * RET1:	info array
+ *			- RET1[0]: CCB state
+ *			- RET1[1]: dax unit
+ *			- RET1[2]: queue number
+ *			- RET1[3]: queue position
+ *
+ * ERRORS:	EOK		operation successful
+ *		EBADALIGN	address not 64B aligned
+ *		ENORADDR	RA in address not valid
+ *		EINVAL		CA not valid
+ *		EWOULDBLOCK	info not available for this CCB currently, try
+ *				again
+ *		ENOACCESS	guest cannot use dax
+ */
+
+#define HV_CCB_INFO                 0x35
+#ifndef __ASSEMBLY__
+unsigned long sun4v_ccb_info(unsigned long ca,
+			     void *info_arr);
+#endif
+
+/* info array byte offsets (RET1) */
+#define CCB_INFO_OFFSET_CCB_STATE	0
+#define CCB_INFO_OFFSET_DAX_UNIT	2
+#define CCB_INFO_OFFSET_QUEUE_NUM	4
+#define CCB_INFO_OFFSET_QUEUE_POS	6
+
+/* CCB state (RET1[0]) */
+#define HV_CCB_STATE_COMPLETED      0
+#define HV_CCB_STATE_ENQUEUED       1
+#define HV_CCB_STATE_INPROGRESS     2
+#define HV_CCB_STATE_NOTFOUND       3
+
+/* ccb_kill()
+ * TRAP:	HV_FAST_TRAP
+ * FUNCTION:	HV_CCB_KILL
+ * ARG0:	real address of CCB completion area
+ * RET0:	status (success or error code)
+ * RET1:	CCB kill status
+ *
+ * ERRORS:	EOK		operation successful
+ *		EBADALIGN	address not 64B aligned
+ *		ENORADDR	RA in address not valid
+ *		EINVAL		CA not valid
+ *		EWOULDBLOCK	kill not available for this CCB currently, try
+ *				again
+ *		ENOACCESS	guest cannot use dax
+ */
+
+#define HV_CCB_KILL                 0x36
+#ifndef __ASSEMBLY__
+unsigned long sun4v_ccb_kill(unsigned long ca,
+			     void *kill_status);
+#endif
+
+/* CCB kill status (RET1) */
+#define HV_CCB_KILL_COMPLETED       0
+#define HV_CCB_KILL_DEQUEUED        1
+#define HV_CCB_KILL_KILLED          2
+#define HV_CCB_KILL_NOTFOUND        3
+
 /* Time of day services.
  *
  * The hypervisor maintains the time of day on a per-domain basis.
@@ -3336,6 +3473,7 @@ unsigned long sun4v_m7_set_perfreg(unsigned long reg_num,
 #define HV_GRP_SDIO_ERR			0x0109
 #define HV_GRP_REBOOT_DATA		0x0110
 #define HV_GRP_ATU			0x0111
+#define HV_GRP_DAX			0x0113
 #define HV_GRP_M7_PERF			0x0114
 #define HV_GRP_NIAG_PERF		0x0200
 #define HV_GRP_FIRE_PERF		0x0201
diff --git a/arch/sparc/kernel/hvapi.c b/arch/sparc/kernel/hvapi.c
index 2677312..c3a923a 100644
--- a/arch/sparc/kernel/hvapi.c
+++ b/arch/sparc/kernel/hvapi.c
@@ -40,6 +40,7 @@ struct api_info {
 	{ .group = HV_GRP_SDIO_ERR,				},
 	{ .group = HV_GRP_REBOOT_DATA,				},
 	{ .group = HV_GRP_ATU,		.flags = FLAG_PRE_API	},
+	{ .group = HV_GRP_DAX,					},
 	{ .group = HV_GRP_NIAG_PERF,	.flags = FLAG_PRE_API	},
 	{ .group = HV_GRP_FIRE_PERF,				},
 	{ .group = HV_GRP_N2_CPU,				},
diff --git a/arch/sparc/kernel/hvcalls.S b/arch/sparc/kernel/hvcalls.S
index 4116ee5..f7d799e 100644
--- a/arch/sparc/kernel/hvcalls.S
+++ b/arch/sparc/kernel/hvcalls.S
@@ -859,3 +859,60 @@ ENTRY(sun4v_m7_set_perfreg)
 	retl
 	nop
 ENDPROC(sun4v_m7_set_perfreg)
+
+	/* %o0: address of CCB array
+	 * %o1: size (in bytes) of CCB array
+	 * %o2: flags
+	 * %o3: reserved
+	 *
+	 * returns:
+	 * %o0: status
+	 * %o1: size (in bytes) of the CCB array that was accepted
+	 * %o2: status data
+	 * %o3: reserved
+	 */
+ENTRY(sun4v_ccb_submit)
+	mov	%o5, %g1
+	mov	HV_CCB_SUBMIT, %o5
+	ta	HV_FAST_TRAP
+	stx	%o1, [%o4]
+	retl
+	 stx	%o2, [%g1]
+ENDPROC(sun4v_ccb_submit)
+EXPORT_SYMBOL(sun4v_ccb_submit)
+
+	/* %o0: completion area ra for the ccb to get info
+	 *
+	 * returns:
+	 * %o0: status
+	 * %o1: CCB state
+	 * %o2: position
+	 * %o3: dax unit
+	 * %o4: queue
+	 */
+ENTRY(sun4v_ccb_info)
+	mov	%o1, %g1
+	mov	HV_CCB_INFO, %o5
+	ta	HV_FAST_TRAP
+	sth	%o1, [%g1 + CCB_INFO_OFFSET_CCB_STATE]
+	sth	%o2, [%g1 + CCB_INFO_OFFSET_QUEUE_POS]
+	sth	%o3, [%g1 + CCB_INFO_OFFSET_DAX_UNIT]
+	retl
+	 sth	%o4, [%g1 + CCB_INFO_OFFSET_QUEUE_NUM]
+ENDPROC(sun4v_ccb_info)
+EXPORT_SYMBOL(sun4v_ccb_info)
+
+	/* %o0: completion area ra for the ccb to kill
+	 *
+	 * returns:
+	 * %o0: status
+	 * %o1: result of the kill
+	 */
+ENTRY(sun4v_ccb_kill)
+	mov	%o1, %g1
+	mov	HV_CCB_KILL, %o5
+	ta	HV_FAST_TRAP
+	retl
+	 sth	%o1, [%g1]
+ENDPROC(sun4v_ccb_kill)
+EXPORT_SYMBOL(sun4v_ccb_kill)
-- 
1.7.1

