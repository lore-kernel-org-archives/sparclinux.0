From: Andrea Gelmini <andrea.gelmini@gelma.net>
Date: Sat, 21 May 2016 12:10:01 +0000
Subject: [PATCH 0256/1529] Fix typo
Message-Id: <20160521121001.13427-1-andrea.gelmini@gelma.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/sparc/include/asm/hypervisor.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/include/asm/hypervisor.h b/arch/sparc/include/asm/hypervisor.h
index f5b6537..8de4a24 100644
--- a/arch/sparc/include/asm/hypervisor.h
+++ b/arch/sparc/include/asm/hypervisor.h
@@ -1065,7 +1065,7 @@ unsigned long sun4v_con_write(unsigned long buffer,
  *
  * This allows the guest to report it's soft state to the hypervisor.  There
  * are two primary components to this state.  The first part states whether
- * the guest software is running or not.  The second containts optional
+ * the guest software is running or not.  The second contains optional
  * details specific to the software.
  *
  * The software state argument is defined below in HV_SOFT_STATE_*, and
@@ -1414,7 +1414,7 @@ struct hv_trap_trace_entry {
  *	cpuid		Unique opaque value which represents a target cpu.
  *
  *	devhandle	Device handle.  It uniquely identifies a device, and
- *			consistes of the lower 28-bits of the hi-cell of the
+ *			consists of the lower 28-bits of the hi-cell of the
  *			first entry of the device's "reg" property in the
  *			OBP device tree.
  *
@@ -1789,7 +1789,7 @@ unsigned long sun4v_vintr_set_target(unsigned long dev_handle,
  *
  * Returns the actual number of mappings creates, which may be less than
  * or equal to the argument #ttes.  If the function returns a value which
- * is less than the #ttes, the caller may continus to call the function with
+ * is less than the #ttes, the caller may continuous to call the function with
  * an updated tsbid, #ttes, io_page_list_p arguments until all pages are
  * mapped.
  *
@@ -1994,7 +1994,7 @@ unsigned long sun4v_vintr_set_target(unsigned long dev_handle,
  * The caller must have permission to write to the given devhandle, real
  * address, which must be an IO address.  The argument real address must be a
  * size aligned address.  The caller must have permission to read from
- * the given devhandle, pci_device cofiguration space offset 0.
+ * the given devhandle, pci_device configuration space offset 0.
  *
  * The hypervisor implementation of this function must block access to any
  * IO address that the guest does not have explicit permission to access.
-- 
2.8.2.534.g1f66975

