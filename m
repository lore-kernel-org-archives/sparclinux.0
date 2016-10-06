From: Tushar Dave <tushar.n.dave@oracle.com>
Date: Thu, 06 Oct 2016 23:33:32 +0000
Subject: [RFC PATCH 2/6] sparc64: Add ATU (new IOMMU) support
Message-Id: <1475796816-14448-3-git-send-email-tushar.n.dave@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1475796816-14448-1-git-send-email-tushar.n.dave@oracle.com>
In-Reply-To: <1475796816-14448-1-git-send-email-tushar.n.dave@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net, chris.hyser@oracle.com, sowmini.varadhan@oracle.com, vgupta@synopsys.com, robin.murphy@arm.com, jroedel@suse.de, egtvedt@samfundet.no, krzk@kernel.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

ATU (Address Translation Unit) is a new IOMMU in SPARC supported with
Hypervisor IOMMU v2 APIs.

Current SPARC IOMMU supports only 32bit address ranges and one TSB
per PCIe root complex that has a 2GB per root complex DVMA space
limit. The limit has become a scalability bottleneck nowadays that
a typical 10G/40G NIC can consume 300MB-500MB DVMA space per
instance. When DVMA resource is exhausted, devices will not be usable
since the driver can't allocate DVMA.

ATU removes bottleneck by allowing guest os to create IOTSB of size
32G (or more) with 64bit address ranges available in ATU HW. 32G is
more than enough DVMA space to be shared by all PCIe devices under
root complex contrast to 2G space provided by legacy IOMMU.

ATU allows PCIe devices to use 64bit DMA addressing. Devices
which choose to use 32bit DMA mask will continue to work with the
existing legacy IOMMU.

Signed-off-by: Tushar Dave <tushar.n.dave@oracle.com>
Reviewed-by: chris hyser <chris.hyser@oracle.com>
Acked-by: Sowmini Varadhan <sowmini.varadhan@oracle.com>
---
 arch/sparc/include/asm/hypervisor.h | 337 ++++++++++++++++++++++++++++++++++++
 arch/sparc/include/asm/iommu_64.h   |  26 +++
 arch/sparc/kernel/hvapi.c           |   1 +
 arch/sparc/kernel/pci_sun4v.c       | 139 +++++++++++++++
 arch/sparc/kernel/pci_sun4v.h       |   7 +
 arch/sparc/kernel/pci_sun4v_asm.S   |  18 ++
 6 files changed, 528 insertions(+)

diff --git a/arch/sparc/include/asm/hypervisor.h b/arch/sparc/include/asm/hypervisor.h
index 666d5ba..7b15df8 100644
--- a/arch/sparc/include/asm/hypervisor.h
+++ b/arch/sparc/include/asm/hypervisor.h
@@ -2335,6 +2335,342 @@ unsigned long sun4v_vintr_set_target(unsigned long dev_handle,
  */
 #define HV_FAST_PCI_MSG_SETVALID	0xd3
 
+/* PCI IOMMU v2 definitions and services
+ *
+ * While the PCI IO definitions above is valid IOMMU v2 adds new PCI IO
+ * definitions and services.
+ *
+ *	CTE		Clump Table Entry. First level table entry in the ATU.
+ *
+ *	pci_device_list
+ *			A 32-bit aligned list of pci_devices.
+ *
+ *	pci_device_listp
+ *			real address of a pci_device_list. 32-bit aligned.
+ *
+ *	iotte		IOMMU translation table entry.
+ *
+ *	iotte_attributes
+ *			IO Attributes for IOMMU v2 mappings. In addition to
+ *			read, write IOMMU v2 supports relax ordering
+ *
+ *	io_page_list	A 64-bit aligned list of real addresses. Each real
+ *			address in an io_page_list must be properly aligned
+ *			to the pagesize of the given IOTSB.
+ *
+ *	io_page_list_p	Real address of an io_page_list, 64-bit aligned.
+ *
+ *	IOTSB		IO Translation Storage Buffer. An aligned table of
+ *			IOTTEs. Each IOTSB has a pagesize, table size, and
+ *			virtual address associated with it that must match
+ *			a pagesize and table size supported by the un-derlying
+ *			hardware implementation. The alignment requirements
+ *			for an IOTSB depend on the pagesize used for that IOTSB.
+ *			Each IOTTE in an IOTSB maps one pagesize-sized page.
+ *			The size of the IOTSB dictates how large of a virtual
+ *			address space the IOTSB is capable of mapping.
+ *
+ *	iotsb_handle	An opaque identifier for an IOTSB. A devhandle plus
+ *			iotsb_handle represents a binding of an IOTSB to a
+ *			PCI root complex.
+ *
+ *	iotsb_index	Zero-based IOTTE number within an IOTSB.
+ */
+
+/* pci_iotsb_conf()
+ * TRAP:	HV_FAST_TRAP
+ * FUNCTION:	HV_FAST_PCI_IOTSB_CONF
+ * ARG0:	devhandle
+ * ARG1:	r_addr
+ * ARG2:	size
+ * ARG3:	pagesize
+ * ARG4:	iova
+ * RET0:	status
+ * RET1:	iotsb_handle
+ * ERRORS:	EINVAL		Invalid devhandle, size, iova, or pagesize
+ *		EBADALIGN	r_addr is not properly aligned
+ *		ENORADDR	r_addr is not a valid real address
+ *		ETOOMANY	No further IOTSBs may be configured
+ *		EBUSY		Duplicate devhandle, raddir, iova combination
+ *
+ * Create an IOTSB suitable for the PCI root complex identified by devhandle,
+ * for the DMA virtual address defined by the argument iova.
+ *
+ * r_addr is the properly aligned base address of the IOTSB and size is the
+ * IOTSB (table) size in bytes.The IOTSB is required to be zeroed prior to
+ * being configured. If it contains any values other than zeros then the
+ * behavior is undefined.
+ *
+ * pagesize is the size of each page in the IOTSB. Note that the combination of
+ * size (table size) and pagesize must be valid.
+ *
+ * virt is the DMA virtual address this IOTSB will map.
+ *
+ * If successful, the opaque 64-bit handle iotsb_handle is returned in ret1.
+ * Once configured, privileged access to the IOTSB memory is prohibited and
+ * creates undefined behavior. The only permitted access is indirect via these
+ * services.
+ */
+#define HV_FAST_PCI_IOTSB_CONF		0x190
+
+/* pci_iotsb_info()
+ * TRAP:	HV_FAST_TRAP
+ * FUNCTION:	HV_FAST_PCI_IOTSB_INFO
+ * ARG0:	devhandle
+ * ARG1:	iotsb_handle
+ * RET0:	status
+ * RET1:	r_addr
+ * RET2:	size
+ * RET3:	pagesize
+ * RET4:	iova
+ * RET5:	#bound
+ * ERRORS:	EINVAL	Invalid devhandle or iotsb_handle
+ *
+ * This service returns configuration information about an IOTSB previously
+ * created with pci_iotsb_conf.
+ *
+ * iotsb_handle value 0 may be used with this service to inquire about the
+ * legacy IOTSB that may or may not exist. If the service succeeds, the return
+ * values describe the legacy IOTSB and I/O virtual addresses mapped by that
+ * table. However, the table base address r_addr may contain the value -1 which
+ * indicates a memory range that cannot be accessed or be reclaimed.
+ *
+ * The return value #bound contains the number of PCI devices that iotsb_handle
+ * is currently bound to.
+ */
+#define HV_FAST_PCI_IOTSB_INFO		0x191
+
+/* pci_iotsb_unconf()
+ * TRAP:	HV_FAST_TRAP
+ * FUNCTION:	HV_FAST_PCI_IOTSB_UNCONF
+ * ARG0:	devhandle
+ * ARG1:	iotsb_handle
+ * RET0:	status
+ * ERRORS:	EINVAL	Invalid devhandle or iotsb_handle
+ *		EBUSY	The IOTSB is bound and may not be unconfigured
+ *
+ * This service unconfigures the IOTSB identified by the devhandle and
+ * iotsb_handle arguments, previously created with pci_iotsb_conf.
+ * The IOTSB must not be currently bound to any device or the service will fail
+ *
+ * If the call succeeds, iotsb_handle is no longer valid.
+ */
+#define HV_FAST_PCI_IOTSB_UNCONF	0x192
+
+/* pci_iotsb_bind()
+ * TRAP:	HV_FAST_TRAP
+ * FUNCTION:	HV_FAST_PCI_IOTSB_BIND
+ * ARG0:	devhandle
+ * ARG1:	iotsb_handle
+ * ARG2:	pci_device
+ * RET0:	status
+ * ERRORS:	EINVAL	Invalid devhandle, iotsb_handle, or pci_device
+ *		EBUSY	A PCI function is already bound to an IOTSB at the same
+ *			address range as specified by devhandle, iotsb_handle.
+ *
+ * This service binds the PCI function specified by the argument pci_device to
+ * the IOTSB specified by the arguments devhandle and iotsb_handle.
+ *
+ * The PCI device function is bound to the specified IOTSB with the IOVA range
+ * specified when the IOTSB was configured via pci_iotsb_conf. If the function
+ * is already bound then it is unbound first.
+ */
+#define HV_FAST_PCI_IOTSB_BIND		0x193
+
+/* pci_iotsb_unbind()
+ * TRAP:	HV_FAST_TRAP
+ * FUNCTION:	HV_FAST_PCI_IOTSB_UNBIND
+ * ARG0:	devhandle
+ * ARG1:	iotsb_handle
+ * ARG2:	pci_device
+ * RET0:	status
+ * ERRORS:	EINVAL	Invalid devhandle, iotsb_handle, or pci_device
+ *		ENOMAP	The PCI function was not bound to the specified IOTSB
+ *
+ * This service unbinds the PCI device specified by the argument pci_device
+ * from the IOTSB identified  * by the arguments devhandle and iotsb_handle.
+ *
+ * If the PCI device is not bound to the specified IOTSB then this service will
+ * fail with status ENOMAP
+ */
+#define HV_FAST_PCI_IOTSB_UNBIND	0x194
+
+/* pci_iotsb_get_binding()
+ * TRAP:	HV_FAST_TRAP
+ * FUNCTION:	HV_FAST_PCI_IOTSB_GET_BINDING
+ * ARG0:	devhandle
+ * ARG1:	iotsb_handle
+ * ARG2:	iova
+ * RET0:	status
+ * RET1:	iotsb_handle
+ * ERRORS:	EINVAL	Invalid devhandle, pci_device, or iova
+ *		ENOMAP	The PCI function is not bound to an IOTSB at iova
+ *
+ * This service returns the IOTSB binding, iotsb_handle, for a given pci_device
+ * and DMA virtual address, iova.
+ *
+ * iova must be the base address of a DMA virtual address range as defined by
+ * the iommu-address-ranges property in the root complex device node defined
+ * by the argument devhandle.
+ */
+#define HV_FAST_PCI_IOTSB_GET_BINDING	0x195
+
+/* pci_iotsb_map()
+ * TRAP:	HV_FAST_TRAP
+ * FUNCTION:	HV_FAST_PCI_IOTSB_MAP
+ * ARG0:	devhandle
+ * ARG1:	iotsb_handle
+ * ARG2:	index_count
+ * ARG3:	iotte_attributes
+ * ARG4:	io_page_list_p
+ * RET0:	status
+ * RET1:	#mapped
+ * ERRORS:	EINVAL		Invalid devhandle, iotsb_handle, #iottes,
+ *				iotsb_index or iotte_attributes
+ *		EBADALIGN	Improperly aligned io_page_list_p or I/O page
+ *				address in the I/O page list.
+ *		ENORADDR	Invalid io_page_list_p or I/O page address in
+ *				the I/O page list.
+ *
+ * This service creates and flushes mappings in the IOTSB defined by the
+ * arguments devhandle, iotsb.
+ *
+ * The index_count argument consists of two fields. Bits 63:48 contain #iotte
+ * and bits 47:0 contain iotsb_index
+ *
+ * The first mapping is created in the IOTSB index specified by iotsb_index.
+ * Subsequent mappings are  created at iotsb_index+1 and so on.
+ *
+ * The attributes of each mapping are defined by the argument iotte_attributes.
+ *
+ * The io_page_list_p specifies the real address of the 64-bit-aligned list of
+ * #iottes I/O page addresses. Each page address must be a properly aligned
+ * real address of a page to be mapped in the IOTSB. The first entry in the I/O
+ * page list contains the real address of the first page, the 2nd entry for the
+ * 2nd page, and so on.
+ *
+ * #iottes must be greater than zero.
+ *
+ * The return value #mapped is the actual number of mappings created, which may
+ * be less than or equal to the argument #iottes. If the function returns
+ * successfully with a #mapped value less than the requested #iottes then the
+ * caller should continue to invoke the service with updated iotsb_index,
+ * #iottes, and io_page_list_p arguments until all pages are mapped.
+ *
+ * This service must not be used to demap a mapping. In other words, all
+ * mappings must be valid and have  one or both of the RW attribute bits set.
+ *
+ * Note:
+ * It is implementation-defined whether I/O page real address validity checking
+ * is done at time mappings are established or deferred until they are
+ * accessed.
+ */
+#define HV_FAST_PCI_IOTSB_MAP		0x196
+
+/* pci_iotsb_map_one()
+ * TRAP:	HV_FAST_TRAP
+ * FUNCTION:	HV_FAST_PCI_IOTSB_MAP_ONE
+ * ARG0:	devhandle
+ * ARG1:	iotsb_handle
+ * ARG2:	iotsb_index
+ * ARG3:	iotte_attributes
+ * ARG4:	r_addr
+ * RET0:	status
+ * ERRORS:	EINVAL		Invalid devhandle,iotsb_handle, iotsb_index
+ *				or iotte_attributes
+ *		EBADALIGN	Improperly aligned r_addr
+ *		ENORADDR	Invalid r_addr
+ *
+ * This service creates and flushes a single mapping in the IOTSB defined by the
+ * arguments devhandle, iotsb.
+ *
+ * The mapping for the page at r_addr is created at the IOTSB index specified by
+ * iotsb_index with  the attributes iotte_attributes.
+ *
+ * This service must not be used to demap a mapping. In other words, the mapping
+ * must be valid and have one or both of the RW attribute bits set.
+ *
+ * Note:
+ * It is implementation-defined whether I/O page real address validity checking
+ * is done at time mappings are established or deferred until they are
+ * accessed.
+ */
+#define HV_FAST_PCI_IOTSB_MAP_ONE	0x197
+
+/* pci_iotsb_demap()
+ * TRAP:	HV_FAST_TRAP
+ * FUNCTION:	HV_FAST_PCI_IOTSB_DEMAP
+ * ARG0:	devhandle
+ * ARG1:	iotsb_handle
+ * ARG2:	iotsb_index
+ * ARG3:	#iottes
+ * RET0:	status
+ * RET1:	#unmapped
+ * ERRORS:	EINVAL	Invalid devhandle, iotsb_handle, iotsb_index or #iottes
+ *
+ * This service unmaps and flushes up to #iottes mappings starting at index
+ * iotsb_index from the IOTSB defined by the arguments devhandle, iotsb.
+ *
+ * #iottes must be greater than zero.
+ *
+ * The actual number of IOTTEs unmapped is returned in #unmapped and may be less
+ * than or equal to the requested number of IOTTEs, #iottes.
+ *
+ * If #unmapped is less than #iottes, the caller should continue to invoke this
+ * service with updated iotsb_index and #iottes arguments until all pages are
+ * demapped.
+ */
+#define HV_FAST_PCI_IOTSB_DEMAP		0x198
+
+/* pci_iotsb_getmap()
+ * TRAP:	HV_FAST_TRAP
+ * FUNCTION:	HV_FAST_PCI_IOTSB_GETMAP
+ * ARG0:	devhandle
+ * ARG1:	iotsb_handle
+ * ARG2:	iotsb_index
+ * RET0:	status
+ * RET1:	r_addr
+ * RET2:	iotte_attributes
+ * ERRORS:	EINVAL	Invalid devhandle, iotsb_handle, or iotsb_index
+ *		ENOMAP	No mapping was found
+ *
+ * This service returns the mapping specified by index iotsb_index from the
+ * IOTSB defined by the arguments devhandle, iotsb.
+ *
+ * Upon success, the real address of the mapping shall be returned in
+ * r_addr and thethe IOTTE mapping attributes shall be returned in
+ * iotte_attributes.
+ *
+ * The return value iotte_attributes may not include optional features used in
+ * the call to create the  mapping.
+ */
+#define HV_FAST_PCI_IOTSB_GETMAP	0x199
+
+/* pci_iotsb_sync_mappings()
+ * TRAP:	HV_FAST_TRAP
+ * FUNCTION:	HV_FAST_PCI_IOTSB_SYNC_MAPPINGS
+ * ARG0:	devhandle
+ * ARG1:	iotsb_handle
+ * ARG2:	iotsb_index
+ * ARG3:	#iottes
+ * RET0:	status
+ * RET1:	#synced
+ * ERROS:	EINVAL	Invalid devhandle, iotsb_handle, iotsb_index, or #iottes
+ *
+ * This service synchronizes #iottes mappings starting at index iotsb_index in
+ * the IOTSB defined by the arguments devhandle, iotsb.
+ *
+ * #iottes must be greater than zero.
+ *
+ * The actual number of IOTTEs synchronized is returned in #synced, which may
+ * be less than or equal to the requested number, #iottes.
+ *
+ * Upon a successful return, #synced is less than #iottes, the caller should
+ * continue to invoke this service with updated iotsb_index and #iottes
+ * arguments until all pages are synchronized.
+ */
+#define HV_FAST_PCI_IOTSB_SYNC_MAPPINGS	0x19a
+
 /* Logical Domain Channel services.  */
 
 #define LDC_CHANNEL_DOWN		0
@@ -2993,6 +3329,7 @@ unsigned long sun4v_m7_set_perfreg(unsigned long reg_num,
 #define HV_GRP_SDIO			0x0108
 #define HV_GRP_SDIO_ERR			0x0109
 #define HV_GRP_REBOOT_DATA		0x0110
+#define HV_GRP_ATU			0x0111
 #define HV_GRP_M7_PERF			0x0114
 #define HV_GRP_NIAG_PERF		0x0200
 #define HV_GRP_FIRE_PERF		0x0201
diff --git a/arch/sparc/include/asm/iommu_64.h b/arch/sparc/include/asm/iommu_64.h
index cd0d69f..93daa59 100644
--- a/arch/sparc/include/asm/iommu_64.h
+++ b/arch/sparc/include/asm/iommu_64.h
@@ -24,8 +24,34 @@ struct iommu_arena {
 	unsigned int	limit;
 };
 
+#define ATU_64_SPACE_SIZE 0x800000000 /* 32G */
+
+/* Data structures for SPARC ATU architecture */
+struct atu_iotsb {
+	void	*table;		/* IOTSB table base virtual addr*/
+	u64	ra;		/* IOTSB table real addr */
+	u64	dvma_size;	/* ranges[3].size or OS slected 32G size */
+	u64	dvma_base;	/* ranges[3].base */
+	u64	table_size;	/* IOTSB table size */
+	u64	page_size;	/* IO PAGE size for IOTSB */
+	u32	iotsb_num;	/* tsbnum is same as iotsb_handle */
+};
+
+struct atu_ranges {
+	u64	base;
+	u64	size;
+};
+
+struct atu {
+	struct	atu_ranges	*ranges;
+	struct	atu_iotsb	*iotsb;
+	u64			base;
+	u64			size;
+};
+
 struct iommu {
 	struct iommu_map_table	tbl;
+	struct atu		*atu;
 	spinlock_t		lock;
 	u32			dma_addr_mask;
 	iopte_t			*page_table;
diff --git a/arch/sparc/kernel/hvapi.c b/arch/sparc/kernel/hvapi.c
index 662500f..2677312 100644
--- a/arch/sparc/kernel/hvapi.c
+++ b/arch/sparc/kernel/hvapi.c
@@ -39,6 +39,7 @@ static struct api_info api_table[] = {
 	{ .group = HV_GRP_SDIO,					},
 	{ .group = HV_GRP_SDIO_ERR,				},
 	{ .group = HV_GRP_REBOOT_DATA,				},
+	{ .group = HV_GRP_ATU,		.flags = FLAG_PRE_API	},
 	{ .group = HV_GRP_NIAG_PERF,	.flags = FLAG_PRE_API	},
 	{ .group = HV_GRP_FIRE_PERF,				},
 	{ .group = HV_GRP_N2_CPU,				},
diff --git a/arch/sparc/kernel/pci_sun4v.c b/arch/sparc/kernel/pci_sun4v.c
index db57d8a..a1c4d5e 100644
--- a/arch/sparc/kernel/pci_sun4v.c
+++ b/arch/sparc/kernel/pci_sun4v.c
@@ -44,6 +44,9 @@ static struct vpci_version vpci_versions[] = {
 	{ .major = 1, .minor = 1 },
 };
 
+static unsigned long vatu_major = 1;
+static unsigned long vatu_minor = 1;
+
 #define PGLIST_NENTS	(PAGE_SIZE / sizeof(u64))
 
 struct iommu_batch {
@@ -581,6 +584,106 @@ static unsigned long probe_existing_entries(struct pci_pbm_info *pbm,
 	return cnt;
 }
 
+static int pci_sun4v_atu_alloc_iotsb(struct pci_pbm_info *pbm)
+{
+	struct atu *atu = pbm->iommu->atu;
+	struct atu_iotsb *iotsb;
+	void *table;
+	u64 table_size;
+	u64 iotsb_num;
+	unsigned long err;
+
+	iotsb = kzalloc(sizeof(*iotsb), GFP_KERNEL);
+	if (!iotsb) {
+		err = -ENOMEM;
+		goto out_err;
+	}
+	atu->iotsb = iotsb;
+
+	/* calculate size of IOTSB */
+	table_size = (atu->size / IO_PAGE_SIZE) * 8;
+	table = kzalloc(table_size, GFP_KERNEL);
+	if (!table) {
+		err = -ENOMEM;
+		goto table_failed;
+	}
+	table = (void *)IO_PAGE_ALIGN((u64)table);
+	iotsb->table = table;
+	iotsb->ra = __pa(table);
+	iotsb->dvma_size = atu->size;
+	iotsb->dvma_base = atu->base;
+	iotsb->table_size = table_size;
+	iotsb->page_size = IO_PAGE_SIZE;
+
+	/* configure and register IOTSB with HV */
+	err = pci_sun4v_iotsb_conf(pbm->devhandle,
+				   iotsb->ra,
+				   iotsb->table_size,
+				   iotsb->page_size,
+				   iotsb->dvma_base,
+				   &iotsb_num);
+	if (err) {
+		pr_err(PFX "pci_iotsb_conf failed error: %ld\n", err);
+		goto iotsb_conf_failed;
+	}
+	iotsb->iotsb_num = iotsb_num;
+
+	return 0;
+
+iotsb_conf_failed:
+	kfree(table);
+table_failed:
+	kfree(iotsb);
+out_err:
+	return err;
+}
+
+static int pci_sun4v_atu_init(struct pci_pbm_info *pbm)
+{
+	struct atu *atu = pbm->iommu->atu;
+	unsigned long err;
+	const u64 *ranges;
+	const u32 *page_size;
+	int len;
+
+	ranges = of_get_property(pbm->op->dev.of_node, "iommu-address-ranges",
+				 &len);
+	if (!ranges) {
+		pr_err(PFX "No iommu-address-ranges\n");
+		return -EINVAL;
+	}
+
+	page_size = of_get_property(pbm->op->dev.of_node, "iommu-pagesizes",
+				    NULL);
+	if (!page_size) {
+		pr_err(PFX "No iommu-pagesizes\n");
+		return -EINVAL;
+	}
+
+	/* There are 4 iommu-address-ranges supported. Each range is pair of
+	 * {base, size}. The ranges[0] and ranges[1] are 32bit address space
+	 * while ranges[2] and ranges[3] are 64bit space.  We want to use 64bit
+	 * address ranges to support 64bit addressing. Because 'size' for
+	 * address ranges[2] and ranges[3] are same we can select either of
+	 * ranges[2] or ranges[3] for mapping. However due to 'size' is too
+	 * large for OS to allocate IOTSB we are using fix size 32G
+	 * (ATU_64_SPACE_SIZE) which is more than enough for all PCIe devices
+	 * to share.
+	 */
+	atu->ranges = (struct atu_ranges *)ranges;
+	atu->base = atu->ranges[3].base;
+	atu->size = ATU_64_SPACE_SIZE;
+
+	/* Create IOTSB */
+	err = pci_sun4v_atu_alloc_iotsb(pbm);
+	if (err) {
+		pr_err(PFX "Error creating ATU IOTSB\n");
+		return err;
+	}
+
+	return 0;
+}
+
 static int pci_sun4v_iommu_init(struct pci_pbm_info *pbm)
 {
 	static const u32 vdma_default[] = { 0x80000000, 0x80000000 };
@@ -918,6 +1021,18 @@ static int pci_sun4v_pbm_init(struct pci_pbm_info *pbm,
 
 	pci_sun4v_scan_bus(pbm, &op->dev);
 
+	/* if atu_init fails its not complete failure.
+	 * we can still continue using legacy iommu.
+	 */
+	if (pbm->iommu->atu) {
+		err = pci_sun4v_atu_init(pbm);
+		if (err) {
+			kfree(pbm->iommu->atu);
+			pbm->iommu->atu = NULL;
+			pr_err(PFX "ATU init failed, err=%d\n", err);
+		}
+	}
+
 	pbm->next = pci_pbm_root;
 	pci_pbm_root = pbm;
 
@@ -931,8 +1046,10 @@ static int pci_sun4v_probe(struct platform_device *op)
 	struct pci_pbm_info *pbm;
 	struct device_node *dp;
 	struct iommu *iommu;
+	struct atu *atu;
 	u32 devhandle;
 	int i, err = -ENODEV;
+	static bool hv_atu = 1;
 
 	dp = op->dev.of_node;
 
@@ -954,6 +1071,19 @@ static int pci_sun4v_probe(struct platform_device *op)
 		pr_info(PFX "Registered hvapi major[%lu] minor[%lu]\n",
 			vpci_major, vpci_minor);
 
+		err = sun4v_hvapi_register(HV_GRP_ATU, vatu_major, &vatu_minor);
+		if (err) {
+			/* don't return an error if we fail to register the
+			 * ATU group, but ATU hcalls won't be available.
+			 */
+			hv_atu = 0;
+			pr_err(PFX "Could not register hvapi ATU err=%d\n",
+			       err);
+		} else {
+			pr_info(PFX "Registered hvapi ATU major[%lu] minor[%lu]\n",
+				vatu_major, vatu_minor);
+		}
+
 		dma_ops = &sun4v_dma_ops;
 	}
 
@@ -991,6 +1121,14 @@ static int pci_sun4v_probe(struct platform_device *op)
 	}
 
 	pbm->iommu = iommu;
+	iommu->atu = NULL;
+	if (hv_atu) {
+		atu = kzalloc(sizeof(*atu), GFP_KERNEL);
+		if (!atu)
+			pr_err(PFX "Could not allocate atu\n");
+		else
+			iommu->atu = atu;
+	}
 
 	err = pci_sun4v_pbm_init(pbm, op, devhandle);
 	if (err)
@@ -1001,6 +1139,7 @@ static int pci_sun4v_probe(struct platform_device *op)
 	return 0;
 
 out_free_iommu:
+	kfree(iommu->atu);
 	kfree(pbm->iommu);
 
 out_free_controller:
diff --git a/arch/sparc/kernel/pci_sun4v.h b/arch/sparc/kernel/pci_sun4v.h
index 5642212..0ef6d1c 100644
--- a/arch/sparc/kernel/pci_sun4v.h
+++ b/arch/sparc/kernel/pci_sun4v.h
@@ -89,4 +89,11 @@ unsigned long pci_sun4v_msg_setvalid(unsigned long devhandle,
 				     unsigned long msinum,
 				     unsigned long valid);
 
+/* Sun4v HV IOMMU v2 APIs */
+unsigned long pci_sun4v_iotsb_conf(unsigned long devhandle,
+				   unsigned long ra,
+				   unsigned long table_size,
+				   unsigned long page_size,
+				   unsigned long dvma_base,
+				   u64 *iotsb_num);
 #endif /* !(_PCI_SUN4V_H) */
diff --git a/arch/sparc/kernel/pci_sun4v_asm.S b/arch/sparc/kernel/pci_sun4v_asm.S
index e606d46..fd94d0e 100644
--- a/arch/sparc/kernel/pci_sun4v_asm.S
+++ b/arch/sparc/kernel/pci_sun4v_asm.S
@@ -360,3 +360,21 @@ ENTRY(pci_sun4v_msg_setvalid)
 	 mov	%o0, %o0
 ENDPROC(pci_sun4v_msg_setvalid)
 
+	/*
+	 * %o0:	devhandle
+	 * %o1:	r_addr
+	 * %o2:	size
+	 * %o3:	pagesize
+	 * %o4:	virt
+	 * %o5: &iotsb_num/&iotsb_handle
+	 *
+	 * returns %o0:	status
+	 *         %o1:	iotsb_num/iotsb_handle
+	 */
+ENTRY(pci_sun4v_iotsb_conf)
+	mov	%o5, %g1
+	mov	HV_FAST_PCI_IOTSB_CONF, %o5
+	ta	HV_FAST_TRAP
+	retl
+	 stx	%o1, [%g1]
+ENDPROC(pci_sun4v_iotsb_conf)
-- 
1.9.1

