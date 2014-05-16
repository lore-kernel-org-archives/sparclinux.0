From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 16 May 2014 21:25:51 +0000
Subject: [PATCH 13/34] sparc: drop use of extern for prototypes in arch/sparc/*
Message-Id: <1400275572-17424-13-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Drop the remaining uses of extern for prototypes in .h files
in the sparc specific part of the kernel tree.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/kernel/cpumap.h        |   4 +-
 arch/sparc/kernel/entry.h         | 259 +++++++++++++++++++-------------------
 arch/sparc/kernel/iommu_common.h  |  14 +--
 arch/sparc/kernel/irq.h           |   2 +-
 arch/sparc/kernel/kernel.h        |  36 +++---
 arch/sparc/kernel/pci_impl.h      |  30 ++---
 arch/sparc/kernel/pci_sun4v.h     | 156 +++++++++++------------
 arch/sparc/kernel/prom.h          |   2 +-
 arch/sparc/kernel/psycho_common.h |  22 ++--
 arch/sparc/mm/init_64.h           |   4 +-
 10 files changed, 264 insertions(+), 265 deletions(-)

diff --git a/arch/sparc/kernel/cpumap.h b/arch/sparc/kernel/cpumap.h
index e639880..9dac398 100644
--- a/arch/sparc/kernel/cpumap.h
+++ b/arch/sparc/kernel/cpumap.h
@@ -2,8 +2,8 @@
 #define _CPUMAP_H
 
 #ifdef CONFIG_SMP
-extern void cpu_map_rebuild(void);
-extern int  map_to_cpu(unsigned int index);
+void cpu_map_rebuild(void);
+int map_to_cpu(unsigned int index);
 #define cpu_map_init() cpu_map_rebuild()
 #else
 #define cpu_map_init() do {} while (0)
diff --git a/arch/sparc/kernel/entry.h b/arch/sparc/kernel/entry.h
index 140966f..ebaba61 100644
--- a/arch/sparc/kernel/entry.h
+++ b/arch/sparc/kernel/entry.h
@@ -6,40 +6,39 @@
 #include <linux/init.h>
 
 /* irq */
-extern void handler_irq(int irq, struct pt_regs *regs);
+void handler_irq(int irq, struct pt_regs *regs);
 
 #ifdef CONFIG_SPARC32
 /* traps */
-extern void do_hw_interrupt(struct pt_regs *regs, unsigned long type);
-extern void do_illegal_instruction(struct pt_regs *regs, unsigned long pc,
-                                   unsigned long npc, unsigned long psr);
-
-extern void do_priv_instruction(struct pt_regs *regs, unsigned long pc,
-                                unsigned long npc, unsigned long psr);
-extern void do_memaccess_unaligned(struct pt_regs *regs, unsigned long pc,
-                                   unsigned long npc,
-                                   unsigned long psr);
-extern void do_fpd_trap(struct pt_regs *regs, unsigned long pc,
+void do_hw_interrupt(struct pt_regs *regs, unsigned long type);
+void do_illegal_instruction(struct pt_regs *regs, unsigned long pc,
+                            unsigned long npc, unsigned long psr);
+
+void do_priv_instruction(struct pt_regs *regs, unsigned long pc,
+                         unsigned long npc, unsigned long psr);
+void do_memaccess_unaligned(struct pt_regs *regs, unsigned long pc,
+                            unsigned long npc, unsigned long psr);
+void do_fpd_trap(struct pt_regs *regs, unsigned long pc,
+                 unsigned long npc, unsigned long psr);
+void do_fpe_trap(struct pt_regs *regs, unsigned long pc,
+                 unsigned long npc, unsigned long psr);
+void handle_tag_overflow(struct pt_regs *regs, unsigned long pc,
+                         unsigned long npc, unsigned long psr);
+void handle_watchpoint(struct pt_regs *regs, unsigned long pc,
+                       unsigned long npc, unsigned long psr);
+void handle_reg_access(struct pt_regs *regs, unsigned long pc,
+                       unsigned long npc, unsigned long psr);
+void handle_cp_disabled(struct pt_regs *regs, unsigned long pc,
                         unsigned long npc, unsigned long psr);
-extern void do_fpe_trap(struct pt_regs *regs, unsigned long pc,
-                        unsigned long npc, unsigned long psr);
-extern void handle_tag_overflow(struct pt_regs *regs, unsigned long pc,
-                                unsigned long npc, unsigned long psr);
-extern void handle_watchpoint(struct pt_regs *regs, unsigned long pc,
-                              unsigned long npc, unsigned long psr);
-extern void handle_reg_access(struct pt_regs *regs, unsigned long pc,
-                              unsigned long npc, unsigned long psr);
-extern void handle_cp_disabled(struct pt_regs *regs, unsigned long pc,
-                               unsigned long npc, unsigned long psr);
-extern void handle_cp_exception(struct pt_regs *regs, unsigned long pc,
-                                unsigned long npc, unsigned long psr);
+void handle_cp_exception(struct pt_regs *regs, unsigned long pc,
+                         unsigned long npc, unsigned long psr);
 
 
 
 /* entry.S */
-extern void fpsave(unsigned long *fpregs, unsigned long *fsr,
-                   void *fpqueue, unsigned long *fpqdepth);
-extern void fpload(unsigned long *fpregs, unsigned long *fsr);
+void fpsave(unsigned long *fpregs, unsigned long *fsr,
+            void *fpqueue, unsigned long *fpqdepth);
+void fpload(unsigned long *fpregs, unsigned long *fsr);
 
 #else /* CONFIG_SPARC32 */
 
@@ -66,123 +65,123 @@ struct pause_patch_entry {
 extern struct pause_patch_entry __pause_3insn_patch,
 	__pause_3insn_patch_end;
 
-extern void __init per_cpu_patch(void);
-extern void sun4v_patch_1insn_range(struct sun4v_1insn_patch_entry *,
-				    struct sun4v_1insn_patch_entry *);
-extern void sun4v_patch_2insn_range(struct sun4v_2insn_patch_entry *,
-				    struct sun4v_2insn_patch_entry *);
-extern void __init sun4v_patch(void);
-extern void __init boot_cpu_id_too_large(int cpu);
+void __init per_cpu_patch(void);
+void sun4v_patch_1insn_range(struct sun4v_1insn_patch_entry *,
+			     struct sun4v_1insn_patch_entry *);
+void sun4v_patch_2insn_range(struct sun4v_2insn_patch_entry *,
+			     struct sun4v_2insn_patch_entry *);
+void __init sun4v_patch(void);
+void __init boot_cpu_id_too_large(int cpu);
 extern unsigned int dcache_parity_tl1_occurred;
 extern unsigned int icache_parity_tl1_occurred;
 
-extern asmlinkage void sparc_breakpoint(struct pt_regs *regs);
-extern void timer_interrupt(int irq, struct pt_regs *regs);
-
-extern void do_notify_resume(struct pt_regs *regs,
-			     unsigned long orig_i0,
-			     unsigned long thread_info_flags);
-
-extern asmlinkage int syscall_trace_enter(struct pt_regs *regs);
-extern asmlinkage void syscall_trace_leave(struct pt_regs *regs);
-
-extern void bad_trap_tl1(struct pt_regs *regs, long lvl);
-
-extern void do_fpieee(struct pt_regs *regs);
-extern void do_fpother(struct pt_regs *regs);
-extern void do_tof(struct pt_regs *regs);
-extern void do_div0(struct pt_regs *regs);
-extern void do_illegal_instruction(struct pt_regs *regs);
-extern void mem_address_unaligned(struct pt_regs *regs,
-				  unsigned long sfar,
-				  unsigned long sfsr);
-extern void sun4v_do_mna(struct pt_regs *regs,
-			 unsigned long addr,
-			 unsigned long type_ctx);
-extern void do_privop(struct pt_regs *regs);
-extern void do_privact(struct pt_regs *regs);
-extern void do_cee(struct pt_regs *regs);
-extern void do_cee_tl1(struct pt_regs *regs);
-extern void do_dae_tl1(struct pt_regs *regs);
-extern void do_iae_tl1(struct pt_regs *regs);
-extern void do_div0_tl1(struct pt_regs *regs);
-extern void do_fpdis_tl1(struct pt_regs *regs);
-extern void do_fpieee_tl1(struct pt_regs *regs);
-extern void do_fpother_tl1(struct pt_regs *regs);
-extern void do_ill_tl1(struct pt_regs *regs);
-extern void do_irq_tl1(struct pt_regs *regs);
-extern void do_lddfmna_tl1(struct pt_regs *regs);
-extern void do_stdfmna_tl1(struct pt_regs *regs);
-extern void do_paw(struct pt_regs *regs);
-extern void do_paw_tl1(struct pt_regs *regs);
-extern void do_vaw(struct pt_regs *regs);
-extern void do_vaw_tl1(struct pt_regs *regs);
-extern void do_tof_tl1(struct pt_regs *regs);
-extern void do_getpsr(struct pt_regs *regs);
-
-extern void spitfire_insn_access_exception(struct pt_regs *regs,
-					   unsigned long sfsr,
-					   unsigned long sfar);
-extern void spitfire_insn_access_exception_tl1(struct pt_regs *regs,
-					       unsigned long sfsr,
-					       unsigned long sfar);
-extern void spitfire_data_access_exception(struct pt_regs *regs,
-					   unsigned long sfsr,
-					   unsigned long sfar);
-extern void spitfire_data_access_exception_tl1(struct pt_regs *regs,
-					       unsigned long sfsr,
-					       unsigned long sfar);
-extern void spitfire_access_error(struct pt_regs *regs,
-				  unsigned long status_encoded,
-				  unsigned long afar);
-
-extern void cheetah_fecc_handler(struct pt_regs *regs,
-				 unsigned long afsr,
-				 unsigned long afar);
-extern void cheetah_cee_handler(struct pt_regs *regs,
-				unsigned long afsr,
-				unsigned long afar);
-extern void cheetah_deferred_handler(struct pt_regs *regs,
-				     unsigned long afsr,
-				     unsigned long afar);
-extern void cheetah_plus_parity_error(int type, struct pt_regs *regs);
-
-extern void sun4v_insn_access_exception(struct pt_regs *regs,
-					unsigned long addr,
-					unsigned long type_ctx);
-extern void sun4v_insn_access_exception_tl1(struct pt_regs *regs,
-					    unsigned long addr,
-					    unsigned long type_ctx);
-extern void sun4v_data_access_exception(struct pt_regs *regs,
-					unsigned long addr,
-					unsigned long type_ctx);
-extern void sun4v_data_access_exception_tl1(struct pt_regs *regs,
-					    unsigned long addr,
-					    unsigned long type_ctx);
-extern void sun4v_resum_error(struct pt_regs *regs,
-			      unsigned long offset);
-extern void sun4v_resum_overflow(struct pt_regs *regs);
-extern void sun4v_nonresum_error(struct pt_regs *regs,
-				 unsigned long offset);
-extern void sun4v_nonresum_overflow(struct pt_regs *regs);
+asmlinkage void sparc_breakpoint(struct pt_regs *regs);
+void timer_interrupt(int irq, struct pt_regs *regs);
+
+void do_notify_resume(struct pt_regs *regs,
+		      unsigned long orig_i0,
+		      unsigned long thread_info_flags);
+
+asmlinkage int syscall_trace_enter(struct pt_regs *regs);
+asmlinkage void syscall_trace_leave(struct pt_regs *regs);
+
+void bad_trap_tl1(struct pt_regs *regs, long lvl);
+
+void do_fpieee(struct pt_regs *regs);
+void do_fpother(struct pt_regs *regs);
+void do_tof(struct pt_regs *regs);
+void do_div0(struct pt_regs *regs);
+void do_illegal_instruction(struct pt_regs *regs);
+void mem_address_unaligned(struct pt_regs *regs,
+			   unsigned long sfar,
+			   unsigned long sfsr);
+void sun4v_do_mna(struct pt_regs *regs,
+		  unsigned long addr,
+		  unsigned long type_ctx);
+void do_privop(struct pt_regs *regs);
+void do_privact(struct pt_regs *regs);
+void do_cee(struct pt_regs *regs);
+void do_cee_tl1(struct pt_regs *regs);
+void do_dae_tl1(struct pt_regs *regs);
+void do_iae_tl1(struct pt_regs *regs);
+void do_div0_tl1(struct pt_regs *regs);
+void do_fpdis_tl1(struct pt_regs *regs);
+void do_fpieee_tl1(struct pt_regs *regs);
+void do_fpother_tl1(struct pt_regs *regs);
+void do_ill_tl1(struct pt_regs *regs);
+void do_irq_tl1(struct pt_regs *regs);
+void do_lddfmna_tl1(struct pt_regs *regs);
+void do_stdfmna_tl1(struct pt_regs *regs);
+void do_paw(struct pt_regs *regs);
+void do_paw_tl1(struct pt_regs *regs);
+void do_vaw(struct pt_regs *regs);
+void do_vaw_tl1(struct pt_regs *regs);
+void do_tof_tl1(struct pt_regs *regs);
+void do_getpsr(struct pt_regs *regs);
+
+void spitfire_insn_access_exception(struct pt_regs *regs,
+				    unsigned long sfsr,
+				    unsigned long sfar);
+void spitfire_insn_access_exception_tl1(struct pt_regs *regs,
+				        unsigned long sfsr,
+				        unsigned long sfar);
+void spitfire_data_access_exception(struct pt_regs *regs,
+				    unsigned long sfsr,
+				    unsigned long sfar);
+void spitfire_data_access_exception_tl1(struct pt_regs *regs,
+				        unsigned long sfsr,
+				        unsigned long sfar);
+void spitfire_access_error(struct pt_regs *regs,
+			   unsigned long status_encoded,
+			   unsigned long afar);
+
+void cheetah_fecc_handler(struct pt_regs *regs,
+			  unsigned long afsr,
+			  unsigned long afar);
+void cheetah_cee_handler(struct pt_regs *regs,
+			 unsigned long afsr,
+			 unsigned long afar);
+void cheetah_deferred_handler(struct pt_regs *regs,
+			      unsigned long afsr,
+			      unsigned long afar);
+void cheetah_plus_parity_error(int type, struct pt_regs *regs);
+
+void sun4v_insn_access_exception(struct pt_regs *regs,
+				 unsigned long addr,
+				 unsigned long type_ctx);
+void sun4v_insn_access_exception_tl1(struct pt_regs *regs,
+				     unsigned long addr,
+				     unsigned long type_ctx);
+void sun4v_data_access_exception(struct pt_regs *regs,
+				 unsigned long addr,
+				 unsigned long type_ctx);
+void sun4v_data_access_exception_tl1(struct pt_regs *regs,
+				     unsigned long addr,
+				     unsigned long type_ctx);
+void sun4v_resum_error(struct pt_regs *regs,
+		       unsigned long offset);
+void sun4v_resum_overflow(struct pt_regs *regs);
+void sun4v_nonresum_error(struct pt_regs *regs,
+			  unsigned long offset);
+void sun4v_nonresum_overflow(struct pt_regs *regs);
 
 extern unsigned long sun4v_err_itlb_vaddr;
 extern unsigned long sun4v_err_itlb_ctx;
 extern unsigned long sun4v_err_itlb_pte;
 extern unsigned long sun4v_err_itlb_error;
 
-extern void sun4v_itlb_error_report(struct pt_regs *regs, int tl);
+void sun4v_itlb_error_report(struct pt_regs *regs, int tl);
 
 extern unsigned long sun4v_err_dtlb_vaddr;
 extern unsigned long sun4v_err_dtlb_ctx;
 extern unsigned long sun4v_err_dtlb_pte;
 extern unsigned long sun4v_err_dtlb_error;
 
-extern void sun4v_dtlb_error_report(struct pt_regs *regs, int tl);
-extern void hypervisor_tlbop_error(unsigned long err,
-				   unsigned long op);
-extern void hypervisor_tlbop_error_xcall(unsigned long err,
-					 unsigned long op);
+void sun4v_dtlb_error_report(struct pt_regs *regs, int tl);
+void hypervisor_tlbop_error(unsigned long err,
+			    unsigned long op);
+void hypervisor_tlbop_error_xcall(unsigned long err,
+				  unsigned long op);
 
 /* WARNING: The error trap handlers in assembly know the precise
  *	    layout of the following structure.
@@ -248,8 +247,8 @@ struct ino_bucket {
 extern struct ino_bucket *ivector_table;
 extern unsigned long ivector_table_pa;
 
-extern void init_irqwork_curcpu(void);
-extern void sun4v_register_mondo_queues(int this_cpu);
+void init_irqwork_curcpu(void);
+void sun4v_register_mondo_queues(int this_cpu);
 
 #endif /* CONFIG_SPARC32 */
 #endif /* _ENTRY_H */
diff --git a/arch/sparc/kernel/iommu_common.h b/arch/sparc/kernel/iommu_common.h
index 591f587..1ec0de4 100644
--- a/arch/sparc/kernel/iommu_common.h
+++ b/arch/sparc/kernel/iommu_common.h
@@ -48,12 +48,12 @@ static inline int is_span_boundary(unsigned long entry,
 	return iommu_is_span_boundary(entry, nr, shift, boundary_size);
 }
 
-extern unsigned long iommu_range_alloc(struct device *dev,
-				       struct iommu *iommu,
-				       unsigned long npages,
-				       unsigned long *handle);
-extern void iommu_range_free(struct iommu *iommu,
-			     dma_addr_t dma_addr,
-			     unsigned long npages);
+unsigned long iommu_range_alloc(struct device *dev,
+				struct iommu *iommu,
+				unsigned long npages,
+				unsigned long *handle);
+void iommu_range_free(struct iommu *iommu,
+		      dma_addr_t dma_addr,
+		      unsigned long npages);
 
 #endif /* _IOMMU_COMMON_H */
diff --git a/arch/sparc/kernel/irq.h b/arch/sparc/kernel/irq.h
index 7c7540a..70a0b8d 100644
--- a/arch/sparc/kernel/irq.h
+++ b/arch/sparc/kernel/irq.h
@@ -96,6 +96,6 @@ void sun4d_handler_irq(unsigned int pil, struct pt_regs *regs);
 /* All SUN4D IPIs are sent on this IRQ, may be shared with hard IRQs */
 #define SUN4D_IPI_IRQ 13
 
-extern void sun4d_ipi_interrupt(void);
+void sun4d_ipi_interrupt(void);
 
 #endif
diff --git a/arch/sparc/kernel/kernel.h b/arch/sparc/kernel/kernel.h
index beaba3a..0ce0f96 100644
--- a/arch/sparc/kernel/kernel.h
+++ b/arch/sparc/kernel/kernel.h
@@ -15,7 +15,7 @@ extern int ncpus_probed;
 #ifdef CONFIG_SPARC64
 /* setup_64.c */
 struct seq_file;
-extern void cpucap_info(struct seq_file *);
+void cpucap_info(struct seq_file *);
 
 static inline unsigned long kimage_addr_to_ra(const char *p)
 {
@@ -31,23 +31,23 @@ struct linux_romvec;
 void sparc32_start_kernel(struct linux_romvec *rp);
 
 /* cpu.c */
-extern void cpu_probe(void);
+void cpu_probe(void);
 
 /* traps_32.c */
-extern void handle_hw_divzero(struct pt_regs *regs, unsigned long pc,
-                              unsigned long npc, unsigned long psr);
+void handle_hw_divzero(struct pt_regs *regs, unsigned long pc,
+                       unsigned long npc, unsigned long psr);
 /* irq_32.c */
 extern struct irqaction static_irqaction[];
 extern int static_irq_count;
 extern spinlock_t irq_action_lock;
 
-extern void unexpected_irq(int irq, void *dev_id, struct pt_regs * regs);
-extern void init_IRQ(void);
+void unexpected_irq(int irq, void *dev_id, struct pt_regs * regs);
+void init_IRQ(void);
 
 /* sun4m_irq.c */
-extern void sun4m_init_IRQ(void);
-extern void sun4m_unmask_profile_irq(void);
-extern void sun4m_clear_profile_irq(int cpu);
+void sun4m_init_IRQ(void);
+void sun4m_unmask_profile_irq(void);
+void sun4m_clear_profile_irq(int cpu);
 
 /* sun4m_smp.c */
 void sun4m_cpu_pre_starting(void *arg);
@@ -61,14 +61,14 @@ void smp4m_percpu_timer_interrupt(struct pt_regs *regs);
 /* sun4d_irq.c */
 extern spinlock_t sun4d_imsk_lock;
 
-extern void sun4d_init_IRQ(void);
-extern int sun4d_request_irq(unsigned int irq,
-                             irq_handler_t handler,
-                             unsigned long irqflags,
-                             const char *devname, void *dev_id);
-extern int show_sun4d_interrupts(struct seq_file *, void *);
-extern void sun4d_distribute_irqs(void);
-extern void sun4d_free_irq(unsigned int irq, void *dev_id);
+void sun4d_init_IRQ(void);
+int sun4d_request_irq(unsigned int irq,
+                      irq_handler_t handler,
+                      unsigned long irqflags,
+                      const char *devname, void *dev_id);
+int show_sun4d_interrupts(struct seq_file *, void *);
+void sun4d_distribute_irqs(void);
+void sun4d_free_irq(unsigned int irq, void *dev_id);
 
 /* sun4d_smp.c */
 void sun4d_cpu_pre_starting(void *arg);
@@ -102,7 +102,7 @@ extern unsigned int real_irq_entry[];
 extern unsigned int smp4d_ticker[];
 extern unsigned int patchme_maybe_smp_msg[];
 
-extern void floppy_hardint(void);
+void floppy_hardint(void);
 
 /* trampoline_32.S */
 extern unsigned long sun4m_cpu_startup;
diff --git a/arch/sparc/kernel/pci_impl.h b/arch/sparc/kernel/pci_impl.h
index 5f68853..75803c7 100644
--- a/arch/sparc/kernel/pci_impl.h
+++ b/arch/sparc/kernel/pci_impl.h
@@ -48,8 +48,8 @@ struct sparc64_msiq_ops {
 			      unsigned long devino);
 };
 
-extern void sparc64_pbm_msi_init(struct pci_pbm_info *pbm,
-				 const struct sparc64_msiq_ops *ops);
+void sparc64_pbm_msi_init(struct pci_pbm_info *pbm,
+			  const struct sparc64_msiq_ops *ops);
 
 struct sparc64_msiq_cookie {
 	struct pci_pbm_info *pbm;
@@ -158,23 +158,23 @@ extern struct pci_pbm_info *pci_pbm_root;
 extern int pci_num_pbms;
 
 /* PCI bus scanning and fixup support. */
-extern void pci_get_pbm_props(struct pci_pbm_info *pbm);
-extern struct pci_bus *pci_scan_one_pbm(struct pci_pbm_info *pbm,
-					struct device *parent);
-extern void pci_determine_mem_io_space(struct pci_pbm_info *pbm);
+void pci_get_pbm_props(struct pci_pbm_info *pbm);
+struct pci_bus *pci_scan_one_pbm(struct pci_pbm_info *pbm,
+				 struct device *parent);
+void pci_determine_mem_io_space(struct pci_pbm_info *pbm);
 
 /* Error reporting support. */
-extern void pci_scan_for_target_abort(struct pci_pbm_info *, struct pci_bus *);
-extern void pci_scan_for_master_abort(struct pci_pbm_info *, struct pci_bus *);
-extern void pci_scan_for_parity_error(struct pci_pbm_info *, struct pci_bus *);
+void pci_scan_for_target_abort(struct pci_pbm_info *, struct pci_bus *);
+void pci_scan_for_master_abort(struct pci_pbm_info *, struct pci_bus *);
+void pci_scan_for_parity_error(struct pci_pbm_info *, struct pci_bus *);
 
 /* Configuration space access. */
-extern void pci_config_read8(u8 *addr, u8 *ret);
-extern void pci_config_read16(u16 *addr, u16 *ret);
-extern void pci_config_read32(u32 *addr, u32 *ret);
-extern void pci_config_write8(u8 *addr, u8 val);
-extern void pci_config_write16(u16 *addr, u16 val);
-extern void pci_config_write32(u32 *addr, u32 val);
+void pci_config_read8(u8 *addr, u8 *ret);
+void pci_config_read16(u16 *addr, u16 *ret);
+void pci_config_read32(u32 *addr, u32 *ret);
+void pci_config_write8(u8 *addr, u8 val);
+void pci_config_write16(u16 *addr, u16 val);
+void pci_config_write32(u32 *addr, u32 val);
 
 extern struct pci_ops sun4u_pci_ops;
 extern struct pci_ops sun4v_pci_ops;
diff --git a/arch/sparc/kernel/pci_sun4v.h b/arch/sparc/kernel/pci_sun4v.h
index 8e9fc3a..5642212 100644
--- a/arch/sparc/kernel/pci_sun4v.h
+++ b/arch/sparc/kernel/pci_sun4v.h
@@ -6,87 +6,87 @@
 #ifndef _PCI_SUN4V_H
 #define _PCI_SUN4V_H
 
-extern long pci_sun4v_iommu_map(unsigned long devhandle,
-				unsigned long tsbid,
-				unsigned long num_ttes,
-				unsigned long io_attributes,
-				unsigned long io_page_list_pa);
-extern unsigned long pci_sun4v_iommu_demap(unsigned long devhandle,
-					   unsigned long tsbid,
-					   unsigned long num_ttes);
-extern unsigned long pci_sun4v_iommu_getmap(unsigned long devhandle,
-					    unsigned long tsbid,
-					    unsigned long *io_attributes,
-					    unsigned long *real_address);
-extern unsigned long pci_sun4v_config_get(unsigned long devhandle,
-					  unsigned long pci_device,
-					  unsigned long config_offset,
-					  unsigned long size);
-extern int pci_sun4v_config_put(unsigned long devhandle,
-				unsigned long pci_device,
-				unsigned long config_offset,
-				unsigned long size,
-				unsigned long data);
+long pci_sun4v_iommu_map(unsigned long devhandle,
+			 unsigned long tsbid,
+			 unsigned long num_ttes,
+			 unsigned long io_attributes,
+			 unsigned long io_page_list_pa);
+unsigned long pci_sun4v_iommu_demap(unsigned long devhandle,
+				    unsigned long tsbid,
+				    unsigned long num_ttes);
+unsigned long pci_sun4v_iommu_getmap(unsigned long devhandle,
+				     unsigned long tsbid,
+				     unsigned long *io_attributes,
+				     unsigned long *real_address);
+unsigned long pci_sun4v_config_get(unsigned long devhandle,
+				   unsigned long pci_device,
+				   unsigned long config_offset,
+				   unsigned long size);
+int pci_sun4v_config_put(unsigned long devhandle,
+			 unsigned long pci_device,
+			 unsigned long config_offset,
+			 unsigned long size,
+			 unsigned long data);
 
-extern unsigned long pci_sun4v_msiq_conf(unsigned long devhandle,
+unsigned long pci_sun4v_msiq_conf(unsigned long devhandle,
 					 unsigned long msiqid,
 					 unsigned long msiq_paddr,
 					 unsigned long num_entries);
-extern unsigned long pci_sun4v_msiq_info(unsigned long devhandle,
-					 unsigned long msiqid,
-					 unsigned long *msiq_paddr,
-					 unsigned long *num_entries);
-extern unsigned long pci_sun4v_msiq_getvalid(unsigned long devhandle,
-					     unsigned long msiqid,
-					     unsigned long *valid);
-extern unsigned long pci_sun4v_msiq_setvalid(unsigned long devhandle,
-					     unsigned long msiqid,
-					     unsigned long valid);
-extern unsigned long pci_sun4v_msiq_getstate(unsigned long devhandle,
-					     unsigned long msiqid,
-					     unsigned long *state);
-extern unsigned long pci_sun4v_msiq_setstate(unsigned long devhandle,
-					     unsigned long msiqid,
-					     unsigned long state);
-extern unsigned long pci_sun4v_msiq_gethead(unsigned long devhandle,
-					     unsigned long msiqid,
-					     unsigned long *head);
-extern unsigned long pci_sun4v_msiq_sethead(unsigned long devhandle,
-					     unsigned long msiqid,
-					     unsigned long head);
-extern unsigned long pci_sun4v_msiq_gettail(unsigned long devhandle,
-					     unsigned long msiqid,
-					     unsigned long *head);
-extern unsigned long pci_sun4v_msi_getvalid(unsigned long devhandle,
-					    unsigned long msinum,
-					    unsigned long *valid);
-extern unsigned long pci_sun4v_msi_setvalid(unsigned long devhandle,
-					    unsigned long msinum,
-					    unsigned long valid);
-extern unsigned long pci_sun4v_msi_getmsiq(unsigned long devhandle,
-					   unsigned long msinum,
-					   unsigned long *msiq);
-extern unsigned long pci_sun4v_msi_setmsiq(unsigned long devhandle,
-					   unsigned long msinum,
-					   unsigned long msiq,
-					   unsigned long msitype);
-extern unsigned long pci_sun4v_msi_getstate(unsigned long devhandle,
-					    unsigned long msinum,
-					    unsigned long *state);
-extern unsigned long pci_sun4v_msi_setstate(unsigned long devhandle,
-					    unsigned long msinum,
-					    unsigned long state);
-extern unsigned long pci_sun4v_msg_getmsiq(unsigned long devhandle,
-					   unsigned long msinum,
-					   unsigned long *msiq);
-extern unsigned long pci_sun4v_msg_setmsiq(unsigned long devhandle,
-					   unsigned long msinum,
-					   unsigned long msiq);
-extern unsigned long pci_sun4v_msg_getvalid(unsigned long devhandle,
-					    unsigned long msinum,
-					    unsigned long *valid);
-extern unsigned long pci_sun4v_msg_setvalid(unsigned long devhandle,
-					    unsigned long msinum,
-					    unsigned long valid);
+unsigned long pci_sun4v_msiq_info(unsigned long devhandle,
+				  unsigned long msiqid,
+				  unsigned long *msiq_paddr,
+				  unsigned long *num_entries);
+unsigned long pci_sun4v_msiq_getvalid(unsigned long devhandle,
+				      unsigned long msiqid,
+				      unsigned long *valid);
+unsigned long pci_sun4v_msiq_setvalid(unsigned long devhandle,
+				      unsigned long msiqid,
+				      unsigned long valid);
+unsigned long pci_sun4v_msiq_getstate(unsigned long devhandle,
+				      unsigned long msiqid,
+				      unsigned long *state);
+unsigned long pci_sun4v_msiq_setstate(unsigned long devhandle,
+				      unsigned long msiqid,
+				      unsigned long state);
+unsigned long pci_sun4v_msiq_gethead(unsigned long devhandle,
+				     unsigned long msiqid,
+				     unsigned long *head);
+unsigned long pci_sun4v_msiq_sethead(unsigned long devhandle,
+				     unsigned long msiqid,
+				     unsigned long head);
+unsigned long pci_sun4v_msiq_gettail(unsigned long devhandle,
+				      unsigned long msiqid,
+				      unsigned long *head);
+unsigned long pci_sun4v_msi_getvalid(unsigned long devhandle,
+				     unsigned long msinum,
+				     unsigned long *valid);
+unsigned long pci_sun4v_msi_setvalid(unsigned long devhandle,
+				     unsigned long msinum,
+				     unsigned long valid);
+unsigned long pci_sun4v_msi_getmsiq(unsigned long devhandle,
+				    unsigned long msinum,
+				    unsigned long *msiq);
+unsigned long pci_sun4v_msi_setmsiq(unsigned long devhandle,
+				    unsigned long msinum,
+				    unsigned long msiq,
+				    unsigned long msitype);
+unsigned long pci_sun4v_msi_getstate(unsigned long devhandle,
+				     unsigned long msinum,
+				     unsigned long *state);
+unsigned long pci_sun4v_msi_setstate(unsigned long devhandle,
+				     unsigned long msinum,
+				     unsigned long state);
+unsigned long pci_sun4v_msg_getmsiq(unsigned long devhandle,
+				    unsigned long msinum,
+				    unsigned long *msiq);
+unsigned long pci_sun4v_msg_setmsiq(unsigned long devhandle,
+				    unsigned long msinum,
+				    unsigned long msiq);
+unsigned long pci_sun4v_msg_getvalid(unsigned long devhandle,
+				     unsigned long msinum,
+				     unsigned long *valid);
+unsigned long pci_sun4v_msg_setvalid(unsigned long devhandle,
+				     unsigned long msinum,
+				     unsigned long valid);
 
 #endif /* !(_PCI_SUN4V_H) */
diff --git a/arch/sparc/kernel/prom.h b/arch/sparc/kernel/prom.h
index cf5fe1c..890281b 100644
--- a/arch/sparc/kernel/prom.h
+++ b/arch/sparc/kernel/prom.h
@@ -4,7 +4,7 @@
 #include <linux/spinlock.h>
 #include <asm/prom.h>
 
-extern void of_console_init(void);
+void of_console_init(void);
 
 extern unsigned int prom_early_allocated;
 
diff --git a/arch/sparc/kernel/psycho_common.h b/arch/sparc/kernel/psycho_common.h
index 590b4ed..05a6e30 100644
--- a/arch/sparc/kernel/psycho_common.h
+++ b/arch/sparc/kernel/psycho_common.h
@@ -30,19 +30,19 @@ enum psycho_error_type {
 	UE_ERR, CE_ERR, PCI_ERR
 };
 
-extern void psycho_check_iommu_error(struct pci_pbm_info *pbm,
-				     unsigned long afsr,
-				     unsigned long afar,
-				     enum psycho_error_type type);
+void psycho_check_iommu_error(struct pci_pbm_info *pbm,
+			      unsigned long afsr,
+			      unsigned long afar,
+			      enum psycho_error_type type);
 
-extern irqreturn_t psycho_pcierr_intr(int irq, void *dev_id);
+irqreturn_t psycho_pcierr_intr(int irq, void *dev_id);
 
-extern int psycho_iommu_init(struct pci_pbm_info *pbm, int tsbsize,
-			     u32 dvma_offset, u32 dma_mask,
-			     unsigned long write_complete_offset);
+int psycho_iommu_init(struct pci_pbm_info *pbm, int tsbsize,
+		      u32 dvma_offset, u32 dma_mask,
+		      unsigned long write_complete_offset);
 
-extern void psycho_pbm_init_common(struct pci_pbm_info *pbm,
-				   struct platform_device *op,
-				   const char *chip_name, int chip_type);
+void psycho_pbm_init_common(struct pci_pbm_info *pbm,
+			    struct platform_device *op,
+			    const char *chip_name, int chip_type);
 
 #endif /* _PSYCHO_COMMON_H */
diff --git a/arch/sparc/mm/init_64.h b/arch/sparc/mm/init_64.h
index 5d3782de..0668b36 100644
--- a/arch/sparc/mm/init_64.h
+++ b/arch/sparc/mm/init_64.h
@@ -21,7 +21,7 @@ extern unsigned int sparc64_highest_unlocked_tlb_ent;
 extern unsigned long sparc64_kern_pri_context;
 extern unsigned long sparc64_kern_pri_nuc_bits;
 extern unsigned long sparc64_kern_sec_context;
-extern void mmu_info(struct seq_file *m);
+void mmu_info(struct seq_file *m);
 
 struct linux_prom_translation {
 	unsigned long virt;
@@ -36,7 +36,7 @@ extern unsigned int prom_trans_ents;
 /* Exported for SMP bootup purposes. */
 extern unsigned long kern_locked_tte_data;
 
-extern void prom_world(int enter);
+void prom_world(int enter);
 
 #ifdef CONFIG_SPARSEMEM_VMEMMAP
 #define VMEMMAP_CHUNK_SHIFT	22
-- 
1.9.0

