From: Dennis Gilmore <dennis@ausil.us>
Date: Sat, 26 Feb 2011 02:17:51 +0000
Subject: Re: [PATCH] Don't build any of the sparc arch bits with -Werror
Message-Id: <201102252017.58951.dennis@ausil.us>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart18571376.RDN4idsxkx"
List-Id: <sparclinux.vger.kernel.org>
References: <1298678235-29164-1-git-send-email-dennis@ausil.us>
In-Reply-To: <1298678235-29164-1-git-send-email-dennis@ausil.us>
To: sparclinux@vger.kernel.org

--nextPart18571376.RDN4idsxkx
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Friday, February 25, 2011 08:10:01 PM David Miller wrote:
> From: Dennis Gilmore <dennis@ausil.us>
> Date: Fri, 25 Feb 2011 18:06:00 -0600
>=20
> > This is due to gcc-4.6 it throws warnings for defined but unused
> > variables. without this we cant build the kernel at all.  i have buil
> > tested but not tried to run yet
>=20
> Then fix the warnings since they are likely legitimate.
>=20
> We've had -Werror there for _years_, don't just knee jerk remove
> it because some new compiler notices new problems.
> --
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
 a build with this patch results in the following

+ make -s ARCH=3Dsparc64 V=3D1 -j16 image
arch/sparc/kernel/traps_64.c: In function 'show_stack':
arch/sparc/kernel/traps_64.c:2155:20: warning: variable 'thread_base' set b=
ut=20
not used [-Wunused-but-set-variable]
kernel/sched.c: In function 'alloc_fair_sched_group':
kernel/sched.c:8237:13: warning: variable 'rq' set but not used [-Wunused-b=
ut-
set-variable]
kernel/sched.c: In function 'alloc_rt_sched_group':
kernel/sched.c:8328:13: warning: variable 'rq' set but not used [-Wunused-b=
ut-
set-variable]
mm/page_alloc.c: In function 'set_migratetype_isolate':
mm/page_alloc.c:5423:6: warning: variable 'zone_idx' set but not used [-
Wunused-but-set-variable]
mm/backing-dev.c: In function 'bdi_debug_stats_show':
mm/backing-dev.c:72:45: warning: variable 'nr_wb' set but not used [-Wunuse=
d-
but-set-variable]
security/integrity/ima/ima_main.c: In function 'ima_file_mmap':
security/integrity/ima/ima_main.c:274:6: warning: variable 'rc' set but not=
=20
used [-Wunused-but-set-variable]
security/integrity/ima/ima_main.c: In function 'ima_bprm_check':
security/integrity/ima/ima_main.c:299:6: warning: variable 'rc' set but not=
=20
used [-Wunused-but-set-variable]
security/integrity/ima/ima_main.c: In function 'ima_file_check':
security/integrity/ima/ima_main.c:318:6: warning: variable 'rc' set but not=
=20
used [-Wunused-but-set-variable]
arch/sparc/kernel/iommu.c: In function 'dma_4u_free_coherent':
arch/sparc/kernel/iommu.c:336:11: warning: variable 'iopte' set but not use=
d=20
[-Wunused-but-set-variable]
mm/memory.c: In function 'copy_pte_range':
mm/memory.c:733:24: warning: variable 'orig_dst_pte' set but not used [-
Wunused-but-set-variable]
mm/memory.c:733:9: warning: variable 'orig_src_pte' set but not used [-
Wunused-but-set-variable]
arch/sparc/kernel/pcr.c: In function 'n2_pcr_write':
arch/sparc/kernel/pcr.c:81:16: warning: variable 'ret' set but not used [-
Wunused-but-set-variable]
mm/mmap.c: In function '__split_vma':
mm/mmap.c:2112:17: warning: unused variable 'old_end' [-Wunused-variable]
mm/mprotect.c: In function 'mprotect_fixup':
mm/mprotect.c:156:29: warning: unused variable 'old_end' [-Wunused-variable]
arch/sparc/kernel/smp_64.c: In function 'smp_synchronize_tick_client':
arch/sparc/kernel/smp_64.c:192:46: warning: variable 'bound' set but not us=
ed=20
[-Wunused-but-set-variable]
arch/sparc/kernel/smp_64.c: In function 'flush_dcache_page_all':
arch/sparc/kernel/smp_64.c:936:6: warning: variable 'this_cpu' set but not=
=20
used [-Wunused-but-set-variable]
fs/bio-integrity.c: In function 'bio_integrity_trim':
fs/bio-integrity.c:670:15: warning: variable 'nr_sectors' set but not used =
[-
Wunused-but-set-variable]
arch/sparc/kernel/pci.c: In function 'pci_bus_register_of_sysfs':
arch/sparc/kernel/pci.c:667:6: warning: variable 'err' set but not used [-
Wunused-but-set-variable]
arch/sparc/kernel/pci_common.c: In function 'sun4v_write_pci_cfg':
arch/sparc/kernel/pci_common.c:298:16: warning: variable 'ret' set but not=
=20
used [-Wunused-but-set-variable]
arch/sparc/kernel/pci_sun4v.c: In function 'pci_sun4v_iommu_init':
arch/sparc/kernel/pci_sun4v.c:583:37: warning: variable 'tsbsize' set but n=
ot=20
used [-Wunused-but-set-variable]
arch/sparc/kernel/pci_schizo.c: In function 'schizo_pbm_init':
arch/sparc/kernel/pci_schizo.c:1316:6: warning: variable 'is_pbm_a' set but=
=20
not used [-Wunused-but-set-variable]
arch/sparc/kernel/pci_fire.c: In function 'pci_fire_msi_teardown':
arch/sparc/kernel/pci_fire.c:217:16: warning: variable 'msiqid' set but not=
=20
used [-Wunused-but-set-variable]
security/selinux/ss/ebitmap.c: In function 'ebitmap_netlbl_import':
security/selinux/ss/ebitmap.c:161:27: warning: variable 'e_sft' set but not=
=20
used [-Wunused-but-set-variable]
kernel/params.c: In function 'version_sysfs_builtin':
kernel/params.c:830:6: warning: variable 'err' set but not used [-Wunused-b=
ut-
set-variable]
arch/sparc/kernel/ldc.c: In function 'ldc_rx':
arch/sparc/kernel/ldc.c:793:28: warning: variable 'hv_err' set but not used=
 [-
Wunused-but-set-variable]
arch/sparc/kernel/ldc.c: In function 'ldc_tx':
arch/sparc/kernel/ldc.c:907:23: warning: variable 'hv_err' set but not used=
 [-
Wunused-but-set-variable]
mm/mempolicy.c: In function 'check_pte_range':
mm/mempolicy.c:470:9: warning: variable 'orig_pte' set but not used [-Wunus=
ed-
but-set-variable]
kernel/debug/debug_core.c: In function 'kgdb_cpu_enter':
kernel/debug/debug_core.c:497:4: warning: value computed is not used [-
Wunused-value]
kernel/debug/debug_core.c:512:5: warning: value computed is not used [-
Wunused-value]
drivers/char/tpm/tpm.c: In function 'tpm_gen_interrupt':
drivers/char/tpm/tpm.c:520:10: warning: variable 'rc' set but not used [-
Wunused-but-set-variable]
drivers/char/tpm/tpm_tis.c:96:12: warning: 'is_itpm' defined but not used [-
Wunused-function]
fs/ext4/extents.c: In function 'check_eofblocks_fl':
fs/ext4/extents.c:3111:22: warning: variable 'ex' set but not used [-Wunuse=
d-
but-set-variable]
fs/ext4/extents.c: In function 'ext4_ext_map_blocks':
fs/ext4/extents.c:3298:29: warning: variable 'eh' set but not used [-Wunuse=
d-
but-set-variable]
drivers/base/module.c: In function 'module_add_driver':
drivers/base/module.c:36:6: warning: variable 'no_warn' set but not used [-
Wunused-but-set-variable]
fs/ext4/mballoc.c: In function 'ext4_mb_normalize_request':
fs/ext4/mballoc.c:2922:15: warning: variable 'orig_size' set but not used [-
Wunused-but-set-variable]
kernel/trace/trace.c: In function 'ftrace_trace_userstack':
kernel/trace/trace.c:1294:21: warning: variable 'trace' set but not used [-
Wunused-but-set-variable]
kernel/module.c: In function 'add_usage_links':
kernel/module.c:1372:6: warning: variable 'nowarn' set but not used [-Wunus=
ed-
but-set-variable]
drivers/input/mouse/sentelic.c: In function 'fsp_attr_set_setreg':
drivers/input/mouse/sentelic.c:414:10: warning: variable 'retval' set but n=
ot=20
used [-Wunused-but-set-variable]
net/core/dev_addr_lists.c: In function '__hw_addr_del_multiple':
net/core/dev_addr_lists.c:143:16: warning: variable 'type' set but not used=
 [-
Wunused-but-set-variable]
lib/atomic64_test.c: In function 'test_atomic64':
lib/atomic64_test.c:131:2: warning: #warning Please implement=20
atomic64_dec_if_positive for your architecture, and add it to the IF above =
[-
Wcpp]
lib/decompress_unlzo.c: In function 'parse_header':
lib/decompress_unlzo.c:59:5: warning: variable 'level' set but not used [-
Wunused-but-set-variable]
kernel/audit.c: In function 'audit_buffer_alloc':
kernel/audit.c:1036:19: warning: variable 'nlh' set but not used [-Wunused-
but-set-variable]
lib/ioremap.c: In function 'ioremap_page_range':
lib/ioremap.c:74:16: warning: variable 'start' set but not used [-Wunused-b=
ut-
set-variable]
lib/radix-tree.c: In function 'radix_tree_tag_get':
lib/radix-tree.c:579:6: warning: variable 'saw_unset_tag' set but not used =
[-
Wunused-but-set-variable]
fs/partitions/check.c: In function 'rescan_partitions':
fs/partitions/check.c:613:31: warning: variable 'info' set but not used [-
Wunused-but-set-variable]
lib/vsprintf.c: In function 'vbin_printf':
lib/vsprintf.c:1691:10: warning: variable 'skip_arg' set but not used [-
Wunused-but-set-variable]
fs/notify/dnotify/dnotify.c: In function 'dnotify_handle_event':
fs/notify/dnotify/dnotify.c:91:16: warning: variable 'to_tell' set but not=
=20
used [-Wunused-but-set-variable]
fs/notify/inotify/inotify_fsnotify.c: In function 'inotify_handle_event':
fs/notify/inotify/inotify_fsnotify.c:98:16: warning: variable 'to_tell' set=
=20
but not used [-Wunused-but-set-variable]
fs/notify/inotify/inotify_user.c: In function=20
'inotify_ignored_and_remove_idr':
fs/notify/inotify/inotify_user.c:523:6: warning: variable 'ret' set but not=
=20
used [-Wunused-but-set-variable]
kernel/padata.c: In function 'padata_parallel_worker':
kernel/padata.c:66:26: warning: variable 'pinst' set but not used [-Wunused-
but-set-variable]
net/netlabel/netlabel_cipso_v4.c: In function 'netlbl_cipsov4_add':
net/netlabel/netlabel_cipso_v4.c:425:14: warning: variable 'type_str' set b=
ut=20
not used [-Wunused-but-set-variable]
net/netfilter/nf_conntrack_core.c: In function 'nf_conntrack_init':
net/netfilter/nf_conntrack_core.c:1556:3: warning: the comparison will alwa=
ys=20
evaluate as 'true' for the address of 'nf_conntrack_attach' will never be N=
ULL=20
[-Waddress]
net/netfilter/nf_conntrack_core.c:1557:3: warning: the comparison will alwa=
ys=20
evaluate as 'true' for the address of 'destroy_conntrack' will never be NUL=
L=20
[-Waddress]
net/netfilter/nf_conntrack_standalone.c: In function 'ct_seq_show':
net/netfilter/nf_conntrack_standalone.c:142:6: warning: variable 'ret' set =
but=20
not used [-Wunused-but-set-variable]
drivers/md/md.c: In function 'calc_sb_1_csum':
drivers/md/md.c:1365:6: warning: variable 'i' set but not used [-Wunused-bu=
t-
set-variable]
drivers/md/bitmap.c: In function 'bitmap_init_from_disk':
drivers/md/bitmap.c:936:29: warning: variable 'oldpage' set but not used [-
Wunused-but-set-variable]
net/netfilter/nf_conntrack_proto.c: In function=20
'nf_conntrack_l3proto_unregister':
net/netfilter/nf_conntrack_proto.c:205:2: warning: the comparison will alwa=
ys=20
evaluate as 'true' for the address of 'nf_conntrack_l3proto_generic' will=20
never be NULL [-Waddress]
net/netfilter/nf_conntrack_proto.c: In function=20
'nf_conntrack_l4proto_unregister':
net/netfilter/nf_conntrack_proto.c:335:2: warning: the comparison will alwa=
ys=20
evaluate as 'true' for the address of 'nf_conntrack_l4proto_generic' will=20
never be NULL [-Waddress]
net/netfilter/nf_conntrack_proto.c: In function 'nf_conntrack_proto_init':
net/netfilter/nf_conntrack_proto.c:360:3: warning: the comparison will alwa=
ys=20
evaluate as 'true' for the address of 'nf_conntrack_l3proto_generic' will=20
never be NULL [-Waddress]
net/packet/af_packet.c: In function 'tpacket_snd':
net/packet/af_packet.c:957:17: warning: variable 'sock' set but not used [-
Wunused-but-set-variable]
fs/quota/dquot.c: In function 'remove_dquot_ref':
fs/quota/dquot.c:1008:6: warning: variable 'reserved' set but not used [-
Wunused-but-set-variable]
net/sched/sch_generic.c: In function 'dev_graft_qdisc':
net/sched/sch_generic.c:671:2: warning: the comparison will always evaluate=
 as=20
'true' for the address of 'noop_qdisc' will never be NULL [-Waddress]
net/ipv4/netfilter/ip_tables.c: In function 'compat_copy_entry_from_user':
net/ipv4/netfilter/ip_tables.c:1564:20: warning: variable 'target' set but =
not=20
used [-Wunused-but-set-variable]
net/unix/af_unix.c: In function 'unix_stream_sendmsg':
net/unix/af_unix.c:1564:22: warning: variable 'sunaddr' set but not used [-
Wunused-but-set-variable]
net/sched/sch_api.c: In function 'tc_classify':
net/sched/sch_api.c:1652:9: warning: variable 'protocol' set but not used [-
Wunused-but-set-variable]
drivers/pci/probe.c: In function '__pci_read_base':
drivers/pci/probe.c:207:4: warning: large integer implicitly truncated to=20
unsigned type [-Woverflow]
drivers/pci/setup-bus.c: In function 'pci_assign_unassigned_bridge_resource=
s':
drivers/pci/setup-bus.c:868:6: warning: variable 'retval' set but not used =
[-
Wunused-but-set-variable]
fs/eventpoll.c: In function 'ep_poll':
fs/eventpoll.c:1175:33: warning: 'slack' may be used uninitialized in this=
=20
function [-Wuninitialized]
fs/binfmt_elf.c: In function 'load_elf_binary':
fs/binfmt_elf.c:573:16: warning: variable 'reloc_func_desc' set but not use=
d=20
[-Wunused-but-set-variable]
In file included from fs/compat_binfmt_elf.c:133:0:
fs/binfmt_elf.c: In function 'load_elf_binary':
fs/binfmt_elf.c:573:16: warning: variable 'reloc_func_desc' set but not use=
d=20
[-Wunused-but-set-variable]
drivers/scsi/device_handler/scsi_dh.c: In function 'scsi_dh_sysfs_attr_add':
drivers/scsi/device_handler/scsi_dh.c:260:6: warning: variable 'err' set bu=
t=20
not used [-Wunused-but-set-variable]
drivers/usb/core/sysfs.c: In function 'usb_create_sysfs_intf_files':
drivers/usb/core/sysfs.c:849:6: warning: variable 'retval' set but not used=
 [-
Wunused-but-set-variable]
drivers/tty/serial/serial_core.c: In function 'uart_suspend_port':
drivers/tty/serial/serial_core.c:1979:21: warning: variable 'tty' set but n=
ot=20
used [-Wunused-but-set-variable]
drivers/scsi/sd.c: In function 'sd_probe_async':
drivers/scsi/sd.c:2356:17: warning: variable 'dev' set but not used [-Wunus=
ed-
but-set-variable]
drivers/tty/vt/vt_ioctl.c: In function 'vt_compat_ioctl':
drivers/tty/vt/vt_ioctl.c:1499:21: warning: variable 'kbd' set but not used=
 [-
Wunused-but-set-variable]
In file included from drivers/usb/host/ehci-hcd.c:336:0:
drivers/usb/host/ehci-hub.c: In function 'create_companion_file':
drivers/usb/host/ehci-hub.c:564:6: warning: variable 'i' set but not used [-
Wunused-but-set-variable]
In file included from drivers/usb/host/ehci-hcd.c:339:0:
drivers/usb/host/ehci-q.c: In function 'submit_async':
drivers/usb/host/ehci-q.c:1110:20: warning: variable 'qtd' set but not used=
 [-
Wunused-but-set-variable]
In file included from drivers/usb/host/ehci-hcd.c:340:0:
drivers/usb/host/ehci-sched.c: In function 'iso_stream_put':
drivers/usb/host/ehci-sched.c:1051:8: warning: variable 'is_in' set but not=
=20
used [-Wunused-but-set-variable]
drivers/usb/host/ehci-sched.c: In function 'itd_complete':
drivers/usb/host/ehci-sched.c:1749:23: warning: variable 'dev' set but not=
=20
used [-Wunused-but-set-variable]
drivers/usb/host/ehci-sched.c: In function 'sitd_complete':
drivers/usb/host/ehci-sched.c:2161:23: warning: variable 'dev' set but not=
=20
used [-Wunused-but-set-variable]
drivers/scsi/sg.c: In function 'sg_common_write':
drivers/scsi/sg.c:720:9: warning: variable 'data_dir' set but not used [-
Wunused-but-set-variable]
drivers/usb/mon/mon_bin.c: In function 'mon_bin_ioctl':
drivers/usb/mon/mon_bin.c:1095:16: warning: variable 'ndropped' set but not=
=20
used [-Wunused-but-set-variable]
drivers/video/aty/atyfb_base.c: In function 'aty_init':
drivers/video/aty/atyfb_base.c:2352:6: warning: variable 'dac_type' set but=
=20
not used [-Wunused-but-set-variable]
drivers/video/aty/atyfb_base.c: In function 'atyfb_setup_sparc':
drivers/video/aty/atyfb_base.c:3093:16: warning: variable 'h_total' set but=
=20
not used [-Wunused-but-set-variable]
drivers/video/aty/atyfb_base.c:3093:7: warning: variable 'v_total' set but =
not=20
used [-Wunused-but-set-variable]
drivers/video/aty/mach64_gx.c: In function 'aty_var_to_pll_8398':
drivers/video/aty/mach64_gx.c:620:36: warning: variable 'mach64RefFreq' set=
=20
but not used [-Wunused-but-set-variable]
drivers/tty/vt/vt.c: In function 'vc_do_resize':
drivers/tty/vt/vt.c:862:49: warning: variable 'old_screen_size' set but not=
=20
used [-Wunused-but-set-variable]
drivers/tty/vt/vt.c:862:15: warning: variable 'old_cols' set but not used [-
Wunused-but-set-variable]
drivers/video/console/fbcon.c: In function 'fb_flashcursor':
drivers/video/console/fbcon.c:373:18: warning: variable 'p' set but not use=
d=20
[-Wunused-but-set-variable]
drivers/video/console/fbcon.c: In function 'fbcon_exit':
drivers/video/console/fbcon.c:3513:7: warning: variable 'pending' set but n=
ot=20
used [-Wunused-but-set-variable]
drivers/video/aty/mach64_ct.c: In function 'aty_init_pll_ct':
drivers/video/aty/mach64_ct.c:406:46: warning: variable 'vga_dsp_on_off' se=
t=20
but not used [-Wunused-but-set-variable]
drivers/video/aty/mach64_ct.c:406:30: warning: variable 'vga_dsp_config' se=
t=20
but not used [-Wunused-but-set-variable]
drivers/video/aty/mach64_ct.c:406:18: warning: variable 'dsp_on_off' set bu=
t=20
not used [-Wunused-but-set-variable]
drivers/video/console/fbcon_cw.c: In function 'cw_update_attr':
drivers/video/console/fbcon_cw.c:30:8: warning: variable 't' set but not us=
ed=20
[-Wunused-but-set-variable]
WARNING: modpost: Found 14 section mismatch(es).
To see full details build your kernel with:
'make CONFIG_DEBUG_SECTION_MISMATCH=3Dy'
+ /usr/lib/rpm/debugedit -b /builddir/build/BUILD -d /usr/src/debug -i=20
=2Etmp_vmlinux1
+ /usr/lib/rpm/debugedit -b /builddir/build/BUILD -d /usr/src/debug -i=20
=2Etmp_vmlinux2
+ /usr/lib/rpm/debugedit -b /builddir/build/BUILD -d /usr/src/debug -i=20
=2Etmp_vmlinux3
/builddir/build/BUILD/kernel-2.6.37.fc15/linux-2.6.37.sparc64/usr/include/s=
csi/scsi_netlink.h:108:=20
found __[us]{8,16,32,64} type without #include <linux/types.h>
/builddir/build/BUILD/kernel-2.6.37.fc15/linux-2.6.37.sparc64/usr/include/d=
rm/drm_mode.h:85:=20
found __[us]{8,16,32,64} type without #include <linux/types.h>
/builddir/build/BUILD/kernel-2.6.37.fc15/linux-2.6.37.sparc64/usr/include/d=
rm/i915_drm.h:120:=20
found __[us]{8,16,32,64} type without #include <linux/types.h>
/builddir/build/BUILD/kernel-2.6.37.fc15/linux-2.6.37.sparc64/usr/include/d=
rm/mga_drm.h:260:=20
found __[us]{8,16,32,64} type without #include <linux/types.h>
/builddir/build/BUILD/kernel-2.6.37.fc15/linux-2.6.37.sparc64/usr/include/d=
rm/radeon_drm.h:758:=20
found __[us]{8,16,32,64} type without #include <linux/types.h>
/builddir/build/BUILD/kernel-2.6.37.fc15/linux-2.6.37.sparc64/usr/include/d=
rm/via_drm.h:117:=20
found __[us]{8,16,32,64} type without #include <linux/types.h>
/builddir/build/BUILD/kernel-2.6.37.fc15/linux-2.6.37.sparc64/usr/include/l=
inux/kernel.h:58:=20
userspace cannot reference function or variable defined in the kernel
/builddir/build/BUILD/kernel-2.6.37.fc15/linux-2.6.37.sparc64/usr/include/l=
inux/quota.h:175:=20
userspace cannot reference function or variable defined in the kernel
/builddir/build/BUILD/kernel-2.6.37.fc15/linux-2.6.37.sparc64/usr/include/l=
inux/sdla.h:116:=20
userspace cannot reference function or variable defined in the kernel
/builddir/build/BUILD/kernel-2.6.37.fc15/linux-2.6.37.sparc64/usr/include/l=
inux/soundcard.h:1054:=20
userspace cannot reference function or variable defined in the kernel
Documentation/accounting/getdelays.c: In function 'get_family_id':
Documentation/accounting/getdelays.c:172:14: warning: variable 'rc' set but=
=20
not used [-Wunused-but-set-variable]
Documentation/accounting/getdelays.c: In function 'main':
Documentation/accounting/getdelays.c:436:7: warning: variable 'i' set but n=
ot=20
used [-Wunused-but-set-variable]
Documentation/networking/ifenslave.c: In function 'if_getconfig':
Documentation/networking/ifenslave.c:508:14: warning: variable 'mtu' set bu=
t=20
not used [-Wunused-but-set-variable]
Documentation/networking/ifenslave.c:508:6: warning: variable 'metric' set =
but=20
not used [-Wunused-but-set-variable]
+ /usr/lib/rpm/debugedit -b /builddir/build/BUILD -d /usr/src/debug -i vmli=
nux
  kernel: arch/sparc/boot/image is ready
+ make -s ARCH=3Dsparc64 V=3D1 -j16 modules
security/keys/trusted.c: In function 'tpm_unseal':
security/keys/trusted.c:620:11: warning: variable 'keyhndl' set but not use=
d=20
[-Wunused-but-set-variable]
drivers/ata/acard-ahci.c: In function 'acard_ahci_qc_prep':
drivers/ata/acard-ahci.c:270:15: warning: variable 'n_elem' set but not use=
d=20
[-Wunused-but-set-variable]
drivers/ata/acard-ahci.c: In function 'acard_ahci_init_one':
drivers/ata/acard-ahci.c:420:2: warning: comparison between 'enum <anonymou=
s>'=20
and 'enum <anonymous>' [-Wenum-compare]
fs/affs/super.c: In function 'affs_fill_super':
fs/affs/super.c:287:9: warning: variable 'key' set but not used [-Wunused-b=
ut-
set-variable]
drivers/ata/sata_inic162x.c: In function 'inic_scr_read':
drivers/ata/sata_inic162x.c:276:16: warning: variable 'addr' set but not us=
ed=20
[-Wunused-but-set-variable]
fs/9p/vfs_inode.c: In function 'v9fs_vfs_lookup':
fs/9p/vfs_inode.c:658:22: warning: variable 'sb' set but not used [-Wunused-
but-set-variable]
fs/9p/vfs_inode.c: In function 'v9fs_vfs_getattr':
fs/9p/vfs_inode.c:826:6: warning: variable 'err' set but not used [-Wunused-
but-set-variable]
fs/affs/inode.c: In function 'affs_iget':
fs/affs/inode.c:23:20: warning: variable 'head' set but not used [-Wunused-=
but-
set-variable]
drivers/ata/sata_sil24.c: In function 'sil24_scr_read':
drivers/ata/sata_sil24.c:510:17: warning: variable 'addr' set but not used =
[-
Wunused-but-set-variable]
drivers/ata/sata_sil24.c: In function 'sil24_scr_write':
drivers/ata/sata_sil24.c:523:17: warning: variable 'addr' set but not used =
[-
Wunused-but-set-variable]
fs/9p/vfs_inode_dotl.c: In function 'v9fs_vfs_getattr_dotl':
fs/9p/vfs_inode_dotl.c:341:6: warning: variable 'err' set but not used [-
Wunused-but-set-variable]
fs/9p/vfs_inode_dotl.c: In function 'v9fs_vfs_setattr_dotl':
fs/9p/vfs_inode_dotl.c:383:28: warning: variable 'v9ses' set but not used [-
Wunused-but-set-variable]
fs/9p/vfs_inode_dotl.c: In function 'v9fs_vfs_link_dotl':
fs/9p/vfs_inode_dotl.c:592:8: warning: variable 'name' set but not used [-
Wunused-but-set-variable]
drivers/atm/eni.c: In function 'bug_int':
drivers/atm/eni.c:1472:18: warning: variable 'eni_dev' set but not used [-
Wunused-but-set-variable]
drivers/atm/eni.c: In function 'eni_open':
drivers/atm/eni.c:1903:18: warning: variable 'eni_dev' set but not used [-
Wunused-but-set-variable]
sound/core/pcm_native.c: In function 'snd_pcm_drop':
sound/core/pcm_native.c:1521:19: warning: variable 'card' set but not used =
[-
Wunused-but-set-variable]
sound/core/pcm_native.c: In function 'snd_pcm_open_file':
sound/core/pcm_native.c:2059:22: warning: variable 'str' set but not used [-
Wunused-but-set-variable]
fs/9p/vfs_file.c: In function 'v9fs_file_write':
fs/9p/vfs_file.c:430:20: warning: variable 'clnt' set but not used [-Wunuse=
d-
but-set-variable]
net/9p/client.c: In function 'p9_client_read':
net/9p/client.c:1255:18: warning: variable 'total' set but not used [-Wunus=
ed-
but-set-variable]
net/9p/client.c: In function 'p9_client_write':
net/9p/client.c:1310:18: warning: variable 'total' set but not used [-Wunus=
ed-
but-set-variable]
net/9p/client.c: In function 'p9_client_readdir':
net/9p/client.c:1700:18: warning: variable 'total' set but not used [-Wunus=
ed-
but-set-variable]
sound/drivers/opl3/opl3_midi.c: In function 'snd_opl3_key_press':
sound/drivers/opl3/opl3_midi.c:720:21: warning: variable 'opl3' set but not=
=20
used [-Wunused-but-set-variable]
sound/drivers/opl3/opl3_midi.c: In function 'snd_opl3_terminate_note':
sound/drivers/opl3/opl3_midi.c:734:21: warning: variable 'opl3' set but not=
=20
used [-Wunused-but-set-variable]
sound/drivers/opl3/opl3_midi.c: In function 'snd_opl3_nrpn':
sound/drivers/opl3/opl3_midi.c:860:21: warning: variable 'opl3' set but not=
=20
used [-Wunused-but-set-variable]
sound/drivers/opl3/opl3_midi.c: In function 'snd_opl3_sysex':
sound/drivers/opl3/opl3_midi.c:875:21: warning: variable 'opl3' set but not=
=20
used [-Wunused-but-set-variable]
drivers/atm/solos-pci.c: In function 'flash_upgrade':
drivers/atm/solos-pci.c:532:11: warning: variable 'data32' set but not used=
 [-
Wunused-but-set-variable]
fs/9p/cache.c: In function 'v9fs_cache_inode_set_cookie':
fs/9p/cache.c:300:17: warning: variable 'fid' set but not used [-Wunused-bu=
t-
set-variable]
fs/9p/cache.c: In function 'v9fs_cache_inode_reset_cookie':
fs/9p/cache.c:319:25: warning: variable 'old' set but not used [-Wunused-bu=
t-
set-variable]
sound/drivers/opl3/opl3_oss.c: In function 'snd_opl3_ioctl_seq_oss':
sound/drivers/opl3/opl3_oss.c:249:19: warning: variable 'opl3' set but not=
=20
used [-Wunused-but-set-variable]
sound/drivers/opl3/opl3_oss.c: In function 'snd_opl3_reset_seq_oss':
sound/drivers/opl3/opl3_oss.c:277:19: warning: variable 'opl3' set but not=
=20
used [-Wunused-but-set-variable]
net/9p/trans_fd.c: In function 'parse_opts':
net/9p/trans_fd.c:719:6: warning: variable 'ret' set but not used [-Wunused-
but-set-variable]
net/9p/trans_rdma.c: In function 'parse_opts':
net/9p/trans_rdma.c:171:6: warning: variable 'ret' set but not used [-Wunus=
ed-
but-set-variable]
drivers/atm/he.c: In function 'he_service_rbrq':
drivers/atm/he.c:1802:21: warning: operation on 'he_dev->rbrq_head' may be=
=20
undefined [-Wsequence-point]
drivers/atm/he.c: In function 'he_service_tbrq':
drivers/atm/he.c:1885:21: warning: operation on 'he_dev->tbrq_head' may be=
=20
undefined [-Wsequence-point]
sound/core/init.c: In function 'snd_card_disconnect':
sound/core/init.c:345:15: warning: variable 'file' set but not used [-Wunus=
ed-
but-set-variable]
fs/cachefiles/namei.c: In function 'cachefiles_walk_to_object':
fs/cachefiles/namei.c:451:16: warning: variable 'start' set but not used [-
Wunused-but-set-variable]
fs/cachefiles/namei.c: In function 'cachefiles_get_directory':
fs/cachefiles/namei.c:694:16: warning: variable 'start' set but not used [-
Wunused-but-set-variable]
fs/cachefiles/namei.c: In function 'cachefiles_check_active':
fs/cachefiles/namei.c:796:16: warning: variable 'start' set but not used [-
Wunused-but-set-variable]
fs/cachefiles/rdwr.c: In function 'cachefiles_uncache_page':
fs/cachefiles/rdwr.c:975:27: warning: variable 'cache' set but not used [-
Wunused-but-set-variable]
sound/core/control.c: In function 'snd_ctl_elem_list':
sound/core/control.c:599:30: warning: variable 'first' set but not used [-
Wunused-but-set-variable]
net/atm/lec.c: In function 'lec_handle_bridge':
net/atm/lec.c:132:17: warning: variable 'eth' set but not used [-Wunused-bu=
t-
set-variable]
net/atm/lec.c: In function 'lane_module_cleanup':
net/atm/lec.c:1183:19: warning: variable 'priv' set but not used [-Wunused-
but-set-variable]
fs/btrfs/root-tree.c: In function 'btrfs_del_root':
fs/btrfs/root-tree.c:331:26: warning: variable 'ri' set but not used [-
Wunused-but-set-variable]
sound/core/vmaster.c: In function 'slave_update':
sound/core/vmaster.c:60:6: warning: variable 'err' set but not used [-Wunus=
ed-
but-set-variable]
fs/ceph/caps.c: In function '__send_cap':
fs/ceph/caps.c:1076:22: warning: variable 'dropping' set but not used [-
Wunused-but-set-variable]
fs/ceph/caps.c: In function 'handle_cap_grant':
fs/ceph/caps.c:2317:6: warning: variable 'revoked_rdcache' set but not used=
 [-
Wunused-but-set-variable]
fs/ceph/caps.c: In function 'ceph_handle_caps':
fs/ceph/caps.c:2755:6: warning: variable 'flock_len' set but not used [-
Wunused-but-set-variable]
fs/ceph/caps.c:2754:8: warning: variable 'flock' set but not used [-Wunused-
but-set-variable]
fs/ceph/caps.c:2750:12: warning: variable 'max_size' set but not used [-
Wunused-but-set-variable]
fs/ceph/caps.c:2750:6: warning: variable 'size' set but not used [-Wunused-
but-set-variable]
drivers/ata/pata_rdc.c: In function 'rdc_init_one':
drivers/ata/pata_rdc.c:319:16: warning: variable 'port_flags' set but not u=
sed=20
[-Wunused-but-set-variable]
net/ax25/ax25_iface.c: In function 'ax25_protocol_release':
net/ax25/ax25_iface.c:61:24: warning: variable 's' set but not used [-Wunus=
ed-
but-set-variable]
sound/core/oss/linear.c: In function 'linear_transfer':
sound/core/oss/linear.c:93:22: warning: variable 'data' set but not used [-
Wunused-but-set-variable]
sound/core/seq/seq_queue.c: In function 'snd_seq_queue_timer_close':
sound/core/seq/seq_queue.c:470:24: warning: variable 'tmr' set but not used=
 [-
Wunused-but-set-variable]
fs/ceph/xattr.c: In function '__remove_xattr_by_name':
fs/ceph/xattr.c:284:19: warning: variable 'p' set but not used [-Wunused-bu=
t-
set-variable]
fs/ceph/mds_client.c: In function 'handle_lease':
fs/ceph/mds_client.c:2694:26: warning: variable 'ci' set but not used [-
Wunused-but-set-variable]
In file included from drivers/block/cciss.c:351:0:
drivers/block/cciss_scsi.c: In function 'cciss_unregister_scsi':
drivers/block/cciss_scsi.c:1512:33: warning: variable 'stk' set but not use=
d=20
[-Wunused-but-set-variable]
drivers/block/cciss_scsi.c: In function 'cciss_engage_scsi':
drivers/block/cciss_scsi.c:1540:33: warning: variable 'stk' set but not use=
d=20
[-Wunused-but-set-variable]
drivers/block/cciss.c: In function 'cciss_procinit':
drivers/block/cciss.c:542:25: warning: variable 'pde' set but not used [-
Wunused-but-set-variable]
drivers/block/cciss.c: In function 'cciss_enter_performant_mode':
drivers/block/cciss.c:3781:8: warning: variable 'trans_offset' set but not =
used=20
[-Wunused-but-set-variable]
drivers/block/DAC960.c: In function 'DAC960_V2_ProcessCompletedCommand':
drivers/block/DAC960.c:5094:30: warning: comparison between=20
'DAC960_V2_IOCTL_Opcode_T' and 'enum <anonymous>' [-Wenum-compare]
drivers/block/DAC960.c: In function 'DAC960_CreateProcEntries':
drivers/block/DAC960.c:6582:25: warning: variable 'UserCommandProcEntry' se=
t=20
but not used [-Wunused-but-set-variable]
drivers/block/DAC960.c:6580:25: warning: variable 'StatusProcEntry' set but=
=20
not used [-Wunused-but-set-variable]
drivers/block/DAC960.c: In function 'DAC960_V1_EnableMemoryMailboxInterface=
':
/builddir/build/BUILD/kernel-2.6.37.fc15/linux-2.6.37.sparc64/arch/sparc/in=
clude/asm/io_64.h:176:2:=20
warning: 'CommandMailbox.Bytes[12]' may be used uninitialized in this funct=
ion=20
[-Wuninitialized]
drivers/block/DAC960.c:1174:30: note: 'CommandMailbox.Bytes[12]' was declar=
ed=20
here
net/core/pktgen.c: In function 'pktgen_output_ipsec':
net/core/pktgen.c:2512:16: warning: variable 'iph' set but not used [-Wunus=
ed-
but-set-variable]
fs/ceph/mdsmap.c: In function 'ceph_mdsmap_decode':
fs/ceph/mdsmap.c:83:7: warning: variable 'state_seq' set but not used [-
Wunused-but-set-variable]
fs/ceph/mdsmap.c:55:6: warning: variable 'version' set but not used [-Wunus=
ed-
but-set-variable]
fs/ceph/mdsmap.c:54:6: warning: variable 'err' set but not used [-Wunused-b=
ut-
set-variable]
fs/btrfs/inode.c: In function 'check_path_shared':
fs/btrfs/inode.c:2727:7: warning: variable 'ret' set but not used [-Wunused-
but-set-variable]
net/ceph/mon_client.c: In function 'ceph_monmap_decode':
net/ceph/mon_client.c:46:6: warning: variable 'version' set but not used [-
Wunused-but-set-variable]
net/ceph/osd_client.c: In function 'ceph_osdc_handle_map':
net/ceph/osd_client.c:1227:6: warning: variable 'err' set but not used [-
Wunused-but-set-variable]
fs/coda/file.c: In function 'coda_release':
fs/coda/file.c:173:6: warning: variable 'err' set but not used [-Wunused-bu=
t-
set-variable]
fs/coda/upcall.c: In function 'venus_setattr':
fs/coda/upcall.c:115:27: warning: variable 'outp' set but not used [-Wunuse=
d-
but-set-variable]
fs/coda/upcall.c: In function 'venus_close':
fs/coda/upcall.c:164:20: warning: variable 'outp' set but not used [-Wunuse=
d-
but-set-variable]
fs/coda/upcall.c: In function 'venus_rename':
fs/coda/upcall.c:238:27: warning: variable 'outp' set but not used [-Wunuse=
d-
but-set-variable]
fs/coda/upcall.c: In function 'venus_rmdir':
fs/coda/upcall.c:306:27: warning: variable 'outp' set but not used [-Wunuse=
d-
but-set-variable]
fs/coda/upcall.c: In function 'venus_remove':
fs/coda/upcall.c:329:27: warning: variable 'outp' set but not used [-Wunuse=
d-
but-set-variable]
fs/coda/upcall.c: In function 'venus_link':
fs/coda/upcall.c:383:27: warning: variable 'outp' set but not used [-Wunuse=
d-
but-set-variable]
fs/coda/upcall.c: In function 'venus_symlink':
fs/coda/upcall.c:410:27: warning: variable 'outp' set but not used [-Wunuse=
d-
but-set-variable]
fs/coda/upcall.c: In function 'venus_fsync':
fs/coda/upcall.c:443:27: warning: variable 'outp' set but not used [-Wunuse=
d-
but-set-variable]
fs/coda/upcall.c: In function 'venus_access':
fs/coda/upcall.c:460:27: warning: variable 'outp' set but not used [-Wunuse=
d-
but-set-variable]
net/ceph/osdmap.c: In function 'ceph_calc_object_layout':
net/ceph/osdmap.c:997:16: warning: variable 'num_mask' set but not used [-
Wunused-but-set-variable]
net/ceph/osdmap.c:997:11: warning: variable 'num' set but not used [-Wunuse=
d-
but-set-variable]
net/bluetooth/sco.c: In function 'sco_sock_getsockopt':
net/bluetooth/sco.c:727:6: warning: variable 'len' set but not used [-Wunus=
ed-
but-set-variable]
drivers/block/cryptoloop.c: In function 'cryptoloop_init':
drivers/block/cryptoloop.c:46:8: warning: variable 'cipher' set but not use=
d=20
[-Wunused-but-set-variable]
sound/pci/ens1370.c: In function 'snd_audiopci_probe':
sound/pci/ens1370.c:2404:11: warning: variable 'pcm_devs' set but not used =
[-
Wunused-but-set-variable]
net/ceph/auth_x.c: In function 'ceph_x_proc_ticket_reply':
net/ceph/auth_x.c:161:20: warning: variable 'blob_struct_v' set but not use=
d=20
[-Wunused-but-set-variable]
In file included from sound/pci/ens1371.c:2:0:
sound/pci/ens1370.c: In function 'snd_es1371_adc_rate':
sound/pci/ens1370.c:718:32: warning: variable 'result' set but not used [-
Wunused-but-set-variable]
sound/pci/ens1370.c: In function 'snd_audiopci_probe':
sound/pci/ens1370.c:2404:11: warning: variable 'pcm_devs' set but not used =
[-
Wunused-but-set-variable]
drivers/block/drbd/drbd_receiver.c: In function 'drbd_asb_recover_1p':
drivers/block/drbd/drbd_receiver.c:2172:12: warning: variable 'peer' set bu=
t=20
not used [-Wunused-but-set-variable]
drivers/block/drbd/drbd_receiver.c: In function 'drbd_asb_recover_2p':
drivers/block/drbd/drbd_receiver.c:2222:12: warning: variable 'peer' set bu=
t=20
not used [-Wunused-but-set-variable]
drivers/block/drbd/drbd_receiver.c: In function 'drbd_disconnect':
drivers/block/drbd/drbd_receiver.c:3705:6: warning: variable 'rv' set but n=
ot=20
used [-Wunused-but-set-variable]
net/dccp/ipv6.c: In function 'dccp_v6_request_recv_sock':
net/dccp/ipv6.c:487:20: warning: variable 'newdp' set but not used [-Wunuse=
d-
but-set-variable]
fs/btrfs/extent_io.c: In function 'extent_fiemap':
fs/btrfs/extent_io.c:2929:33: warning: variable 'item' set but not used [-
Wunused-but-set-variable]
net/dccp/probe.c: In function 'dccpprobe_init':
net/dccp/probe.c:166:2: warning: the omitted middle operand in ?: will alwa=
ys=20
be 'true', suggest explicit middle operand [-Wparentheses]
sound/pci/es1938.c: In function 'snd_es1938_interrupt':
sound/pci/es1938.c:1671:24: warning: variable 'audiostatus' set but not use=
d=20
[-Wunused-but-set-variable]
net/bluetooth/cmtp/capi.c: In function 'cmtp_recv_capimsg':
net/bluetooth/cmtp/capi.c:327:8: warning: variable 'cmd' set but not used [-
Wunused-but-set-variable]
sound/pci/sonicvibes.c: In function 'snd_sonicvibes_midi':
sound/pci/sonicvibes.c:1430:26: warning: variable 'dir' set but not used [-
Wunused-but-set-variable]
sound/pci/via82xx_modem.c: In function 'snd_via82xx_codec_wait':
sound/pci/via82xx_modem.c:410:6: warning: variable 'err' set but not used [-
Wunused-but-set-variable]
fs/btrfs/lzo.c: In function 'lzo_decompress':
fs/btrfs/lzo.c:379:9: warning: variable 'tot_len' set but not used [-Wunuse=
d-
but-set-variable]
sound/pci/via82xx.c: In function 'snd_via82xx_codec_wait':
sound/pci/via82xx.c:556:6: warning: variable 'err' set but not used [-Wunus=
ed-
but-set-variable]
drivers/block/drbd/drbd_actlog.c: In function '_al_get':
drivers/block/drbd/drbd_actlog.c:178:20: warning: variable 'al_flags' set b=
ut=20
not used [-Wunused-but-set-variable]
drivers/block/drbd/drbd_actlog.c: In function 'drbd_al_read_log':
drivers/block/drbd/drbd_actlog.c:460:16: warning: variable 'trn' set but no=
t=20
used [-Wunused-but-set-variable]
drivers/block/drbd/drbd_actlog.c: In function '__drbd_set_out_of_sync':
drivers/block/drbd/drbd_actlog.c:1011:28: warning: variable 'lbnr' set but =
not=20
used [-Wunused-but-set-variable]
drivers/block/drbd/drbd_main.c: In function 'after_state_ch':
drivers/block/drbd/drbd_main.c:1241:22: warning: variable 'fp' set but not=
=20
used [-Wunused-but-set-variable]
drivers/block/drbd/drbd_main.c: In function 'drbd_buildtag':
drivers/block/drbd/drbd_main.c:3987:19: warning: the comparison will always=
=20
evaluate as 'true' for the address of '__this_module' will never be NULL [-
Waddress]
drivers/bluetooth/btmrvl_debugfs.c: In function 'btmrvl_hscfgcmd_write':
drivers/bluetooth/btmrvl_debugfs.c:59:15: warning: variable 'ret' set but n=
ot=20
used [-Wunused-but-set-variable]
drivers/bluetooth/btmrvl_debugfs.c: In function 'btmrvl_psmode_write':
drivers/bluetooth/btmrvl_debugfs.c:103:15: warning: variable 'ret' set but =
not=20
used [-Wunused-but-set-variable]
drivers/bluetooth/btmrvl_debugfs.c: In function 'btmrvl_pscmd_write':
drivers/bluetooth/btmrvl_debugfs.c:142:15: warning: variable 'ret' set but =
not=20
used [-Wunused-but-set-variable]
drivers/bluetooth/btmrvl_debugfs.c: In function 'btmrvl_gpiogap_write':
drivers/bluetooth/btmrvl_debugfs.c:186:15: warning: variable 'ret' set but =
not=20
used [-Wunused-but-set-variable]
drivers/bluetooth/btmrvl_debugfs.c: In function 'btmrvl_hscmd_write':
drivers/bluetooth/btmrvl_debugfs.c:225:15: warning: variable 'ret' set but =
not=20
used [-Wunused-but-set-variable]
drivers/bluetooth/btmrvl_debugfs.c: In function 'btmrvl_hsmode_write':
drivers/bluetooth/btmrvl_debugfs.c:267:15: warning: variable 'ret' set but =
not=20
used [-Wunused-but-set-variable]
sound/pci/ali5451/ali5451.c: In function 'snd_ali_update_ptr':
sound/pci/ali5451/ali5451.c:858:26: warning: variable 'runtime' set but not=
=20
used [-Wunused-but-set-variable]
sound/pci/ali5451/ali5451.c: In function 'snd_ali_pcm_free_substream':
sound/pci/ali5451/ali5451.c:1499:18: warning: variable 'codec' set but not=
=20
used [-Wunused-but-set-variable]
sound/pci/cs46xx/dsp_spos_scb_lib.c: In function=20
'cs46xx_dsp_proc_scb_info_read':
sound/pci/cs46xx/dsp_spos_scb_lib.c:76:29: warning: variable 'ins' set but =
not=20
used [-Wunused-but-set-variable]
net/decnet/dn_table.c: In function 'dn_rebuild_zone':
net/decnet/dn_table.c:128:32: warning: variable 'next' set but not used [-
Wunused-but-set-variable]
net/irda/iriap.c: In function 'iriap_getvaluebyclass_confirm':
net/irda/iriap.c:441:8: warning: variable 'len' set but not used [-Wunused-
but-set-variable]
drivers/block/drbd/drbd_nl.c: In function 'drbd_nl_disk_conf':
drivers/block/drbd/drbd_nl.c:1010:14: warning: comparison between 'enum=20
drbd_ret_codes' and 'enum drbd_state_ret_codes' [-Wenum-compare]
sound/pci/cs5535audio/cs5535audio_pcm.c: In function=20
'cs5535audio_build_dma_packets':
sound/pci/cs5535audio/cs5535audio_pcm.c:152:3: warning: large integer=20
implicitly truncated to unsigned type [-Woverflow]
sound/pci/cs5535audio/cs5535audio_pcm.c:160:2: warning: large integer=20
implicitly truncated to unsigned type [-Woverflow]
sound/pci/cs5535audio/cs5535audio.c: In function 'process_bm0_irq':
sound/pci/cs5535audio/cs5535audio.c:193:27: warning: variable 'dma' set but=
=20
not used [-Wunused-but-set-variable]
sound/pci/cs5535audio/cs5535audio.c: In function 'process_bm1_irq':
sound/pci/cs5535audio/cs5535audio.c:209:27: warning: variable 'dma' set but=
=20
not used [-Wunused-but-set-variable]
net/ipv6/ip6_output.c: In function 'ip6_nd_hdr':
net/ipv6/ip6_output.c:277:6: warning: variable 'totlen' set but not used [-
Wunused-but-set-variable]
net/irda/irlap_event.c: In function 'irlap_state_sclose':
net/irda/irlap_event.c:2230:6: warning: variable 'ret' set but not used [-
Wunused-but-set-variable]
sound/pci/ctxfi/ctatc.c: In function 'atc_release_resources':
sound/pci/ctxfi/ctatc.c:1105:14: warning: variable 'dai' set but not used [-
Wunused-but-set-variable]
fs/ecryptfs/file.c: In function 'ecryptfs_open':
fs/ecryptfs/file.c:161:17: warning: variable 'lower_dentry' set but not use=
d [-
Wunused-but-set-variable]
drivers/char/rocket.c: In function 'rp_throttle':
drivers/char/rocket.c:1383:13: warning: variable 'cp' set but not used [-
Wunused-but-set-variable]
drivers/char/rocket.c: In function 'rp_unthrottle':
drivers/char/rocket.c:1403:13: warning: variable 'cp' set but not used [-
Wunused-but-set-variable]
drivers/char/rocket.c: In function 'rp_chars_in_buffer':
drivers/char/rocket.c:1725:13: warning: variable 'cp' set but not used [-
Wunused-but-set-variable]
drivers/char/rocket.c: In function 'register_PCI':
drivers/char/rocket.c:1782:14: warning: variable 'board_type' set but not u=
sed=20
[-Wunused-but-set-variable]
drivers/char/rocket.c:1782:8: warning: variable 'str' set but not used [-
Wunused-but-set-variable]
drivers/char/cyclades.c: In function 'cy_shutdown':
drivers/char/cyclades.c:1448:6: warning: variable 'channel' set but not use=
d=20
[-Wunused-but-set-variable]
net/ipv6/addrconf.c: In function 'ipv6_del_addr':
net/ipv6/addrconf.c:721:6: warning: variable 'hash' set but not used [-
Wunused-but-set-variable]
net/ipv6/route.c: In function 'icmp6_dst_gc':
net/ipv6/route.c:1031:26: warning: variable 'next' set but not used [-Wunus=
ed-
but-set-variable]
net/l2tp/l2tp_netlink.c: In function 'l2tp_nl_register_ops':
net/l2tp/l2tp_netlink.c:786:6: warning: variable 'ret' set but not used [-
Wunused-but-set-variable]
fs/dlm/lowcomms.c: In function 'dlm_lowcomms_get_buffer':
fs/dlm/lowcomms.c:1257:6: warning: variable 'users' set but not used [-
Wunused-but-set-variable]
In file included from sound/pci/echoaudio/darla20.c:101:0:
sound/pci/echoaudio/echoaudio.c: In function 'snd_echo_vumeters_info':
sound/pci/echoaudio/echoaudio.c:1754:20: warning: variable 'chip' set but n=
ot=20
used [-Wunused-but-set-variable]
sound/pci/echoaudio/echoaudio.c: In function 'snd_echo_channels_info_info':
sound/pci/echoaudio/echoaudio.c:1798:20: warning: variable 'chip' set but n=
ot=20
used [-Wunused-but-set-variable]
sound/pci/echoaudio/echoaudio.c: In function 'snd_echo_probe':
sound/pci/echoaudio/echoaudio.c:2048:6: warning: variable 'i' set but not u=
sed=20
[-Wunused-but-set-variable]
net/irda/irproc.c: In function 'irda_proc_register':
net/irda/irproc.c:68:25: warning: variable 'd' set but not used [-Wunused-b=
ut-
set-variable]
drivers/char/synclinkmp.c: In function 'init_adapter':
drivers/char/synclinkmp.c:5188:6: warning: variable 'readval' set but not u=
sed=20
[-Wunused-but-set-variable]
In file included from sound/pci/echoaudio/darla24.c:108:0:
sound/pci/echoaudio/echoaudio.c: In function 'snd_echo_vumeters_info':
sound/pci/echoaudio/echoaudio.c:1754:20: warning: variable 'chip' set but n=
ot=20
used [-Wunused-but-set-variable]
sound/pci/echoaudio/echoaudio.c: In function 'snd_echo_channels_info_info':
sound/pci/echoaudio/echoaudio.c:1798:20: warning: variable 'chip' set but n=
ot=20
used [-Wunused-but-set-variable]
In file included from sound/pci/echoaudio/gina20.c:105:0:
sound/pci/echoaudio/echoaudio.c: In function 'snd_echo_vumeters_info':
sound/pci/echoaudio/echoaudio.c:1754:20: warning: variable 'chip' set but n=
ot=20
used [-Wunused-but-set-variable]
sound/pci/echoaudio/echoaudio.c: In function 'snd_echo_channels_info_info':
sound/pci/echoaudio/echoaudio.c:1798:20: warning: variable 'chip' set but n=
ot=20
used [-Wunused-but-set-variable]
In file included from sound/pci/echoaudio/echo3g.c:121:0:
sound/pci/echoaudio/echoaudio.c: In function 'snd_echo_vumeters_info':
sound/pci/echoaudio/echoaudio.c:1754:20: warning: variable 'chip' set but n=
ot=20
used [-Wunused-but-set-variable]
sound/pci/echoaudio/echoaudio.c: In function 'snd_echo_channels_info_info':
sound/pci/echoaudio/echoaudio.c:1798:20: warning: variable 'chip' set but n=
ot=20
used [-Wunused-but-set-variable]
net/ipv6/mcast.c: In function 'ip6_mc_source':
net/ipv6/mcast.c:322:21: warning: variable 'dev' set but not used [-Wunused-
but-set-variable]
net/ipv6/mcast.c: In function 'ip6_mc_msfilter':
net/ipv6/mcast.c:458:21: warning: variable 'dev' set but not used [-Wunused-
but-set-variable]
net/ipv6/mcast.c: In function 'ip6_mc_msfget':
net/ipv6/mcast.c:552:21: warning: variable 'dev' set but not used [-Wunused-
but-set-variable]
net/irda/irlan/irlan_provider.c: In function=20
'irlan_provider_connect_indication':
net/irda/irlan/irlan_provider.c:131:15: warning: variable 'daddr' set but n=
ot=20
used [-Wunused-but-set-variable]
net/irda/irlan/irlan_provider.c:131:8: warning: variable 'saddr' set but no=
t=20
used [-Wunused-but-set-variable]
net/irda/irlan/irlan_filter.c: In function 'irlan_check_command_param':
net/irda/irlan/irlan_filter.c:146:8: warning: variable 'bytes' set but not =
used=20
[-Wunused-but-set-variable]
net/irda/ircomm/ircomm_core.c: In function 'ircomm_connect_indication':
net/irda/ircomm/ircomm_core.c:247:6: warning: variable 'clen' set but not u=
sed=20
[-Wunused-but-set-variable]
net/irda/ircomm/ircomm_lmp.c: In function 'ircomm_lmp_connect_response':
net/irda/ircomm/ircomm_lmp.c:78:6: warning: variable 'ret' set but not used=
 [-
Wunused-but-set-variable]
In file included from sound/pci/echoaudio/gina24.c:129:0:
sound/pci/echoaudio/echoaudio.c: In function 'snd_echo_vumeters_info':
sound/pci/echoaudio/echoaudio.c:1754:20: warning: variable 'chip' set but n=
ot=20
used [-Wunused-but-set-variable]
sound/pci/echoaudio/echoaudio.c: In function 'snd_echo_channels_info_info':
sound/pci/echoaudio/echoaudio.c:1798:20: warning: variable 'chip' set but n=
ot=20
used [-Wunused-but-set-variable]
sound/synth/emux/emux_oss.c: In function 'gusspec_control':
sound/synth/emux/emux_oss.c:442:8: warning: variable 'p2' set but not used =
[-
Wunused-but-set-variable]
sound/usb/mixer.c: In function 'parse_audio_feature_unit':
sound/usb/mixer.c:1155:28: warning: variable 'first_ch_bits' set but not us=
ed=20
[-Wunused-but-set-variable]
sound/usb/quirks.c: In function 'snd_usb_apply_boot_quirk':
sound/usb/quirks.c:389:6: warning: 'err' may be used uninitialized in this=
=20
function [-Wuninitialized]
net/ipv4/netfilter/nf_nat_standalone.c: In function 'nf_nat_fn':
net/ipv4/netfilter/nf_nat_standalone.c:118:2: warning: case value '4' not i=
n=20
enumerated type 'enum ip_conntrack_info' [-Wswitch]
net/ipv4/netfilter/nf_nat_standalone.c: In function 'nf_nat_standalone_init=
':
net/ipv4/netfilter/nf_nat_standalone.c:286:2: warning: the comparison will=
=20
always evaluate as 'true' for the address of 'nat_decode_session' will neve=
r=20
be NULL [-Waddress]
net/ipv4/netfilter/nf_nat_core.c: In function 'nf_nat_protocol_unregister':
net/ipv4/netfilter/nf_nat_core.c:520:2: warning: the comparison will always=
=20
evaluate as 'true' for the address of 'nf_nat_unknown_protocol' will never =
be=20
NULL [-Waddress]
net/ipv4/netfilter/nf_nat_core.c: In function 'nf_nat_init':
net/ipv4/netfilter/nf_nat_core.c:734:3: warning: the comparison will always=
=20
evaluate as 'true' for the address of 'nf_nat_unknown_protocol' will never =
be=20
NULL [-Waddress]
net/ipv4/netfilter/nf_nat_core.c:735:2: warning: the comparison will always=
=20
evaluate as 'true' for the address of 'nf_nat_protocol_tcp' will never be N=
ULL=20
[-Waddress]
net/ipv4/netfilter/nf_nat_core.c:736:2: warning: the comparison will always=
=20
evaluate as 'true' for the address of 'nf_nat_protocol_udp' will never be N=
ULL=20
[-Waddress]
net/ipv4/netfilter/nf_nat_core.c:737:2: warning: the comparison will always=
=20
evaluate as 'true' for the address of 'nf_nat_protocol_icmp' will never be=
=20
NULL [-Waddress]
net/ipv4/netfilter/nf_nat_core.c:746:2: warning: the comparison will always=
=20
evaluate as 'true' for the address of 'nf_nat_seq_adjust' will never be NUL=
L=20
[-Waddress]
net/ipv4/netfilter/nf_nat_core.c:748:2: warning: the comparison will always=
=20
evaluate as 'true' for the address of 'nfnetlink_parse_nat_setup' will neve=
r=20
be NULL [-Waddress]
net/ipv4/netfilter/nf_nat_core.c:751:2: warning: the comparison will always=
=20
evaluate as 'true' for the address of 'nf_nat_get_offset' will never be NUL=
L [-
Waddress]
net/ipv6/ip6mr.c: In function 'ip6mr_cache_resolve':
net/ipv6/ip6mr.c:1042:8: warning: variable 'err' set but not used [-Wunused-
but-set-variable]
sound/usb/pcm.c: In function 'init_pitch_v2':
sound/usb/pcm.c:143:15: warning: variable 'ep' set but not used [-Wunused-b=
ut-
set-variable]
In file included from sound/pci/echoaudio/indigodj.c:106:0:
sound/pci/echoaudio/echoaudio.c: In function 'snd_echo_vumeters_info':
sound/pci/echoaudio/echoaudio.c:1754:20: warning: variable 'chip' set but n=
ot=20
used [-Wunused-but-set-variable]
sound/pci/echoaudio/echoaudio.c: In function 'snd_echo_channels_info_info':
sound/pci/echoaudio/echoaudio.c:1798:20: warning: variable 'chip' set but n=
ot=20
used [-Wunused-but-set-variable]
sound/pci/echoaudio/echoaudio.c: In function 'snd_echo_probe':
sound/pci/echoaudio/echoaudio.c:2048:6: warning: variable 'i' set but not u=
sed=20
[-Wunused-but-set-variable]
In file included from sound/pci/echoaudio/indigo.c:106:0:
sound/pci/echoaudio/echoaudio.c: In function 'snd_echo_vumeters_info':
sound/pci/echoaudio/echoaudio.c:1754:20: warning: variable 'chip' set but n=
ot=20
used [-Wunused-but-set-variable]
sound/pci/echoaudio/echoaudio.c: In function 'snd_echo_channels_info_info':
sound/pci/echoaudio/echoaudio.c:1798:20: warning: variable 'chip' set but n=
ot=20
used [-Wunused-but-set-variable]
sound/pci/echoaudio/echoaudio.c: In function 'snd_echo_probe':
sound/pci/echoaudio/echoaudio.c:2048:6: warning: variable 'i' set but not u=
sed=20
[-Wunused-but-set-variable]
net/ipv4/netfilter/nf_nat_amanda.c: In function 'nf_nat_amanda_init':
net/ipv4/netfilter/nf_nat_amanda.c:80:2: warning: the comparison will alway=
s=20
evaluate as 'true' for the address of 'help' will never be NULL [-Waddress]
net/ipv4/netfilter/nf_nat_ftp.c: In function 'nf_nat_ftp_init':
net/ipv4/netfilter/nf_nat_ftp.c:123:2: warning: the comparison will always=
=20
evaluate as 'true' for the address of 'nf_nat_ftp' will never be NULL [-
Waddress]
sound/usb/misc/ua101.c: In function 'ua101_card_free':
sound/usb/misc/ua101.c:1172:16: warning: unused variable 'ua' [-Wunused-
variable]
drivers/char/pcmcia/cm4000_cs.c: In function 'cmm_write':
drivers/char/pcmcia/cm4000_cs.c:1051:16: warning: variable 'tmp' set but no=
t=20
used [-Wunused-but-set-variable]
drivers/char/pcmcia/cm4000_cs.c: In function 'cm4000_config':
drivers/char/pcmcia/cm4000_cs.c:1751:21: warning: variable 'dev' set but no=
t=20
used [-Wunused-but-set-variable]
drivers/char/pcmcia/cm4040_cs.c: In function 'cm4040_read':
drivers/char/pcmcia/cm4040_cs.c:224:16: warning: variable 'uc' set but not=
=20
used [-Wunused-but-set-variable]
net/ipv4/netfilter/nf_nat_h323.c: In function 'init':
net/ipv4/netfilter/nf_nat_h323.c:584:2: warning: the comparison will always=
=20
evaluate as 'true' for the address of 'set_h245_addr' will never be NULL [-
Waddress]
net/ipv4/netfilter/nf_nat_h323.c:585:2: warning: the comparison will always=
=20
evaluate as 'true' for the address of 'set_h225_addr' will never be NULL [-
Waddress]
net/ipv4/netfilter/nf_nat_h323.c:586:2: warning: the comparison will always=
=20
evaluate as 'true' for the address of 'set_sig_addr' will never be NULL [-
Waddress]
net/ipv4/netfilter/nf_nat_h323.c:587:2: warning: the comparison will always=
=20
evaluate as 'true' for the address of 'set_ras_addr' will never be NULL [-
Waddress]
net/ipv4/netfilter/nf_nat_h323.c:588:2: warning: the comparison will always=
=20
evaluate as 'true' for the address of 'nat_rtp_rtcp' will never be NULL [-
Waddress]
net/ipv4/netfilter/nf_nat_h323.c:589:2: warning: the comparison will always=
=20
evaluate as 'true' for the address of 'nat_t120' will never be NULL [-
Waddress]
net/ipv4/netfilter/nf_nat_h323.c:590:2: warning: the comparison will always=
=20
evaluate as 'true' for the address of 'nat_h245' will never be NULL [-
Waddress]
net/ipv4/netfilter/nf_nat_h323.c:591:2: warning: the comparison will always=
=20
evaluate as 'true' for the address of 'nat_callforwarding' will never be NU=
LL=20
[-Waddress]
net/ipv4/netfilter/nf_nat_h323.c:592:2: warning: the comparison will always=
=20
evaluate as 'true' for the address of 'nat_q931' will never be NULL [-
Waddress]
net/ipv4/netfilter/nf_nat_irc.c: In function 'nf_nat_irc_init':
net/ipv4/netfilter/nf_nat_irc.c:85:2: warning: the comparison will always=20
evaluate as 'true' for the address of 'help' will never be NULL [-Waddress]
In file included from sound/pci/echoaudio/indigodjx.c:108:0:
sound/pci/echoaudio/echoaudio.c: In function 'snd_echo_vumeters_info':
sound/pci/echoaudio/echoaudio.c:1754:20: warning: variable 'chip' set but n=
ot=20
used [-Wunused-but-set-variable]
sound/pci/echoaudio/echoaudio.c: In function 'snd_echo_channels_info_info':
sound/pci/echoaudio/echoaudio.c:1798:20: warning: variable 'chip' set but n=
ot=20
used [-Wunused-but-set-variable]
sound/pci/echoaudio/echoaudio.c: In function 'snd_echo_probe':
sound/pci/echoaudio/echoaudio.c:2048:6: warning: variable 'i' set but not u=
sed=20
[-Wunused-but-set-variable]
net/ipv4/netfilter/nf_nat_pptp.c: In function 'nf_nat_helper_pptp_init':
net/ipv4/netfilter/nf_nat_pptp.c:285:2: warning: the comparison will always=
=20
evaluate as 'true' for the address of 'pptp_outbound_pkt' will never be NUL=
L=20
[-Waddress]
net/ipv4/netfilter/nf_nat_pptp.c:288:2: warning: the comparison will always=
=20
evaluate as 'true' for the address of 'pptp_inbound_pkt' will never be NULL=
 [-
Waddress]
net/ipv4/netfilter/nf_nat_pptp.c:291:2: warning: the comparison will always=
=20
evaluate as 'true' for the address of 'pptp_exp_gre' will never be NULL [-
Waddress]
net/ipv4/netfilter/nf_nat_pptp.c:294:2: warning: the comparison will always=
=20
evaluate as 'true' for the address of 'pptp_nat_expected' will never be NUL=
L=20
[-Waddress]
In file included from sound/pci/echoaudio/indigoio.c:107:0:
sound/pci/echoaudio/echoaudio.c: In function 'snd_echo_vumeters_info':
sound/pci/echoaudio/echoaudio.c:1754:20: warning: variable 'chip' set but n=
ot=20
used [-Wunused-but-set-variable]
sound/pci/echoaudio/echoaudio.c: In function 'snd_echo_channels_info_info':
sound/pci/echoaudio/echoaudio.c:1798:20: warning: variable 'chip' set but n=
ot=20
used [-Wunused-but-set-variable]
sound/pci/echoaudio/echoaudio.c: In function 'snd_echo_probe':
sound/pci/echoaudio/echoaudio.c:2048:6: warning: variable 'i' set but not u=
sed=20
[-Wunused-but-set-variable]
net/ipv4/netfilter/nf_nat_sip.c: In function 'nf_nat_sip_init':
net/ipv4/netfilter/nf_nat_sip.c:550:2: warning: the comparison will always=
=20
evaluate as 'true' for the address of 'ip_nat_sip' will never be NULL [-
Waddress]
net/ipv4/netfilter/nf_nat_sip.c:551:2: warning: the comparison will always=
=20
evaluate as 'true' for the address of 'ip_nat_sip_seq_adjust' will never be=
=20
NULL [-Waddress]
net/ipv4/netfilter/nf_nat_sip.c:552:2: warning: the comparison will always=
=20
evaluate as 'true' for the address of 'ip_nat_sip_expect' will never be NUL=
L=20
[-Waddress]
net/ipv4/netfilter/nf_nat_sip.c:553:2: warning: the comparison will always=
=20
evaluate as 'true' for the address of 'ip_nat_sdp_addr' will never be NULL =
[-
Waddress]
net/ipv4/netfilter/nf_nat_sip.c:554:2: warning: the comparison will always=
=20
evaluate as 'true' for the address of 'ip_nat_sdp_port' will never be NULL =
[-
Waddress]
net/ipv4/netfilter/nf_nat_sip.c:555:2: warning: the comparison will always=
=20
evaluate as 'true' for the address of 'ip_nat_sdp_session' will never be NU=
LL=20
[-Waddress]
net/ipv4/netfilter/nf_nat_sip.c:556:2: warning: the comparison will always=
=20
evaluate as 'true' for the address of 'ip_nat_sdp_media' will never be NULL=
 [-
Waddress]
net/ipv4/netfilter/nf_nat_tftp.c: In function 'nf_nat_tftp_init':
net/ipv4/netfilter/nf_nat_tftp.c:46:2: warning: the comparison will always=
=20
evaluate as 'true' for the address of 'help' will never be NULL [-Waddress]
net/ipv6/xfrm6_tunnel.c: In function 'xfrm6_tunnel_rcv':
net/ipv6/xfrm6_tunnel.c:244:53: warning: the omitted middle operand in ?: w=
ill=20
always be 'true', suggest explicit middle operand [-Wparentheses]
In file included from sound/pci/echoaudio/indigoiox.c:109:0:
sound/pci/echoaudio/echoaudio.c: In function 'snd_echo_vumeters_info':
sound/pci/echoaudio/echoaudio.c:1754:20: warning: variable 'chip' set but n=
ot=20
used [-Wunused-but-set-variable]
sound/pci/echoaudio/echoaudio.c: In function 'snd_echo_channels_info_info':
sound/pci/echoaudio/echoaudio.c:1798:20: warning: variable 'chip' set but n=
ot=20
used [-Wunused-but-set-variable]
sound/pci/echoaudio/echoaudio.c: In function 'snd_echo_probe':
sound/pci/echoaudio/echoaudio.c:2048:6: warning: variable 'i' set but not u=
sed=20
[-Wunused-but-set-variable]
net/ipv6/xfrm6_mode_beet.c: In function 'xfrm6_beet_output':
net/ipv6/xfrm6_mode_beet.c:44:16: warning: variable 'iphv4' set but not use=
d=20
[-Wunused-but-set-variable]
In file included from sound/pci/echoaudio/layla20.c:114:0:
sound/pci/echoaudio/echoaudio.c: In function 'snd_echo_vumeters_info':
sound/pci/echoaudio/echoaudio.c:1754:20: warning: variable 'chip' set but n=
ot=20
used [-Wunused-but-set-variable]
sound/pci/echoaudio/echoaudio.c: In function 'snd_echo_channels_info_info':
sound/pci/echoaudio/echoaudio.c:1798:20: warning: variable 'chip' set but n=
ot=20
used [-Wunused-but-set-variable]
In file included from sound/pci/echoaudio/layla24.c:126:0:
sound/pci/echoaudio/echoaudio.c: In function 'snd_echo_vumeters_info':
sound/pci/echoaudio/echoaudio.c:1754:20: warning: variable 'chip' set but n=
ot=20
used [-Wunused-but-set-variable]
sound/pci/echoaudio/echoaudio.c: In function 'snd_echo_channels_info_info':
sound/pci/echoaudio/echoaudio.c:1798:20: warning: variable 'chip' set but n=
ot=20
used [-Wunused-but-set-variable]
In file included from sound/pci/echoaudio/mia.c:120:0:
sound/pci/echoaudio/echoaudio.c: In function 'snd_echo_vumeters_info':
sound/pci/echoaudio/echoaudio.c:1754:20: warning: variable 'chip' set but n=
ot=20
used [-Wunused-but-set-variable]
sound/pci/echoaudio/echoaudio.c: In function 'snd_echo_channels_info_info':
sound/pci/echoaudio/echoaudio.c:1798:20: warning: variable 'chip' set but n=
ot=20
used [-Wunused-but-set-variable]
In file included from sound/pci/echoaudio/mona.c:138:0:
sound/pci/echoaudio/echoaudio.c: In function 'snd_echo_vumeters_info':
sound/pci/echoaudio/echoaudio.c:1754:20: warning: variable 'chip' set but n=
ot=20
used [-Wunused-but-set-variable]
sound/pci/echoaudio/echoaudio.c: In function 'snd_echo_channels_info_info':
sound/pci/echoaudio/echoaudio.c:1798:20: warning: variable 'chip' set but n=
ot=20
used [-Wunused-but-set-variable]
net/ipv4/netfilter/nf_nat_proto_sctp.c: In function 'sctp_manip_pkt':
net/ipv4/netfilter/nf_nat_proto_sctp.c:39:16: warning: variable 'newip' set=
 but=20
not used [-Wunused-but-set-variable]
net/ipv4/netfilter/nf_nat_proto_sctp.c:39:9: warning: variable 'oldip' set =
but=20
not used [-Wunused-but-set-variable]
net/ipv6/netfilter/ip6_tables.c: In function 'compat_copy_entry_from_user':
net/ipv6/netfilter/ip6_tables.c:1579:20: warning: variable 'target' set but=
 not=20
used [-Wunused-but-set-variable]
net/ipv6/netfilter/ip6table_mangle.c: In function 'ip6t_mangle_out':
net/ipv6/netfilter/ip6table_mangle.c:39:12: warning: variable 'flowlabel' s=
et=20
but not used [-Wunused-but-set-variable]
drivers/firewire/net.c: In function 'fwnet_receive_broadcast':
drivers/firewire/net.c:833:18: warning: variable 'card' set but not used [-
Wunused-but-set-variable]
sound/pci/emu10k1/emu10k1_main.c: In function 'snd_emu10k1_cardbus_init':
sound/pci/emu10k1/emu10k1_main.c:635:15: warning: variable 'value' set but =
not=20
used [-Wunused-but-set-variable]
sound/pci/emu10k1/emu10k1_main.c: In function 'snd_emu1010_load_firmware':
sound/pci/emu10k1/emu10k1_main.c:665:15: warning: variable 'write_post' set=
=20
but not used [-Wunused-but-set-variable]
sound/pci/emu10k1/emu10k1_patch.c: In function 'snd_emu10k1_sample_new':
sound/pci/emu10k1/emu10k1_patch.c:43:22: warning: variable 'loopsize' set b=
ut=20
not used [-Wunused-but-set-variable]
net/ipv4/netfilter/ipt_CLUSTERIP.c: In function 'clusterip_tg':
net/ipv4/netfilter/ipt_CLUSTERIP.c:329:3: warning: case value '4' not in=20
enumerated type 'enum ip_conntrack_info' [-Wswitch]
In file included from net/ipv4/netfilter/ipt_LOG.c:27:0:
include/net/netfilter/xt_log.h: In function 'sb_close':
include/net/netfilter/xt_log.h:50:3: warning: value computed is not used [-
Wunused-value]
net/ipv4/netfilter/arp_tables.c: In function 'compat_copy_entry_from_user':
net/ipv4/netfilter/arp_tables.c:1276:20: warning: variable 'target' set but=
 not=20
used [-Wunused-but-set-variable]
sound/pci/emu10k1/emupcm.c: In function 'snd_emu10k1_pcm_init_voice':
sound/pci/emu10k1/emupcm.c:292:16: warning: variable 'attn' set but not use=
d=20
[-Wunused-but-set-variable]
net/mac80211/sta_info.c: In function 'sta_info_cleanup_expire_buffered':
net/mac80211/sta_info.c:586:32: warning: variable 'sdata' set but not used =
[-
Wunused-but-set-variable]
drivers/gpu/drm/drm_gem.c: In function 'drm_gem_handle_delete':
drivers/gpu/drm/drm_gem.c:187:21: warning: variable 'dev' set but not used =
[-
Wunused-but-set-variable]
fs/fscache/cookie.c: In function '__fscache_relinquish_cookie':
fs/fscache/cookie.c:413:24: warning: variable 'cache' set but not used [-
Wunused-but-set-variable]
sound/pci/korg1212/korg1212.c: In function 'snd_korg1212_create':
sound/pci/korg1212/korg1212.c:2163:36: warning: variable 'iomem2_size' set =
but=20
not used [-Wunused-but-set-variable]
sound/pci/korg1212/korg1212.c:2163:11: warning: variable 'ioport_size' set =
but=20
not used [-Wunused-but-set-variable]
sound/pci/ice1712/ice1712.c: In function 'snd_ice1712_playback_ds_prepare':
sound/pci/ice1712/ice1712.c:624:19: warning: variable 'buf_size' set but no=
t=20
used [-Wunused-but-set-variable]
In file included from net/ipv6/netfilter/ip6t_LOG.c:26:0:
include/net/netfilter/xt_log.h: In function 'sb_close':
include/net/netfilter/xt_log.h:50:3: warning: value computed is not used [-
Wunused-value]
fs/fscache/operation.c: In function 'fscache_op_work_func':
fs/fscache/operation.c:461:16: warning: variable 'start' set but not used [-
Wunused-but-set-variable]
fs/fscache/object.c: In function 'fscache_object_work_func':
fs/fscache/object.c:336:16: warning: variable 'start' set but not used [-
Wunused-but-set-variable]
net/mac80211/ibss.c: In function 'ieee80211_rx_mgmt_auth_ibss':
net/mac80211/ibss.c:44:34: warning: variable 'status_code' set but not used=
 [-
Wunused-but-set-variable]
net/mac80211/ibss.c: In function 'ieee80211_sta_create_ibss':
net/mac80211/ibss.c:535:35: warning: variable 'sband' set but not used [-
Wunused-but-set-variable]
drivers/hid/hid-picolcd.c: In function 'picolcd_raw_event':
drivers/hid/hid-picolcd.c:2378:6: warning: variable 'ret' set but not used =
[-
Wunused-but-set-variable]
fs/fscache/page.c: In function 'fscache_wait_for_deferred_lookup':
fs/fscache/page.c:269:16: warning: variable 'jif' set but not used [-Wunuse=
d-
but-set-variable]
net/mac80211/work.c: In function 'ieee80211_send_assoc':
net/mac80211/work.c:210:9: warning: variable 'len' set but not used [-Wunus=
ed-
but-set-variable]
net/mac80211/work.c:208:12: warning: variable 'ies' set but not used [-
Wunused-but-set-variable]
sound/pci/hda/patch_hdmi.c: In function 'nvhdmi_8ch_7x_pcm_prepare':
sound/pci/hda/patch_hdmi.c:1307:15: warning: variable 'dataDCC1' set but no=
t=20
used [-Wunused-but-set-variable]
sound/pci/ice1712/revo.c: In function 'ap192_ak4114_init':
sound/pci/ice1712/revo.c:485:6: warning: variable 'err' set but not used [-
Wunused-but-set-variable]
net/mac80211/aes_ccm.c: In function 'ieee80211_aes_ccm_encrypt':
net/mac80211/aes_ccm.c:57:39: warning: variable 'aad' set but not used [-
Wunused-but-set-variable]
net/mac80211/aes_ccm.c: In function 'ieee80211_aes_ccm_decrypt':
net/mac80211/aes_ccm.c:97:39: warning: variable 'aad' set but not used [-
Wunused-but-set-variable]
net/mac80211/rx.c: In function 'ieee80211_reassemble_add':
net/mac80211/rx.c:1223:6: warning: variable 'idx' set but not used [-Wunuse=
d-
but-set-variable]
fs/gfs2/dir.c: In function 'dir_split_leaf':
fs/gfs2/dir.c:919:9: warning: variable 'moved' set but not used [-Wunused-b=
ut-
set-variable]
drivers/gpu/drm/drm_modes.c: In function 'drm_cvt_mode':
drivers/gpu/drm/drm_modes.c:176:27: warning: variable 'vback_porch' set but=
=20
not used [-Wunused-but-set-variable]
drivers/gpu/drm/drm_modes.c: In function 'drm_gtf_mode_complex':
drivers/gpu/drm/drm_modes.c:326:28: warning: variable 'vframe_rate' set but=
=20
not used [-Wunused-but-set-variable]
drivers/gpu/drm/drm_modes.c:325:45: warning: variable 'hperiod' set but not=
=20
used [-Wunused-but-set-variable]
drivers/gpu/drm/drm_modes.c:325:29: warning: variable 'vfieldrate_est' set =
but=20
not used [-Wunused-but-set-variable]
drivers/gpu/drm/drm_modes.c:324:21: warning: variable 'vback_porch' set but=
=20
not used [-Wunused-but-set-variable]
net/mac80211/tx.c: In function '__ieee80211_parse_tx_radiotap':
net/mac80211/tx.c:1041:35: warning: variable 'sband' set but not used [-
Wunused-but-set-variable]
net/mac80211/tx.c: In function 'ieee80211_get_buffered_bc':
net/mac80211/tx.c:2530:19: warning: variable 'sta' set but not used [-Wunus=
ed-
but-set-variable]
drivers/gpu/drm/drm_global.c: In function 'drm_global_item_ref':
drivers/gpu/drm/drm_global.c:70:8: warning: variable 'object' set but not u=
sed=20
[-Wunused-but-set-variable]
drivers/gpu/drm/drm_fb_helper.c: In function 'drm_fb_helper_init':
drivers/gpu/drm/drm_fb_helper.c:547:6: warning: variable 'ret' set but not=
=20
used [-Wunused-but-set-variable]
drivers/gpu/drm/drm_fb_helper.c: In function 'drm_fb_helper_setcmap':
drivers/gpu/drm/drm_fb_helper.c:689:29: warning: variable 'htransp' set but=
=20
not used [-Wunused-but-set-variable]
drivers/gpu/drm/drm_fb_helper.c: In function 'drm_pick_crtcs':
drivers/gpu/drm/drm_fb_helper.c:1318:29: warning: variable 'best_crtc' set =
but=20
not used [-Wunused-but-set-variable]
drivers/gpu/drm/drm_fb_helper.c: In function 'drm_fb_helper_hotplug_event':
drivers/gpu/drm/drm_fb_helper.c:1503:6: warning: variable 'count' set but n=
ot=20
used [-Wunused-but-set-variable]
sound/pci/lx6464es/lx_core.c: In function 'lx_interrupt_handle_async_events=
':
sound/pci/lx6464es/lx_core.c:1116:6: warning: variable 'urun_mask' set but =
not=20
used [-Wunused-but-set-variable]
sound/pci/lx6464es/lx_core.c:1115:6: warning: variable 'orun_mask' set but =
not=20
used [-Wunused-but-set-variable]
fs/gfs2/log.c: In function 'gfs2_logd':
fs/gfs2/log.c:900:11: warning: variable 'preflush' set but not used [-Wunus=
ed-
but-set-variable]
fs/gfs2/inode.c: In function 'gfs2_lookup_by_inum':
fs/gfs2/inode.c:188:16: warning: 'inode' may be used uninitialized in this=
=20
function [-Wuninitialized]
fs/hfs/bnode.c: In function 'hfs_bnode_copy':
fs/hfs/bnode.c:100:20: warning: variable 'tree' set but not used [-Wunused-
but-set-variable]
fs/hfs/bnode.c: In function '__hfs_bnode_create':
fs/hfs/bnode.c:238:22: warning: variable 'sb' set but not used [-Wunused-bu=
t-
set-variable]
drivers/gpu/drm/mga/mga_state.c: In function 'mga_dma_iload':
drivers/gpu/drm/mga/mga_state.c:948:22: warning: variable 'buf_priv' set bu=
t=20
not used [-Wunused-but-set-variable]
sound/pci/mixart/mixart_core.c: In function 'send_msg':
sound/pci/mixart/mixart_core.c:152:6: warning: variable 'err' set but not u=
sed=20
[-Wunused-but-set-variable]
fs/hfsplus/extents.c: In function 'hfsplus_get_block':
fs/hfsplus/extents.c:213:6: warning: variable 'shift' set but not used [-
Wunused-but-set-variable]
net/mac80211/mesh.c: In function 'ieee80211_mesh_rx_queued_mgmt':
net/mac80211/mesh.c:614:28: warning: variable 'ifmsh' set but not used [-
Wunused-but-set-variable]
fs/hfsplus/bnode.c: In function 'hfsplus_bnode_copy':
fs/hfsplus/bnode.c:128:20: warning: variable 'tree' set but not used [-
Wunused-but-set-variable]
fs/hfsplus/bnode.c: In function '__hfs_bnode_create':
fs/hfsplus/bnode.c:402:22: warning: variable 'sb' set but not used [-Wunuse=
d-
but-set-variable]
net/mac80211/mesh_hwmp.c: In function 'hwmp_perr_frame_process':
net/mac80211/mesh_hwmp.c:636:5: warning: variable 'target_flags' set but no=
t=20
used [-Wunused-but-set-variable]
net/mac80211/mesh_hwmp.c: In function 'hwmp_rann_frame_process':
net/mac80211/mesh_hwmp.c:678:6: warning: variable 'ta' set but not used [-
Wunused-but-set-variable]
fs/gfs2/ops_fstype.c: In function 'init_inodes':
fs/gfs2/ops_fstype.c:770:21: warning: variable 'ip' set but not used [-
Wunused-but-set-variable]
drivers/infiniband/hw/amso1100/c2.c: In function 'c2_probe':
drivers/infiniband/hw/amso1100/c2.c:929:16: warning: variable 'reg2_start' =
set=20
but not used [-Wunused-but-set-variable]
net/netfilter/nfnetlink_log.c: In function '__build_packet_message':
net/netfilter/nfnetlink_log.c:385:9: warning: variable 'tmp_uint' set but n=
ot=20
used [-Wunused-but-set-variable]
drivers/input/joystick/analog.c:175:2: warning: #warning Precise timer not=
=20
defined for this architecture. [-Wcpp]
drivers/infiniband/hw/cxgb3/iwch_cm.c: In function 'iwch_reject_cr':
drivers/infiniband/hw/cxgb3/iwch_cm.c:1765:6: warning: variable 'err' set b=
ut=20
not used [-Wunused-but-set-variable]
fs/jffs2/dir.c: In function 'jffs2_lookup':
fs/jffs2/dir.c:78:24: warning: variable 'c' set but not used [-Wunused-but-=
set-
variable]
fs/jffs2/dir.c: In function 'jffs2_readdir':
fs/jffs2/dir.c:122:24: warning: variable 'c' set but not used [-Wunused-but-
set-variable]
drivers/gpu/drm/radeon/radeon_state.c: In function 'radeon_cp_indices':
drivers/gpu/drm/radeon/radeon_state.c:2343:6: warning: variable 'count' set=
=20
but not used [-Wunused-but-set-variable]
net/netfilter/nf_conntrack_netlink.c: In function 'ctnetlink_parse_tuple':
net/netfilter/nf_conntrack_netlink.c:790:11: warning: comparison between 'e=
num=20
ctattr_tuple' and 'enum ctattr_type' [-Wenum-compare]
drivers/infiniband/hw/cxgb4/cm.c: In function 'c4iw_reject_cr':
drivers/infiniband/hw/cxgb4/cm.c:1770:6: warning: variable 'err' set but no=
t=20
used [-Wunused-but-set-variable]
drivers/gpu/drm/savage/savage_bci.c: In function 'savage_driver_firstopen':
drivers/gpu/drm/savage/savage_bci.c:568:24: warning: variable 'aper_rsrc' s=
et=20
but not used [-Wunused-but-set-variable]
drivers/gpu/drm/savage/savage_bci.c:568:15: warning: variable 'fb_rsrc' set=
=20
but not used [-Wunused-but-set-variable]
drivers/infiniband/hw/cxgb3/iwch_qp.c: In function 'iwch_bind_mw':
drivers/infiniband/hw/cxgb3/iwch_qp.c:533:18: warning: variable 'mhp' set b=
ut=20
not used [-Wunused-but-set-variable]
sound/pci/trident/trident_main.c: In function 'snd_trident_free_voice':
sound/pci/trident/trident_main.c:3875:8: warning: variable 'private_data' s=
et=20
but not used [-Wunused-but-set-variable]
sound/pci/trident/trident_memory.c: In function 'search_empty':
sound/pci/trident/trident_memory.c:142:32: warning: variable 'prev' set but=
=20
not used [-Wunused-but-set-variable]
drivers/gpu/drm/via/via_dma.c: In function 'via_cmdbuf_jump':
drivers/gpu/drm/via/via_dma.c:590:11: warning: variable 'agp_base' set but =
not=20
used [-Wunused-but-set-variable]
drivers/hwmon/lm75.c: In function 'lm75_detect':
drivers/hwmon/lm75.c:241:6: warning: variable 'cur' set but not used [-
Wunused-but-set-variable]
drivers/infiniband/core/iwcm.c: In function 'destroy_cm_id':
drivers/infiniband/core/iwcm.c:329:6: warning: variable 'ret' set but not u=
sed=20
[-Wunused-but-set-variable]
fs/jffs2/xattr.c: In function 'jffs2_garbage_collect_xattr_datum':
fs/jffs2/xattr.c:1204:27: warning: variable 'old_ofs' set but not used [-
Wunused-but-set-variable]
fs/jffs2/xattr.c: In function 'jffs2_garbage_collect_xattr_ref':
fs/jffs2/xattr.c:1240:27: warning: variable 'old_ofs' set but not used [-
Wunused-but-set-variable]
drivers/infiniband/core/cma.c: In function 'cma_iw_handler':
drivers/infiniband/core/cma.c:1321:3: warning: case value '4294967235' not =
in=20
enumerated type 'enum iw_cm_event_status' [-Wswitch]
drivers/infiniband/core/cma.c:1324:3: warning: case value '4294967236' not =
in=20
enumerated type 'enum iw_cm_event_status' [-Wswitch]
drivers/infiniband/core/cma.c:1320:3: warning: case value '4294967242' not =
in=20
enumerated type 'enum iw_cm_event_status' [-Wswitch]
drivers/gpu/drm/radeon/radeon_atombios.c: In function=20
'radeon_get_atom_connector_info_from_object_table':
drivers/gpu/drm/radeon/radeon_atombios.c:656:26: warning: variable=20
'grph_obj_num' set but not used [-Wunused-but-set-variable]
drivers/gpu/drm/radeon/radeon_atombios.c:656:13: warning: variable=20
'grph_obj_id' set but not used [-Wunused-but-set-variable]
drivers/gpu/drm/radeon/radeon_atombios.c:578:37: warning: variable=20
'con_obj_type' set but not used [-Wunused-but-set-variable]
drivers/infiniband/hw/mlx4/qp.c: In function 'mlx4_ib_post_send':
drivers/infiniband/hw/mlx4/qp.c:1379:30: warning: 'vlan' may be used=20
uninitialized in this function [-Wuninitialized]
drivers/infiniband/hw/mlx4/qp.c:1304:6: note: 'vlan' was declared here
fs/jfs/namei.c: In function 'jfs_symlink':
fs/jfs/namei.c:899:6: warning: variable 'extent' set but not used [-Wunused-
but-set-variable]
drivers/gpu/drm/radeon/radeon_combios.c: In function=20
'radeon_combios_get_power_modes':
drivers/gpu/drm/radeon/radeon_combios.c:2487:10: warning: variable 'blocks'=
=20
set but not used [-Wunused-but-set-variable]
fs/jfs/jfs_dmap.c: In function 'dbAllocDmapBU':
fs/jfs/jfs_dmap.c:3164:15: warning: variable 'leaf' set but not used [-
Wunused-but-set-variable]
fs/logfs/journal.c: In function 'logfs_read_journal':
fs/logfs/journal.c:335:6: warning: variable 'segno' set but not used [-
Wunused-but-set-variable]
drivers/gpu/drm/radeon/radeon_ttm.c: In function 'radeon_move_vram_ram':
drivers/gpu/drm/radeon/radeon_ttm.c:293:24: warning: variable 'rdev' set bu=
t=20
not used [-Wunused-but-set-variable]
drivers/gpu/drm/radeon/radeon_ttm.c: In function 'radeon_move_ram_vram':
drivers/gpu/drm/radeon/radeon_ttm.c:340:24: warning: variable 'rdev' set bu=
t=20
not used [-Wunused-but-set-variable]
net/rds/ib_send.c: In function 'rds_ib_xmit_atomic':
net/rds/ib_send.c:789:24: warning: variable 'rds_ibdev' set but not used [-
Wunused-but-set-variable]
drivers/input/touchscreen/usbtouchscreen.c: In function 'nexio_read_data':
drivers/input/touchscreen/usbtouchscreen.c:869:50: warning: variable 'ret' =
set=20
but not used [-Wunused-but-set-variable]
drivers/gpu/drm/vmwgfx/vmwgfx_kms.c: In function 'vmw_kms_init':
drivers/gpu/drm/vmwgfx/vmwgfx_kms.c:922:6: warning: variable 'ret' set but =
not=20
used [-Wunused-but-set-variable]
drivers/gpu/drm/vmwgfx/vmwgfx_fb.c: In function 'vmw_fb_init':
drivers/gpu/drm/vmwgfx/vmwgfx_fb.c:408:29: warning: variable 'fb_offset' se=
t=20
but not used [-Wunused-but-set-variable]
drivers/infiniband/hw/nes/nes.c: In function 'nes_store_wqm_quanta':
drivers/infiniband/hw/nes/nes.c:1140:16: warning: ignoring return value of=
=20
'strict_strtoul', declared with attribute warn_unused_result [-Wunused-resu=
lt]
drivers/infiniband/hw/nes/nes_hw.c: In function 'flush_wqes':
drivers/infiniband/hw/nes/nes_hw.c:3872:6: warning: variable 'ret' set but =
not=20
used [-Wunused-but-set-variable]
drivers/infiniband/hw/nes/nes_utils.c: In function 'nes_arp_table':
drivers/infiniband/hw/nes/nes_utils.c:657:9: warning: variable 'tmp_addr' s=
et=20
but not used [-Wunused-but-set-variable]
drivers/infiniband/hw/nes/nes_utils.c: In function 'nes_mh_fix':
drivers/infiniband/hw/nes/nes_utils.c:724:6: warning: variable 'serdes_stat=
us'=20
set but not used [-Wunused-but-set-variable]
fs/jfs/jfs_txnmgr.c: In function 'txCommit':
fs/jfs/jfs_txnmgr.c:1146:6: warning: variable 'lsn' set but not used [-
Wunused-but-set-variable]
fs/jfs/jfs_txnmgr.c: In function 'jfs_sync':
fs/jfs/jfs_txnmgr.c:2938:6: warning: variable 'rc' set but not used [-Wunus=
ed-
but-set-variable]
drivers/infiniband/hw/qib/qib_diag.c: In function 'qib_diag_read':
drivers/infiniband/hw/qib/qib_diag.c:761:16: warning: variable 'kreg_base' =
set=20
but not used [-Wunused-but-set-variable]
drivers/infiniband/hw/qib/qib_diag.c: In function 'qib_diag_write':
drivers/infiniband/hw/qib/qib_diag.c:837:16: warning: variable 'kreg_base' =
set=20
but not used [-Wunused-but-set-variable]
net/netfilter/xt_osf.c: In function 'xt_osf_match_packet':
net/netfilter/xt_osf.c:269:10: warning: variable 'loop_cont' set but not us=
ed=20
[-Wunused-but-set-variable]
net/rds/iw_rdma.c: In function 'rds_iw_flush_mr_pool':
net/rds/iw_rdma.c:501:41: warning: variable 'free_goal' set but not used [-
Wunused-but-set-variable]
drivers/infiniband/hw/qib/qib_file_ops.c: In function 'qib_clean_part_key':
drivers/infiniband/hw/qib/qib_file_ops.c:687:6: warning: variable 'oldpkey'=
 set=20
but not used [-Wunused-but-set-variable]
drivers/infiniband/hw/qib/qib_file_ops.c: In function 'qib_close':
drivers/infiniband/hw/qib/qib_file_ops.c:1722:8: warning: variable 'pid' se=
t but=20
not used [-Wunused-but-set-variable]
net/netfilter/xt_rateest.c: In function 'xt_rateest_mt_checkentry':
net/netfilter/xt_rateest.c:81:6: warning: variable 'ret' set but not used [-
Wunused-but-set-variable]
drivers/gpu/drm/radeon/radeon_display.c: In function 'radeon_div':
drivers/gpu/drm/radeon/radeon_display.c:904:11: warning: variable 'mod' set=
=20
but not used [-Wunused-but-set-variable]
drivers/infiniband/hw/nes/nes_verbs.c: In function 'nes_setup_virt_qp':
drivers/infiniband/hw/nes/nes_verbs.c:924:6: warning: variable 'pbl_entries=
'=20
set but not used [-Wunused-but-set-variable]
drivers/infiniband/hw/nes/nes_verbs.c: In function 'nes_dereg_mr':
drivers/infiniband/hw/nes/nes_verbs.c:2662:6: warning: variable 'minor_code=
'=20
set but not used [-Wunused-but-set-variable]
drivers/infiniband/hw/qib/qib_mad.c: In function 'subn_get_nodeinfo':
drivers/infiniband/hw/qib/qib_mad.c:273:6: warning: variable 'vendor' set b=
ut=20
not used [-Wunused-but-set-variable]
drivers/infiniband/hw/nes/nes_cm.c: In function 'mini_cm_recv_pkt':
drivers/infiniband/hw/nes/nes_cm.c:2270:20: warning: variable 'tmp_saddr' s=
et=20
but not used [-Wunused-but-set-variable]
drivers/infiniband/hw/nes/nes_cm.c:2270:9: warning: variable 'tmp_daddr' se=
t=20
but not used [-Wunused-but-set-variable]
drivers/infiniband/hw/nes/nes_cm.c: In function 'cm_event_reset':
drivers/infiniband/hw/nes/nes_cm.c:3471:6: warning: variable 'ret' set but =
not=20
used [-Wunused-but-set-variable]
drivers/infiniband/hw/qib/qib_pcie.c: In function 'qib_tune_pcie_coalesce':
drivers/infiniband/hw/qib/qib_pcie.c:497:6: warning: variable 'r' set but n=
ot=20
used [-Wunused-but-set-variable]
drivers/gpu/drm/radeon/radeon_gem.c: In function=20
'radeon_gem_set_domain_ioctl':
drivers/gpu/drm/radeon/radeon_gem.c:220:20: warning: variable 'robj' set bu=
t=20
not used [-Wunused-but-set-variable]
drivers/leds/leds-lp5521.c: In function 'lp5521_set_engine_mode':
drivers/leds/leds-lp5521.c:180:15: warning: 'engine_state' may be used=20
uninitialized in this function [-Wuninitialized]
drivers/leds/leds-lp5521.c: In function 'lp5521_do_store_load':
drivers/leds/leds-lp5521.c:148:2: warning: 'mode' may be used uninitialized=
 in=20
this function [-Wuninitialized]
drivers/leds/leds-lp5521.c:194:5: note: 'mode' was declared here
drivers/leds/leds-lp5523.c: In function 'lp5523_selftest':
drivers/leds/leds-lp5523.c:490:18: warning: 'adc' may be used uninitialized=
 in=20
this function [-Wuninitialized]
drivers/leds/leds-lp5523.c:465:5: warning: 'vdd' may be used uninitialized =
in=20
this function [-Wuninitialized]
drivers/leds/leds-lp5523.c: In function 'lp5523_probe':
drivers/leds/leds-lp5523.c:247:9: warning: 'status' may be used uninitializ=
ed=20
in this function [-Wuninitialized]
drivers/leds/leds-lp5523.c:196:5: note: 'status' was declared here
fs/ncpfs/inode.c: In function 'ncp_parse_options':
fs/ncpfs/inode.c:376:6: warning: variable 'version' set but not used [-
Wunused-but-set-variable]
drivers/gpu/drm/radeon/radeon_cs.c: In function 'radeon_cs_parser_init':
drivers/gpu/drm/radeon/radeon_cs.c:123:20: warning: variable 'cdata' set bu=
t=20
not used [-Wunused-but-set-variable]
drivers/isdn/capi/capi.c: In function 'handle_recv_skb':
drivers/isdn/capi/capi.c:429:15: warning: variable 'datahandle' set but not=
=20
used [-Wunused-but-set-variable]
fs/ncpfs/ioctl.c: In function '__ncp_ioctl':
fs/ncpfs/ioctl.c:643:11: warning: variable 'oldprivatelen' set but not used=
 [-
Wunused-but-set-variable]
fs/ncpfs/ioctl.c:641:11: warning: variable 'oldnamelen' set but not used [-
Wunused-but-set-variable]
fs/ncpfs/ioctl.c:741:11: warning: variable 'oldlen' set but not used [-
Wunused-but-set-variable]
drivers/infiniband/ulp/iser/iscsi_iser.c: In function 'iscsi_iser_recv':
drivers/infiniband/ulp/iser/iscsi_iser.c:100:6: warning: variable 'ahslen' =
set=20
but not used [-Wunused-but-set-variable]
drivers/gpu/drm/radeon/r600.c: In function 'r600_pcie_gart_tlb_flush':
drivers/gpu/drm/radeon/r600.c:892:7: warning: variable 'tmp' set but not us=
ed=20
[-Wunused-but-set-variable]
drivers/gpu/drm/radeon/r600.c: In function 'r600_gpu_is_lockup':
drivers/gpu/drm/radeon/r600.c:1355:6: warning: variable 'grbm_status2' set =
but=20
not used [-Wunused-but-set-variable]
drivers/gpu/drm/radeon/r600.c:1353:6: warning: variable 'srbm_status' set b=
ut=20
not used [-Wunused-but-set-variable]
drivers/gpu/drm/radeon/r600.c: In function 'r600_ioctl_wait_idle':
drivers/gpu/drm/radeon/r600.c:3532:7: warning: variable 'tmp' set but not u=
sed=20
[-Wunused-but-set-variable]
net/netfilter/ipvs/ip_vs_core.c: In function 'ip_vs_leave':
net/netfilter/ipvs/ip_vs_core.c:474:12: warning: variable 'cs' set but not =
used=20
[-Wunused-but-set-variable]
net/netfilter/ipvs/ip_vs_core.c: In function 'ip_vs_in':
net/netfilter/ipvs/ip_vs_core.c:1429:11: warning: variable 'restart' set bu=
t=20
not used [-Wunused-but-set-variable]
drivers/isdn/gigaset/bas-gigaset.c: In function 'stopurbs':
drivers/isdn/gigaset/bas-gigaset.c:1043:9: warning: variable 'rc' set but n=
ot=20
used [-Wunused-but-set-variable]
drivers/isdn/gigaset/bas-gigaset.c: In function 'write_iso_tasklet':
drivers/isdn/gigaset/bas-gigaset.c:1160:6: warning: variable 'offset' set b=
ut=20
not used [-Wunused-but-set-variable]
net/sctp/associola.c: In function 'sctp_assoc_bh_rcv':
net/sctp/associola.c:1092:15: warning: variable 'sk' set but not used [-
Wunused-but-set-variable]
drivers/infiniband/hw/qib/qib_tx.c: In function 'qib_disarm_piobufs_set':
drivers/infiniband/hw/qib/qib_tx.c:181:7: warning: variable 'which' set but=
 not=20
used [-Wunused-but-set-variable]
net/sunrpc/xprtsock.c: In function 'bc_send_request':
net/sunrpc/xprtsock.c:2040:27: warning: variable 'svsk' set but not used [-
Wunused-but-set-variable]
net/sctp/sm_make_chunk.c: In function 'sctp_make_fwdtsn':
net/sctp/sm_make_chunk.c:3378:28: warning: variable 'ftsn_chunk' set but no=
t=20
used [-Wunused-but-set-variable]
drivers/isdn/gigaset/interface.c: In function 'if_set_termios':
drivers/isdn/gigaset/interface.c:507:15: warning: variable 'iflag' set but =
not=20
used [-Wunused-but-set-variable]
fs/nfsd/vfs.c: In function 'nfsd_vfs_read':
fs/nfsd/vfs.c:880:16: warning: variable 'inode' set but not used [-Wunused-
but-set-variable]
drivers/infiniband/hw/qib/qib_iba7220.c: In function 'autoneg_7220_work':
drivers/infiniband/hw/qib/qib_iba7220.c:3529:6: warning: variable 'startms'=
 set=20
but not used [-Wunused-but-set-variable]
net/sctp/outqueue.c: In function 'sctp_outq_flush_rtx':
net/sctp/outqueue.c:548:27: warning: variable 'asoc' set but not used [-
Wunused-but-set-variable]
drivers/isdn/gigaset/capi.c:301:20: warning: 'format_ie' defined but not us=
ed=20
[-Wunused-function]
drivers/gpu/drm/radeon/radeon_legacy_tv.c: In function=20
'radeon_legacy_tv_init_restarts':
drivers/gpu/drm/radeon/radeon_legacy_tv.c:434:21: warning: variable 'pll' s=
et=20
but not used [-Wunused-but-set-variable]
drivers/gpu/drm/radeon/radeon_legacy_tv.c: In function=20
'radeon_legacy_tv_mode_set':
drivers/gpu/drm/radeon/radeon_legacy_tv.c:547:24: warning: variable=20
'tv_pll_cntl1' set but not used [-Wunused-but-set-variable]
net/sctp/ulpqueue.c: In function 'sctp_ulpq_tail_data':
net/sctp/ulpqueue.c:108:21: warning: variable 'hdr' set but not used [-
Wunused-but-set-variable]
net/sctp/ulpqueue.c: In function 'sctp_ulpq_retrieve_ordered':
net/sctp/ulpqueue.c:747:8: warning: variable 'ssn' set but not used [-Wunus=
ed-
but-set-variable]
drivers/infiniband/hw/qib/qib_sd7220.c: In function 'qib_sd7220_ram_xfer':
drivers/infiniband/hw/qib/qib_sd7220.c:752:14: warning: variable 'op' set b=
ut=20
not used [-Wunused-but-set-variable]
drivers/infiniband/hw/qib/qib_iba7322.c: In function=20
'qib_setup_7322_interrupt':
drivers/infiniband/hw/qib/qib_iba7322.c:3100:7: warning: variable 'val' set=
 but=20
not used [-Wunused-but-set-variable]
drivers/infiniband/hw/qib/qib_iba7322.c: In function 'autoneg_7322_work':
drivers/infiniband/hw/qib/qib_iba7322.c:4991:6: warning: variable 'startms'=
 set=20
but not used [-Wunused-but-set-variable]
drivers/infiniband/hw/qib/qib_iba7322.c:4990:22: warning: variable 'dd' set=
 but=20
not used [-Wunused-but-set-variable]
drivers/infiniband/hw/qib/qib_iba7322.c: In function 'ibsd_wr_allchans':
drivers/infiniband/hw/qib/qib_iba7322.c:7284:6: warning: variable 'rbc' set=
 but=20
not used [-Wunused-but-set-variable]
drivers/infiniband/hw/qib/qib_iba6120.c: In function 'qib_6120_put_tid_2':
drivers/infiniband/hw/qib/qib_iba6120.c:1931:6: warning: variable 'tidx' se=
t=20
but not used [-Wunused-but-set-variable]
net/sctp/socket.c: In function 'sctp_setsockopt_peer_primary_addr':
net/sctp/socket.c:2931:24: warning: variable 'ep' set but not used [-Wunuse=
d-
but-set-variable]
fs/nfsd/nfs4xdr.c: In function 'nfsd4_decode_bind_conn_to_session':
fs/nfsd/nfs4xdr.c:427:6: warning: variable 'dummy' set but not used [-Wunus=
ed-
but-set-variable]
fs/nfsd/nfs4state.c: In function 'nfsd4_bind_conn_to_session':
fs/nfsd/nfs4state.c:1618:9: warning: variable 'status' set but not used [-
Wunused-but-set-variable]
drivers/gpu/drm/radeon/r600_blit_kms.c: In function 'r600_blit_done_copy':
drivers/gpu/drm/radeon/r600_blit_kms.c:649:6: warning: variable 'r' set but=
=20
not used [-Wunused-but-set-variable]
drivers/isdn/hardware/mISDN/hfcpci.c: In function 'hfcpci_empty_bfifo':
drivers/isdn/hardware/mISDN/hfcpci.c:408:7: warning: variable 'total' set b=
ut=20
not used [-Wunused-but-set-variable]
drivers/isdn/hardware/mISDN/hfcpci.c: In function 'ph_state_nt':
drivers/isdn/hardware/mISDN/hfcpci.c:971:9: warning: variable 'val' set but=
=20
not used [-Wunused-but-set-variable]
drivers/isdn/hardware/mISDN/hfcsusb.c: In function 'ctrl_complete':
drivers/isdn/hardware/mISDN/hfcsusb.c:121:19: warning: variable 'buf' set b=
ut=20
not used [-Wunused-but-set-variable]
drivers/isdn/hardware/mISDN/hfcsusb.c: In function 'setup_hfcsusb':
drivers/isdn/hardware/mISDN/hfcsusb.c:1729:6: warning: variable 'err' set b=
ut=20
not used [-Wunused-but-set-variable]
drivers/isdn/hardware/mISDN/hfcpci.c: In function 'hfcpci_softirq':
drivers/isdn/hardware/mISDN/hfcpci.c:2320:2: warning: ignoring return value=
 of=20
'driver_for_each_device', declared with attribute warn_unused_result [-
Wunused-result]
net/sctp/input.c: In function '__sctp_rcv_init_lookup':
net/sctp/input.c:951:19: warning: variable 'ch' set but not used [-Wunused-
but-set-variable]
drivers/gpu/drm/radeon/evergreen.c: In function 'evergreen_gpu_init':
drivers/gpu/drm/radeon/evergreen.c:1566:6: warning: variable 'mc_shared_chm=
ap'=20
set but not used [-Wunused-but-set-variable]
drivers/gpu/drm/radeon/evergreen.c: In function 'evergreen_gpu_is_lockup':
drivers/gpu/drm/radeon/evergreen.c:2208:23: warning: variable=20
'grbm_status_se1' set but not used [-Wunused-but-set-variable]
drivers/gpu/drm/radeon/evergreen.c:2208:6: warning: variable 'grbm_status_s=
e0'=20
set but not used [-Wunused-but-set-variable]
drivers/gpu/drm/radeon/evergreen.c:2206:6: warning: variable 'srbm_status' =
set=20
but not used [-Wunused-but-set-variable]
net/sctp/ipv6.c: In function 'sctp_v6_get_dst':
net/sctp/ipv6.c:265:20: warning: variable 'rt' set but not used [-Wunused-b=
ut-
set-variable]
net/sunrpc/auth_gss/gss_krb5_unseal.c: In function 'gss_verify_mic_v2':
net/sunrpc/auth_gss/gss_krb5_unseal.c:153:6: warning: variable 'seqnum' set=
=20
but not used [-Wunused-but-set-variable]
net/sunrpc/xprtrdma/svc_rdma.c: In function 'read_reset_stat':
net/sunrpc/xprtrdma/svc_rdma.c:99:9: warning: variable 'data' set but not u=
sed=20
[-Wunused-but-set-variable]
drivers/isdn/i4l/isdn_net.c: In function 'isdn_net_ciscohdlck_slarp_in':
drivers/isdn/i4l/isdn_net.c:1681:6: warning: variable 'unused' set but not=
=20
used [-Wunused-but-set-variable]
net/sunrpc/auth_gss/gss_krb5_wrap.c: In function 'gss_wrap_kerberos_v2':
net/sunrpc/auth_gss/gss_krb5_wrap.c:405:7: warning: variable 'blocksize' se=
t=20
but not used [-Wunused-but-set-variable]
net/sunrpc/auth_gss/gss_krb5_wrap.c: In function 'gss_unwrap_kerberos_v2':
net/sunrpc/auth_gss/gss_krb5_wrap.c:463:7: warning: variable 'ec' set but n=
ot=20
used [-Wunused-but-set-variable]
net/sunrpc/auth_gss/gss_krb5_wrap.c:460:7: warning: variable 'seqnum' set b=
ut=20
not used [-Wunused-but-set-variable]
net/sunrpc/auth_gss/gss_krb5_crypto.c: In function 'make_checksum_v2':
net/sunrpc/auth_gss/gss_krb5_crypto.c:330:15: warning: variable 'checksumle=
n'=20
set but not used [-Wunused-but-set-variable]
fs/nilfs2/btree.c: In function 'nilfs_btree_split':
fs/nilfs2/btree.c:855:8: warning: variable 'newptr' set but not used [-
Wunused-but-set-variable]
fs/nilfs2/btree.c:854:8: warning: variable 'newkey' set but not used [-
Wunused-but-set-variable]
drivers/isdn/i4l/isdn_tty.c: In function 'isdn_tty_change_speed':
drivers/isdn/i4l/isdn_tty.c:1001:3: warning: variable 'fcr' set but not use=
d=20
[-Wunused-but-set-variable]
net/sunrpc/xprtrdma/svc_rdma_transport.c: In function 'svc_rdma_create':
net/sunrpc/xprtrdma/svc_rdma_transport.c:685:19: warning: variable 'xprt' s=
et=20
but not used [-Wunused-but-set-variable]
fs/nilfs2/dat.c: In function 'nilfs_dat_prepare_end':
fs/nilfs2/dat.c:152:8: warning: variable 'start' set but not used [-Wunused-
but-set-variable]
net/wireless/reg.c: In function 'freq_reg_info_regd':
net/wireless/reg.c:676:38: warning: variable 'pr' set but not used [-Wunuse=
d-
but-set-variable]
drivers/isdn/hisax/l3dss1.c: In function 'dss1up':
drivers/isdn/hisax/l3dss1.c:2946:17: warning: variable 'cause' set but not=
=20
used [-Wunused-but-set-variable]
drivers/isdn/hisax/l3ni1.c: In function 'ni1up':
drivers/isdn/hisax/l3ni1.c:2886:17: warning: variable 'cause' set but not u=
sed=20
[-Wunused-but-set-variable]
net/sunrpc/xprtrdma/verbs.c: In function 'rpcrdma_deregister_external':
net/sunrpc/xprtrdma/verbs.c:1799:29: warning: variable 'rc' set but not use=
d=20
[-Wunused-but-set-variable]
drivers/isdn/i4l/isdn_common.c: In function 'isdn_capi_rec_hl_msg':
drivers/isdn/i4l/isdn_common.c:405:6: warning: variable 'ch' set but not us=
ed=20
[-Wunused-but-set-variable]
drivers/isdn/i4l/isdn_common.c: In function 'isdn_ioctl':
drivers/isdn/i4l/isdn_common.c:1281:6: warning: variable 'chidx' set but no=
t=20
used [-Wunused-but-set-variable]
drivers/gpu/drm/radeon/evergreen_blit_kms.c: In function=20
'evergreen_blit_done_copy':
drivers/gpu/drm/radeon/evergreen_blit_kms.c:710:6: warning: variable 'r' se=
t=20
but not used [-Wunused-but-set-variable]
net/wireless/lib80211_crypt_wep.c: In function 'lib80211_wep_build_iv':
net/wireless/lib80211_crypt_wep.c:99:12: warning: variable 'len' set but no=
t=20
used [-Wunused-but-set-variable]
fs/nilfs2/segment.c: In function 'nilfs_segctor_do_immediate_flush':
fs/nilfs2/segment.c:2523:6: warning: variable 'err' set but not used [-
Wunused-but-set-variable]
fs/nilfs2/sufile.c: In function 'nilfs_sufile_alloc':
fs/nilfs2/sufile.c:275:27: warning: variable 'ncleansegs' set but not used =
[-
Wunused-but-set-variable]
drivers/isdn/hisax/arcofi.c: In function 'send_arcofi':
drivers/isdn/hisax/arcofi.c:33:9: warning: variable 'val' set but not used =
[-
Wunused-but-set-variable]
fs/ocfs2/alloc.c: In function 'ocfs2_unlink_subtree':
fs/ocfs2/alloc.c:2632:28: warning: variable 'el' set but not used [-Wunused-
but-set-variable]
fs/ocfs2/aops.c: In function 'ocfs2_direct_IO_get_blocks':
fs/ocfs2/aops.c:512:15: warning: variable 'inode_blocks' set but not used [-
Wunused-but-set-variable]
fs/ocfs2/alloc.c: In function 'ocfs2_adjust_rightmost_records':
fs/ocfs2/alloc.c:3923:6: warning: variable 'ret' set but not used [-Wunused-
but-set-variable]
fs/ocfs2/alloc.c: In function 'ocfs2_split_extent':
fs/ocfs2/alloc.c:5016:28: warning: variable 'rightmost_el' set but not used=
 [-
Wunused-but-set-variable]
fs/ocfs2/alloc.c: In function 'ocfs2_truncate_rec':
fs/ocfs2/alloc.c:5300:6: warning: variable 'wants_rotate' set but not used =
[-
Wunused-but-set-variable]
drivers/gpu/drm/radeon/r600_cs.c: In function 'r600_cs_track_validate_cb':
drivers/gpu/drm/radeon/r600_cs.c:237:31: warning: variable 'size' set but n=
ot=20
used [-Wunused-but-set-variable]
drivers/gpu/drm/radeon/r600_cs.c: In function 'r600_cs_track_check':
drivers/gpu/drm/radeon/r600_cs.c:377:28: warning: variable 'size' set but n=
ot=20
used [-Wunused-but-set-variable]
In file included from drivers/isdn/hisax/elsa.c:138:0:
drivers/isdn/hisax/elsa_ser.c: In function 'change_speed':
drivers/isdn/hisax/elsa_ser.c:112:6: warning: variable 'bits' set but not u=
sed=20
[-Wunused-but-set-variable]
drivers/isdn/mISDN/socket.c: In function 'data_sock_getsockopt':
drivers/isdn/mISDN/socket.c:455:6: warning: variable 'len' set but not used=
 [-
Wunused-but-set-variable]
drivers/gpu/drm/radeon/evergreen_cs.c: In function 'evergreen_packet3_check=
':
drivers/gpu/drm/radeon/evergreen_cs.c:931:29: warning: variable 'track' set=
=20
but not used [-Wunused-but-set-variable]
fs/nilfs2/alloc.c: In function 'nilfs_palloc_prepare_alloc_entry':
fs/nilfs2/alloc.c:414:38: warning: variable 'groups_per_desc_block' set but=
=20
not used [-Wunused-but-set-variable]
drivers/isdn/hisax/ipacx.c: In function 'dch_l2l1':
drivers/isdn/hisax/ipacx.c:99:19: warning: variable 'cda2_cr' set but not u=
sed=20
[-Wunused-but-set-variable]
drivers/md/raid0.c: In function 'dump_zones':
drivers/md/raid0.c:67:12: warning: variable 'h' set but not used [-Wunused-
but-set-variable]
drivers/md/raid10.c: In function 'sync_request':
drivers/md/raid10.c:1821:6: warning: variable 'disk' set but not used [-
Wunused-but-set-variable]
drivers/md/dm-log-userspace-base.c: In function 'userspace_set_region_sync':
drivers/md/dm-log-userspace-base.c:593:6: warning: variable 'r' set but not=
=20
used [-Wunused-but-set-variable]
drivers/media/common/saa7146_video.c: In function 'video_close':
drivers/media/common/saa7146_video.c:1350:6: warning: variable 'err' set bu=
t=20
not used [-Wunused-but-set-variable]
drivers/media/common/tuners/mt20xx.c: In function 'mt2050_set_antenna':
drivers/media/common/tuners/mt20xx.c:433:6: warning: variable 'ret' set but=
=20
not used [-Wunused-but-set-variable]
drivers/media/common/tuners/mt20xx.c: In function 'mt2050_init':
drivers/media/common/tuners/mt20xx.c:577:6: warning: variable 'ret' set but=
=20
not used [-Wunused-but-set-variable]
drivers/md/raid5.c: In function 'make_request':
drivers/md/raid5.c:4011:14: warning: variable 'data_disks' set but not used=
 [-
Wunused-but-set-variable]
drivers/isdn/mISDN/dsp_pipeline.c: In function 'dsp_pipeline_build':
drivers/isdn/mISDN/dsp_pipeline.c:237:11: warning: variable 'incomplete' se=
t=20
but not used [-Wunused-but-set-variable]
drivers/isdn/hisax/jade.c: In function 'JadeVersion':
drivers/isdn/hisax/jade.c:26:13: warning: variable 'i' set but not used [-
Wunused-but-set-variable]
drivers/media/common/tuners/mxl5005s.c: In function 'MXL_TuneRF':
drivers/media/common/tuners/mxl5005s.c:2327:6: warning: variable 'Xtal_Int'=
=20
set but not used [-Wunused-but-set-variable]
drivers/isdn/hisax/elsa_cs.c: In function 'elsa_cs_config':
drivers/isdn/hisax/elsa_cs.c:132:19: warning: variable 'dev' set but not us=
ed=20
[-Wunused-but-set-variable]
drivers/isdn/hisax/teles_cs.c: In function 'teles_cs_config':
drivers/isdn/hisax/teles_cs.c:114:19: warning: variable 'dev' set but not u=
sed=20
[-Wunused-but-set-variable]
drivers/message/fusion/mptbase.c: In function 'GetIocFacts':
drivers/message/fusion/mptbase.c:3013:9: warning: variable 'status' set but=
=20
not used [-Wunused-but-set-variable]
fs/ocfs2/dir.c: In function 'ocfs2_find_entry_el':
fs/ocfs2/dir.c:707:18: warning: variable 'err' set but not used [-Wunused-b=
ut-
set-variable]
drivers/isdn/hisax/hisax_isac.c: In function 'isac_version':
drivers/isdn/hisax/hisax_isac.c:444:6: warning: variable 'val' set but not=
=20
used [-Wunused-but-set-variable]
drivers/isdn/hisax/hisax_isac.c: In function 'isac_setup':
drivers/isdn/hisax/hisax_isac.c:774:11: warning: variable 'eval' set but no=
t=20
used [-Wunused-but-set-variable]
fs/ocfs2/dir.c: In function 'ocfs2_dx_dir_transfer_leaf':
fs/ocfs2/dir.c:3751:42: warning: variable 'new_list' set but not used [-
Wunused-but-set-variable]
drivers/message/fusion/mptscsih.c: In function 'mptscsih_IssueTaskMgmt':
drivers/message/fusion/mptscsih.c:1615:17: warning: variable 'timeleft' set=
=20
but not used [-Wunused-but-set-variable]
drivers/message/fusion/mptspi.c: In function 'mptspi_writeIOCPage4':
drivers/message/fusion/mptspi.c:262:9: warning: variable 'frameOffset' set =
but=20
not used [-Wunused-but-set-variable]
drivers/message/fusion/mptspi.c:261:9: warning: variable 'req_idx' set but =
not=20
used [-Wunused-but-set-variable]
drivers/misc/apds990x.c:612:12: warning: 'apds990x_chip_on' defined but not=
=20
used [-Wunused-function]
drivers/memstick/host/tifm_ms.c: In function 'tifm_ms_issue_cmd':
drivers/memstick/host/tifm_ms.c:256:17: warning: variable 'data' set but no=
t=20
used [-Wunused-but-set-variable]
drivers/memstick/host/jmb38x_ms.c: In function 'jmb38x_ms_issue_cmd':
drivers/memstick/host/jmb38x_ms.c:369:17: warning: variable 'data' set but =
not=20
used [-Wunused-but-set-variable]
fs/sysv/inode.c: In function '__sysv_write_inode':
fs/sysv/inode.c:259:6: warning: variable 'err' set but not used [-Wunused-b=
ut-
set-variable]
fs/reiserfs/do_balan.c: In function 'balance_leaf':
fs/reiserfs/do_balan.c:331:10: warning: variable 'version' set but not used=
 [-
Wunused-but-set-variable]
fs/reiserfs/do_balan.c:754:10: warning: variable 'version' set but not used=
 [-
Wunused-but-set-variable]
fs/reiserfs/do_balan.c:1183:10: warning: variable 'version' set but not use=
d=20
[-Wunused-but-set-variable]
fs/reiserfs/do_balan.c:1425:10: warning: variable 'leaf_mi' set but not use=
d=20
[-Wunused-but-set-variable]
fs/ubifs/super.c: In function 'ubifs_umount':
fs/ubifs/super.c:1499:2: warning: statement with no effect [-Wunused-value]
drivers/message/fusion/mptsas.c: In function=20
'mptsas_add_device_component_starget':
drivers/message/fusion/mptsas.c:751:14: warning: variable 'vtarget' set but=
=20
not used [-Wunused-but-set-variable]
drivers/message/fusion/mptctl.c: In function 'mptctl_do_taskmgmt':
drivers/message/fusion/mptctl.c:324:17: warning: variable 'time_count' set =
but=20
not used [-Wunused-but-set-variable]
drivers/message/fusion/mptctl.c: In function 'mptctl_gettargetinfo':
drivers/message/fusion/mptctl.c:1412:7: warning: variable 'port' set but no=
t=20
used [-Wunused-but-set-variable]
drivers/message/fusion/mptctl.c: In function 'mptctl_hp_hostinfo':
drivers/message/fusion/mptctl.c:2444:8: warning: variable 'retval' set but =
not=20
used [-Wunused-but-set-variable]
drivers/message/fusion/mptsas.c: In function 'mptsas_reprobe_lun':
drivers/message/fusion/mptsas.c:4201:6: warning: variable 'rc' set but not=
=20
used [-Wunused-but-set-variable]
drivers/message/fusion/mptsas.c: In function 'mptsas_issue_tm':
drivers/message/fusion/mptsas.c:4759:17: warning: variable 'timeleft' set b=
ut=20
not used [-Wunused-but-set-variable]
drivers/message/fusion/mptlan.c: In function 'mpt_lan_receive_post_reply':
drivers/message/fusion/mptlan.c:975:16: warning: variable 'offset' set but =
not=20
used [-Wunused-but-set-variable]
fs/udf/balloc.c: In function 'udf_bitmap_prealloc_blocks':
fs/udf/balloc.c:183:6: warning: variable 'nr_groups' set but not used [-
Wunused-but-set-variable]
fs/udf/balloc.c:182:31: warning: variable 'group_start' set but not used [-
Wunused-but-set-variable]
fs/udf/balloc.c: In function 'udf_table_free_blocks':
fs/udf/balloc.c:365:6: warning: variable 'i' set but not used [-Wunused-but-
set-variable]
drivers/media/dvb/b2c2/flexcop-misc.c: In function 'flexcop_dump_reg':
drivers/media/dvb/b2c2/flexcop-misc.c:78:20: warning: variable 'v' set but =
not=20
used [-Wunused-but-set-variable]
fs/udf/inode.c: In function 'inode_getblk':
fs/udf/inode.c:464:18: warning: variable 'last_block' set but not used [-
Wunused-but-set-variable]
fs/udf/inode.c: In function 'udf_fill_inode':
fs/udf/inode.c:1141:6: warning: variable 'offset' set but not used [-Wunuse=
d-
but-set-variable]
fs/reiserfs/file.c: In function 'reiserfs_file_write':
fs/reiserfs/file.c:267:37: warning: variable 'th' set but not used [-Wunuse=
d-
but-set-variable]
fs/reiserfs/fix_node.c: In function 'get_num_ver':
fs/reiserfs/fix_node.c:371:6: warning: variable 'cur_free' set but not used=
 [-
Wunused-but-set-variable]
fs/reiserfs/fix_node.c: In function 'dc_check_balance_internal':
fs/reiserfs/fix_node.c:1569:6: warning: variable 'maxsize' set but not used=
 [-
Wunused-but-set-variable]
fs/reiserfs/fix_node.c: In function 'dc_check_balance_leaf':
fs/reiserfs/fix_node.c:1752:6: warning: variable 'maxsize' set but not used=
 [-
Wunused-but-set-variable]
fs/reiserfs/fix_node.c:1750:6: warning: variable 'levbytes' set but not use=
d [-
Wunused-but-set-variable]
fs/ubifs/tnc_commit.c: In function 'write_index':
fs/ubifs/tnc_commit.c:834:15: warning: variable 'offs' set but not used [-
Wunused-but-set-variable]
drivers/media/dvb/bt8xx/dst_ca.c: In function 'ca_send_message':
drivers/media/dvb/bt8xx/dst_ca.c:480:15: warning: variable=20
'ca_message_header_len' set but not used [-Wunused-but-set-variable]
fs/ubifs/lpt_commit.c: In function 'layout_cnodes':
fs/ubifs/lpt_commit.c:211:3: warning: statement with no effect [-Wunused-va=
lue]
fs/ubifs/lpt_commit.c:219:3: warning: statement with no effect [-Wunused-va=
lue]
fs/ubifs/lpt_commit.c:233:4: warning: statement with no effect [-Wunused-va=
lue]
fs/ubifs/lpt_commit.c:246:5: warning: statement with no effect [-Wunused-va=
lue]
fs/ubifs/lpt_commit.c:254:5: warning: statement with no effect [-Wunused-va=
lue]
fs/ubifs/lpt_commit.c:267:3: warning: statement with no effect [-Wunused-va=
lue]
fs/ubifs/lpt_commit.c:276:4: warning: statement with no effect [-Wunused-va=
lue]
fs/ubifs/lpt_commit.c:288:3: warning: statement with no effect [-Wunused-va=
lue]
fs/ubifs/lpt_commit.c:296:4: warning: statement with no effect [-Wunused-va=
lue]
fs/ubifs/lpt_commit.c:308:3: warning: statement with no effect [-Wunused-va=
lue]
fs/ubifs/lpt_commit.c:313:2: warning: statement with no effect [-Wunused-va=
lue]
fs/ubifs/lpt_commit.c: In function 'write_cnodes':
fs/ubifs/lpt_commit.c:395:3: warning: statement with no effect [-Wunused-va=
lue]
fs/ubifs/lpt_commit.c:402:3: warning: statement with no effect [-Wunused-va=
lue]
fs/ubifs/lpt_commit.c:421:4: warning: statement with no effect [-Wunused-va=
lue]
fs/ubifs/lpt_commit.c:436:5: warning: statement with no effect [-Wunused-va=
lue]
fs/ubifs/lpt_commit.c:443:5: warning: statement with no effect [-Wunused-va=
lue]
fs/ubifs/lpt_commit.c:465:3: warning: statement with no effect [-Wunused-va=
lue]
fs/ubifs/lpt_commit.c:479:4: warning: statement with no effect [-Wunused-va=
lue]
fs/ubifs/lpt_commit.c:493:3: warning: statement with no effect [-Wunused-va=
lue]
fs/ubifs/lpt_commit.c:506:4: warning: statement with no effect [-Wunused-va=
lue]
fs/ubifs/lpt_commit.c:520:3: warning: statement with no effect [-Wunused-va=
lue]
fs/ubifs/lpt_commit.c:531:2: warning: statement with no effect [-Wunused-va=
lue]
fs/ocfs2/localalloc.c: In function 'ocfs2_local_alloc_find_clear_bits':
fs/ocfs2/localalloc.c:817:40: warning: variable 'lastzero' set but not used=
 [-
Wunused-but-set-variable]
fs/reiserfs/prints.c: In function 'check_internal_block_head':
fs/reiserfs/prints.c:722:21: warning: variable 'blkh' set but not used [-
Wunused-but-set-variable]
fs/reiserfs/lbalance.c: In function 'leaf_copy_items':
fs/reiserfs/lbalance.c:478:22: warning: variable 'dest' set but not used [-
Wunused-but-set-variable]
fs/reiserfs/objectid.c: In function 'reiserfs_convert_objectid_map_v1':
fs/reiserfs/objectid.c:173:25: warning: variable 'new_objectid_map' set but=
=20
not used [-Wunused-but-set-variable]
fs/reiserfs/lbalance.c: In function 'leaf_paste_entries':
fs/reiserfs/lbalance.c:1210:9: warning: variable 'old_entry_num' set but no=
t=20
used [-Wunused-but-set-variable]
fs/reiserfs/stree.c: In function 'search_by_key':
fs/reiserfs/stree.c:602:6: warning: variable 'right_neighbor_of_leaf_node' =
set=20
but not used [-Wunused-but-set-variable]
fs/reiserfs/journal.c: In function 'flush_older_commits':
fs/reiserfs/journal.c:895:15: warning: variable 'first_trans_id' set but no=
t=20
used [-Wunused-but-set-variable]
fs/reiserfs/journal.c: In function 'flush_journal_list':
fs/reiserfs/journal.c:1346:38: warning: variable 'last' set but not used [-
Wunused-but-set-variable]
fs/reiserfs/journal.c: In function 'flush_used_journal_lists':
fs/reiserfs/journal.c:1787:6: warning: variable 'ret' set but not used [-
Wunused-but-set-variable]
fs/reiserfs/journal.c: In function 'do_journal_release':
fs/reiserfs/journal.c:1895:6: warning: variable 'flushed' set but not used =
[-
Wunused-but-set-variable]
fs/reiserfs/journal.c: In function 'do_journal_end':
fs/reiserfs/journal.c:3947:6: warning: variable 'old_start' set but not use=
d=20
[-Wunused-but-set-variable]
drivers/media/dvb/dvb-usb/af9005-fe.c: In function 'af9005_write_word_agc':
drivers/media/dvb/dvb-usb/af9005-fe.c:66:5: warning: variable 'temp' set bu=
t=20
not used [-Wunused-but-set-variable]
drivers/media/dvb/dvb-core/dvb_frontend.c: In function 'dvb_frontend_thread=
':
drivers/media/dvb/dvb-core/dvb_frontend.c:538:16: warning: variable 'timeou=
t'=20
set but not used [-Wunused-but-set-variable]
drivers/mtd/nftlmount.c: In function 'NFTL_mount':
drivers/mtd/nftlmount.c:567:62: warning: variable 'nb_erases' set but not u=
sed=20
[-Wunused-but-set-variable]
fs/ocfs2/namei.c: In function 'ocfs2_create_inode_in_orphan':
fs/ocfs2/namei.c:2232:23: warning: variable 'di' set but not used [-Wunused-
but-set-variable]
fs/ocfs2/refcounttree.c: In function 'ocfs2_create_reflink_node':
fs/ocfs2/refcounttree.c:4167:31: warning: variable 'rb' set but not used [-
Wunused-but-set-variable]
fs/ufs/balloc.c: In function 'ufs_free_fragments':
fs/ufs/balloc.c:41:33: warning: variable 'usb1' set but not used [-Wunused-
but-set-variable]
fs/ufs/balloc.c: In function 'ufs_free_blocks':
fs/ufs/balloc.c:138:33: warning: variable 'usb1' set but not used [-Wunused-
but-set-variable]
fs/ufs/balloc.c: In function 'ufs_add_fragments':
fs/ufs/balloc.c:501:33: warning: variable 'usb1' set but not used [-Wunused-
but-set-variable]
fs/ufs/balloc.c: In function 'ufs_alloc_fragments':
fs/ufs/balloc.c:579:33: warning: variable 'usb1' set but not used [-Wunused-
but-set-variable]
fs/ufs/balloc.c: In function 'ufs_alloccg_block':
fs/ufs/balloc.c:692:33: warning: variable 'usb1' set but not used [-Wunused-
but-set-variable]
fs/ufs/balloc.c: In function 'ufs_bitmap_search':
fs/ufs/balloc.c:797:29: warning: variable 'ucg' set but not used [-Wunused-
but-set-variable]
fs/ufs/balloc.c:796:32: warning: variable 'usb1' set but not used [-Wunused-
but-set-variable]
drivers/media/dvb/dvb-usb/az6027.c: In function 'az6027_set_voltage':
drivers/media/dvb/dvb-usb/az6027.c:785:6: warning: variable 'ret' set but n=
ot=20
used [-Wunused-but-set-variable]
drivers/media/dvb/dvb-usb/az6027.c: In function 'az6027_i2c_xfer':
drivers/media/dvb/dvb-usb/az6027.c:957:6: warning: variable 'ret' set but n=
ot=20
used [-Wunused-but-set-variable]
fs/ufs/ialloc.c: In function 'ufs_free_inode':
fs/ufs/ialloc.c:60:33: warning: variable 'usb1' set but not used [-Wunused-
but-set-variable]
fs/ufs/ialloc.c: In function 'ufs_new_inode':
fs/ufs/ialloc.c:178:33: warning: variable 'usb1' set but not used [-Wunused-
but-set-variable]
drivers/mtd/chips/cfi_cmdset_0002.c: In function 'do_read_secsi_onechip':
drivers/mtd/chips/cfi_cmdset_0002.c:1056:16: warning: variable 'timeo' set =
but=20
not used [-Wunused-but-set-variable]
drivers/mtd/chips/cfi_cmdset_0020.c: In function 'cfi_staa_write_buffers':
include/linux/mtd/map.h:330:11: warning: 'r.x[0]' may be used uninitialized=
 in=20
this function [-Wuninitialized]
drivers/media/dvb/dvb-usb/dib0700_core.c: In function=20
'dib0700_rc_urb_completion':
drivers/media/dvb/dvb-usb/dib0700_core.c:529:24: warning: variable 'st' set=
=20
but not used [-Wunused-but-set-variable]
drivers/mmc/host/sdhci-pci.c: In function 'sdhci_pci_probe_slot':
drivers/mmc/host/sdhci-pci.c:904:18: warning: variable 'addr' set but not u=
sed=20
[-Wunused-but-set-variable]
drivers/mmc/host/via-sdmmc.c: In function 'via_reset_pcictrl':
drivers/mmc/host/via-sdmmc.c:805:16: warning: variable 'addrbase' set but n=
ot=20
used [-Wunused-but-set-variable]
drivers/mmc/host/cb710-mmc.c: In function 'cb710_wait_while_busy':
drivers/mmc/host/cb710-mmc.c:182:6: warning: variable 'err' set but not use=
d=20
[-Wunused-but-set-variable]
fs/ufs/inode.c: In function 'ufs_getfrag_block':
fs/ufs/inode.c:420:6: warning: variable 'ret' set but not used [-Wunused-bu=
t-
set-variable]
drivers/media/radio/radio-si4713.c: In function 'radio_si4713_querycap':
drivers/media/radio/radio-si4713.c:95:30: warning: variable 'rsdev' set but=
=20
not used [-Wunused-but-set-variable]
drivers/mtd/chips/cfi_cmdset_0002.c: In function 'cfi_amdstd_write_words':
include/linux/mtd/map.h:330:11: warning: 'r.x[0]' may be used uninitialized=
 in=20
this function [-Wuninitialized]
drivers/mtd/chips/cfi_cmdset_0002.c: In function 'cfi_amdstd_write_buffers':
include/linux/mtd/map.h:330:11: warning: 'r.x[0]' may be used uninitialized=
 in=20
this function [-Wuninitialized]
drivers/net/ipg.c: In function 'ipg_config_autoneg':
drivers/net/ipg.c:480:6: warning: variable 'asicctrl' set but not used [-
Wunused-but-set-variable]
drivers/mtd/chips/cfi_cmdset_0001.c: In function 'cfi_intelext_write_words':
include/linux/mtd/map.h:330:11: warning: 'r.x[0]' may be used uninitialized=
 in=20
this function [-Wuninitialized]
drivers/media/radio/si470x/radio-si470x-usb.c: In function=20
'si470x_int_in_callback':
drivers/media/radio/si470x/radio-si470x-usb.c:399:16: warning: variable 'bu=
f'=20
set but not used [-Wunused-but-set-variable]
drivers/net/tehuti.c: In function 'bdx_recycle_skb':
drivers/net/tehuti.c:1172:18: warning: variable 'skb' set but not used [-
Wunused-but-set-variable]
fs/ufs/super.c: In function 'ufs_read_cylinder_structures':
fs/ufs/super.c:513:32: warning: variable 'usb3' set but not used [-Wunused-
but-set-variable]
fs/ufs/super.c: In function 'ufs_statfs':
fs/ufs/super.c:1370:33: warning: variable 'usb2' set but not used [-Wunused-
but-set-variable]
fs/ufs/super.c:1369:32: warning: variable 'usb1' set but not used [-Wunused-
but-set-variable]
drivers/media/dvb/dvb-usb/dw2102.c: In function 'dw2102_i2c_transfer':
drivers/media/dvb/dvb-usb/dw2102.c:125:13: warning: variable 'ret' set but =
not=20
used [-Wunused-but-set-variable]
drivers/media/dvb/dvb-usb/dw2102.c: In function 'dw2102_serit_i2c_transfer':
drivers/media/dvb/dvb-usb/dw2102.c:199:6: warning: variable 'ret' set but n=
ot=20
used [-Wunused-but-set-variable]
drivers/media/dvb/dvb-usb/dw2102.c: In function 'dw2102_earda_i2c_transfer':
drivers/media/dvb/dvb-usb/dw2102.c:254:6: warning: variable 'ret' set but n=
ot=20
used [-Wunused-but-set-variable]
drivers/media/dvb/dvb-usb/dw2102.c: In function 'dw2104_i2c_transfer':
drivers/media/dvb/dvb-usb/dw2102.c:327:6: warning: variable 'ret' set but n=
ot=20
used [-Wunused-but-set-variable]
drivers/media/dvb/dvb-usb/dw2102.c: In function 'dw3101_i2c_transfer':
drivers/media/dvb/dvb-usb/dw2102.c:410:6: warning: variable 'ret' set but n=
ot=20
used [-Wunused-but-set-variable]
drivers/media/dvb/dvb-usb/dw2102.c: In function 's6x0_i2c_transfer':
drivers/media/dvb/dvb-usb/dw2102.c:474:6: warning: variable 'ret' set but n=
ot=20
used [-Wunused-but-set-variable]
drivers/media/dvb/dvb-usb/dw2102.c: In function 'dw210x_read_mac_address':
drivers/media/dvb/dvb-usb/dw2102.c:611:18: warning: variable 'eepromline' s=
et=20
but not used [-Wunused-but-set-variable]
drivers/media/dvb/dvb-usb/dw2102.c: In function 's6x0_read_mac_address':
drivers/media/dvb/dvb-usb/dw2102.c:635:18: warning: variable 'eepromline' s=
et=20
but not used [-Wunused-but-set-variable]
drivers/mtd/devices/pmc551.c: In function 'pmc551_erase':
drivers/mtd/devices/pmc551.c:107:15: warning: variable 'soff_lo' set but no=
t=20
used [-Wunused-but-set-variable]
drivers/mtd/devices/pmc551.c: In function 'pmc551_read':
drivers/mtd/devices/pmc551.c:220:15: warning: variable 'soff_lo' set but no=
t=20
used [-Wunused-but-set-variable]
drivers/mtd/devices/pmc551.c: In function 'pmc551_write':
drivers/mtd/devices/pmc551.c:287:15: warning: variable 'soff_lo' set but no=
t=20
used [-Wunused-but-set-variable]
drivers/media/dvb/dvb-usb/lmedm04.c: In function 'lme2510_probe':
drivers/media/dvb/dvb-usb/lmedm04.c:927:6: warning: variable 'ret' set but =
not=20
used [-Wunused-but-set-variable]
drivers/media/rc/imon.c: In function 'imon_incoming_packet':
drivers/media/rc/imon.c:1468:7: warning: variable 'norelease' set but not u=
sed=20
[-Wunused-but-set-variable]
drivers/media/rc/imon.c: In function 'imon_probe':
drivers/media/rc/imon.c:2248:13: warning: variable 'code_length' set but no=
t=20
used [-Wunused-but-set-variable]
In file included from drivers/mtd/lpddr/qinfo_probe.c:31:0:
include/linux/mtd/pfow.h: In function 'send_pfow_command':
include/linux/mtd/pfow.h:104:6: warning: variable 'chipnum' set but not use=
d=20
[-Wunused-but-set-variable]
In file included from drivers/mtd/lpddr/lpddr_cmds.c:27:0:
include/linux/mtd/pfow.h: In function 'send_pfow_command':
include/linux/mtd/pfow.h:104:6: warning: variable 'chipnum' set but not use=
d=20
[-Wunused-but-set-variable]
drivers/mtd/nand/nand_bbt.c: In function 'search_bbt':
drivers/mtd/nand/nand_bbt.c:600:6: warning: variable 'bits' set but not use=
d=20
[-Wunused-but-set-variable]
fs/ocfs2/suballoc.c: In function '_ocfs2_free_clusters':
fs/ocfs2/suballoc.c:2555:23: warning: variable 'fe' set but not used [-
Wunused-but-set-variable]
drivers/mtd/nand/diskonchip.c:56:2: warning: #warning Unknown architecture =
for=20
DiskOnChip. No default probe locations defined [-Wcpp]
drivers/mtd/nand/diskonchip.c: In function 'DoC_Delay':
drivers/mtd/nand/diskonchip.c:225:16: warning: variable 'dummy' set but not=
=20
used [-Wunused-but-set-variable]
drivers/mtd/nand/diskonchip.c: In function 'doc200x_calculate_ecc':
drivers/mtd/nand/diskonchip.c:910:6: warning: variable 'emptymatch' set but=
=20
not used [-Wunused-but-set-variable]
drivers/media/video/tvaudio.c: In function 'tvaudio_s_ctrl':
drivers/media/video/tvaudio.c:1697:15: warning: variable 'balance' set but =
not=20
used [-Wunused-but-set-variable]
drivers/media/video/tvaudio.c:1697:7: warning: variable 'volume' set but no=
t=20
used [-Wunused-but-set-variable]
drivers/nfc/pn544.c: In function 'pn544_ioctl':
drivers/nfc/pn544.c:511:34: warning: variable 'pdata' set but not used [-
Wunused-but-set-variable]
drivers/mtd/ubi/vtbl.c: In function 'create_vtbl':
drivers/mtd/ubi/vtbl.c:311:33: warning: variable 'old_seb' set but not used=
 [-
Wunused-but-set-variable]
drivers/net/3c59x.c: In function 'vortex_up':
drivers/net/3c59x.c:1565:9: warning: variable 'mii_reg1' set but not used [-
Wunused-but-set-variable]
drivers/net/3c59x.c: In function 'vortex_eisa_cleanup':
drivers/net/3c59x.c:3293:25: warning: variable 'vp' set but not used [-
Wunused-but-set-variable]
fs/ocfs2/xattr.c: In function 'ocfs2_xattr_bucket_find':
fs/ocfs2/xattr.c:3804:6: warning: variable 'last_hash' set but not used [-
Wunused-but-set-variable]
fs/xfs/quota/xfs_qm_syscalls.c: In function 'xfs_qm_scall_quotaon':
fs/xfs/quota/xfs_qm_syscalls.c:321:8: warning: variable 'accflags' set but =
not=20
used [-Wunused-but-set-variable]
drivers/media/dvb/frontends/stb0899_drv.c: In function 'stb0899_init_calc':
drivers/media/dvb/frontends/stb0899_drv.c:640:5: warning: variable 'agc1cn'=
=20
set but not used [-Wunused-but-set-variable]
drivers/media/dvb/frontends/stb0899_drv.c: In function 'stb0899_diseqc_init=
':
drivers/media/dvb/frontends/stb0899_drv.c:830:13: warning: variable 'f22_rx=
'=20
set but not used [-Wunused-but-set-variable]
drivers/media/dvb/frontends/stb0899_drv.c:826:31: warning: variable 'tx_dat=
a'=20
set but not used [-Wunused-but-set-variable]
drivers/media/dvb/mantis/hopper_cards.c: In function 'hopper_irq_handler':
drivers/media/dvb/mantis/hopper_cards.c:68:37: warning: variable 'mstat' se=
t=20
but not used [-Wunused-but-set-variable]
drivers/media/dvb/mantis/mantis_cards.c: In function 'mantis_irq_handler':
drivers/media/dvb/mantis/mantis_cards.c:76:37: warning: variable 'mstat' se=
t=20
but not used [-Wunused-but-set-variable]
drivers/media/video/mt9v011.c: In function 'set_balance':
drivers/media/video/mt9v011.c:186:19: warning: variable 'green2_gain' set b=
ut=20
not used [-Wunused-but-set-variable]
drivers/media/dvb/frontends/stv0900_sw.c: In function=20
'stv0900_track_optimization':
drivers/media/dvb/frontends/stv0900_sw.c:838:26: warning: variable 'rolloff=
'=20
set but not used [-Wunused-but-set-variable]
drivers/net/tlan.c: In function 'TLan_EisaProbe':
drivers/net/tlan.c:745:7: warning: variable 'rc' set but not used [-Wunused-
but-set-variable]
drivers/net/e100.c: In function 'e100_diag_test':
drivers/net/e100.c:2573:9: warning: variable 'err' set but not used [-Wunus=
ed-
but-set-variable]
fs/xfs/quota/xfs_qm.c: In function 'xfs_qm_dqflush_all':
fs/xfs/quota/xfs_qm.c:467:8: warning: variable 'niters' set but not used [-
Wunused-but-set-variable]
fs/xfs/quota/xfs_qm.c: In function 'xfs_qm_dqiter_bufs':
fs/xfs/quota/xfs_qm.c:1328:7: warning: variable 'incr' set but not used [-
Wunused-but-set-variable]
fs/xfs/quota/xfs_qm.c:1327:7: warning: variable 'notcommitted' set but not=
=20
used [-Wunused-but-set-variable]
drivers/media/video/ov2640.c: In function 'ov2640_try_fmt':
drivers/media/video/ov2640.c:969:32: warning: variable 'win' set but not us=
ed=20
[-Wunused-but-set-variable]
drivers/media/dvb/mantis/mantis_dma.c: In function 'mantis_dma_stop':
drivers/media/dvb/mantis/mantis_dma.c:224:16: warning: variable 'mask' set =
but=20
not used [-Wunused-but-set-variable]
drivers/media/dvb/mantis/mantis_dma.c:224:6: warning: variable 'stat' set b=
ut=20
not used [-Wunused-but-set-variable]
drivers/net/sis900.c: In function 'sis900_set_capability':
drivers/net/sis900.c:771:6: warning: variable 'status' set but not used [-
Wunused-but-set-variable]
drivers/media/dvb/frontends/stb6100.c: In function 'stb6100_read_reg':
drivers/media/dvb/frontends/stb6100.c:161:6: warning: variable 'rc' set but=
=20
not used [-Wunused-but-set-variable]
fs/ocfs2/cluster/tcp.c:213:16: warning: 'o2net_get_func_run_time' defined b=
ut=20
not used [-Wunused-function]
drivers/media/dvb/frontends/cx24110.c: In function 'cx24110_read_ucblocks':
drivers/media/dvb/frontends/cx24110.c:515:6: warning: variable 'lastbyer' s=
et=20
but not used [-Wunused-but-set-variable]
drivers/net/acenic.c: In function 'ace_rx_int':
drivers/net/acenic.c:1965:19: warning: variable 'rxdesc' set but not used [-
Wunused-but-set-variable]
drivers/media/dvb/mantis/mantis_evm.c: In function 'mantis_hifevm_work':
drivers/media/dvb/mantis/mantis_evm.c:43:17: warning: variable 'gpif_mask' =
set=20
but not used [-Wunused-but-set-variable]
drivers/net/ns83820.c: In function 'phy_intr':
drivers/net/ns83820.c:638:6: warning: variable 'tbisr' set but not used [-
Wunused-but-set-variable]
drivers/net/ns83820.c: In function 'ns83820_get_settings':
drivers/net/ns83820.c:1248:11: warning: variable 'tanar' set but not used [-
Wunused-but-set-variable]
fs/ocfs2/dlm/dlmast.c: In function 'dlm_do_local_ast':
fs/ocfs2/dlm/dlmast.c:227:25: warning: variable 'lksb' set but not used [-
Wunused-but-set-variable]
drivers/media/video/videobuf-dvb.c: In function 'videobuf_dvb_thread':
drivers/media/video/videobuf-dvb.c:48:6: warning: variable 'err' set but no=
t=20
used [-Wunused-but-set-variable]
fs/ocfs2/dlmfs/dlmfs.c: In function 'dlmfs_file_release':
fs/ocfs2/dlmfs/dlmfs.c:183:13: warning: variable 'status' set but not used =
[-
Wunused-but-set-variable]
fs/ocfs2/dlmfs/dlmfs.c: In function 'dlmfs_get_root_inode':
fs/ocfs2/dlmfs/dlmfs.c:405:30: warning: variable 'ip' set but not used [-
Wunused-but-set-variable]
drivers/media/video/zr364xx.c: In function 'zr364xx_fillbuff':
drivers/media/video/zr364xx.c:512:25: warning: variable 'frm' set but not u=
sed=20
[-Wunused-but-set-variable]
drivers/net/cnic.c: In function 'cnic_bnx2x_fcoe_fw_destroy':
drivers/net/cnic.c:2415:28: warning: variable 'req' set but not used [-
Wunused-but-set-variable]
drivers/net/cnic.c: In function 'cnic_cm_open':
drivers/net/cnic.c:3999:2: warning: the comparison will always evaluate as=
=20
'true' for the address of 'cm_ulp_ops' will never be NULL [-Waddress]
drivers/media/video/s2255drv.c: In function 's2255_fillbuff':
drivers/media/video/s2255drv.c:633:23: warning: variable 'frm' set but not=
=20
used [-Wunused-but-set-variable]
drivers/media/video/s2255drv.c: In function 'vidioc_s_fmt_vid_cap':
drivers/media/video/s2255drv.c:986:6: warning: variable 'norm' set but not=
=20
used [-Wunused-but-set-variable]
drivers/media/dvb/siano/smssdio.c: In function 'smssdio_interrupt':
drivers/media/dvb/siano/smssdio.c:116:11: warning: variable 'isr' set but n=
ot=20
used [-Wunused-but-set-variable]
fs/xfs/xfs_bmap.c: In function 'xfs_bmap_rtalloc':
fs/xfs/xfs_bmap.c:2330:18: warning: variable 'atype' set but not used [-
Wunused-but-set-variable]
drivers/media/dvb/frontends/zl10353.c: In function 'zl10353_init':
drivers/media/dvb/frontends/zl10353.c:575:6: warning: variable 'rc' set but=
=20
not used [-Wunused-but-set-variable]
drivers/media/video/au0828/au0828-dvb.c: In function 'urb_completion':
drivers/media/video/au0828/au0828-dvb.c:99:6: warning: variable 'ptr' set b=
ut=20
not used [-Wunused-but-set-variable]
drivers/media/video/au0828/au0828-video.c: In function 'au0828_irq_callback=
':
drivers/media/video/au0828/au0828-video.c:126:6: warning: variable 'rc' set=
=20
but not used [-Wunused-but-set-variable]
drivers/media/video/au0828/au0828-video.c: In function 'au0828_set_format':
drivers/media/video/au0828/au0828-video.c:1180:25: warning: variable=20
'maxheight' set but not used [-Wunused-but-set-variable]
drivers/media/video/au0828/au0828-video.c:1180:15: warning: variable=20
'maxwidth' set but not used [-Wunused-but-set-variable]
drivers/media/dvb/frontends/drx397xD.c: In function 'drx_tune':
drivers/media/dvb/frontends/drx397xD.c:651:9: warning: variable 'b' set but=
=20
not used [-Wunused-but-set-variable]
drivers/media/dvb/frontends/stv0297.c: In function 'stv0297_set_frontend':
drivers/media/dvb/frontends/stv0297.c:416:16: warning: variable 'starttime'=
=20
set but not used [-Wunused-but-set-variable]
drivers/media/video/bt8xx/bttv-input.c: In function 'bttv_rc5_timer_end':
drivers/media/video/bt8xx/bttv-input.c:196:16: warning: variable=20
'current_jiffies' set but not used [-Wunused-but-set-variable]
drivers/media/dvb/frontends/s5h1420.c: In function 's5h1420_set_frontend':
drivers/media/dvb/frontends/s5h1420.c:637:10: warning: variable=20
'clock_settting' set but not used [-Wunused-but-set-variable]
drivers/net/ksz884x.c: In function 'sw_r_table':
drivers/net/ksz884x.c:1685:2: warning: variable 'dummy' set but not used [-
Wunused-but-set-variable]
drivers/net/ksz884x.c: In function 'sw_w_table_64':
drivers/net/ksz884x.c:1716:2: warning: variable 'dummy' set but not used [-
Wunused-but-set-variable]
drivers/net/ksz884x.c: In function 'port_r_mib_cnt':
drivers/net/ksz884x.c:1811:2: warning: variable 'dummy' set but not used [-
Wunused-but-set-variable]
drivers/net/ksz884x.c: In function 'port_r_mib_pkt':
drivers/net/ksz884x.c:1852:3: warning: variable 'dummy' set but not used [-
Wunused-but-set-variable]
drivers/net/ksz884x.c: In function 'port_set_link_speed':
drivers/net/ksz884x.c:3383:24: warning: variable 'info' set but not used [-
Wunused-but-set-variable]
drivers/net/ksz884x.c: In function 'rx_proc':
drivers/net/ksz884x.c:5017:6: warning: variable 'rx_status' set but not use=
d=20
[-Wunused-but-set-variable]
drivers/net/ksz884x.c: In function 'netdev_ioctl':
drivers/net/ksz884x.c:5859:6: warning: variable 'rc' set but not used [-
Wunused-but-set-variable]
drivers/net/ksz884x.c: In function 'netdev_get_ethtool_stats':
drivers/net/ksz884x.c:6536:6: warning: variable 'rc' set but not used [-
Wunused-but-set-variable]
drivers/media/video/cx18/cx18-alsa-main.c: In function 'cx18_alsa_exit':
drivers/media/video/cx18/cx18-alsa-main.c:281:6: warning: variable 'ret' se=
t=20
but not used [-Wunused-but-set-variable]
drivers/media/video/cx18/cx18-alsa-pcm.c: In function=20
'snd_cx18_pcm_capture_open':
drivers/media/video/cx18/cx18-alsa-pcm.c:156:6: warning: variable 'ret' set=
=20
but not used [-Wunused-but-set-variable]
drivers/media/video/cx18/cx18-alsa-pcm.c: In function=20
'snd_cx18_pcm_capture_close':
drivers/media/video/cx18/cx18-alsa-pcm.c:202:6: warning: variable 'ret' set=
=20
but not used [-Wunused-but-set-variable]
drivers/media/video/cx18/cx18-alsa-pcm.c: In function=20
'snd_cx18_pcm_hw_params':
drivers/media/video/cx18/cx18-alsa-pcm.c:255:6: warning: variable 'ret' set=
=20
but not used [-Wunused-but-set-variable]
drivers/media/dvb/frontends/lgdt330x.c: In function 'lgdt330x_read_ucblocks=
':
drivers/media/dvb/frontends/lgdt330x.c:288:6: warning: variable 'err' set b=
ut=20
not used [-Wunused-but-set-variable]
drivers/media/dvb/frontends/lgdt330x.c: In function 'lgdt330x_set_parameter=
s':
drivers/media/dvb/frontends/lgdt330x.c:346:6: warning: variable 'err' set b=
ut=20
not used [-Wunused-but-set-variable]
drivers/net/via-velocity.c: In function 'velocity_set_media_mode':
drivers/net/via-velocity.c:891:6: warning: variable 'curr_status' set but n=
ot=20
used [-Wunused-but-set-variable]
drivers/media/video/cpia2/cpia2_core.c: In function 'cpia2_send_command':
drivers/media/video/cpia2/cpia2_core.c:529:14: warning: variable 'dir' set =
but=20
not used [-Wunused-but-set-variable]
drivers/media/video/cpia2/cpia2_core.c:526:5: warning: variable 'block_inde=
x'=20
set but not used [-Wunused-but-set-variable]
drivers/media/video/cx231xx/cx231xx-audio.c: In function=20
'snd_cx231xx_hw_capture_params':
drivers/media/video/cx231xx/cx231xx-audio.c:510:6: warning: variable 'ret' =
set=20
but not used [-Wunused-but-set-variable]
drivers/media/video/cx231xx/cx231xx-audio.c:509:31: warning: variable 'form=
at'=20
set but not used [-Wunused-but-set-variable]
drivers/media/video/cx231xx/cx231xx-audio.c:509:25: warning: variable 'rate=
'=20
set but not used [-Wunused-but-set-variable]
drivers/media/video/cx231xx/cx231xx-audio.c:509:15: warning: variable=20
'channels' set but not used [-Wunused-but-set-variable]
drivers/media/video/cx231xx/cx231xx-audio.c: In function=20
'snd_cx231xx_capture_trigger':
drivers/media/video/cx231xx/cx231xx-audio.c:572:6: warning: variable 'retva=
l'=20
set but not used [-Wunused-but-set-variable]
drivers/media/video/cx231xx/cx231xx-video.c: In function 'cx231xx_isoc_copy=
':
drivers/media/video/cx231xx/cx231xx-video.c:331:17: warning: variable 'outp=
'=20
set but not used [-Wunused-but-set-variable]
drivers/media/video/cx231xx/cx231xx-video.c: In function 'cx231xx_bulk_copy=
':
drivers/media/video/cx231xx/cx231xx-video.c:434:17: warning: variable 'outp=
'=20
set but not used [-Wunused-but-set-variable]
drivers/media/video/cx231xx/cx231xx-video.c: In function=20
'cx231xx_reset_video_buffer':
drivers/media/video/cx231xx/cx231xx-video.c:704:7: warning: variable 'outp'=
=20
set but not used [-Wunused-but-set-variable]
drivers/media/video/cx18/cx18-streams.c: In function=20
'cx18_stop_v4l2_encode_stream':
drivers/media/video/cx18/cx18-streams.c:787:16: warning: variable 'then' se=
t=20
but not used [-Wunused-but-set-variable]
drivers/net/forcedeth.c: In function 'nv_open':
drivers/net/forcedeth.c:5150:7: warning: variable 'miistat' set but not use=
d=20
[-Wunused-but-set-variable]
fs/xfs/xfs_da_btree.c: In function 'xfs_da_root_join':
fs/xfs/xfs_da_btree.c:707:20: warning: variable 'blkinfo' set but not used =
[-
Wunused-but-set-variable]
drivers/net/qla3xxx.c: In function 'ql_process_mac_tx_intr':
drivers/net/qla3xxx.c:1921:6: warning: variable 'retval' set but not used [-
Wunused-but-set-variable]
fs/xfs/xfs_dir2_block.c: In function 'xfs_dir2_sf_to_block':
fs/xfs/xfs_dir2_block.c:1151:26: warning: array subscript is above array=20
bounds [-Warray-bounds]
drivers/media/video/cx231xx/cx231xx-core.c: In function 'cx231xx_set_mode':
drivers/media/video/cx231xx/cx231xx-core.c:695:6: warning: variable 'errCod=
e'=20
set but not used [-Wunused-but-set-variable]
drivers/media/video/cx231xx/cx231xx-core.c: In function 'cx231xx_ep5_bulkou=
t':
drivers/media/video/cx231xx/cx231xx-core.c:757:6: warning: variable 'errCod=
e'=20
set but not used [-Wunused-but-set-variable]
drivers/media/video/cx231xx/cx231xx-core.c: In function=20
'cx231xx_isoc_irq_callback':
drivers/media/video/cx231xx/cx231xx-core.c:794:6: warning: variable 'rc' se=
t=20
but not used [-Wunused-but-set-variable]
drivers/media/video/cx231xx/cx231xx-core.c: In function=20
'cx231xx_bulk_irq_callback':
drivers/media/video/cx231xx/cx231xx-core.c:840:6: warning: variable 'rc' se=
t=20
but not used [-Wunused-but-set-variable]
drivers/media/video/cx231xx/cx231xx-core.c: In function 'cx231xx_stop_TS1':
drivers/media/video/cx231xx/cx231xx-core.c:1228:6: warning: variable 'statu=
s'=20
set but not used [-Wunused-but-set-variable]
drivers/media/video/cx231xx/cx231xx-core.c: In function 'cx231xx_start_TS1':
drivers/media/video/cx231xx/cx231xx-core.c:1248:6: warning: variable 'statu=
s'=20
set but not used [-Wunused-but-set-variable]
drivers/media/video/cx18/cx18-mailbox.c: In function 'cx18_api_call':
drivers/media/video/cx18/cx18-mailbox.c:540:6: warning: variable 'state' se=
t=20
but not used [-Wunused-but-set-variable]
drivers/media/video/cx231xx/cx231xx-avcore.c: In function 'cx231xx_enable65=
6':
drivers/media/video/cx231xx/cx231xx-avcore.c:939:6: warning: variable 'stat=
us'=20
set but not used [-Wunused-but-set-variable]
drivers/media/video/cx231xx/cx231xx-avcore.c: In function=20
'cx231xx_disable656':
drivers/media/video/cx231xx/cx231xx-avcore.c:957:6: warning: variable 'stat=
us'=20
set but not used [-Wunused-but-set-variable]
drivers/media/video/cx231xx/cx231xx-avcore.c: In function=20
'cx231xx_dump_HH_reg':
drivers/media/video/cx231xx/cx231xx-avcore.c:1323:5: warning: variable=20
'status' set but not used [-Wunused-but-set-variable]
drivers/media/video/cx231xx/cx231xx-avcore.c: In function=20
'cx231xx_dump_SC_reg':
drivers/media/video/cx231xx/cx231xx-avcore.c:1358:6: warning: variable=20
'status' set but not used [-Wunused-but-set-variable]
drivers/media/video/cx231xx/cx231xx-avcore.c: In function=20
'cx231xx_Setup_AFE_for_LowIF':
drivers/media/video/cx231xx/cx231xx-avcore.c:1444:5: warning: variable=20
'status' set but not used [-Wunused-but-set-variable]
drivers/media/video/cx231xx/cx231xx-avcore.c: In function=20
'cx231xx_set_Colibri_For_LowIF':
drivers/media/video/cx231xx/cx231xx-avcore.c:1504:5: warning: variable=20
'status' set but not used [-Wunused-but-set-variable]
drivers/media/video/cx231xx/cx231xx-avcore.c: In function=20
'cx231xx_set_DIF_bandpass':
drivers/media/video/cx231xx/cx231xx-avcore.c:1559:6: warning: variable=20
'status' set but not used [-Wunused-but-set-variable]
drivers/media/video/cx231xx/cx231xx-417.c: In function=20
'cx231xx_initialize_codec':
drivers/media/video/cx231xx/cx231xx-417.c:1098:9: warning: variable 'data' =
set=20
but not used [-Wunused-but-set-variable]
drivers/media/video/cx231xx/cx231xx-avcore.c: In function=20
'cx231xx_gpio_i2c_write':
drivers/media/video/cx231xx/cx231xx-avcore.c:3091:6: warning: variable=20
'status' set but not used [-Wunused-but-set-variable]
drivers/media/video/cx231xx/cx231xx-417.c: In function 'vidioc_streamon':
drivers/media/video/cx231xx/cx231xx-417.c:1796:6: warning: variable 'rc' se=
t=20
but not used [-Wunused-but-set-variable]
fs/xfs/xfs_dir2_leaf.c: In function 'xfs_dir2_leaf_compact':
fs/xfs/xfs_dir2_leaf.c:622:31: warning: array subscript is above array boun=
ds=20
[-Warray-bounds]
fs/xfs/xfs_filestream.c: In function '_xfs_filestream_pick_ag':
fs/xfs/xfs_filestream.c:217:24: warning: variable 'free' set but not used [-
Wunused-but-set-variable]
fs/xfs/xfs_filestream.c:215:7: warning: variable 'streams' set but not used=
 [-
Wunused-but-set-variable]
fs/xfs/xfs_filestream.c: In function 'xfs_filestream_lookup_ag':
fs/xfs/xfs_filestream.c:538:7: warning: variable 'ref' set but not used [-
Wunused-but-set-variable]
drivers/media/dvb/frontends/lgs8gxx.c: In function 'lgs8gxx_set_mode_manual=
':
drivers/media/dvb/frontends/lgs8gxx.c:265:6: warning: variable 'ret' set bu=
t=20
not used [-Wunused-but-set-variable]
drivers/media/video/cx231xx/cx231xx-vbi.c: In function=20
'cx231xx_isoc_vbi_copy':
drivers/media/video/cx231xx/cx231xx-vbi.c:86:25: warning: variable 'buf' se=
t=20
but not used [-Wunused-but-set-variable]
drivers/media/video/cx231xx/cx231xx-vbi.c: In function=20
'cx231xx_irq_vbi_callback':
drivers/media/video/cx231xx/cx231xx-vbi.c:313:6: warning: variable 'rc' set=
=20
but not used [-Wunused-but-set-variable]
drivers/media/dvb/frontends/stv090x.c: In function 'stv090x_optimize_track':
drivers/media/dvb/frontends/stv090x.c:2834:23: warning: variable 'rolloff' =
set=20
but not used [-Wunused-but-set-variable]
drivers/media/dvb/frontends/stv090x.c: In function 'stv090x_algo':
drivers/media/dvb/frontends/stv090x.c:3164:28: warning: variable 'no_signal=
'=20
set but not used [-Wunused-but-set-variable]
fs/xfs/xfs_itable.c: In function 'xfs_bulkstat':
fs/xfs/xfs_itable.c:207:15: warning: variable 'bno' set but not used [-
Wunused-but-set-variable]
drivers/media/video/cx23885/cx23888-ir.c: In function=20
'pulse_clocks_to_clock_divider':
drivers/media/video/cx23885/cx23888-ir.c:334:6: warning: variable 'rem' set=
=20
but not used [-Wunused-but-set-variable]
drivers/media/dvb/frontends/ds3000.c: In function 'ds3000_tune':
drivers/media/dvb/frontends/ds3000.c:1026:5: warning: variable 'status' set=
=20
but not used [-Wunused-but-set-variable]
drivers/media/video/em28xx/em28xx-audio.c: In function=20
'snd_em28xx_capture_open':
drivers/media/video/em28xx/em28xx-audio.c:289:7: warning: variable 'errCode=
'=20
set but not used [-Wunused-but-set-variable]
drivers/media/video/em28xx/em28xx-audio.c: In function=20
'snd_em28xx_hw_capture_params':
drivers/media/video/em28xx/em28xx-audio.c:339:6: warning: variable 'ret' se=
t=20
but not used [-Wunused-but-set-variable]
drivers/media/video/em28xx/em28xx-audio.c:338:31: warning: variable 'format=
'=20
set but not used [-Wunused-but-set-variable]
drivers/media/video/em28xx/em28xx-audio.c:338:25: warning: variable 'rate' =
set=20
but not used [-Wunused-but-set-variable]
drivers/media/video/em28xx/em28xx-audio.c:338:15: warning: variable 'channe=
ls'=20
set but not used [-Wunused-but-set-variable]
drivers/media/video/em28xx/em28xx-audio.c: In function=20
'snd_em28xx_capture_trigger':
drivers/media/video/em28xx/em28xx-audio.c:396:6: warning: variable 'retval'=
=20
set but not used [-Wunused-but-set-variable]
drivers/media/video/cx25840/cx25840-ir.c: In function=20
'pulse_clocks_to_clock_divider':
drivers/media/video/cx25840/cx25840-ir.c:318:6: warning: variable 'rem' set=
=20
but not used [-Wunused-but-set-variable]
drivers/media/video/cx25840/cx25840-ir.c: In function 'cx25840_ir_tx_write':
drivers/media/video/cx25840/cx25840-ir.c:858:21: warning: variable 'c' set =
but=20
not used [-Wunused-but-set-variable]
drivers/media/video/em28xx/em28xx-i2c.c: In function=20
'em28xx_i2c_check_for_device':
drivers/media/video/em28xx/em28xx-i2c.c:221:7: warning: variable 'msg' set =
but=20
not used [-Wunused-but-set-variable]
drivers/media/video/em28xx/em28xx-core.c: In function 'em28xx_irq_callback':
drivers/media/video/em28xx/em28xx-core.c:919:6: warning: variable 'rc' set =
but=20
not used [-Wunused-but-set-variable]
drivers/media/video/em28xx/em28xx-cards.c: In function 'em28xx_card_setup':
drivers/media/video/em28xx/em28xx-cards.c:2629:23: warning: variable 'sd' s=
et=20
but not used [-Wunused-but-set-variable]
drivers/net/pptp.c: In function 'pptp_release':
drivers/net/pptp.c:528:19: warning: variable 'opt' set but not used [-Wunus=
ed-
but-set-variable]
drivers/media/video/gspca/cpia1.c: In function 'monitor_exposure':
drivers/media/video/gspca/cpia1.c:1259:27: warning: variable 'coarseL' set =
but=20
not used [-Wunused-but-set-variable]
drivers/media/video/gspca/cpia1.c:1259:21: warning: variable 'gain' set but=
=20
not used [-Wunused-but-set-variable]
drivers/media/video/gspca/jeilinj.c: In function 'jlj_dostream':
drivers/media/video/gspca/jeilinj.c:186:6: warning: variable 'size_in_block=
s'=20
set but not used [-Wunused-but-set-variable]
drivers/net/8139cp.c: In function 'cp_tx_timeout':
drivers/net/8139cp.c:1209:6: warning: variable 'rc' set but not used [-
Wunused-but-set-variable]
drivers/media/video/hdpvr/hdpvr-control.c: In function 'get_input_lines_inf=
o':
drivers/media/video/hdpvr/hdpvr-control.c:98:6: warning: variable 'ret' set=
=20
but not used [-Wunused-but-set-variable]
drivers/media/video/hdpvr/hdpvr-video.c: In function 'hdpvr_try_ctrl':
drivers/media/video/hdpvr/hdpvr-video.c:937:6: warning: variable 'ret' set =
but=20
not used [-Wunused-but-set-variable]
drivers/net/8139too.c: In function 'rtl8139_init_board':
drivers/net/8139too.c:749:28: warning: variable 'mmio_end' set but not used=
 [-
Wunused-but-set-variable]
drivers/net/8139too.c:749:16: warning: variable 'mmio_start' set but not us=
ed=20
[-Wunused-but-set-variable]
drivers/net/8139too.c:748:27: warning: variable 'pio_end' set but not used =
[-
Wunused-but-set-variable]
drivers/media/video/ivtv/ivtv-ioctl.c: In function 'ivtv_set_speed':
drivers/media/video/ivtv/ivtv-ioctl.c:138:22: warning: variable 's' set but=
=20
not used [-Wunused-but-set-variable]
fs/xfs/linux-2.6/xfs_sync.c: In function 'xfs_sync_worker':
fs/xfs/linux-2.6/xfs_sync.c:503:7: warning: variable 'error' set but not us=
ed=20
[-Wunused-but-set-variable]
drivers/media/video/pvrusb2/pvrusb2-v4l2.c: In function 'pvr2_v4l2_do_ioctl=
':
drivers/media/video/pvrusb2/pvrusb2-v4l2.c:798:23: warning: variable 'cap' =
set=20
but not used [-Wunused-but-set-variable]
drivers/media/video/ivtv/ivtvfb.c: In function 'ivtvfb_init':
drivers/media/video/ivtv/ivtvfb.c:1279:6: warning: variable 'err' set but n=
ot=20
used [-Wunused-but-set-variable]
drivers/media/video/ivtv/ivtvfb.c: In function 'ivtvfb_cleanup':
drivers/media/video/ivtv/ivtvfb.c:1300:6: warning: variable 'err' set but n=
ot=20
used [-Wunused-but-set-variable]
drivers/media/video/pwc/pwc-if.c: In function 'pwc_isoc_handler':
drivers/media/video/pwc/pwc-if.c:707:15: warning: variable 'errmsg' set but=
=20
not used [-Wunused-but-set-variable]
drivers/net/dl2k.c: In function 'find_miiphy':
drivers/net/dl2k.c:304:7: warning: variable 'ioaddr' set but not used [-
Wunused-but-set-variable]
drivers/rtc/rtc-ds1286.c: In function 'ds1286_read_alarm':
drivers/rtc/rtc-ds1286.c:273:16: warning: variable 'cmd' set but not used [-
Wunused-but-set-variable]
drivers/target/target_core_device.c: In function=20
'transport_core_report_lun_response':
drivers/target/target_core_device.c:657:17: warning: variable 'se_lun' set =
but=20
not used [-Wunused-but-set-variable]
drivers/target/target_core_configfs.c: In function=20
'target_core_dev_pr_store_attr_res_aptpl_metadata':
drivers/target/target_core_configfs.c:1463:15: warning: variable 'scope' se=
t=20
but not used [-Wunused-but-set-variable]
drivers/target/target_core_configfs.c:1462:6: warning: variable 'port_rpti'=
 set=20
but not used [-Wunused-but-set-variable]
drivers/target/target_core_configfs.c:1454:28: warning: variable 't_fabric'=
 set=20
but not used [-Wunused-but-set-variable]
drivers/target/target_core_configfs.c:1454:17: warning: variable 'i_fabric'=
 set=20
but not used [-Wunused-but-set-variable]
drivers/target/target_core_configfs.c: In function 'target_core_drop_subdev=
':
drivers/target/target_core_configfs.c:2814:27: warning: variable 't' set bu=
t=20
not used [-Wunused-but-set-variable]
drivers/staging/crystalhd/crystalhd_hw.c: In function 'crystalhd_hw_post_tx=
':
drivers/staging/crystalhd/crystalhd_hw.c:2025:21: warning: variable=20
'high_addr' set but not used [-Wunused-but-set-variable]
drivers/staging/crystalhd/crystalhd_hw.c:2025:11: warning: variable 'low_ad=
dr'=20
set but not used [-Wunused-but-set-variable]
In file included from drivers/net/s2io.c:88:0:
drivers/net/s2io.h: In function 'SPECIAL_REG_WRITE':
drivers/net/s2io.h:1008:6: warning: variable 'ret' set but not used [-Wunus=
ed-
but-set-variable]
drivers/net/s2io.c: In function 'fix_mac_address':
drivers/net/s2io.c:2247:6: warning: variable 'val64' set but not used [-
Wunused-but-set-variable]
drivers/net/s2io.c: In function 'free_rxd_blk':
drivers/net/s2io.c:2730:18: warning: variable 'ba' set but not used [-Wunus=
ed-
but-set-variable]
drivers/scsi/scsi_transport_iscsi.c: In function 'iscsi_add_session':
drivers/scsi/scsi_transport_iscsi.c:758:25: warning: variable 'ihost' set b=
ut=20
not used [-Wunused-but-set-variable]
drivers/media/video/saa7134/saa7134-video.c: In function 'saa7134_s_tuner':
drivers/media/video/saa7134/saa7134-video.c:2029:6: warning: variable 'rx' =
set=20
but not used [-Wunused-but-set-variable]
drivers/target/target_core_pr.c: In function 'core_scsi3_pro_reserve':
drivers/target/target_core_pr.c:2384:26: warning: variable 'se_tpg' set but=
=20
not used [-Wunused-but-set-variable]
drivers/target/target_core_pr.c:2382:23: warning: variable 'se_deve' set bu=
t=20
not used [-Wunused-but-set-variable]
drivers/target/target_core_pr.c: In function 'core_scsi3_pro_preempt':
drivers/target/target_core_pr.c:2958:23: warning: variable 'se_deve' set bu=
t=20
not used [-Wunused-but-set-variable]
drivers/target/target_core_pr.c: In function=20
'core_scsi3_emulate_pro_register_and_move':
drivers/target/target_core_pr.c:3302:23: warning: variable 'se_deve' set bu=
t=20
not used [-Wunused-but-set-variable]
drivers/media/video/gspca/stv06xx/stv06xx.c: In function 'stv06xx_config':
drivers/media/video/gspca/stv06xx/stv06xx.c:528:14: warning: variable 'cam'=
=20
set but not used [-Wunused-but-set-variable]
drivers/media/video/saa7164/saa7164-api.c: In function 'saa7164_api_i2c_rea=
d':
drivers/media/video/saa7164/saa7164-api.c:1370:6: warning: variable 'regval=
'=20
set but not used [-Wunused-but-set-variable]
drivers/ssb/driver_pcicore.c: In function 'ssb_pcicore_init':
drivers/ssb/driver_pcicore.c:420:18: warning: variable 'bus' set but not us=
ed=20
[-Wunused-but-set-variable]
drivers/staging/lirc/lirc_imon.c: In function 'usb_rx_callback':
drivers/staging/lirc/lirc_imon.c:676:6: warning: variable 'len' set but not=
=20
used [-Wunused-but-set-variable]
drivers/staging/lirc/lirc_imon.c:675:17: warning: variable 'buf' set but no=
t=20
used [-Wunused-but-set-variable]
drivers/staging/lirc/lirc_imon.c: In function 'imon_probe':
drivers/staging/lirc/lirc_imon.c:731:6: warning: variable 'code_length' set=
=20
but not used [-Wunused-but-set-variable]
drivers/staging/lirc/lirc_imon.c: In function 'vfd_write':
drivers/staging/lirc/lirc_imon.c:450:7: warning: 'data_buf' may be used=20
uninitialized in this function [-Wuninitialized]
drivers/staging/lirc/lirc_serial.c: In function 'irq_handler':
drivers/staging/lirc/lirc_serial.c:705:5: warning: format '%lx' expects=20
argument of type 'long unsigned int', but argument 6 has type=20
'__kernel_suseconds_t' [-Wformat]
drivers/staging/lirc/lirc_serial.c:705:5: warning: format '%lx' expects=20
argument of type 'long unsigned int', but argument 7 has type=20
'__kernel_suseconds_t' [-Wformat]
drivers/staging/lirc/lirc_serial.c:720:12: warning: format '%lx' expects=20
argument of type 'long unsigned int', but argument 6 has type=20
'__kernel_suseconds_t' [-Wformat]
drivers/staging/lirc/lirc_serial.c:720:12: warning: format '%lx' expects=20
argument of type 'long unsigned int', but argument 7 has type=20
'__kernel_suseconds_t' [-Wformat]
drivers/staging/lirc/lirc_serial.c:731:13: warning: format '%lx' expects=20
argument of type 'long unsigned int', but argument 6 has type=20
'__kernel_suseconds_t' [-Wformat]
drivers/staging/lirc/lirc_serial.c:731:13: warning: format '%lx' expects=20
argument of type 'long unsigned int', but argument 7 has type=20
'__kernel_suseconds_t' [-Wformat]
drivers/scsi/libiscsi.c: In function 'iscsi_eh_abort':
drivers/scsi/libiscsi.c:2107:6: warning: variable 'rc' set but not used [-
Wunused-but-set-variable]
drivers/staging/lirc/lirc_sasem.c: In function 'vfd_write':
drivers/staging/lirc/lirc_sasem.c:451:7: warning: 'data_buf' may be used=20
uninitialized in this function [-Wuninitialized]
drivers/scsi/iscsi_tcp.c: In function 'iscsi_sw_tcp_state_change':
drivers/scsi/iscsi_tcp.c:156:24: warning: variable 'session' set but not us=
ed=20
[-Wunused-but-set-variable]
drivers/net/dnet.c: In function 'dnet_start_xmit':
drivers/net/dnet.c:549:15: warning: variable 'len' set but not used [-Wunus=
ed-
but-set-variable]
drivers/net/dnet.c:548:6: warning: variable 'tx_status' set but not used [-
Wunused-but-set-variable]
drivers/staging/lirc/lirc_sir.c: In function 'send_pulse':
drivers/staging/lirc/lirc_sir.c:742:7: warning: variable 'time_left' set bu=
t=20
not used [-Wunused-but-set-variable]
drivers/rtc/rtc-v3020.c: In function 'rtc_probe':
drivers/rtc/rtc-v3020.c:310:6: warning: variable 'temp' set but not used [-
Wunused-but-set-variable]
drivers/tty/serial/jsm/jsm_tty.c: In function 'jsm_tty_close':
drivers/tty/serial/jsm/jsm_tty.c:276:19: warning: variable 'ts' set but not=
=20
used [-Wunused-but-set-variable]
drivers/tty/serial/jsm/jsm_tty.c: In function 'jsm_uart_port_init':
drivers/tty/serial/jsm/jsm_tty.c:438:22: warning: variable 'ch' set but not=
=20
used [-Wunused-but-set-variable]
drivers/staging/se401/se401.c: In function 'decode_JangGu':
drivers/staging/se401/se401.c:672:32: warning: variable 'frameinfo' set but=
=20
not used [-Wunused-but-set-variable]
drivers/staging/se401/se401.c: In function 'se401_init':
drivers/staging/se401/se401.c:1257:13: warning: variable 'rc' set but not u=
sed=20
[-Wunused-but-set-variable]
drivers/staging/usbvideo/usbvideo.c: In function 'usbvideo_GetFrame':
drivers/staging/usbvideo/usbvideo.c:1997:7: warning: variable 'ntries' set =
but=20
not used [-Wunused-but-set-variable]
drivers/target/target_core_tpg.c: In function 'core_tpg_clear_object_luns':
drivers/target/target_core_tpg.c:322:9: warning: variable 'ret' set but not=
=20
used [-Wunused-but-set-variable]
drivers/target/target_core_tpg.c: In function=20
'core_tpg_del_initiator_node_acl':
drivers/target/target_core_tpg.c:442:6: warning: variable 'dynamic_acl' set=
=20
but not used [-Wunused-but-set-variable]
drivers/target/target_core_transport.c: In function=20
'transport_release_all_cmds':
drivers/target/target_core_transport.c:1281:6: warning: variable 'bug_out' =
set=20
but not used [-Wunused-but-set-variable]
drivers/scsi/aic7xxx_old.c: In function 'aic7xxx_set_syncrate':
drivers/scsi/aic7xxx_old.c:2071:28: warning: variable 'old_offset' set but =
not=20
used [-Wunused-but-set-variable]
drivers/scsi/aic7xxx_old.c:2071:16: warning: variable 'old_period' set but =
not=20
used [-Wunused-but-set-variable]
drivers/scsi/aic7xxx_old.c:2070:22: warning: variable 'old_options' set but=
=20
not used [-Wunused-but-set-variable]
drivers/scsi/aic7xxx_old.c: In function 'aic7xxx_set_width':
drivers/scsi/aic7xxx_old.c:2200:16: warning: variable 'old_width' set but n=
ot=20
used [-Wunused-but-set-variable]
drivers/scsi/aic7xxx_old.c:2199:18: warning: variable 'target_mask' set but=
=20
not used [-Wunused-but-set-variable]
drivers/scsi/aic7xxx_old.c: In function 'aic7xxx_done':
drivers/scsi/aic7xxx_old.c:2713:20: warning: variable 'mask' set but not us=
ed=20
[-Wunused-but-set-variable]
drivers/scsi/aic7xxx_old.c: In function 'aic7xxx_handle_seqint':
drivers/scsi/aic7xxx_old.c:4419:7: warning: variable 'diff' set but not use=
d [-
Wunused-but-set-variable]
drivers/scsi/aic7xxx_old.c:3911:18: warning: variable 'target_mask' set but=
=20
not used [-Wunused-but-set-variable]
drivers/scsi/aic7xxx_old.c: In function 'aic7xxx_handle_scsiint':
drivers/scsi/aic7xxx_old.c:5927:20: warning: variable 'cmd' set but not use=
d=20
[-Wunused-but-set-variable]
drivers/scsi/aic7xxx_old.c: In function=20
'aic7xxx_handle_command_completion_intr':
drivers/scsi/aic7xxx_old.c:6236:27: warning: variable 'tindex' set but not=
=20
used [-Wunused-but-set-variable]
drivers/target/target_core_transport.c: In function=20
'transport_generic_do_tmr':
drivers/target/target_core_transport.c:5831:17: warning: variable 'ref_cmd'=
=20
set but not used [-Wunused-but-set-variable]
drivers/target/target_core_transport.c: In function=20
'transport_processing_shutdown':
drivers/target/target_core_transport.c:5902:5: warning: variable 'state' se=
t=20
but not used [-Wunused-but-set-variable]
drivers/scsi/aic7xxx_old.c: In function 'aic7xxx_register':
drivers/scsi/aic7xxx_old.c:7901:5: warning: case value '257' not in enumera=
ted=20
type 'ahc_chip' [-Wswitch]
drivers/scsi/aic7xxx_old.c:7898:5: warning: case value '513' not in enumera=
ted=20
type 'ahc_chip' [-Wswitch]
drivers/scsi/aic7xxx_old.c:7852:7: warning: variable 'max_targets' set but =
not=20
used [-Wunused-but-set-variable]
drivers/scsi/aic7xxx_old.c: In function 'aic7xxx_load_seeprom':
drivers/scsi/aic7xxx_old.c:8517:5: warning: case value '257' not in enumera=
ted=20
type 'ahc_chip' [-Wswitch]
drivers/scsi/aic7xxx_old.c:8510:5: warning: case value '513' not in enumera=
ted=20
type 'ahc_chip' [-Wswitch]
drivers/scsi/aic7xxx_old.c:8809:17: warning: variable 'ultraenb' set but no=
t=20
used [-Wunused-but-set-variable]
drivers/scsi/aic7xxx_old.c: In function 'aic7xxx_queue_lck':
drivers/scsi/aic7xxx_old.c:10241:24: warning: variable 'aic_dev' set but no=
t=20
used [-Wunused-but-set-variable]
drivers/scsi/aic7xxx_old.c: In function '__aic7xxx_bus_device_reset':
drivers/scsi/aic7xxx_old.c:10313:7: warning: variable 'channel' set but not=
=20
used [-Wunused-but-set-variable]
drivers/scsi/aic7xxx_old.c: In function 'aic7xxx_reset':
drivers/scsi/aic7xxx_old.c:10787:24: warning: variable 'aic_dev' set but no=
t=20
used [-Wunused-but-set-variable]
drivers/net/niu.c: In function 'link_status_1g_rgmii':
drivers/net/niu.c:1236:25: warning: variable 'estat' set but not used [-
Wunused-but-set-variable]
drivers/net/niu.c:1236:17: warning: variable 'common' set but not used [-
Wunused-but-set-variable]
drivers/net/niu.c: In function 'xcvr_init_10g':
drivers/net/niu.c:1626:14: warning: variable 'err' set but not used [-Wunus=
ed-
but-set-variable]
drivers/net/niu.c: In function 'serdes_init_10g_serdes':
drivers/net/niu.c:2384:6: warning: variable 'reset_val' set but not used [-
Wunused-but-set-variable]
drivers/net/niu.c: In function 'niu_pci_vpd_scan_props':
drivers/net/niu.c:8134:27: warning: variable 'type' set but not used [-
Wunused-but-set-variable]
drivers/net/niu.c:8134:17: warning: variable 'instance' set but not used [-
Wunused-but-set-variable]
drivers/net/atl1c/atl1c_main.c: In function 'atl1c_configure_tx':
drivers/net/atl1c/atl1c_main.c:1095:6: warning: variable 'extra_size' set b=
ut=20
not used [-Wunused-but-set-variable]
drivers/net/atl1c/atl1c_main.c: At top level:
drivers/net/atl1c/atl1c_main.c:2543:12: warning: 'atl1c_resume' defined but=
 not=20
used [-Wunused-function]
drivers/media/video/usbvision/usbvision-core.c: In function=20
'usbvision_decompress':
drivers/media/video/usbvision/usbvision-core.c:696:23: warning: variable=20
'max_pos' set but not used [-Wunused-but-set-variable]
drivers/media/video/usbvision/usbvision-core.c: In function=20
'usbvision_parse_compress':
drivers/media/video/usbvision/usbvision-core.c:797:39: warning: variable 'r=
c'=20
set but not used [-Wunused-but-set-variable]
drivers/media/video/usbvision/usbvision-core.c:797:22: warning: variable=20
'bytes_per_pixel' set but not used [-Wunused-but-set-variable]
drivers/uwb/beacon.c: In function 'uwbd_evt_handle_rc_beacon':
drivers/uwb/beacon.c:397:16: warning: variable 'last_ts' set but not used [-
Wunused-but-set-variable]
drivers/watchdog/pcwd_usb.c: In function 'usb_pcwd_probe':
drivers/watchdog/pcwd_usb.c:621:12: warning: variable 'maxp' set but not us=
ed=20
[-Wunused-but-set-variable]
drivers/uwb/est.c: In function 'uwb_est_register':
drivers/uwb/est.c:260:6: warning: variable 'type_event_high' set but not us=
ed=20
[-Wunused-but-set-variable]
drivers/uwb/ie-rcv.c: In function 'uwbd_evt_handle_rc_ie_rcv':
drivers/uwb/ie-rcv.c:34:9: warning: variable 'iesize' set but not used [-
Wunused-but-set-variable]
drivers/target/target_core_rd.c: In function 'rd_MEMCPY_read':
drivers/target/target_core_rd.c:381:28: warning: variable 'table_sg_end' se=
t=20
but not used [-Wunused-but-set-variable]
drivers/target/target_core_rd.c: In function 'rd_MEMCPY_write':
drivers/target/target_core_rd.c:504:28: warning: variable 'table_sg_end' se=
t=20
but not used [-Wunused-but-set-variable]
drivers/usb/class/cdc-wdm.c: In function 'wdm_post_reset':
drivers/usb/class/cdc-wdm.c:862:6: warning: variable 'rv' set but not used =
[-
Wunused-but-set-variable]
drivers/net/atlx/atl1.c: In function 'atl1_intr_tx':
drivers/net/atlx/atl1.c:2076:26: warning: variable 'tpd' set but not used [-
Wunused-but-set-variable]
drivers/net/atl1e/atl1e_main.c: In function 'atl1e_init_ring_resources':
drivers/net/atl1e/atl1e_main.c:694:24: warning: variable 'tx_ring' set but =
not=20
used [-Wunused-but-set-variable]
drivers/scsi/ips.c:210:2: warning: #warning "This driver has only been test=
ed=20
on the x86/ia64/x86_64 platforms" [-Wcpp]
drivers/scsi/ips.c: In function 'ips_init_copperhead':
drivers/scsi/ips.c:4791:10: warning: variable 'ConfigByte' set but not used=
 [-
Wunused-but-set-variable]
drivers/scsi/ips.c: In function 'ips_init_copperhead_memio':
drivers/scsi/ips.c:4885:10: warning: variable 'ConfigByte' set but not used=
 [-
Wunused-but-set-variable]
drivers/scsi/ips.c: In function 'ips_init_phase1':
drivers/scsi/ips.c:6964:10: warning: variable 'func' set but not used [-
Wunused-but-set-variable]
drivers/scsi/ips.c:6963:10: warning: variable 'bus' set but not used [-
Wunused-but-set-variable]
drivers/usb/serial/usb-serial.c: In function 'usb_serial_disconnect':
drivers/usb/serial/usb-serial.c:1134:10: warning: variable 'rc' set but not=
=20
used [-Wunused-but-set-variable]
drivers/usb/host/xhci.c: In function 'xhci_add_endpoint':
drivers/usb/host/xhci.c:1330:22: warning: variable 'ep_ctx' set but not use=
d=20
[-Wunused-but-set-variable]
drivers/usb/storage/alauda.c: In function 'alauda_check_media':
drivers/usb/storage/alauda.c:468:6: warning: variable 'rc' set but not used=
 [-
Wunused-but-set-variable]
drivers/usb/storage/freecom.c: In function 'init_freecom':
drivers/usb/storage/freecom.c:427:6: warning: variable 'result' set but not=
=20
used [-Wunused-but-set-variable]
drivers/usb/wusbcore/devconnect.c: In function 'wusbhc_devconnect_ack':
drivers/usb/wusbcore/devconnect.c:308:16: warning: variable 'devnum' set bu=
t=20
not used [-Wunused-but-set-variable]
drivers/video/mb862xx/mb862xxfb_accel.c: In function 'mb86290fb_imageblit':
drivers/video/mb862xx/mb862xxfb_accel.c:191:6: warning: variable 'mdr' set =
but=20
not used [-Wunused-but-set-variable]
drivers/usb/host/xhci-ring.c: In function 'handle_cmd_completion':
drivers/usb/host/xhci-ring.c:1025:20: warning: variable 'ep_ring' set but n=
ot=20
used [-Wunused-but-set-variable]
drivers/net/benet/be_ethtool.c: In function 'be_set_coalesce':
drivers/net/benet/be_ethtool.c:179:14: warning: variable 'tx_min' set but n=
ot=20
used [-Wunused-but-set-variable]
drivers/net/benet/be_ethtool.c:179:6: warning: variable 'tx_max' set but no=
t=20
used [-Wunused-but-set-variable]
drivers/net/benet/be_ethtool.c: In function 'be_do_flash':
drivers/net/benet/be_ethtool.c:634:6: warning: variable 'region' set but no=
t=20
used [-Wunused-but-set-variable]
drivers/scsi/qla1280.c: In function 'qla1280_done':
drivers/scsi/qla1280.c:1281:19: warning: variable 'lun' set but not used [-
Wunused-but-set-variable]
drivers/scsi/qla1280.c: In function 'qla1280_nvram_config':
drivers/scsi/qla1280.c:2226:36: warning: variable 'ddma_conf' set but not u=
sed=20
[-Wunused-but-set-variable]
drivers/scsi/qla1280.c: In function 'qla1280_mailbox_command':
drivers/scsi/qla1280.c:2475:11: warning: variable 'data' set but not used [-
Wunused-but-set-variable]
drivers/scsi/qla1280.c: In function 'qla1280_status_entry':
drivers/scsi/qla1280.c:3683:28: warning: variable 'lun' set but not used [-
Wunused-but-set-variable]
drivers/scsi/qla1280.c:3683:20: warning: variable 'target' set but not used=
 [-
Wunused-but-set-variable]
drivers/scsi/qla1280.c:3683:15: warning: variable 'bus' set but not used [-
Wunused-but-set-variable]
drivers/usb/storage/sddr09.c: In function 'sddr09_write_lba':
drivers/usb/storage/sddr09.c:877:17: warning: variable 'isnew' set but not=
=20
used [-Wunused-but-set-variable]
drivers/usb/storage/sddr55.c: In function 'sddr55_transport':
drivers/usb/storage/sddr55.c:795:15: warning: variable 'pba' set but not us=
ed=20
[-Wunused-but-set-variable]
drivers/usb/serial/cypress_m8.c: In function 'cypress_send':
drivers/usb/serial/cypress_m8.c:741:33: warning: variable 'actual_size' set=
=20
but not used [-Wunused-but-set-variable]
drivers/usb/serial/cypress_m8.c: In function 'cypress_set_termios':
drivers/usb/serial/cypress_m8.c:971:18: warning: variable 'iflag' set but n=
ot=20
used [-Wunused-but-set-variable]
drivers/usb/serial/cypress_m8.c: In function 'cypress_read_int_callback':
drivers/usb/serial/cypress_m8.c:1185:6: warning: variable 'havedata' set bu=
t=20
not used [-Wunused-but-set-variable]
drivers/usb/host/xhci-ring.c: In function 'xhci_handle_event':
drivers/usb/host/xhci-ring.c:1751:3: warning: 'event_trb' may be used=20
uninitialized in this function [-Wuninitialized]
drivers/usb/host/xhci-ring.c:1789:18: note: 'event_trb' was declared here
drivers/video/nvidia/nv_setup.c: In function 'NVWriteAttr':
drivers/video/nvidia/nv_setup.c:92:14: warning: variable 'tmp' set but not=
=20
used [-Wunused-but-set-variable]
drivers/video/nvidia/nv_setup.c: In function 'NVReadAttr':
drivers/video/nvidia/nv_setup.c:104:14: warning: variable 'tmp' set but not=
=20
used [-Wunused-but-set-variable]
drivers/usb/host/xhci-dbg.c: In function 'xhci_dbg_ctx':
drivers/usb/host/xhci-dbg.c:545:24: warning: variable 'slot_ctx' set but no=
t=20
used [-Wunused-but-set-variable]
drivers/usb/misc/sisusbvga/sisusb.c: In function 'sisusb_set_default_mode':
drivers/usb/misc/sisusbvga/sisusb.c:1799:28: warning: variable 'modey' set =
but=20
not used [-Wunused-but-set-variable]
drivers/net/bna/bna_ctrl.c: In function 'bna_mbox_flush_q':
drivers/net/bna/bna_ctrl.c:249:19: warning: variable 'cmd_h' set but not us=
ed=20
[-Wunused-but-set-variable]
drivers/net/bna/bna_ctrl.c: In function 'bna_rit_mod_uninit':
drivers/net/bna/bna_ctrl.c:2780:26: warning: variable 'rit_segment' set but=
=20
not used [-Wunused-but-set-variable]
drivers/net/bonding/bond_main.c: In function 'bond_send_gratuitous_arp':
drivers/net/bonding/bond_main.c:2658:21: warning: variable 'vlan_dev' set b=
ut=20
not used [-Wunused-but-set-variable]
drivers/net/bnx2x/bnx2x_main.c: In function 'bnx2x_timer':
drivers/net/bnx2x/bnx2x_main.c:3882:7: warning: variable 'rc' set but not u=
sed=20
[-Wunused-but-set-variable]
drivers/net/bnx2x/bnx2x_main.c: In function 'bnx2x_init_sb':
drivers/net/bnx2x/bnx2x_main.c:4040:24: warning: variable 'hc_index_p' set =
but=20
not used [-Wunused-but-set-variable]
drivers/scsi/dc395x.c: In function 'start_scsi':
drivers/scsi/dc395x.c:1495:6: warning: variable 's_stat2' set but not used =
[-
Wunused-but-set-variable]
drivers/scsi/dc395x.c: In function 'data_io_transfer':
drivers/scsi/dc395x.c:2536:16: warning: variable 'data2' set but not used [-
Wunused-but-set-variable]
drivers/scsi/dc395x.c:2536:6: warning: variable 'data' set but not used [-
Wunused-but-set-variable]
drivers/scsi/dc395x.c: In function 'reselect':
drivers/scsi/dc395x.c:3128:5: warning: variable 'arblostflag' set but not u=
sed=20
[-Wunused-but-set-variable]
drivers/scsi/dc395x.c: In function 'doing_srb_done':
drivers/scsi/dc395x.c:3535:28: warning: variable 'dir' set but not used [-
Wunused-but-set-variable]
drivers/scsi/hpsa.c: In function 'hpsa_scatter_gather':
drivers/scsi/hpsa.c:1861:17: warning: variable 'sg_index' set but not used =
[-
Wunused-but-set-variable]
drivers/net/bnx2x/bnx2x_main.c: In function 'bnx2x_get_hwinfo':
drivers/net/bnx2x/bnx2x_main.c:8460:10: warning: variable 'port' set but no=
t=20
used [-Wunused-but-set-variable]
drivers/scsi/tmscsim.c: In function 'dc390_RequestSense':
drivers/scsi/tmscsim.c:1674:20: warning: variable 'pcmd' set but not used [-
Wunused-but-set-variable]
drivers/scsi/tmscsim.c: In function 'dc390_DoingSRB_Done':
drivers/scsi/tmscsim.c:1818:23: warning: variable 'pcmd' set but not used [-
Wunused-but-set-variable]
drivers/usb/serial/io_edgeport.c: In function 'edge_set_termios':
drivers/usb/serial/io_edgeport.c:1519:15: warning: variable 'cflag' set but=
 not=20
used [-Wunused-but-set-variable]
drivers/usb/serial/io_edgeport.c: In function 'write_cmd_usb':
drivers/usb/serial/io_edgeport.c:2346:6: warning: variable 'timeout' set bu=
t=20
not used [-Wunused-but-set-variable]
drivers/scsi/megaraid.c: In function 'mega_build_cmd':
drivers/scsi/megaraid.c:520:21: warning: variable 'epthru' set but not used=
 [-
Wunused-but-set-variable]
drivers/scsi/megaraid.c: In function 'proc_read_stat':
drivers/scsi/megaraid.c:2251:6: warning: variable 'i' set but not used [-
Wunused-but-set-variable]
drivers/scsi/megaraid.c: In function 'megadev_ioctl':
drivers/scsi/megaraid.c:3324:7: warning: variable 'num_ldrv' set but not us=
ed=20
[-Wunused-but-set-variable]
drivers/scsi/megaraid.c:3323:21: warning: variable 'ustats' set but not use=
d=20
[-Wunused-but-set-variable]
drivers/scsi/megaraid.c: In function 'mega_is_bios_enabled':
drivers/scsi/megaraid.c:3920:6: warning: variable 'ret' set but not used [-
Wunused-but-set-variable]
drivers/scsi/atp870u.c: In function 'atp870u_probe':
drivers/scsi/atp870u.c:2560:32: warning: variable 'error' set but not used =
[-
Wunused-but-set-variable]
drivers/scsi/atp870u.c: In function 'atp870u_proc_info':
drivers/scsi/atp870u.c:3102:8: warning: variable 'pos' set but not used [-
Wunused-but-set-variable]
drivers/usb/serial/io_ti.c: In function 'edge_close':
drivers/usb/serial/io_ti.c:2020:6: warning: variable 'status' set but not u=
sed=20
[-Wunused-but-set-variable]
drivers/usb/serial/io_ti.c: In function 'edge_set_termios':
drivers/usb/serial/io_ti.c:2431:15: warning: variable 'cflag' set but not u=
sed=20
[-Wunused-but-set-variable]
drivers/usb/serial/io_ti.c: In function 'edge_startup':
drivers/usb/serial/io_ti.c:2620:21: warning: variable 'dev' set but not use=
d=20
[-Wunused-but-set-variable]
drivers/usb/storage/initializers.c: In function 'usb_stor_euscsi_init':
drivers/usb/storage/initializers.c:49:6: warning: variable 'result' set but=
=20
not used [-Wunused-but-set-variable]
drivers/usb/storage/initializers.c: In function 'usb_stor_huawei_e220_init':
drivers/usb/storage/initializers.c:98:6: warning: variable 'result' set but=
=20
not used [-Wunused-but-set-variable]
drivers/usb/storage/sierra_ms.c: In function 'sierra_ms_init':
drivers/usb/storage/sierra_ms.c:133:22: warning: variable 'sd' set but not=
=20
used [-Wunused-but-set-variable]
drivers/usb/storage/sierra_ms.c:129:14: warning: variable 'delay_t' set but=
=20
not used [-Wunused-but-set-variable]
drivers/usb/host/u132-hcd.c: In function 'u132_probe':
drivers/usb/host/u132-hcd.c:3093:6: warning: variable 'num_ports' set but n=
ot=20
used [-Wunused-but-set-variable]
drivers/usb/host/whci/asl.c: In function 'process_qset':
drivers/usb/host/whci/asl.c:104:7: warning: variable 't' set but not used [-
Wunused-but-set-variable]
drivers/net/bna/bfa_ioc.c: In function 'bfa_nw_ioc_fwver_get':
drivers/net/bna/bfa_ioc.c:1275:13: warning: variable 'pgoff' set but not us=
ed=20
[-Wunused-but-set-variable]
drivers/net/bna/bfa_ioc.c: In function 'bfa_ioc_download_fw':
drivers/net/bna/bfa_ioc.c:1512:13: warning: variable 'pgoff' set but not us=
ed=20
[-Wunused-but-set-variable]
drivers/net/bna/bna_txrx.c: In function 'bna_rit_create':
drivers/net/bna/bna_txrx.c:2232:14: warning: variable 'bna' set but not use=
d=20
[-Wunused-but-set-variable]
drivers/net/bna/bna_txrx.c: In function 'bna_rx_create':
drivers/net/bna/bna_txrx.c:2833:54: warning: variable 'ret' set but not use=
d=20
[-Wunused-but-set-variable]
drivers/scsi/esp_scsi.c: In function 'esp_finish_select':
drivers/scsi/esp_scsi.c:1201:5: warning: variable 'orig_select_state' set b=
ut=20
not used [-Wunused-but-set-variable]
drivers/scsi/a100u2w.c: In function 'inia100_probe_one':
drivers/scsi/a100u2w.c:1094:8: warning: variable 'bios_phys' set but not us=
ed=20
[-Wunused-but-set-variable]
drivers/scsi/initio.c: In function 'initio_find_busy_scb':
drivers/scsi/initio.c:899:30: warning: variable 'prev' set but not used [-
Wunused-but-set-variable]
drivers/usb/host/whci/pzl.c: In function 'pzl_process_qset':
drivers/usb/host/whci/pzl.c:110:7: warning: variable 't' set but not used [-
Wunused-but-set-variable]
drivers/net/bonding/bond_sysfs.c: In function 'bonding_store_carrier':
drivers/net/bonding/bond_sysfs.c:1182:17: warning: variable 'ret' set but n=
ot=20
used [-Wunused-but-set-variable]
drivers/net/bonding/bond_sysfs.c: In function 'bonding_store_slaves_active':
drivers/net/bonding/bond_sysfs.c:1566:20: warning: variable 'ret' set but n=
ot=20
used [-Wunused-but-set-variable]
drivers/usb/serial/iuu_phoenix.c: In function 'iuu_rxcmd':
drivers/usb/serial/iuu_phoenix.c:199:6: warning: variable 'result' set but =
not=20
used [-Wunused-but-set-variable]
drivers/usb/serial/iuu_phoenix.c: In function 'iuu_status_callback':
drivers/usb/serial/iuu_phoenix.c:287:6: warning: variable 'result' set but =
not=20
used [-Wunused-but-set-variable]
drivers/usb/serial/iuu_phoenix.c: In function 'iuu_led_activity_on':
drivers/usb/serial/iuu_phoenix.c:406:6: warning: variable 'result' set but =
not=20
used [-Wunused-but-set-variable]
drivers/usb/serial/iuu_phoenix.c: In function 'iuu_led_activity_off':
drivers/usb/serial/iuu_phoenix.c:427:6: warning: variable 'result' set but =
not=20
used [-Wunused-but-set-variable]
drivers/scsi/3w-xxxx.c: In function 'tw_empty_response_que':
drivers/scsi/3w-xxxx.c:463:24: warning: variable 'response_que_value' set b=
ut=20
not used [-Wunused-but-set-variable]
drivers/scsi/3w-xxxx.c: In function 'tw_scsi_biosparam':
drivers/scsi/3w-xxxx.c:1372:23: warning: variable 'tw_dev' set but not used=
 [-
Wunused-but-set-variable]
drivers/scsi/3w-9xxx.c: In function 'twa_empty_response_queue':
drivers/scsi/3w-9xxx.c:942:24: warning: variable 'response_que_value' set b=
ut=20
not used [-Wunused-but-set-variable]
drivers/scsi/3w-sas.c: In function 'twl_scsiop_execute_scsi':
drivers/scsi/3w-sas.c:333:22: warning: variable 'sglist' set but not used [-
Wunused-but-set-variable]
drivers/scsi/3w-9xxx.c: In function 'twa_scsi_biosparam':
drivers/scsi/3w-9xxx.c:1717:23: warning: variable 'tw_dev' set but not used=
 [-
Wunused-but-set-variable]
drivers/scsi/3w-9xxx.c: In function 'twa_scsiop_execute_scsi':
drivers/scsi/3w-9xxx.c:1825:22: warning: variable 'sglist' set but not used=
 [-
Wunused-but-set-variable]
drivers/scsi/3w-sas.c: In function 'twl_scsi_biosparam':
drivers/usb/serial/keyspan.c: In function 'keyspan_open':drivers/scsi/3w-
sas.c:1455:23: warning: variable 'tw_dev' set but not used [-Wunused-but-se=
t-
variable]
drivers/usb/serial/keyspan.c:1195:34: warning: variable 's_priv' set but no=
t=20
used [-Wunused-but-set-variable]
drivers/usb/serial/keyspan.c: In function 'keyspan_close':
drivers/usb/serial/keyspan.c:1293:34: warning: variable 's_priv' set but no=
t=20
used [-Wunused-but-set-variable]
drivers/usb/serial/keyspan.c: In function 'keyspan_usa26_send_setup':
drivers/usb/serial/keyspan.c:1825:11: warning: variable 'outcont_urb' set b=
ut=20
not used [-Wunused-but-set-variable]
drivers/net/can/dev.c: In function 'can_calc_bittiming':
drivers/net/can/dev.c:72:13: warning: variable 'best_rate' set but not used=
 [-
Wunused-but-set-variable]
drivers/usb/serial/kobil_sct.c: In function 'kobil_set_termios':
drivers/usb/serial/kobil_sct.c:623:6: warning: variable 'result' set but no=
t=20
used [-Wunused-but-set-variable]
drivers/net/can/sja1000/kvaser_pci.c: In function 'kvaser_pci_add_chan':
drivers/net/can/sja1000/kvaser_pci.c:218:11: warning: variable 'init_step' =
set=20
but not used [-Wunused-but-set-variable]
drivers/scsi/pmcraid.c: In function 'pmcraid_abort_cmd':
drivers/scsi/pmcraid.c:2943:33: warning: variable 'res' set but not used [-
Wunused-but-set-variable]
drivers/scsi/pmcraid.c: In function 'pmcraid_ioctl_passthrough':
drivers/scsi/pmcraid.c:3811:3: warning: passing argument 2 of 'access_ok'=20
makes pointer from integer without a cast [enabled by default]
/builddir/build/BUILD/kernel-2.6.37.fc15/linux-2.6.37.sparc64/arch/sparc/in=
clude/asm/uaccess_64.h:56:19:=20
note: expected 'const void *' but argument is of type 'long unsigned int'
drivers/scsi/st.c: In function 'flush_buffer':
drivers/scsi/st.c:761:20: warning: variable 'STbuffer' set but not used [-
Wunused-but-set-variable]
drivers/scsi/osst.c: In function 'osst_configure_onstream':
drivers/scsi/osst.c:2691:33: warning: variable 'drive_buffer_size' set but =
not=20
used [-Wunused-but-set-variable]
drivers/usb/serial/mos7720.c: In function 'mos7720_open':
drivers/usb/serial/mos7720.c:1017:26: warning: variable 'port0' set but not=
=20
used [-Wunused-but-set-variable]
drivers/usb/serial/mos7720.c: In function 'change_port_settings':
drivers/usb/serial/mos7720.c:1596:7: warning: variable 'mask' set but not u=
sed=20
[-Wunused-but-set-variable]
drivers/usb/serial/mos7720.c:1595:11: warning: variable 'iflag' set but not=
=20
used [-Wunused-but-set-variable]
drivers/usb/serial/mos7720.c: In function 'mos7720_set_termios':
drivers/usb/serial/mos7720.c:1756:15: warning: variable 'cflag' set but not=
=20
used [-Wunused-but-set-variable]
drivers/usb/serial/mos7840.c: In function 'mos7840_interrupt_callback':
drivers/usb/serial/mos7840.c:588:14: warning: variable 'st' set but not use=
d=20
[-Wunused-but-set-variable]
drivers/usb/serial/mos7840.c: In function 'mos7840_write':
drivers/usb/serial/mos7840.c:1437:17: warning: variable 'data1' set but not=
=20
used [-Wunused-but-set-variable]
drivers/usb/serial/mos7840.c: In function 'mos7840_tiocmget':
drivers/usb/serial/mos7840.c:1654:6: warning: variable 'status' set but not=
=20
used [-Wunused-but-set-variable]
drivers/usb/serial/mos7840.c: In function 'mos7840_send_cmd_write_baud_rate=
':
drivers/usb/serial/mos7840.c:1802:16: warning: variable 'number' set but no=
t=20
used [-Wunused-but-set-variable]
drivers/usb/serial/mos7840.c: In function 'mos7840_change_port_settings':
drivers/usb/serial/mos7840.c:1914:11: warning: variable 'iflag' set but not=
=20
used [-Wunused-but-set-variable]
drivers/usb/serial/mos7840.c: In function 'mos7840_set_termios':
drivers/usb/serial/mos7840.c:2087:15: warning: variable 'cflag' set but not=
=20
used [-Wunused-but-set-variable]
drivers/net/can/usb/ems_usb.c: In function 'ems_usb_read_bulk_callback':
drivers/net/can/usb/ems_usb.c:442:17: warning: variable 'again' set but not=
=20
used [-Wunused-but-set-variable]
drivers/net/can/usb/esd_usb2.c: In function 'esd_usb2_write_bulk_callback':
drivers/net/can/usb/esd_usb2.c:455:19: warning: variable 'dev' set but not=
=20
used [-Wunused-but-set-variable]
drivers/net/e1000/e1000_main.c: In function 'e1000_watchdog':
drivers/net/e1000/e1000_main.c:2408:9: warning: variable 'txb2b' set but no=
t=20
used [-Wunused-but-set-variable]
drivers/net/e1000/e1000_hw.c: In function 'e1000_phy_init_script':
drivers/net/e1000/e1000_hw.c:158:6: warning: variable 'ret_val' set but not=
=20
used [-Wunused-but-set-variable]
drivers/net/e1000/e1000_hw.c: In function 'e1000_reset_hw':
drivers/net/e1000/e1000_hw.c:411:6: warning: variable 'icr' set but not use=
d=20
[-Wunused-but-set-variable]
drivers/net/e1000/e1000_hw.c: In function 'e1000_check_for_link':
drivers/net/e1000/e1000_hw.c:2422:6: warning: variable 'signal' set but not=
=20
used [-Wunused-but-set-variable]
drivers/net/e1000/e1000_hw.c:2418:6: warning: variable 'ctrl' set but not u=
sed=20
[-Wunused-but-set-variable]
drivers/net/e1000/e1000_hw.c:2417:6: warning: variable 'rxcw' set but not u=
sed=20
[-Wunused-but-set-variable]
drivers/net/e1000/e1000_hw.c: In function 'e1000_clear_hw_cntrs':
drivers/net/e1000/e1000_hw.c:4736:15: warning: variable 'temp' set but not=
=20
used [-Wunused-but-set-variable]
drivers/net/bnx2x/bnx2x_link.c: In function 'bnx2x_set_swap_lanes':
drivers/net/bnx2x/bnx2x_link.c:1846:6: warning: variable 'ser_lane' set but=
=20
not used [-Wunused-but-set-variable]
drivers/net/bnx2x/bnx2x_link.c: In function 'bnx2x_populate_int_phy':
drivers/net/bnx2x/bnx2x_link.c:7088:6: warning: variable 'chip_id' set but =
not=20
used [-Wunused-but-set-variable]
drivers/net/bnx2x/bnx2x_link.c: In function 'bnx2x_phy_probe':
drivers/net/bnx2x/bnx2x_link.c:7349:32: warning: variable 'link_cfg_idx' se=
t=20
but not used [-Wunused-but-set-variable]
drivers/net/bnx2x/bnx2x_cmn.c: In function 'bnx2x_free_tx_skbs':
drivers/net/bnx2x/bnx2x_cmn.c:917:7: warning: variable 'bd_cons' set but no=
t=20
used [-Wunused-but-set-variable]
drivers/scsi/scsi_debug.c: In function 'resp_log_sense':
drivers/scsi/scsi_debug.c:1572:15: warning: variable 'pcontrol' set but not=
=20
used [-Wunused-but-set-variable]
drivers/scsi/scsi_debug.c: In function 'scsi_debug_proc_info':
drivers/scsi/scsi_debug.c:2785:6: warning: variable 'orig_length' set but n=
ot=20
used [-Wunused-but-set-variable]
drivers/scsi/aacraid/aachba.c: In function 'aac_srb_callback':
drivers/scsi/aacraid/aachba.c:2595:18: warning: variable 'dev' set but not=
=20
used [-Wunused-but-set-variable]
drivers/scsi/aacraid/aachba.c: In function 'aac_build_sg':
drivers/scsi/aacraid/aachba.c:2816:18: warning: variable 'dev' set but not=
=20
used [-Wunused-but-set-variable]
drivers/scsi/aacraid/aachba.c: In function 'aac_build_sg64':
drivers/scsi/aacraid/aachba.c:2858:18: warning: variable 'dev' set but not=
=20
used [-Wunused-but-set-variable]
drivers/scsi/arcmsr/arcmsr_hba.c: In function 'arcmsr_sleep_for_bus_reset':
drivers/scsi/arcmsr/arcmsr_hba.c:176:21: warning: variable 'shost' set but =
not=20
used [-Wunused-but-set-variable]
drivers/scsi/arcmsr/arcmsr_hba.c: In function 'arcmsr_drain_donequeue':
drivers/scsi/arcmsr/arcmsr_hba.c:924:10: warning: variable 'lun' set but no=
t=20
used [-Wunused-but-set-variable]
drivers/scsi/arcmsr/arcmsr_hba.c:924:6: warning: variable 'id' set but not=
=20
used [-Wunused-but-set-variable]
drivers/scsi/be2iscsi/be_main.c: In function 'be_isr_msix':
drivers/scsi/be2iscsi/be_main.c:713:24: warning: variable 'cq' set but not=
=20
used [-Wunused-but-set-variable]
drivers/scsi/be2iscsi/be_main.c: In function 'be_isr':
drivers/scsi/be2iscsi/be_main.c:777:23: warning: variable 'index' set but n=
ot=20
used [-Wunused-but-set-variable]
drivers/scsi/be2iscsi/be_main.c: In function 'beiscsi_process_cq':
drivers/scsi/be2iscsi/be_main.c:1853:19: warning: variable 'dmsg' set but n=
ot=20
used [-Wunused-but-set-variable]
drivers/scsi/be2iscsi/be_main.c: In function 'beiscsi_find_mem_req':
drivers/scsi/be2iscsi/be_main.c:2194:15: warning: variable 'num_cq_pages' s=
et=20
but not used [-Wunused-but-set-variable]
drivers/scsi/be2iscsi/be_main.c: In function 'beiscsi_create_wrb_rings':
drivers/scsi/be2iscsi/be_main.c:2970:38: warning: variable 'size' set but n=
ot=20
used [-Wunused-but-set-variable]
drivers/scsi/be2iscsi/be_main.c:2970:30: warning: variable 'offset' set but=
 not=20
used [-Wunused-but-set-variable]
drivers/scsi/be2iscsi/be_main.c:2970:15: warning: variable 'wrb_mem_index' =
set=20
but not used [-Wunused-but-set-variable]
drivers/scsi/bfa/bfad_attr.c: In function 'bfad_im_vport_delete':
drivers/scsi/bfa/bfad_attr.c:449:22: warning: variable 'port' set but not u=
sed=20
[-Wunused-but-set-variable]
drivers/scsi/bfa/bfa_ioc.c: In function 'bfa_ioc_fwver_get':
drivers/scsi/bfa/bfa_ioc.c:1317:13: warning: variable 'pgoff' set but not u=
sed=20
[-Wunused-but-set-variable]
drivers/scsi/bfa/bfa_ioc.c: In function 'bfa_ioc_download_fw':
drivers/scsi/bfa/bfa_ioc.c:1569:13: warning: variable 'pgoff' set but not u=
sed=20
[-Wunused-but-set-variable]
drivers/net/enic/vnic_wq.c: In function 'vnic_wq_alloc_bufs':
drivers/net/enic/vnic_wq.c:33:19: warning: variable 'vdev' set but not used=
 [-
Wunused-but-set-variable]
drivers/net/hamradio/6pack.c: In function 'decode_prio_command':
drivers/net/hamradio/6pack.c:908:16: warning: variable 'channel' set but no=
t=20
used [-Wunused-but-set-variable]
drivers/net/hamradio/6pack.c: In function 'decode_std_command':
drivers/net/hamradio/6pack.c:965:40: warning: variable 'channel' set but no=
t=20
used [-Wunused-but-set-variable]
drivers/net/igb/igb_main.c: In function 'igb_has_link':
drivers/net/igb/igb_main.c:3424:6: warning: variable 'ret_val' set but not=
=20
used [-Wunused-but-set-variable]
drivers/net/enic/vnic_rq.c: In function 'vnic_rq_alloc_bufs':
drivers/net/enic/vnic_rq.c:33:19: warning: variable 'vdev' set but not used=
 [-
Wunused-but-set-variable]
drivers/net/igb/e1000_82575.c: In function 'igb_reset_hw_82575':
drivers/net/igb/e1000_82575.c:934:12: warning: variable 'icr' set but not u=
sed=20
[-Wunused-but-set-variable]
drivers/net/igb/e1000_82575.c: In function 'igb_reset_hw_82580':
drivers/net/igb/e1000_82575.c:1653:12: warning: variable 'icr' set but not=
=20
used [-Wunused-but-set-variable]
drivers/net/igbvf/netdev.c: In function 'igbvf_configure_rx':
drivers/net/igbvf/netdev.c:1364:6: warning: variable 'rdlen' set but not us=
ed=20
[-Wunused-but-set-variable]
drivers/net/irda/irda-usb.c: In function 'irda_usb_net_timeout':
drivers/net/irda/irda-usb.c:632:6: warning: variable 'done' set but not use=
d=20
[-Wunused-but-set-variable]
drivers/net/irda/mcs7780.c: In function 'mcs_receive_irq':
drivers/net/irda/mcs7780.c:760:6: warning: variable 'ret' set but not used =
[-
Wunused-but-set-variable]
drivers/net/irda/irtty-sir.c: In function 'irtty_change_speed':
drivers/net/irda/irtty-sir.c:119:6: warning: variable 'cflag' set but not u=
sed=20
[-Wunused-but-set-variable]
drivers/scsi/bnx2i/bnx2i_hwi.c: In function 'bnx2i_send_iscsi_login':
drivers/scsi/bnx2i/bnx2i_hwi.c:327:20: warning: variable 'bnx2i_cmd' set bu=
t=20
not used [-Wunused-but-set-variable]
drivers/scsi/bnx2i/bnx2i_hwi.c: In function 'bnx2i_send_iscsi_tmf':
drivers/scsi/bnx2i/bnx2i_hwi.c:386:20: warning: variable 'bnx2i_cmd' set bu=
t=20
not used [-Wunused-but-set-variable]
drivers/scsi/bnx2i/bnx2i_hwi.c: In function 'bnx2i_send_iscsi_nopout':
drivers/scsi/bnx2i/bnx2i_hwi.c:486:20: warning: variable 'bnx2i_cmd' set bu=
t=20
not used [-Wunused-but-set-variable]
drivers/scsi/bnx2i/bnx2i_hwi.c: In function 'bnx2i_send_iscsi_logout':
drivers/scsi/bnx2i/bnx2i_hwi.c:544:20: warning: variable 'bnx2i_cmd' set bu=
t=20
not used [-Wunused-but-set-variable]
drivers/scsi/bnx2i/bnx2i_hwi.c: In function 'bnx2i_process_ofld_cmpl':
drivers/scsi/bnx2i/bnx2i_hwi.c:2168:6: warning: variable 'cid_num' set but =
not=20
used [-Wunused-but-set-variable]
drivers/scsi/bfa/bfa_fcs_rport.c: In function 'bfa_fcs_rport_process_adisc':
drivers/scsi/bfa/bfa_fcs_rport.c:1881:21: warning: variable 'adisc' set but=
=20
not used [-Wunused-but-set-variable]
drivers/scsi/bfa/bfa_fcpim.c: In function 'bfa_ioim_send_ioreq':
drivers/scsi/bfa/bfa_fcpim.c:2113:4: warning: left shift count >=3D width o=
f=20
type [enabled by default]
drivers/scsi/bfa/bfa_fcpim.c:2113:4: warning: right shift count >=3D width =
of=20
type [enabled by default]
drivers/scsi/bfa/bfa_fcpim.c:2125:4: warning: left shift count >=3D width o=
f=20
type [enabled by default]
drivers/scsi/bfa/bfa_fcpim.c:2125:4: warning: right shift count >=3D width =
of=20
type [enabled by default]
drivers/scsi/bfa/bfa_svc.c: In function 'uf_recv':
drivers/scsi/bfa/bfa_svc.c:4969:17: warning: variable 'fchs' set but not us=
ed=20
[-Wunused-but-set-variable]
drivers/net/ixgb/ixgb_hw.c: In function 'ixgb_adapter_stop':
drivers/net/ixgb/ixgb_hw.c:125:6: warning: variable 'icr_reg' set but not u=
sed=20
[-Wunused-but-set-variable]
drivers/net/ixgb/ixgb_hw.c: In function 'ixgb_init_hw':
drivers/net/ixgb/ixgb_hw.c:300:6: warning: variable 'ctrl_reg' set but not=
=20
used [-Wunused-but-set-variable]
drivers/net/ixgb/ixgb_hw.c: In function 'ixgb_clear_hw_cntrs':
drivers/net/ixgb/ixgb_hw.c:975:15: warning: variable 'temp_reg' set but not=
=20
used [-Wunused-but-set-variable]
drivers/net/ixgb/ixgb_hw.c: In function 'ixgb_optics_reset':
drivers/net/ixgb/ixgb_hw.c:1187:7: warning: variable 'mdio_reg' set but not=
=20
used [-Wunused-but-set-variable]
drivers/scsi/fcoe/fcoe.c: In function 'fcoe_recv_frame':
drivers/scsi/fcoe/fcoe.c:1621:20: warning: variable 'port' set but not used=
 [-
Wunused-but-set-variable]
drivers/net/irda/ksdazzle-sir.c: In function 'ksdazzle_probe':
drivers/net/irda/ksdazzle-sir.c:584:21: warning: variable 'maxp_out' set bu=
t=20
not used [-Wunused-but-set-variable]
drivers/net/irda/kingsun-sir.c: In function 'kingsun_rcv_irq':
drivers/net/irda/kingsun-sir.c:204:6: warning: variable 'ret' set but not u=
sed=20
[-Wunused-but-set-variable]
drivers/net/ixgbevf/ixgbevf_main.c: In function 'ixgbevf_check_tx_hang':
drivers/net/ixgbevf/ixgbevf_main.c:181:28: warning: variable 'tx_desc' set =
but=20
not used [-Wunused-but-set-variable]
drivers/net/ixgbevf/ixgbevf_main.c: In function 'ixgbevf_receive_skb':
drivers/net/ixgbevf/ixgbevf_main.c:337:6: warning: variable 'ret' set but n=
ot=20
used [-Wunused-but-set-variable]
drivers/net/irda/ks959-sir.c: In function 'ks959_rcv_irq':
drivers/net/irda/ks959-sir.c:435:6: warning: variable 'ret' set but not use=
d=20
[-Wunused-but-set-variable]
drivers/net/ixgbevf/ixgbevf_main.c: In function 'ixgbevf_assign_netdev_ops':
drivers/net/ixgbevf/ixgbevf_main.c:3275:26: warning: variable 'adapter' set=
=20
but not used [-Wunused-but-set-variable]
drivers/scsi/libfc/fc_fcp.c: In function 'fc_fcp_srr':
drivers/scsi/libfc/fc_fcp.c:1654:5: warning: variable 'cdb_op' set but not=
=20
used [-Wunused-but-set-variable]
drivers/scsi/libfc/fc_fcp.c: In function 'fc_queuecommand_lck':
drivers/scsi/libfc/fc_fcp.c:1801:30: warning: variable 'rpriv' set but not=
=20
used [-Wunused-but-set-variable]
drivers/net/mlx4/mr.c: In function 'mlx4_fmr_alloc':
drivers/net/mlx4/mr.c:583:6: warning: variable 'mtt_seg' set but not used [-
Wunused-but-set-variable]
drivers/net/netxen/netxen_nic_hw.c: In function 'netxen_send_cmd_descs':
drivers/net/netxen/netxen_nic_hw.c:587:25: warning: variable 'cmd_desc' set=
=20
but not used [-Wunused-but-set-variable]
drivers/net/netxen/netxen_nic_hw.c:585:19: warning: variable 'consumer' set=
=20
but not used [-Wunused-but-set-variable]
drivers/net/netxen/netxen_nic_main.c: In function 'netxen_nic_xmit_frame':
drivers/net/netxen/netxen_nic_main.c:1846:18: warning: variable 'no_of_desc=
'=20
set but not used [-Wunused-but-set-variable]
drivers/scsi/libsas/sas_port.c: In function 'sas_porte_broadcast_rcvd':
drivers/scsi/libsas/sas_port.c:225:6: warning: variable 'prim' set but not=
=20
used [-Wunused-but-set-variable]
drivers/net/pcmcia/3c574_cs.c: In function 'update_stats':
drivers/net/pcmcia/3c574_cs.c:959:9: warning: variable 'tx' set but not use=
d=20
[-Wunused-but-set-variable]
drivers/net/pcmcia/3c574_cs.c:959:5: warning: variable 'rx' set but not use=
d=20
[-Wunused-but-set-variable]
drivers/scsi/libsas/sas_discover.c: In function 'sas_revalidate_domain':
drivers/scsi/libsas/sas_discover.c:332:6: warning: variable 'res' set but n=
ot=20
used [-Wunused-but-set-variable]
drivers/net/qlcnic/qlcnic_hw.c: In function 'qlcnic_send_cmd_descs':
drivers/net/qlcnic/qlcnic_hw.c:308:25: warning: variable 'cmd_desc' set but=
=20
not used [-Wunused-but-set-variable]
drivers/net/qlcnic/qlcnic_hw.c:306:19: warning: variable 'consumer' set but=
=20
not used [-Wunused-but-set-variable]
drivers/net/qlcnic/qlcnic_main.c: In function 'qlcnic_set_function_modes':
drivers/net/qlcnic/qlcnic_main.c:498:6: warning: variable 'ref_count' set b=
ut=20
not used [-Wunused-but-set-variable]
drivers/net/qlcnic/qlcnic_main.c: In function 'qlcnic_setup_pci_map':
drivers/net/qlcnic/qlcnic_main.c:571:18: warning: variable 'mem_base' set b=
ut=20
not used [-Wunused-but-set-variable]
drivers/net/qlcnic/qlcnic_main.c: In function 'qlcnic_xmit_frame':
drivers/net/qlcnic/qlcnic_main.c:2105:18: warning: variable 'no_of_desc' se=
t=20
but not used [-Wunused-but-set-variable]
drivers/net/mlx4/en_tx.c: In function 'mlx4_en_process_tx_cq':
drivers/net/mlx4/en_tx.c:313:6: warning: variable 'cq_last_sav' set but not=
=20
used [-Wunused-but-set-variable]
drivers/net/pcmcia/smc91c92_cs.c: In function 'smc91c92_probe':
drivers/net/pcmcia/smc91c92_cs.c:939:6: warning: 'j' may be used uninitiali=
zed=20
in this function [-Wuninitialized]
drivers/net/pcmcia/smc91c92_cs.c:812:12: note: 'j' was declared here
drivers/scsi/libsas/sas_scsi_host.c: In function 'sas_scsi_task_done':
drivers/scsi/libsas/sas_scsi_host.c:116:3: warning: case value '2' not in=20
enumerated type 'enum exec_status' [-Wswitch]
drivers/scsi/libsas/sas_scsi_host.c: In function 'sas_slave_configure':
drivers/scsi/libsas/sas_scsi_host.c:784:24: warning: variable 'sas_ha' set =
but=20
not used [-Wunused-but-set-variable]
drivers/scsi/libsas/sas_ata.c: In function 'sas_to_ata_err':
drivers/scsi/libsas/sas_ata.c:74:3: warning: case value '2' not in enumerat=
ed=20
type 'enum exec_status' [-Wswitch]
drivers/net/sfc/nic.c: In function 'efx_handle_rx_not_ok':
drivers/net/sfc/nic.c:769:11: warning: variable 'rx_ev_pkt_type' set but no=
t=20
used [-Wunused-but-set-variable]
drivers/net/sfc/nic.c:768:23: warning: variable 'rx_ev_mcast_pkt' set but n=
ot=20
used [-Wunused-but-set-variable]
drivers/net/sfc/nic.c:768:7: warning: variable 'rx_ev_hdr_type' set but not=
=20
used [-Wunused-but-set-variable]
drivers/net/sfc/nic.c:767:7: warning: variable 'rx_ev_other_err' set but no=
t=20
used [-Wunused-but-set-variable]
drivers/net/sfc/mcdi_mac.c: In function 'efx_mcdi_set_mac':
drivers/net/sfc/mcdi_mac.c:36:2: warning: case value '3' not in enumerated=
=20
type 'enum efx_fc_type' [-Wswitch]
drivers/scsi/lpfc/lpfc_sli.c: In function 'lpfc_sli4_mq_put':
drivers/scsi/lpfc/lpfc_sli.c:159:11: warning: variable 'host_index' set but=
=20
not used [-Wunused-but-set-variable]
drivers/scsi/lpfc/lpfc_sli.c: In function 'lpfc_sli_process_unsol_iocb':
drivers/scsi/lpfc/lpfc_sli.c:2373:21: warning: variable 'match' set but not=
=20
used [-Wunused-but-set-variable]
drivers/scsi/lpfc/lpfc_ct.c: In function 'lpfc_cmpl_ct_cmd_gid_ft':
drivers/scsi/lpfc/lpfc_ct.c:588:22: warning: variable 'bmp' set but not use=
d=20
[-Wunused-but-set-variable]
drivers/scsi/lpfc/lpfc_ct.c: In function 'lpfc_fdmi_cmd':
drivers/scsi/lpfc/lpfc_ct.c:1565:16: warning: variable 'vp' set but not use=
d=20
[-Wunused-but-set-variable]
drivers/scsi/lpfc/lpfc_sli.c: In function 'lpfc_sli4_post_rpi_hdr':
drivers/scsi/lpfc/lpfc_sli.c:12386:11: warning: variable 'mbox_tmo' set but=
=20
not used [-Wunused-but-set-variable]
drivers/scsi/lpfc/lpfc_sli.c: In function 'lpfc_sli4_add_fcf_record':
drivers/scsi/lpfc/lpfc_sli.c:12662:13: warning: variable 'phys_addr' set bu=
t=20
not used [-Wunused-but-set-variable]
drivers/net/skfp/cfm.c: In function 'cfm':
drivers/net/skfp/cfm.c:217:6: warning: variable 'oldstate' set but not used=
 [-
Wunused-but-set-variable]
drivers/scsi/lpfc/lpfc_els.c: In function 'lpfc_issue_reg_vfi':
drivers/scsi/lpfc/lpfc_els.c:435:20: warning: variable 'sp' set but not use=
d=20
[-Wunused-but-set-variable]
drivers/scsi/lpfc/lpfc_els.c: In function 'lpfc_issue_els_flogi':
drivers/scsi/lpfc/lpfc_els.c:992:24: warning: variable 'pring' set but not=
=20
used [-Wunused-but-set-variable]
drivers/scsi/lpfc/lpfc_els.c: In function 'lpfc_more_plogi':
drivers/scsi/lpfc/lpfc_els.c:1233:6: warning: variable 'sentplogi' set but =
not=20
used [-Wunused-but-set-variable]
drivers/scsi/lpfc/lpfc_els.c: In function 'lpfc_cmpl_els_plogi':
drivers/scsi/lpfc/lpfc_els.c:1561:21: warning: variable 'type' set but not=
=20
used [-Wunused-but-set-variable]
drivers/scsi/lpfc/lpfc_els.c:1561:16: warning: variable 'did' set but not u=
sed=20
[-Wunused-but-set-variable]
drivers/scsi/lpfc/lpfc_els.c:1561:12: warning: variable 'rc' set but not us=
ed=20
[-Wunused-but-set-variable]
drivers/scsi/lpfc/lpfc_els.c: In function 'lpfc_issue_els_plogi':
drivers/scsi/lpfc/lpfc_els.c:1694:19: warning: variable 'psli' set but not=
=20
used [-Wunused-but-set-variable]
drivers/scsi/lpfc/lpfc_els.c:1691:10: warning: variable 'icmd' set but not=
=20
used [-Wunused-but-set-variable]
drivers/scsi/lpfc/lpfc_els.c: In function 'lpfc_cmpl_els_prli':
drivers/scsi/lpfc/lpfc_els.c:1769:19: warning: variable 'psli' set but not=
=20
used [-Wunused-but-set-variable]
drivers/scsi/lpfc/lpfc_els.c: In function 'lpfc_issue_els_prli':
drivers/scsi/lpfc/lpfc_els.c:1852:10: warning: variable 'icmd' set but not=
=20
used [-Wunused-but-set-variable]
drivers/scsi/lpfc/lpfc_els.c: In function 'lpfc_more_adisc':
drivers/scsi/lpfc/lpfc_els.c:2000:6: warning: variable 'sentadisc' set but =
not=20
used [-Wunused-but-set-variable]
drivers/scsi/lpfc/lpfc_els.c: In function 'lpfc_issue_els_adisc':
drivers/scsi/lpfc/lpfc_els.c:2140:10: warning: variable 'icmd' set but not=
=20
used [-Wunused-but-set-variable]
drivers/scsi/lpfc/lpfc_els.c: In function 'lpfc_cmpl_els_logo':
drivers/scsi/lpfc/lpfc_els.c:2205:19: warning: variable 'psli' set but not=
=20
used [-Wunused-but-set-variable]
drivers/scsi/lpfc/lpfc_els.c: In function 'lpfc_issue_els_logo':
drivers/scsi/lpfc/lpfc_els.c:2292:10: warning: variable 'icmd' set but not=
=20
used [-Wunused-but-set-variable]
drivers/scsi/lpfc/lpfc_els.c: In function 'lpfc_issue_els_scr':
drivers/scsi/lpfc/lpfc_els.c:2410:19: warning: variable 'psli' set but not=
=20
used [-Wunused-but-set-variable]
drivers/scsi/lpfc/lpfc_els.c:2408:10: warning: variable 'icmd' set but not=
=20
used [-Wunused-but-set-variable]
drivers/scsi/lpfc/lpfc_els.c: In function 'lpfc_issue_els_farpr':
drivers/scsi/lpfc/lpfc_els.c:2503:19: warning: variable 'psli' set but not=
=20
used [-Wunused-but-set-variable]
drivers/scsi/lpfc/lpfc_els.c:2501:10: warning: variable 'icmd' set but not=
=20
used [-Wunused-but-set-variable]
drivers/scsi/lpfc/lpfc_els.c: In function 'lpfc_els_retry_delay_handler':
drivers/scsi/lpfc/lpfc_els.c:2696:16: warning: variable 'did' set but not u=
sed=20
[-Wunused-but-set-variable]
drivers/scsi/lpfc/lpfc_els.c: In function 'lpfc_els_rsp_acc':
drivers/scsi/lpfc/lpfc_els.c:3548:19: warning: variable 'psli' set but not=
=20
used [-Wunused-but-set-variable]
drivers/scsi/lpfc/lpfc_els.c: In function 'lpfc_els_rsp_reject':
drivers/scsi/lpfc/lpfc_els.c:3681:19: warning: variable 'psli' set but not=
=20
used [-Wunused-but-set-variable]
drivers/scsi/lpfc/lpfc_els.c: In function 'lpfc_els_rsp_prli_acc':
drivers/scsi/lpfc/lpfc_els.c:3830:19: warning: variable 'psli' set but not=
=20
used [-Wunused-but-set-variable]
drivers/scsi/lpfc/lpfc_els.c: In function 'lpfc_els_rsp_rnid_acc':
drivers/scsi/lpfc/lpfc_els.c:3931:19: warning: variable 'psli' set but not=
=20
used [-Wunused-but-set-variable]
drivers/scsi/lpfc/lpfc_els.c: In function 'lpfc_els_rsp_echo_acc':
drivers/scsi/lpfc/lpfc_els.c:4058:19: warning: variable 'psli' set but not=
=20
used [-Wunused-but-set-variable]
drivers/scsi/lpfc/lpfc_els.c: In function 'lpfc_els_rcv_rscn':
drivers/scsi/lpfc/lpfc_els.c:4434:10: warning: variable 'icmd' set but not=
=20
used [-Wunused-but-set-variable]
drivers/scsi/lpfc/lpfc_els.c: In function 'lpfc_els_rcv_rnid':
drivers/scsi/lpfc/lpfc_els.c:4827:16: warning: variable 'did' set but not u=
sed=20
[-Wunused-but-set-variable]
drivers/scsi/lpfc/lpfc_els.c:4827:11: warning: variable 'cmd' set but not u=
sed=20
[-Wunused-but-set-variable]
drivers/scsi/lpfc/lpfc_els.c: In function 'lpfc_els_rcv_rls':
drivers/scsi/lpfc/lpfc_els.c:5133:22: warning: variable 'pcmd' set but not=
=20
used [-Wunused-but-set-variable]
drivers/scsi/lpfc/lpfc_els.c: In function 'lpfc_issue_els_rrq':
drivers/scsi/lpfc/lpfc_els.c:5353:10: warning: variable 'icmd' set but not=
=20
used [-Wunused-but-set-variable]
drivers/scsi/lpfc/lpfc_els.c: In function 'lpfc_els_rcv_farp':
drivers/scsi/lpfc/lpfc_els.c:5586:11: warning: variable 'cmd' set but not u=
sed=20
[-Wunused-but-set-variable]
drivers/scsi/lpfc/lpfc_els.c: In function 'lpfc_els_rcv_farpr':
drivers/scsi/lpfc/lpfc_els.c:5658:11: warning: variable 'cmd' set but not u=
sed=20
[-Wunused-but-set-variable]
drivers/scsi/lpfc/lpfc_els.c: In function 'lpfc_issue_els_npiv_logo':
drivers/scsi/lpfc/lpfc_els.c:7200:10: warning: variable 'icmd' set but not=
=20
used [-Wunused-but-set-variable]
drivers/scsi/lpfc/lpfc_hbadisc.c: In function 'lpfc_cleanup_rpis':
drivers/scsi/lpfc/lpfc_hbadisc.c:777:7: warning: variable 'rc' set but not=
=20
used [-Wunused-but-set-variable]
drivers/scsi/lpfc/lpfc_hbadisc.c: In function 'lpfc_sli4_fcf_rec_mbox_parse=
':
drivers/scsi/lpfc/lpfc_hbadisc.c:1692:13: warning: variable 'phys_addr' set=
=20
but not used [-Wunused-but-set-variable]
drivers/scsi/lpfc/lpfc_hbadisc.c: In function 'lpfc_disc_start':
drivers/scsi/lpfc/lpfc_hbadisc.c:4606:6: warning: variable 'did_changed' se=
t=20
but not used [-Wunused-but-set-variable]
drivers/scsi/lpfc/lpfc_nportdisc.c: In function 'lpfc_disc_illegal':
drivers/scsi/lpfc/lpfc_nportdisc.c:692:13: warning: variable 'mb' set but n=
ot=20
used [-Wunused-but-set-variable]
drivers/scsi/lpfc/lpfc_mbox.c: In function 'lpfc_read_topology':
drivers/scsi/lpfc/lpfc_mbox.c:291:19: warning: variable 'psli' set but not=
=20
used [-Wunused-but-set-variable]
drivers/scsi/lpfc/lpfc_mbox.c: In function 'lpfc_init_link':
drivers/scsi/lpfc/lpfc_mbox.c:485:19: warning: variable 'psli' set but not=
=20
used [-Wunused-but-set-variable]
drivers/scsi/lpfc/lpfc_mbox.c: In function 'lpfc_read_sparam':
drivers/scsi/lpfc/lpfc_mbox.c:587:19: warning: variable 'psli' set but not=
=20
used [-Wunused-but-set-variable]
drivers/scsi/lpfc/lpfc_hbadisc.c: In function 'lpfc_parse_fcoe_conf':
drivers/scsi/lpfc/lpfc_hbadisc.c:5796:23: warning: variable 'rec_length' se=
t=20
but not used [-Wunused-but-set-variable]
drivers/scsi/lpfc/lpfc_mbox.c: In function 'lpfc_sli4_mbx_read_fcf_rec':
drivers/scsi/lpfc/lpfc_mbox.c:1847:13: warning: variable 'phys_addr' set bu=
t=20
not used [-Wunused-but-set-variable]
drivers/scsi/lpfc/lpfc_init.c: In function 'lpfc_sli4_pci_mem_unset':
drivers/scsi/lpfc/lpfc_init.c:7042:18: warning: variable 'pdev' set but not=
=20
used [-Wunused-but-set-variable]
drivers/scsi/lpfc/lpfc_init.c: In function 'lpfc_pci_probe_one_s4':
drivers/scsi/lpfc/lpfc_init.c:8505:6: warning: variable 'mcnt' set but not=
=20
used [-Wunused-but-set-variable]
drivers/scsi/lpfc/lpfc_scsi.c: In function 'lpfc_bg_setup_bpl':
drivers/scsi/lpfc/lpfc_scsi.c:1382:11: warning: variable 'blksize' set but =
not=20
used [-Wunused-but-set-variable]
drivers/net/sfc/mcdi.c: In function 'efx_mcdi_poll':
drivers/net/sfc/mcdi.c:124:24: warning: variable 'respcmd' set but not used=
 [-
Wunused-but-set-variable]
drivers/scsi/lpfc/lpfc_attr.c: In function 'lpfc_enable_npiv_show':
drivers/scsi/lpfc/lpfc_attr.c:1976:1: warning: variable 'val' set but not u=
sed=20
[-Wunused-but-set-variable]
drivers/scsi/lpfc/lpfc_attr.c: In function 'lpfc_enable_rrq_show':
drivers/scsi/lpfc/lpfc_attr.c:1983:1: warning: variable 'val' set but not u=
sed=20
[-Wunused-but-set-variable]
drivers/scsi/lpfc/lpfc_attr.c: In function 'lpfc_suppress_link_up_show':
drivers/scsi/lpfc/lpfc_attr.c:1996:1: warning: variable 'val' set but not u=
sed=20
[-Wunused-but-set-variable]
drivers/scsi/lpfc/lpfc_attr.c: In function 'lpfc_iocb_cnt_show':
drivers/scsi/lpfc/lpfc_attr.c:2046:1: warning: variable 'val' set but not u=
sed=20
[-Wunused-but-set-variable]
drivers/scsi/lpfc/lpfc_attr.c: In function 'lpfc_devloss_tmo_show':
drivers/scsi/lpfc/lpfc_attr.c:2201:1: warning: variable 'val' set but not u=
sed=20
[-Wunused-but-set-variable]
drivers/scsi/lpfc/lpfc_attr.c: In function 'lpfc_log_verbose_show':
drivers/scsi/lpfc/lpfc_attr.c:2247:1: warning: variable 'val' set but not u=
sed=20
[-Wunused-but-set-variable]
drivers/scsi/lpfc/lpfc_attr.c: In function 'lpfc_enable_da_id_show':
drivers/scsi/lpfc/lpfc_attr.c:2254:1: warning: variable 'val' set but not u=
sed=20
[-Wunused-but-set-variable]
drivers/scsi/lpfc/lpfc_attr.c: In function 'lpfc_lun_queue_depth_show':
drivers/scsi/lpfc/lpfc_attr.c:2261:1: warning: variable 'val' set but not u=
sed=20
[-Wunused-but-set-variable]
drivers/scsi/lpfc/lpfc_attr.c: In function 'lpfc_tgt_queue_depth_show':
drivers/scsi/lpfc/lpfc_attr.c:2268:1: warning: variable 'val' set but not u=
sed=20
[-Wunused-but-set-variable]
drivers/scsi/lpfc/lpfc_attr.c: In function 'lpfc_hba_queue_depth_show':
drivers/scsi/lpfc/lpfc_attr.c:2278:1: warning: variable 'val' set but not u=
sed=20
[-Wunused-but-set-variable]
drivers/scsi/lpfc/lpfc_attr.c: In function 'lpfc_peer_port_login_show':
drivers/scsi/lpfc/lpfc_attr.c:2291:1: warning: variable 'val' set but not u=
sed=20
[-Wunused-but-set-variable]
drivers/scsi/lpfc/lpfc_attr.c: In function 'lpfc_restrict_login_show':
drivers/scsi/lpfc/lpfc_attr.c:2308:1: warning: variable 'val' set but not u=
sed=20
[-Wunused-but-set-variable]
drivers/scsi/lpfc/lpfc_attr.c: In function 'lpfc_scan_down_show':
drivers/scsi/lpfc/lpfc_attr.c:2403:1: warning: variable 'val' set but not u=
sed=20
[-Wunused-but-set-variable]
drivers/scsi/lpfc/lpfc_attr.c: In function 'lpfc_topology_show':
drivers/scsi/lpfc/lpfc_attr.c:2478:1: warning: variable 'val' set but not u=
sed=20
[-Wunused-but-set-variable]
drivers/scsi/lpfc/lpfc_attr.c: In function 'lpfc_link_speed_show':
drivers/scsi/lpfc/lpfc_attr.c:2920:1: warning: variable 'val' set but not u=
sed=20
[-Wunused-but-set-variable]
drivers/scsi/lpfc/lpfc_attr.c: In function 'lpfc_aer_support_show':
drivers/scsi/lpfc/lpfc_attr.c:3048:1: warning: variable 'val' set but not u=
sed=20
[-Wunused-but-set-variable]
drivers/scsi/lpfc/lpfc_attr.c: In function 'lpfc_fcp_class_show':
drivers/scsi/lpfc/lpfc_attr.c:3140:1: warning: variable 'val' set but not u=
sed=20
[-Wunused-but-set-variable]
drivers/scsi/lpfc/lpfc_attr.c: In function 'lpfc_use_adisc_show':
drivers/scsi/lpfc/lpfc_attr.c:3147:1: warning: variable 'val' set but not u=
sed=20
[-Wunused-but-set-variable]
drivers/scsi/lpfc/lpfc_attr.c: In function 'lpfc_max_scsicmpl_time_show':
drivers/scsi/lpfc/lpfc_attr.c:3161:1: warning: variable 'val' set but not u=
sed=20
[-Wunused-but-set-variable]
drivers/scsi/lpfc/lpfc_attr.c: In function 'lpfc_ack0_show':
drivers/scsi/lpfc/lpfc_attr.c:3195:1: warning: variable 'val' set but not u=
sed=20
[-Wunused-but-set-variable]
drivers/scsi/lpfc/lpfc_attr.c: In function 'lpfc_cr_delay_show':
drivers/scsi/lpfc/lpfc_attr.c:3205:1: warning: variable 'val' set but not u=
sed=20
[-Wunused-but-set-variable]
drivers/scsi/lpfc/lpfc_attr.c: In function 'lpfc_cr_count_show':
drivers/scsi/lpfc/lpfc_attr.c:3208:1: warning: variable 'val' set but not u=
sed=20
[-Wunused-but-set-variable]
drivers/scsi/lpfc/lpfc_attr.c: In function 'lpfc_multi_ring_support_show':
drivers/scsi/lpfc/lpfc_attr.c:3216:1: warning: variable 'val' set but not u=
sed=20
[-Wunused-but-set-variable]
drivers/scsi/lpfc/lpfc_attr.c: In function 'lpfc_multi_ring_rctl_show':
drivers/scsi/lpfc/lpfc_attr.c:3224:1: warning: variable 'val' set but not u=
sed=20
[-Wunused-but-set-variable]
drivers/scsi/lpfc/lpfc_attr.c: In function 'lpfc_multi_ring_type_show':
drivers/scsi/lpfc/lpfc_attr.c:3232:1: warning: variable 'val' set but not u=
sed=20
[-Wunused-but-set-variable]
drivers/scsi/lpfc/lpfc_attr.c: In function 'lpfc_fdmi_on_show':
drivers/scsi/lpfc/lpfc_attr.c:3241:1: warning: variable 'val' set but not u=
sed=20
[-Wunused-but-set-variable]
drivers/scsi/lpfc/lpfc_attr.c: In function 'lpfc_max_luns_show':
drivers/scsi/lpfc/lpfc_attr.c:3255:1: warning: variable 'val' set but not u=
sed=20
[-Wunused-but-set-variable]
drivers/scsi/lpfc/lpfc_attr.c: In function 'lpfc_poll_tmo_show':
drivers/scsi/lpfc/lpfc_attr.c:3262:1: warning: variable 'val' set but not u=
sed=20
[-Wunused-but-set-variable]
drivers/scsi/lpfc/lpfc_attr.c: In function 'lpfc_use_msi_show':
drivers/scsi/lpfc/lpfc_attr.c:3273:1: warning: variable 'val' set but not u=
sed=20
[-Wunused-but-set-variable]
drivers/scsi/lpfc/lpfc_attr.c: In function 'lpfc_fcp_imax_show':
drivers/scsi/lpfc/lpfc_attr.c:3281:1: warning: variable 'val' set but not u=
sed=20
[-Wunused-but-set-variable]
drivers/scsi/lpfc/lpfc_attr.c: In function 'lpfc_fcp_wq_count_show':
drivers/scsi/lpfc/lpfc_attr.c:3289:1: warning: variable 'val' set but not u=
sed=20
[-Wunused-but-set-variable]
drivers/scsi/lpfc/lpfc_attr.c: In function 'lpfc_fcp_eq_count_show':
drivers/scsi/lpfc/lpfc_attr.c:3297:1: warning: variable 'val' set but not u=
sed=20
[-Wunused-but-set-variable]
drivers/scsi/lpfc/lpfc_attr.c: In function 'lpfc_enable_hba_reset_show':
drivers/scsi/lpfc/lpfc_attr.c:3305:1: warning: variable 'val' set but not u=
sed=20
[-Wunused-but-set-variable]
drivers/scsi/lpfc/lpfc_attr.c: In function 'lpfc_enable_hba_heartbeat_show':
drivers/scsi/lpfc/lpfc_attr.c:3313:1: warning: variable 'val' set but not u=
sed=20
[-Wunused-but-set-variable]
drivers/scsi/lpfc/lpfc_attr.c: In function 'lpfc_enable_bg_show':
drivers/scsi/lpfc/lpfc_attr.c:3321:1: warning: variable 'val' set but not u=
sed=20
[-Wunused-but-set-variable]
drivers/scsi/lpfc/lpfc_attr.c: In function 'lpfc_sg_seg_cnt_show':
drivers/scsi/lpfc/lpfc_attr.c:3357:1: warning: variable 'val' set but not u=
sed=20
[-Wunused-but-set-variable]
drivers/scsi/lpfc/lpfc_attr.c: In function 'lpfc_prot_sg_seg_cnt_show':
drivers/scsi/lpfc/lpfc_attr.c:3361:1: warning: variable 'val' set but not u=
sed=20
[-Wunused-but-set-variable]
drivers/net/tulip/media.c: In function 'tulip_select_media':
drivers/net/tulip/media.c:327:8: warning: variable 'setup' set but not used=
 [-
Wunused-but-set-variable]
drivers/net/tulip/tulip_core.c: In function 'tulip_init_one':
drivers/net/tulip/tulip_core.c:1328:15: warning: variable 'force_csr0' set =
but=20
not used [-Wunused-but-set-variable]
drivers/net/tulip/tulip_core.c:1318:13: warning: variable 'multiport_cnt' s=
et=20
but not used [-Wunused-but-set-variable]
drivers/net/tulip/tulip_core.c:1317:13: warning: variable 'last_irq' set bu=
t=20
not used [-Wunused-but-set-variable]
drivers/scsi/megaraid/megaraid_mbox.c: In function 'megaraid_mbox_sync_scb':
drivers/scsi/megaraid/megaraid_mbox.c:2221:14: warning: variable 'ccb' set =
but=20
not used [-Wunused-but-set-variable]
drivers/scsi/megaraid/megaraid_mbox.c: In function 'megaraid_reset_handler':
drivers/scsi/megaraid/megaraid_mbox.c:2614:7: warning: variable 'recovering=
'=20
set but not used [-Wunused-but-set-variable]
drivers/scsi/megaraid/megaraid_mbox.c: In function 'mbox_post_sync_cmd':
drivers/scsi/megaraid/megaraid_mbox.c:2763:12: warning: variable 'mbox64' s=
et=20
but not used [-Wunused-but-set-variable]
drivers/scsi/megaraid/megaraid_mbox.c: In function=20
'megaraid_mbox_support_random_del':
drivers/scsi/megaraid/megaraid_mbox.c:3174:11: warning: variable 'mbox' set=
=20
but not used [-Wunused-but-set-variable]
drivers/scsi/megaraid/megaraid_mbox.c: In function 'megaraid_mbox_flush_cac=
he':
drivers/scsi/megaraid/megaraid_mbox.c:3302:10: warning: variable 'mbox' set=
=20
but not used [-Wunused-but-set-variable]
drivers/scsi/megaraid/megaraid_mbox.c: In function=20
'megaraid_mbox_fire_sync_cmd':
drivers/scsi/megaraid/megaraid_mbox.c:3338:12: warning: variable 'mbox64' s=
et=20
but not used [-Wunused-but-set-variable]
drivers/scsi/megaraid/megaraid_mbox.c: In function 'gather_hbainfo':
drivers/scsi/megaraid/megaraid_mbox.c:3833:10: warning: variable 'dmajor' s=
et=20
but not used [-Wunused-but-set-variable]
drivers/scsi/megaraid/megaraid_sas_base.c: In function=20
'megasas_check_reset_xscale':
drivers/scsi/megaraid/megaraid_sas_base.c:354:6: warning: variable 'consume=
r'=20
set but not used [-Wunused-but-set-variable]
drivers/scsi/megaraid/megaraid_sas_base.c: In function=20
'megasas_transition_to_ready':
drivers/scsi/megaraid/megaraid_sas_base.c:2595:6: warning: variable=20
'cur_state' set but not used [-Wunused-but-set-variable]
drivers/scsi/megaraid/megaraid_sas_base.c: In function 'megasas_init_fw':
drivers/scsi/megaraid/megaraid_sas_base.c:3443:39: warning: variable 'reg_s=
et'=20
set but not used [-Wunused-but-set-variable]
drivers/scsi/megaraid/megaraid_sas_fusion.c: In function=20
'megasas_disable_intr_fusion':
drivers/scsi/megaraid/megaraid_sas_fusion.c:115:6: warning: variable 'statu=
s'=20
set but not used [-Wunused-but-set-variable]
drivers/scsi/megaraid/megaraid_sas_fp.c: In function 'mega_div64_32':
drivers/scsi/megaraid/megaraid_sas_fp.c:88:6: warning: variable 'remainder'=
=20
set but not used [-Wunused-but-set-variable]
drivers/scsi/megaraid/megaraid_sas_fusion.c: In function=20
'megasas_free_cmds_fusion':
drivers/scsi/megaraid/megaraid_sas_fusion.c:254:34: warning: variable=20
'io_frames_sz' set but not used [-Wunused-but-set-variable]
drivers/scsi/megaraid/megaraid_sas_fusion.c:254:24: warning: variable=20
'reply_sz' set but not used [-Wunused-but-set-variable]
drivers/scsi/megaraid/megaraid_sas_fp.c: In function 'MR_GetSpanBlock':
drivers/scsi/megaraid/megaraid_sas_fp.c:195:16: warning: variable 'debugBlk=
'=20
set but not used [-Wunused-but-set-variable]
drivers/scsi/megaraid/megaraid_sas_fusion.c: In function=20
'megasas_alloc_cmds_fusion':
drivers/scsi/megaraid/megaraid_sas_fusion.c:386:15: warning: variable=20
'io_frames_sz' set but not used [-Wunused-but-set-variable]
drivers/scsi/megaraid/megaraid_sas_fusion.c: In function=20
'megasas_sync_map_info':
drivers/scsi/megaraid/megaraid_sas_fusion.c:814:6: warning: variable=20
'size_sync_info' set but not used [-Wunused-but-set-variable]
drivers/scsi/megaraid/megaraid_sas_fusion.c: In function=20
'megasas_make_sgl_fusion':
drivers/scsi/megaraid/megaraid_sas_fusion.c:1081:17: warning: variable=20
'sge_idx' set but not used [-Wunused-but-set-variable]
drivers/scsi/megaraid/megaraid_sas_fusion.c: In function=20
'megasas_build_ldio_fusion':
drivers/scsi/megaraid/megaraid_sas_fusion.c:1289:42: warning: variable=20
'req_desc' set but not used [-Wunused-but-set-variable]
drivers/scsi/megaraid/megaraid_sas_fusion.c: In function=20
'megasas_build_io_fusion':
drivers/scsi/megaraid/megaraid_sas_fusion.c:1477:6: warning: variable=20
'device_id' set but not used [-Wunused-but-set-variable]
drivers/scsi/megaraid/megaraid_sas_fusion.c: In function=20
'megasas_build_and_issue_cmd_fusion':
drivers/scsi/megaraid/megaraid_sas_fusion.c:1572:25: warning: variable=20
'fusion' set but not used [-Wunused-but-set-variable]
drivers/scsi/megaraid/megaraid_sas_fusion.c: In function=20
'megasas_issue_dcmd_fusion':
drivers/scsi/megaraid/megaraid_sas_fusion.c:1904:19: warning: variable 'd_v=
al'=20
set but not used [-Wunused-but-set-variable]
drivers/net/usb/rtl8150.c: In function 'read_bulk_callback':
drivers/net/usb/rtl8150.c:424:6: warning: variable 'rx_stat' set but not us=
ed=20
[-Wunused-but-set-variable]
drivers/net/tulip/de4x5.c: In function 'mii_get_oui':
drivers/net/tulip/de4x5.c:4948:13: warning: variable 'r3' set but not used =
[-
Wunused-but-set-variable]
drivers/net/vmxnet3/vmxnet3_drv.c: In function 'vmxnet3_tq_cleanup':
drivers/net/vmxnet3/vmxnet3_drv.c:407:30: warning: variable 'gdesc' set but=
=20
not used [-Wunused-but-set-variable]
drivers/net/vxge/vxge-traffic.c: In function 'vxge_hw_vpath_intr_enable':
drivers/net/vxge/vxge-traffic.c:31:6: warning: variable 'val64' set but not=
 used=20
[-Wunused-but-set-variable]
drivers/net/vxge/vxge-traffic.c: In function 'vxge_hw_vpath_intr_disable':
drivers/net/vxge/vxge-traffic.c:158:6: warning: variable 'val64' set but no=
t=20
used [-Wunused-but-set-variable]
drivers/net/vxge/vxge-traffic.c: In function 'vxge_hw_device_flush_io':
drivers/net/vxge/vxge-traffic.c:409:6: warning: variable 'val32' set but no=
t=20
used [-Wunused-but-set-variable]
drivers/net/vxge/vxge-config.c: In function '__vxge_hw_blockpool_destroy':
drivers/net/vxge/vxge-config.c:1112:6: warning: variable 'ret' set but not =
used=20
[-Wunused-but-set-variable]
drivers/net/vxge/vxge-traffic.c: In function 'vxge_hw_ring_rxd_post_post':
drivers/net/vxge/vxge-traffic.c:1138:28: warning: variable 'channel' set bu=
t not=20
used [-Wunused-but-set-variable]
drivers/net/vxge/vxge-traffic.c: In function 'vxge_hw_ring_handle_tcode':
drivers/net/vxge/vxge-traffic.c:1288:28: warning: variable 'channel' set bu=
t not=20
used [-Wunused-but-set-variable]
drivers/net/vxge/vxge-traffic.c: In function '__vxge_hw_non_offload_db_post=
':
drivers/net/vxge/vxge-traffic.c:1328:28: warning: variable 'channel' set bu=
t not=20
used [-Wunused-but-set-variable]
drivers/net/vxge/vxge-traffic.c: In function 'vxge_hw_fifo_txdl_buffer_set':
drivers/net/vxge/vxge-traffic.c:1435:28: warning: variable 'channel' set bu=
t not=20
used [-Wunused-but-set-variable]
drivers/net/vxge/vxge-traffic.c: In function 'vxge_hw_fifo_txdl_post':
drivers/net/vxge/vxge-traffic.c:1483:28: warning: variable 'channel' set bu=
t not=20
used [-Wunused-but-set-variable]
drivers/net/vxge/vxge-traffic.c: In function 'vxge_hw_fifo_handle_tcode':
drivers/net/vxge/vxge-traffic.c:1601:28: warning: variable 'channel' set bu=
t not=20
used [-Wunused-but-set-variable]
drivers/net/vxge/vxge-traffic.c: In function 'vxge_hw_fifo_txdl_free':
drivers/net/vxge/vxge-traffic.c:1643:6: warning: variable 'max_frags' set b=
ut=20
not used [-Wunused-but-set-variable]
drivers/net/vxge/vxge-traffic.c:1642:35: warning: variable 'txdl_priv' set =
but=20
not used [-Wunused-but-set-variable]
drivers/net/vxge/vxge-config.c: In function 'vxge_hw_blockpool_block_add':
drivers/net/vxge/vxge-config.c:2285:6: warning: variable 'req_out' set but =
not=20
used [-Wunused-but-set-variable]
drivers/net/vxge/vxge-config.c:2284:22: warning: variable 'status' set but =
not=20
used [-Wunused-but-set-variable]
drivers/net/vxge/vxge-config.c: In function '__vxge_hw_blockpool_malloc':
drivers/net/vxge/vxge-config.c:2382:22: warning: variable 'status' set but =
not=20
used [-Wunused-but-set-variable]
drivers/net/vxge/vxge-traffic.c: In function 'vxge_hw_vpath_poll_rx':
drivers/net/vxge/vxge-traffic.c:2345:6: warning: variable 'val64' set but n=
ot=20
used [-Wunused-but-set-variable]
drivers/net/vxge/vxge-main.c: In function 'vxge_learn_mac':
drivers/net/vxge/vxge-main.c:734:27: warning: variable 'hldev' set but not=
=20
used [-Wunused-but-set-variable]
drivers/net/vxge/vxge-main.c: In function 'vxge_set_multicast':
drivers/net/vxge/vxge-main.c:1131:27: warning: variable 'hldev' set but not=
=20
used [-Wunused-but-set-variable]
drivers/net/vxge/vxge-main.c: In function 'vxge_set_mac_addr':
drivers/net/vxge/vxge-main.c:1294:27: warning: variable 'hldev' set but not=
=20
used [-Wunused-but-set-variable]
drivers/net/vxge/vxge-main.c: In function 'vxge_isr_napi':
drivers/net/vxge/vxge-main.c:2094:21: warning: variable 'dev' set but not u=
sed=20
[-Wunused-but-set-variable]
drivers/net/vxge/vxge-main.c: In function 'vxge_rem_isr':
drivers/net/vxge/vxge-main.c:2336:27: warning: variable 'hldev' set but not=
=20
used [-Wunused-but-set-variable]
drivers/net/vxge/vxge-main.c: In function 'vxge_open':
drivers/net/vxge/vxge-main.c:2572:13: warning: variable 'function_mode' set=
=20
but not used [-Wunused-but-set-variable]
drivers/net/vxge/vxge-main.c: In function 'vxge_probe':
drivers/net/vxge/vxge-main.c:4238:22: warning: variable 'is_privileged' set=
=20
but not used [-Wunused-but-set-variable]
drivers/scsi/lpfc/lpfc_bsg.c: In function 'lpfc_bsg_rport_els':
drivers/scsi/lpfc/lpfc_bsg.c:495:10: warning: variable 'rsp' set but not us=
ed=20
[-Wunused-but-set-variable]
drivers/scsi/lpfc/lpfc_bsg.c:492:11: warning: variable 'rspsize' set but no=
t=20
used [-Wunused-but-set-variable]
drivers/scsi/lpfc/lpfc_bsg.c: In function 'lpfc_bsg_ct_unsol_event':
drivers/scsi/lpfc/lpfc_bsg.c:764:11: warning: variable 'len' set but not us=
ed=20
[-Wunused-but-set-variable]
drivers/scsi/lpfc/lpfc_bsg.c: In function 'lpfc_bsg_diag_test':
drivers/scsi/lpfc/lpfc_bsg.c:2083:25: warning: variable 'diag_mode' set but=
=20
not used [-Wunused-but-set-variable]
drivers/scsi/lpfc/lpfc_bsg.c: In function 'lpfc_bsg_get_dfc_rev':
drivers/scsi/lpfc/lpfc_bsg.c:2366:23: warning: variable 'event_req' set but=
=20
not used [-Wunused-but-set-variable]
drivers/scsi/lpfc/lpfc_bsg.c: In function 'lpfc_menlo_cmd':
drivers/scsi/lpfc/lpfc_bsg.c:3201:25: warning: variable 'menlo_resp' set bu=
t=20
not used [-Wunused-but-set-variable]
drivers/scsi/lpfc/lpfc_bsg.c:3198:16: warning: variable 'rsp' set but not u=
sed=20
[-Wunused-but-set-variable]
drivers/scsi/mpt2sas/mpt2sas_base.c: In function=20
'_base_handshake_req_reply_wait':
drivers/scsi/mpt2sas/mpt2sas_base.c:2701:6: warning: variable 'dummy' set b=
ut=20
not used [-Wunused-but-set-variable]
drivers/scsi/mpt2sas/mpt2sas_base.c: In function=20
'mpt2sas_base_sas_iounit_control':
drivers/scsi/mpt2sas/mpt2sas_base.c:2820:16: warning: variable 'timeleft' s=
et=20
but not used [-Wunused-but-set-variable]
drivers/scsi/mpt2sas/mpt2sas_base.c: In function=20
'mpt2sas_base_scsi_enclosure_processor':
drivers/scsi/mpt2sas/mpt2sas_base.c:2925:16: warning: variable 'timeleft' s=
et=20
but not used [-Wunused-but-set-variable]
drivers/scsi/mpt2sas/mpt2sas_base.c: In function '_base_send_ioc_init':
drivers/scsi/mpt2sas/mpt2sas_base.c:3164:6: warning: right shift count >=3D=
=20
width of type [enabled by default]
drivers/scsi/mpt2sas/mpt2sas_base.c:3164:6: warning: right shift count >=3D=
=20
width of type [enabled by default]
drivers/scsi/mpt2sas/mpt2sas_base.c:3164:6: warning: right shift count >=3D=
=20
width of type [enabled by default]
drivers/scsi/mpt2sas/mpt2sas_base.c:3164:6: warning: right shift count >=3D=
=20
width of type [enabled by default]
drivers/scsi/mpt2sas/mpt2sas_base.c:3164:6: warning: right shift count >=3D=
=20
width of type [enabled by default]
drivers/scsi/mpt2sas/mpt2sas_base.c:3164:6: warning: right shift count >=3D=
=20
width of type [enabled by default]
drivers/scsi/mpt2sas/mpt2sas_base.c:3166:6: warning: right shift count >=3D=
=20
width of type [enabled by default]
drivers/scsi/mpt2sas/mpt2sas_base.c:3166:6: warning: right shift count >=3D=
=20
width of type [enabled by default]
drivers/scsi/mpt2sas/mpt2sas_base.c:3166:6: warning: right shift count >=3D=
=20
width of type [enabled by default]
drivers/scsi/mpt2sas/mpt2sas_base.c:3166:6: warning: right shift count >=3D=
=20
width of type [enabled by default]
drivers/scsi/mpt2sas/mpt2sas_base.c:3166:6: warning: right shift count >=3D=
=20
width of type [enabled by default]
drivers/scsi/mpt2sas/mpt2sas_base.c:3166:6: warning: right shift count >=3D=
=20
width of type [enabled by default]
drivers/scsi/mpt2sas/mpt2sas_base.c: In function '_base_send_port_enable':
drivers/scsi/mpt2sas/mpt2sas_base.c:3233:16: warning: variable 'timeleft' s=
et=20
but not used [-Wunused-but-set-variable]
drivers/scsi/mpt2sas/mpt2sas_base.c: In function '_base_event_notification':
drivers/scsi/mpt2sas/mpt2sas_base.c:3330:16: warning: variable 'timeleft' s=
et=20
but not used [-Wunused-but-set-variable]
drivers/scsi/mvsas/mv_sas.c: In function 'mvs_task_exec':
drivers/scsi/mvsas/mv_sas.c:981:3: warning: case value '5' not in enumerate=
d=20
type 'enum sas_protocol' [-Wswitch]
drivers/scsi/mvsas/mv_sas.c: In function 'mvs_update_phyinfo':
drivers/scsi/mvsas/mv_sas.c:1206:34: warning: comparison between 'enum=20
sas_device_type' and 'enum sas_dev_type' [-Wenum-compare]
drivers/scsi/mvsas/mv_sas.c:1209:39: warning: comparison between 'enum=20
sas_device_type' and 'enum sas_dev_type' [-Wenum-compare]
drivers/scsi/mvsas/mv_sas.c: In function 'mvs_slot_err':
drivers/scsi/mvsas/mv_sas.c:1804:2: warning: case value '5' not in enumerat=
ed=20
type 'enum sas_protocol' [-Wswitch]
drivers/scsi/mvsas/mv_sas.c: In function 'mvs_slot_complete':
drivers/scsi/mvsas/mv_sas.c:1909:2: warning: case value '5' not in enumerat=
ed=20
type 'enum sas_protocol' [-Wswitch]
drivers/scsi/mvsas/mv_sas.c: In function 'mvs_work_queue':
drivers/scsi/mvsas/mv_sas.c:2009:31: warning: variable 'id' set but not use=
d=20
[-Wunused-but-set-variable]
drivers/net/wimax/i2400m/control.c: In function 'i2400m_msg_ack_hook':
drivers/net/wimax/i2400m/control.c:567:21: warning: variable 'ack_status' s=
et=20
but not used [-Wunused-but-set-variable]
drivers/net/wimax/i2400m/fw.c: In function 'i2400m_dev_bootstrap':
drivers/net/wimax/i2400m/fw.c:1554:31: warning: variable 'bcf' set but not=
=20
used [-Wunused-but-set-variable]
drivers/net/wireless/airo_cs.c: In function 'airo_config':
drivers/net/wireless/airo_cs.c:107:16: warning: variable 'dev' set but not=
=20
used [-Wunused-but-set-variable]
drivers/net/wireless/airo.c: In function 'airo_handle_tx':
drivers/net/wireless/airo.c:3421:9: warning: variable 'len' set but not use=
d=20
[-Wunused-but-set-variable]
drivers/net/wireless/atmel_cs.c: In function 'atmel_config':
drivers/net/wireless/atmel_cs.c:123:16: warning: variable 'dev' set but not=
=20
used [-Wunused-but-set-variable]
drivers/net/wireless/rndis_wlan.c: In function 'remove_pmkid':
drivers/net/wireless/rndis_wlan.c:1763:9: warning: variable 'len' set but n=
ot=20
used [-Wunused-but-set-variable]
drivers/net/wireless/rndis_wlan.c: In function 'update_pmkid':
drivers/net/wireless/rndis_wlan.c:1804:14: warning: variable 'len' set but =
not=20
used [-Wunused-but-set-variable]
drivers/net/wireless/zd1201.c: In function 'zd1201_usbrx':
drivers/net/wireless/zd1201.c:229:28: warning: variable 'framelen' set but =
not=20
used [-Wunused-but-set-variable]
drivers/net/wireless/adm8211.c: In function 'adm8211_probe':
drivers/net/wireless/adm8211.c:1768:15: warning: variable 'io_addr' set but=
=20
not used [-Wunused-but-set-variable]
drivers/net/wireless/adm8211.c:1767:16: warning: variable 'mem_addr' set bu=
t=20
not used [-Wunused-but-set-variable]
In file included from drivers/scsi/pcmcia/aha152x_core.c:3:0:
drivers/scsi/aha152x.c: In function 'datai_run':
drivers/scsi/aha152x.c:2239:9: warning: variable 'data' set but not used [-
Wunused-but-set-variable]
drivers/scsi/aha152x.c: In function 'get_command':
drivers/scsi/aha152x.c:2979:2: warning: cast from pointer to integer of=20
different size [-Wpointer-to-int-cast]
drivers/scsi/mpt2sas/mpt2sas_config.c: In function '_config_request':
drivers/scsi/mpt2sas/mpt2sas_config.c:292:16: warning: variable 'timeleft' =
set=20
but not used [-Wunused-but-set-variable]
drivers/scsi/mpt2sas/mpt2sas_scsih.c: In function 'mpt2sas_scsih_issue_tm':
drivers/scsi/mpt2sas/mpt2sas_scsih.c:2033:16: warning: variable 'timeleft' =
set=20
but not used [-Wunused-but-set-variable]
drivers/scsi/mpt2sas/mpt2sas_scsih.c: In function=20
'_scsih_block_io_to_children_attached_directly':
drivers/scsi/mpt2sas/mpt2sas_scsih.c:2654:5: warning: variable 'phy_number'=
=20
set but not used [-Wunused-but-set-variable]
drivers/scsi/mpt2sas/mpt2sas_scsih.c: In function '_scsih_io_done':
drivers/scsi/mpt2sas/mpt2sas_scsih.c:3821:6: warning: variable 'log_info' s=
et=20
but not used [-Wunused-but-set-variable]
drivers/scsi/mpt2sas/mpt2sas_scsih.c:3814:23: warning: variable 'mpi_reques=
t'=20
set but not used [-Wunused-but-set-variable]
drivers/scsi/mpt2sas/mpt2sas_scsih.c: In function '_scsih_reprobe_lun':
drivers/scsi/mpt2sas/mpt2sas_scsih.c:5243:6: warning: variable 'rc' set but=
=20
not used [-Wunused-but-set-variable]
drivers/scsi/mpt2sas/mpt2sas_scsih.c: In function '_scsih_probe_boot_device=
s':
drivers/scsi/mpt2sas/mpt2sas_scsih.c:6727:6: warning: variable 'handle' set=
=20
but not used [-Wunused-but-set-variable]
drivers/scsi/mpt2sas/mpt2sas_transport.c: In function=20
'_transport_expander_report_manufacture':
drivers/scsi/mpt2sas/mpt2sas_transport.c:295:16: warning: variable 'timelef=
t'=20
set but not used [-Wunused-but-set-variable]
drivers/scsi/mpt2sas/mpt2sas_transport.c: In function=20
'_transport_get_expander_phy_error_log':
drivers/scsi/mpt2sas/mpt2sas_transport.c:1081:16: warning: variable 'timele=
ft'=20
set but not used [-Wunused-but-set-variable]
drivers/scsi/mpt2sas/mpt2sas_transport.c: In function=20
'_transport_expander_phy_control':
drivers/scsi/mpt2sas/mpt2sas_transport.c:1402:16: warning: variable 'timele=
ft'=20
set but not used [-Wunused-but-set-variable]
drivers/scsi/mpt2sas/mpt2sas_transport.c: In function=20
'_transport_smp_handler':
drivers/scsi/mpt2sas/mpt2sas_transport.c:1839:16: warning: variable 'timele=
ft'=20
set but not used [-Wunused-but-set-variable]
drivers/net/wireless/airo.c: In function 'encapsulate':
drivers/net/wireless/airo.c:1420:15: warning: array subscript is above arra=
y=20
bounds [-Warray-bounds]
drivers/net/wimax/i2400m/netdev.c: In function 'i2400m_net_erx':
drivers/net/wimax/i2400m/netdev.c:564:6: warning: variable 'protocol' set b=
ut=20
not used [-Wunused-but-set-variable]
drivers/net/wireless/mwl8k.c: In function 'mwl8k_bss_info_changed':
drivers/net/wireless/mwl8k.c:2476:27: warning: 'ap_legacy_rates' may be use=
d=20
uninitialized in this function [-Wuninitialized]
drivers/net/wireless/mwl8k.c:3552:6: note: 'ap_legacy_rates' was declared h=
ere
drivers/scsi/mpt2sas/mpt2sas_ctl.c: In function '_ctl_do_mpt_command':
drivers/scsi/mpt2sas/mpt2sas_ctl.c:635:25: warning: variable 'timeleft' set=
=20
but not used [-Wunused-but-set-variable]
drivers/scsi/mpt2sas/mpt2sas_ctl.c:633:6: warning: variable 'ioc_status' se=
t=20
but not used [-Wunused-but-set-variable]
drivers/scsi/mpt2sas/mpt2sas_ctl.c: In function '_ctl_diag_register_2':
drivers/scsi/mpt2sas/mpt2sas_ctl.c:1366:16: warning: variable 'timeleft' se=
t=20
but not used [-Wunused-but-set-variable]
drivers/scsi/mpt2sas/mpt2sas_ctl.c: In function '_ctl_send_release':
drivers/scsi/mpt2sas/mpt2sas_ctl.c:1770:16: warning: variable 'timeleft' se=
t=20
but not used [-Wunused-but-set-variable]
drivers/scsi/mpt2sas/mpt2sas_ctl.c: In function '_ctl_diag_read_buffer':
drivers/scsi/mpt2sas/mpt2sas_ctl.c:1966:16: warning: variable 'timeleft' se=
t=20
but not used [-Wunused-but-set-variable]
drivers/net/wireless/airo.c: In function 'decapsulate':
drivers/net/wireless/airo.c:1508:16: warning: array subscript is above arra=
y=20
bounds [-Warray-bounds]
drivers/scsi/qla2xxx/qla_os.c: In function 'qla2x00_do_dpc':
drivers/scsi/qla2xxx/qla_os.c:3276:7: warning: variable 'rval' set but not=
=20
used [-Wunused-but-set-variable]
drivers/scsi/qla2xxx/qla_init.c: In function 'qla2x00_fabric_dev_login':
drivers/scsi/qla2xxx/qla_init.c:3589:6: warning: variable 'retry' set but n=
ot=20
used [-Wunused-but-set-variable]
drivers/scsi/qla2xxx/qla_mbx.c: In function 'qla24xx_login_fabric':
drivers/scsi/qla2xxx/qla_mbx.c:1594:18: warning: variable 'rsp' set but not=
=20
used [-Wunused-but-set-variable]
drivers/scsi/qla2xxx/qla_mbx.c: In function 'qla24xx_fabric_logout':
drivers/scsi/qla2xxx/qla_mbx.c:1864:18: warning: variable 'rsp' set but not=
=20
used [-Wunused-but-set-variable]
drivers/scsi/pm8001/pm8001_sas.c: In function 'pm8001_task_exec':
drivers/scsi/pm8001/pm8001_sas.c:467:3: warning: case value '5' not in=20
enumerated type 'enum sas_protocol' [-Wswitch]
drivers/scsi/pm8001/pm8001_hwi.c: In function 'mpi_set_phys_g3_with_ssc':
drivers/scsi/pm8001/pm8001_hwi.c:377:6: warning: variable 'value' set but n=
ot=20
used [-Wunused-but-set-variable]
drivers/scsi/pm8001/pm8001_sas.c: In function 'pm8001_abort_task':
drivers/scsi/pm8001/pm8001_sas.c:1051:26: warning: variable 'ccb' set but n=
ot=20
used [-Wunused-but-set-variable]
drivers/scsi/pm8001/pm8001_hwi.c: In function 'mpi_smp_completion':
drivers/scsi/pm8001/pm8001_hwi.c:2424:6: warning: variable 'param' set but =
not=20
used [-Wunused-but-set-variable]
drivers/scsi/pm8001/pm8001_hwi.c: In function 'pm8001_bytes_dmaed':
drivers/scsi/pm8001/pm8001_hwi.c:2758:24: warning: variable 'sas_ha' set bu=
t=20
not used [-Wunused-but-set-variable]
drivers/scsi/pm8001/pm8001_hwi.c: In function 'hw_event_sas_phy_up':
drivers/scsi/pm8001/pm8001_hwi.c:2934:32: warning: comparison between 'enum=
=20
sas_device_type' and 'enum sas_dev_type' [-Wenum-compare]
drivers/scsi/pm8001/pm8001_hwi.c:2936:37: warning: comparison between 'enum=
=20
sas_device_type' and 'enum sas_dev_type' [-Wenum-compare]
drivers/scsi/qla4xxx/ql4_os.c: In function 'qla4_8xxx_iospace_config':
drivers/scsi/qla4xxx/ql4_os.c:1445:44: warning: variable 'db_len' set but n=
ot=20
used [-Wunused-but-set-variable]
drivers/scsi/qla4xxx/ql4_os.c:1445:35: warning: variable 'db_base' set but =
not=20
used [-Wunused-but-set-variable]
drivers/scsi/qla4xxx/ql4_os.c: In function 'qla4xxx_probe_adapter':
drivers/scsi/qla4xxx/ql4_os.c:1627:21: warning: variable 'status' set but n=
ot=20
used [-Wunused-but-set-variable]
drivers/scsi/qla4xxx/ql4_os.c: In function 'qla4xxx_config_dma_addressing':
drivers/scsi/qla4xxx/ql4_os.c:1852:6: warning: variable 'retval' set but no=
t=20
used [-Wunused-but-set-variable]
drivers/scsi/sym53c8xx_2/sym_fw.c: In function 'sym_fw1_setup':
drivers/scsi/sym53c8xx_2/sym_fw.c:298:23: warning: variable 'scriptb0' set =
but=20
not used [-Wunused-but-set-variable]
drivers/scsi/sym53c8xx_2/sym_fw.c: In function 'sym_fw2_setup':
drivers/scsi/sym53c8xx_2/sym_fw.c:322:23: warning: variable 'scriptb0' set =
but=20
not used [-Wunused-but-set-variable]
drivers/scsi/qla4xxx/ql4_init.c: In function 'ql4xxx_set_mac_number':
drivers/scsi/qla4xxx/ql4_init.c:20:10: warning: variable 'func_number' set =
but=20
not used [-Wunused-but-set-variable]
drivers/scsi/qla4xxx/ql4_init.c: In function 'qla4xxx_devices_ready':
drivers/scsi/qla4xxx/ql4_init.c:929:6: warning: variable 'error' set but no=
t=20
used [-Wunused-but-set-variable]
drivers/scsi/qla4xxx/ql4_init.c: In function 'qla4xxx_pci_config':
drivers/scsi/qla4xxx/ql4_init.c:1140:6: warning: variable 'status' set but =
not=20
used [-Wunused-but-set-variable]
drivers/scsi/sym53c8xx_2/sym_hipd.c: In function 'sym_compute_residual':
drivers/scsi/sym53c8xx_2/sym_hipd.c:3854:13: warning: variable 'dp_sgmin' s=
et=20
but not used [-Wunused-but-set-variable]
drivers/scsi/sym53c8xx_2/sym_hipd.c: In function 'sym_complete_error':
drivers/scsi/sym53c8xx_2/sym_hipd.c:5361:18: warning: variable 'lp' set but=
=20
not used [-Wunused-but-set-variable]
drivers/scsi/sym53c8xx_2/sym_hipd.c: In function 'sym_complete_ok':
drivers/scsi/sym53c8xx_2/sym_hipd.c:5490:18: warning: variable 'lp' set but=
=20
not used [-Wunused-but-set-variable]
drivers/net/wireless/mac80211_hwsim.c: In function 'mac80211_hwsim_beacon_t=
x':
drivers/net/wireless/mac80211_hwsim.c:638:28: warning: variable 'info' set =
but=20
not used [-Wunused-but-set-variable]
drivers/net/wireless/ath/ar9170/main.c: In function 'ar9170_op_tx':
drivers/net/wireless/ath/ar9170/main.c:1481:28: warning: variable 'info' se=
t=20
but not used [-Wunused-but-set-variable]
drivers/net/wireless/ath/ar9170/main.c: In function 'ar9170_get_stats':
drivers/net/wireless/ath/ar9170/main.c:1895:6: warning: variable 'err' set =
but=20
not used [-Wunused-but-set-variable]
drivers/scsi/qla2xxx/qla_iocb.c: In function 'qla2x00_start_scsi':
drivers/scsi/qla2xxx/qla_iocb.c:316:7: warning: variable 'ret' set but not=
=20
used [-Wunused-but-set-variable]
drivers/scsi/qla2xxx/qla_iocb.c: In function 'qla24xx_build_scsi_iocbs':
drivers/scsi/qla2xxx/qla_iocb.c:624:18: warning: variable 'req' set but not=
=20
used [-Wunused-but-set-variable]
drivers/scsi/qla2xxx/qla_iocb.c: In function 'qla24xx_walk_and_build_sglist=
':
drivers/scsi/qla2xxx/qla_iocb.c:797:12: warning: variable 'cp' set but not=
=20
used [-Wunused-but-set-variable]
drivers/scsi/qla2xxx/qla_iocb.c: In function=20
'qla24xx_walk_and_build_prot_sglist':
drivers/scsi/qla2xxx/qla_iocb.c:876:12: warning: variable 'cp' set but not=
=20
used [-Wunused-but-set-variable]
drivers/scsi/qla2xxx/qla_iocb.c: In function 'qla24xx_build_scsi_crc_2_iocb=
s':
drivers/scsi/qla2xxx/qla_iocb.c:961:8: warning: variable 'sgc' set but not=
=20
used [-Wunused-but-set-variable]
drivers/scsi/qla2xxx/qla_iocb.c:960:22: warning: variable 'cur_seg' set but=
=20
not used [-Wunused-but-set-variable]
drivers/scsi/qla2xxx/qla_iocb.c: In function 'qla24xx_start_scsi':
drivers/scsi/qla2xxx/qla_iocb.c:1166:7: warning: variable 'ret' set but not=
=20
used [-Wunused-but-set-variable]
drivers/scsi/qla2xxx/qla_iocb.c: In function 'qla2x00_ct_iocb':
drivers/scsi/qla2xxx/qla_iocb.c:1807:6: warning: variable 'cont_iocb_prsnt'=
=20
set but not used [-Wunused-but-set-variable]
drivers/scsi/qla2xxx/qla_iocb.c: In function 'qla24xx_ct_iocb':
drivers/scsi/qla2xxx/qla_iocb.c:1882:6: warning: variable 'cont_iocb_prsnt'=
=20
set but not used [-Wunused-but-set-variable]
drivers/scsi/qla2xxx/qla_dbg.c: In function 'qla24xx_fw_dump':
drivers/scsi/qla2xxx/qla_dbg.c:760:11: warning: variable 'risc_address' set=
=20
but not used [-Wunused-but-set-variable]
drivers/scsi/qla2xxx/qla_dbg.c: In function 'qla25xx_fw_dump':
drivers/scsi/qla2xxx/qla_dbg.c:1000:11: warning: variable 'risc_address' se=
t=20
but not used [-Wunused-but-set-variable]
drivers/scsi/qla2xxx/qla_dbg.c: In function 'qla81xx_fw_dump':
drivers/scsi/qla2xxx/qla_dbg.c:1311:11: warning: variable 'risc_address' se=
t=20
but not used [-Wunused-but-set-variable]
drivers/net/wireless/ath/ath9k/beacon.c: In function 'ath_beacon_setup':
drivers/net/wireless/ath/ath9k/beacon.c:71:13: warning: variable 'antenna' =
set=20
but not used [-Wunused-but-set-variable]
drivers/net/wireless/ath/ath9k/recv.c: In function 'ath_ant_comb_scan':
drivers/net/wireless/ath/ath9k/recv.c:1395:21: warning: variable 'curr_bias=
'=20
set but not used [-Wunused-but-set-variable]
drivers/scsi/qla2xxx/qla_attr.c: In function 'qla2x00_sysfs_read_dcbx_tlv':
drivers/scsi/qla2xxx/qla_attr.c:793:11: warning: variable 'actual_size' set=
=20
but not used [-Wunused-but-set-variable]
drivers/scsi/qla2xxx/qla_mid.c: In function 'qla2x00_do_dpc_all_vps':
drivers/scsi/qla2xxx/qla_mid.c:340:6: warning: variable 'ret' set but not u=
sed=20
[-Wunused-but-set-variable]
drivers/scsi/qla2xxx/qla_mid.c: In function 'qla25xx_create_req_que':
drivers/scsi/qla2xxx/qla_mid.c:602:24: warning: variable 'reg' set but not=
=20
used [-Wunused-but-set-variable]
drivers/net/wireless/ath/ath9k/rc.c: In function 'ath_rc_update_ht':
drivers/net/wireless/ath/ath9k/rc.c:1020:7: warning: variable 'state_change=
'=20
set but not used [-Wunused-but-set-variable]
drivers/net/wireless/b43/phy_n.c: In function 'b43_nphy_op_switch_channel':
drivers/net/wireless/b43/phy_n.c:214:7: warning: 'tabent_r3' may be used=20
uninitialized in this function [-Wuninitialized]
drivers/net/wireless/b43/phy_n.c:3696:47: note: 'tabent_r3' was declared he=
re
drivers/net/wireless/b43/phy_n.c:139:46: warning: 'tabent_r2' may be used=20
uninitialized in this function [-Wuninitialized]
drivers/net/wireless/b43/phy_n.c:3695:47: note: 'tabent_r2' was declared he=
re
drivers/scsi/qla2xxx/qla_nx.c: In function 'qla82xx_pci_config':
drivers/scsi/qla2xxx/qla_nx.c:1688:6: warning: variable 'ret' set but not u=
sed=20
[-Wunused-but-set-variable]
drivers/scsi/qla2xxx/qla_nx.c: In function 'qla82xx_start_scsi':
drivers/scsi/qla2xxx/qla_nx.c:2605:7: warning: variable 'ret' set but not u=
sed=20
[-Wunused-but-set-variable]
drivers/scsi/qla2xxx/qla_nx.c: In function 'qla82xx_write_flash_data':
drivers/scsi/qla2xxx/qla_nx.c:3042:11: warning: variable 'sec_mask' set but=
=20
not used [-Wunused-but-set-variable]
drivers/scsi/qla2xxx/qla_nx.c: In function 'qla82xx_start_iocbs':
drivers/scsi/qla2xxx/qla_nx.c:3160:34: warning: variable 'reg' set but not=
=20
used [-Wunused-but-set-variable]
drivers/net/wireless/b43/lo.c: In function 'lo_measure_gain_values':
drivers/net/wireless/b43/lo.c:304:7: warning: variable 'trsw_rx' set but no=
t=20
used [-Wunused-but-set-variable]
drivers/net/wireless/b43/dma.c: In function 'free_all_descbuffers':
drivers/net/wireless/b43/dma.c:760:30: warning: variable 'desc' set but not=
=20
used [-Wunused-but-set-variable]
drivers/net/wireless/b43/dma.c: In function 'b43_dma_handle_txstatus':
drivers/net/wireless/b43/dma.c:1393:7: warning: variable 'frame_succeed' se=
t=20
but not used [-Wunused-but-set-variable]
drivers/net/wireless/b43/dma.c:1390:30: warning: variable 'desc' set but no=
t=20
used [-Wunused-but-set-variable]
drivers/net/wireless/b43/phy_n.c: In function 'b43_nphy_rev2_rssi_cal':
drivers/net/wireless/b43/phy_n.c:2169:16: warning: 'save_regs_phy[8]' may b=
e=20
used uninitialized in this function [-Wuninitialized]
drivers/net/wireless/b43/phy_n.c:2117:6: note: 'save_regs_phy[8]' was decla=
red=20
here
drivers/net/wireless/b43/phy_n.c:2181:16: warning: 'save_regs_phy[7]' may b=
e=20
used uninitialized in this function [-Wuninitialized]
drivers/net/wireless/b43/phy_n.c:2117:6: note: 'save_regs_phy[7]' was decla=
red=20
here
drivers/net/wireless/b43/phy_n.c:2189:16: warning: 'save_regs_phy[6]' may b=
e=20
used uninitialized in this function [-Wuninitialized]
drivers/net/wireless/b43/phy_n.c:2117:6: note: 'save_regs_phy[6]' was decla=
red=20
here
drivers/net/wireless/b43/phy_n.c:2188:16: warning: 'save_regs_phy[5]' may b=
e=20
used uninitialized in this function [-Wuninitialized]
drivers/net/wireless/b43/phy_n.c:2117:6: note: 'save_regs_phy[5]' was decla=
red=20
here
drivers/net/wireless/b43/phy_n.c:2187:16: warning: 'save_regs_phy[4]' may b=
e=20
used uninitialized in this function [-Wuninitialized]
drivers/net/wireless/b43/phy_n.c:2117:6: note: 'save_regs_phy[4]' was decla=
red=20
here
drivers/net/wireless/b43/phy_n.c:2186:16: warning: 'save_regs_phy[3]' may b=
e=20
used uninitialized in this function [-Wuninitialized]
drivers/net/wireless/b43/phy_n.c:2117:6: note: 'save_regs_phy[3]' was decla=
red=20
here
drivers/net/wireless/b43/phy_n.c:2185:16: warning: 'save_regs_phy[2]' may b=
e=20
used uninitialized in this function [-Wuninitialized]
drivers/net/wireless/b43/phy_n.c:2117:6: note: 'save_regs_phy[2]' was decla=
red=20
here
drivers/net/wireless/b43/phy_n.c:2184:16: warning: 'save_regs_phy[1]' may b=
e=20
used uninitialized in this function [-Wuninitialized]
drivers/net/wireless/b43/phy_n.c:2117:6: note: 'save_regs_phy[1]' was decla=
red=20
here
drivers/net/wireless/b43/phy_n.c:2183:16: warning: 'save_regs_phy[0]' may b=
e=20
used uninitialized in this function [-Wuninitialized]
drivers/net/wireless/b43/phy_n.c:2117:6: note: 'save_regs_phy[0]' was decla=
red=20
here
drivers/net/wireless/ath/ath5k/phy.c: In function 'ath5k_hw_rf_gainf_corr':
drivers/net/wireless/ath/ath5k/phy.c:399:7: warning: variable 'rf' set but =
not=20
used [-Wunused-but-set-variable]
drivers/net/wireless/ath/ath5k/phy.c: In function=20
'ath5k_hw_rf_check_gainf_readback':
drivers/net/wireless/ath/ath5k/phy.c:457:7: warning: variable 'rf' set but =
not=20
used [-Wunused-but-set-variable]
drivers/net/wireless/ath/ath5k/reset.c: In function 'ath5k_hw_reset':
drivers/net/wireless/ath/ath5k/reset.c:215:1: warning: 'txf2txs' may be use=
d=20
uninitialized in this function [-Wuninitialized]
drivers/net/wireless/ath/ath5k/reset.c:100:51: note: 'txf2txs' was declared=
=20
here
drivers/net/wireless/ath/carl9170/tx.c: In function=20
'carl9170_tx_accounting_free':
drivers/net/wireless/ath/carl9170/tx.c:109:28: warning: variable 'txinfo' s=
et=20
but not used [-Wunused-but-set-variable]
drivers/net/wireless/ath/carl9170/tx.c: In function=20
'carl9170_tx_status_process_ampdu':
drivers/net/wireless/ath/carl9170/tx.c:333:27: warning: variable 'ar_info' =
set=20
but not used [-Wunused-but-set-variable]
drivers/net/wireless/ath/carl9170/tx.c: In function=20
'__carl9170_tx_process_status':
drivers/net/wireless/ath/carl9170/tx.c:607:27: warning: variable 'arinfo' s=
et=20
but not used [-Wunused-but-set-variable]
drivers/net/wireless/ath/carl9170/tx.c: In function 'carl9170_tx_ampdu_queu=
e':
drivers/net/wireless/ath/carl9170/tx.c:1268:15: warning: variable 'max' set=
=20
but not used [-Wunused-but-set-variable]
drivers/net/wireless/ath/ath9k/htc_drv_main.c: In function=20
'__ath9k_htc_remove_monitor_interface':
drivers/net/wireless/ath/ath9k/htc_drv_main.c:242:6: warning: variable 'ret=
'=20
set but not used [-Wunused-but-set-variable]
drivers/net/wireless/ath/ath9k/htc_drv_main.c: In function 'ath9k_htc_stop':
drivers/net/wireless/ath/ath9k/htc_drv_main.c:1025:6: warning: variable 're=
t'=20
set but not used [-Wunused-but-set-variable]
drivers/net/wireless/ath/ath9k/htc_drv_main.c: In function=20
'ath9k_htc_remove_interface':
drivers/net/wireless/ath/ath9k/htc_drv_main.c:1162:6: warning: variable 're=
t'=20
set but not used [-Wunused-but-set-variable]
drivers/net/wireless/ath/ath9k/htc_drv_beacon.c: In function=20
'ath9k_htc_beacon_config_sta':
drivers/net/wireless/ath/ath9k/htc_drv_beacon.c:33:6: warning: variable 're=
t'=20
set but not used [-Wunused-but-set-variable]
drivers/net/wireless/ath/ath9k/htc_drv_beacon.c: In function=20
'ath9k_htc_beacon_config_adhoc':
drivers/net/wireless/ath/ath9k/htc_drv_beacon.c:148:6: warning: variable 'r=
et'=20
set but not used [-Wunused-but-set-variable]
drivers/net/wireless/ath/ath9k/htc_drv_gpio.c: In function=20
'ath_btcoex_period_work':
drivers/net/wireless/ath/ath9k/htc_drv_gpio.c:67:6: warning: variable 'ret'=
=20
set but not used [-Wunused-but-set-variable]
drivers/net/wireless/b43legacy/main.c: In function=20
'b43legacy_request_firmware':
drivers/net/wireless/b43legacy/main.c:1567:6: warning: variable 'tmshigh' s=
et=20
but not used [-Wunused-but-set-variable]
drivers/net/wireless/b43legacy/main.c: In function 'b43legacy_op_dev_config=
':
drivers/net/wireless/b43legacy/main.c:2638:6: warning: variable 'antenna_rx=
'=20
set but not used [-Wunused-but-set-variable]
drivers/net/wireless/b43legacy/main.c: In function=20
'b43legacy_op_bss_info_changed':
drivers/net/wireless/b43legacy/main.c:2779:24: warning: variable 'phy' set =
but=20
not used [-Wunused-but-set-variable]
drivers/net/wireless/b43legacy/xmit.c: In function 'generate_txhdr_fw3':
drivers/net/wireless/b43legacy/xmit.c:324:7: warning: variable 'rts_rate_of=
dm'=20
set but not used [-Wunused-but-set-variable]
drivers/net/wireless/b43legacy/dma.c: In function 'free_all_descbuffers':
drivers/net/wireless/b43legacy/dma.c:820:36: warning: variable 'desc' set b=
ut=20
not used [-Wunused-but-set-variable]
drivers/net/wireless/b43legacy/dma.c: In function 'b43legacy_dma_tx':
drivers/net/wireless/b43legacy/dma.c:1377:28: warning: variable 'info' set =
but=20
not used [-Wunused-but-set-variable]
drivers/net/wireless/b43legacy/dma.c:1374:24: warning: variable 'hdr' set b=
ut=20
not used [-Wunused-but-set-variable]
drivers/net/wireless/b43legacy/dma.c: In function=20
'b43legacy_dma_handle_txstatus':
drivers/net/wireless/b43legacy/dma.c:1438:36: warning: variable 'desc' set =
but=20
not used [-Wunused-but-set-variable]
drivers/net/wireless/hostap/hostap_ap.c: In function 'handle_assoc':
drivers/net/wireless/hostap/hostap_ap.c:1504:8: warning: variable 'txt' set=
=20
but not used [-Wunused-but-set-variable]
drivers/net/wireless/ath/ath9k/ar9003_phy.c: In function=20
'ar9003_hw_process_ini':
drivers/net/wireless/ath/ath9k/ar9003_phy.c:593:18: warning: variable=20
'freqIndex' set but not used [-Wunused-but-set-variable]
drivers/net/wireless/iwlwifi/iwl3945-base.c: In function 'iwl3945_tx_skb':
drivers/net/wireless/iwlwifi/iwl3945-base.c:480:5: warning: variable 'unica=
st'=20
set but not used [-Wunused-but-set-variable]
drivers/net/wireless/iwlwifi/iwl3945-base.c:479:5: warning: variable 'id' s=
et=20
but not used [-Wunused-but-set-variable]
drivers/net/wireless/iwlwifi/iwl3945-base.c: In function=20
'iwl3945_rx_queue_restock':
drivers/net/wireless/iwlwifi/iwl3945-base.c:1002:6: warning: variable 'writ=
e'=20
set but not used [-Wunused-but-set-variable]
drivers/net/wireless/libertas/cfg.c: In function 'lbs_ret_scan':
drivers/net/wireless/libertas/cfg.c:562:6: warning: variable 'ssid_len' set=
=20
but not used [-Wunused-but-set-variable]
drivers/net/wireless/libertas/cfg.c:561:13: warning: variable 'ssid' set bu=
t=20
not used [-Wunused-but-set-variable]
drivers/net/wireless/libertas/cfg.c:483:6: warning: variable 'tsfsize' set =
but=20
not used [-Wunused-but-set-variable]
drivers/net/wireless/libertas/cfg.c: In function 'lbs_associate':
drivers/net/wireless/libertas/cfg.c:1070:6: warning: variable 'tmp' set but=
=20
not used [-Wunused-but-set-variable]
drivers/net/wireless/iwlwifi/iwl3945-base.c: In function=20
'iwl3945_post_associate':
drivers/net/wireless/iwlwifi/iwl3945-base.c:3051:25: warning: variable 'con=
f'=20
set but not used [-Wunused-but-set-variable]
drivers/net/wireless/iwmc3200wifi/rx.c: In function 'iwm_ntf_tx':
drivers/net/wireless/iwmc3200wifi/rx.c:221:31: warning: variable 'hdr' set =
but=20
not used [-Wunused-but-set-variable]
drivers/net/wireless/iwmc3200wifi/rx.c:220:27: warning: variable 'tx_resp' =
set=20
but not used [-Wunused-but-set-variable]
drivers/net/wireless/iwmc3200wifi/rx.c: In function 'iwm_ntf_calib_cfg':
drivers/net/wireless/iwmc3200wifi/rx.c:291:32: warning: variable 'cal_resp'=
 set=20
but not used [-Wunused-but-set-variable]
drivers/net/wireless/iwmc3200wifi/rx.c: In function 'iwm_mlme_assoc_start':
drivers/net/wireless/iwmc3200wifi/rx.c:507:37: warning: variable 'start' se=
t=20
but not used [-Wunused-but-set-variable]
drivers/net/wireless/iwmc3200wifi/rx.c: In function=20
'iwm_mlme_update_bss_table':
drivers/net/wireless/iwmc3200wifi/rx.c:787:35: warning: variable 'band' set=
 but=20
not used [-Wunused-but-set-variable]
drivers/net/wireless/iwmc3200wifi/rx.c: In function 'iwm_mlme_remove_bss':
drivers/net/wireless/iwmc3200wifi/rx.c:878:28: warning: variable 'mgmt' set=
 but=20
not used [-Wunused-but-set-variable]
drivers/net/wireless/iwmc3200wifi/hal.c: In function 'iwm_hal_send_host_cmd=
':
drivers/net/wireless/iwmc3200wifi/hal.c:429:6: warning: variable 'lmac_hdr_=
len'=20
set but not used [-Wunused-but-set-variable]
drivers/net/wireless/iwmc3200wifi/commands.c: In function 'iwm_set_key':
drivers/net/wireless/iwmc3200wifi/commands.c:614:15: warning: variable=20
'sta_addr' set but not used [-Wunused-but-set-variable]
drivers/net/wireless/iwmc3200wifi/cfg80211.c: In function=20
'iwm_cfg80211_inform_bss':
drivers/net/wireless/iwmc3200wifi/cfg80211.c:273:35: warning: variable 'ban=
d'=20
set but not used [-Wunused-but-set-variable]
drivers/net/wireless/hostap/hostap_ioctl.c: In function=20
'prism2_translate_scan':
drivers/net/wireless/hostap/hostap_ioctl.c:1955:13: warning: variable=20
'hostscan' set but not used [-Wunused-but-set-variable]
drivers/net/wireless/libertas_tf/main.c: In function 'lbtf_rx':
drivers/net/wireless/libertas_tf/main.c:562:15: warning: variable 'flags' s=
et=20
but not used [-Wunused-but-set-variable]
drivers/net/wireless/libertas/mesh.c: In function 'lbs_cmd_fwt_access':
drivers/net/wireless/libertas/mesh.c:629:6: warning: variable 'ret' set but=
=20
not used [-Wunused-but-set-variable]
drivers/net/wireless/libertas/mesh.c: In function 'lbs_persist_config_init':
drivers/net/wireless/libertas/mesh.c:1183:6: warning: variable 'ret' set bu=
t=20
not used [-Wunused-but-set-variable]
drivers/net/wireless/ath/ath9k/eeprom_9287.c: In function=20
'ath9k_hw_set_ar9287_power_cal_table':
drivers/net/wireless/ath/ath9k/eeprom_9287.c:307:10: warning: variable=20
'modalIdx' set but not used [-Wunused-but-set-variable]
drivers/net/wireless/ath/ath9k/eeprom_9287.c: In function=20
'ath9k_hw_ar9287_set_board_values':
drivers/net/wireless/ath/ath9k/eeprom_9287.c:840:6: warning: variable=20
'antWrites' set but not used [-Wunused-but-set-variable]
drivers/net/wireless/ath/ath9k/ani.c: In function 'ath9k_hw_ani_init':
drivers/net/wireless/ath/ath9k/ani.c:903:37: warning: variable 'entry_cck' =
set=20
but not used [-Wunused-but-set-variable]
drivers/net/wireless/ath/ath9k/ani.c:902:38: warning: variable 'entry_ofdm'=
=20
set but not used [-Wunused-but-set-variable]
drivers/net/wireless/libertas_tf/cmd.c: In function 'lbtf_geo_init':
drivers/net/wireless/libertas_tf/cmd.c:60:30: warning: variable 'range' set=
=20
but not used [-Wunused-but-set-variable]
drivers/net/wireless/libertas_tf/cmd.c: In function 'lbtf_submit_command':
drivers/net/wireless/libertas_tf/cmd.c:240:11: warning: variable 'command' =
set=20
but not used [-Wunused-but-set-variable]
drivers/net/wireless/libertas_tf/cmd.c: In function=20
'lbtf_execute_next_command':
drivers/net/wireless/libertas_tf/cmd.c:565:21: warning: variable 'cmd' set =
but=20
not used [-Wunused-but-set-variable]
In file included from drivers/net/wireless/hostap/hostap_plx.c:264:0:
drivers/net/wireless/hostap/hostap_hw.c: In function 'prism2_tx_80211':
drivers/net/wireless/hostap/hostap_hw.c:1816:18: warning: variable 'fc' set=
=20
but not used [-Wunused-but-set-variable]
In file included from drivers/net/wireless/hostap/hostap_cs.c:196:0:
drivers/net/wireless/hostap/hostap_hw.c: In function 'prism2_tx_80211':
drivers/net/wireless/hostap/hostap_hw.c:1816:18: warning: variable 'fc' set=
=20
but not used [-Wunused-but-set-variable]
In file included from drivers/net/wireless/hostap/hostap_pci.c:221:0:
drivers/net/wireless/hostap/hostap_hw.c: In function 'prism2_tx_80211':
drivers/net/wireless/hostap/hostap_hw.c:1816:18: warning: variable 'fc' set=
=20
but not used [-Wunused-but-set-variable]
drivers/net/wireless/iwlwifi/iwl-3945.c: In function=20
'iwl3945_hw_reg_set_txpower':
drivers/net/wireless/iwlwifi/iwl-3945.c:1624:5: warning: variable 'a_band' =
set=20
but not used [-Wunused-but-set-variable]
drivers/net/wireless/iwlwifi/iwl-agn-rs.c: In function 'rs_rate_scale_perfo=
rm':
drivers/net/wireless/iwlwifi/iwl-agn-rs.c:2214:6: warning: variable 'rate' =
set=20
but not used [-Wunused-but-set-variable]
drivers/net/wireless/iwlwifi/iwl-agn-rs.c: In function=20
'rs_sta_dbgfs_rate_scale_data_read':
drivers/net/wireless/iwlwifi/iwl-agn-rs.c:3260:19: warning: variable 'priv'=
 set=20
but not used [-Wunused-but-set-variable]
drivers/net/wireless/orinoco/orinoco_usb.c: In function 'ezusb_delete':
drivers/net/wireless/orinoco/orinoco_usb.c:1459:21: warning: variable 'dev'=
=20
set but not used [-Wunused-but-set-variable]
drivers/net/wireless/ath/ath9k/ar9003_eeprom.c: In function=20
'ar9300_compress_decision':
drivers/net/wireless/ath/ath9k/ar9003_eeprom.c:3220:6: warning: variable=20
'dptr' set but not used [-Wunused-but-set-variable]
drivers/net/wireless/iwlwifi/iwl-4965.c: In function 'iwl4965_post_associat=
e':
drivers/net/wireless/iwlwifi/iwl-4965.c:2354:25: warning: variable 'conf' s=
et=20
but not used [-Wunused-but-set-variable]
drivers/net/wireless/rtl818x/rtl8180/dev.c: In function 'rtl8180_probe':
drivers/net/wireless/rtl818x/rtl8180/dev.c:907:15: warning: variable 'io_ad=
dr'=20
set but not used [-Wunused-but-set-variable]
drivers/net/wireless/rtl818x/rtl8180/dev.c:906:16: warning: variable=20
'mem_addr' set but not used [-Wunused-but-set-variable]
drivers/net/wireless/rtlwifi/base.c: In function 'rtl_tx_agg_stop':
drivers/net/wireless/rtlwifi/base.c:738:6: warning: variable 'ssn' set but =
not=20
used [-Wunused-but-set-variable]
drivers/net/wireless/rtlwifi/base.c: In function 'rtl_watchdog_wq_callback':
drivers/net/wireless/rtlwifi/base.c:783:7: warning: variable=20
'b_higher_busytxtraffic' set but not used [-Wunused-but-set-variable]
drivers/net/wireless/p54/p54pci.c: In function 'p54p_tx':
drivers/net/wireless/p54/p54pci.c:334:6: warning: variable 'device_idx' set=
=20
but not used [-Wunused-but-set-variable]
drivers/net/wireless/rtlwifi/efuse.c: In function 'efuse_pg_packet_write':
drivers/net/wireless/rtlwifi/efuse.c:903:25: warning: variable 'bdataempty'=
 set=20
but not used [-Wunused-but-set-variable]
drivers/net/wireless/rtlwifi/efuse.c: In function 'efuse_get_current_size':
drivers/net/wireless/rtlwifi/efuse.c:1140:5: warning: variable 'hoffset' se=
t but=20
not used [-Wunused-but-set-variable]
drivers/net/wireless/rtlwifi/pci.c: In function '_rtl_pci_switch_clk_req':
drivers/net/wireless/rtlwifi/pci.c:168:5: warning: variable 'buffer' set bu=
t not=20
used [-Wunused-but-set-variable]
drivers/net/wireless/rtlwifi/ps.c: In function 'rtl_ps_set_rf_state':
drivers/net/wireless/rtlwifi/ps.c:88:19: warning: variable 'rtstate' set bu=
t=20
not used [-Wunused-but-set-variable]
drivers/net/wireless/rtlwifi/regd.c: In function '_rtl_dump_channel_map':
drivers/net/wireless/rtlwifi/regd.c:256:28: warning: variable 'ch' set but =
not=20
used [-Wunused-but-set-variable]
drivers/net/wireless/rtlwifi/efuse.c: In function 'efuse_pg_packet_write':
drivers/net/wireless/rtlwifi/efuse.c:711:31: warning: 'hworden' may be used=
=20
uninitialized in this function [-Wuninitialized]
drivers/net/wireless/rtlwifi/efuse.c:689:5: note: 'hworden' was declared he=
re
drivers/net/wireless/iwlwifi/iwl-eeprom.c: In function 'iwl_set_otp_access':
drivers/net/wireless/iwlwifi/iwl-eeprom.c:180:6: warning: variable 'otpgp' =
set=20
but not used [-Wunused-but-set-variable]
drivers/net/wireless/iwlwifi/iwl-tx.c: In function 'iwl_enqueue_hcmd':
drivers/net/wireless/iwlwifi/iwl-tx.c:428:6: warning: variable 'len' set bu=
t=20
not used [-Wunused-but-set-variable]
drivers/net/wireless/rtlwifi/rtl8192ce/fw.c: In function=20
'_rtl92c_cmd_send_packet':
drivers/net/wireless/rtlwifi/rtl8192ce/fw.c:570:5: warning: variable 'own' =
set=20
but not used [-Wunused-but-set-variable]
drivers/net/wireless/rtlwifi/rtl8192ce/dm.c: In function=20
'rtl92c_dm_check_txpower_tracking_thermal_meter':
drivers/net/wireless/rtlwifi/rtl8192ce/dm.c:1051:19: warning: 'cck_index' m=
ay=20
be used uninitialized in this function [-Wuninitialized]
drivers/net/wireless/rtlwifi/rtl8192ce/dm.c:719:20: note: 'cck_index' was=20
declared here
drivers/net/wireless/rtlwifi/rtl8192ce/dm.c:825:26: warning: 'cck_index_old=
'=20
may be used uninitialized in this function [-Wuninitialized]
drivers/net/wireless/rtlwifi/rtl8192ce/dm.c:719:50: note: 'cck_index_old' w=
as=20
declared here
drivers/net/wireless/rtlwifi/rtl8192ce/fw.c: In function 'rtl92c_fill_h2c_c=
md':
drivers/net/wireless/rtlwifi/rtl8192ce/fw.c:418:4: warning: 'buf_index' may=
 be=20
used uninitialized in this function [-Wuninitialized]
drivers/net/wireless/rtlwifi/rtl8192ce/fw.c:308:5: note: 'buf_index' was=20
declared here
drivers/net/wireless/rtlwifi/rtl8192ce/fw.c:454:40: warning: 'box_extreg' m=
ay=20
be used uninitialized in this function [-Wuninitialized]
drivers/net/wireless/rtlwifi/rtl8192ce/fw.c:305:15: note: 'box_extreg' was=
=20
declared here
drivers/net/wireless/rtlwifi/rtl8192ce/fw.c:504:6: warning: 'box_reg' may b=
e=20
used uninitialized in this function [-Wuninitialized]
drivers/net/wireless/rtlwifi/rtl8192ce/hw.c: In function=20
'_rtl92ce_hw_configure':
drivers/net/wireless/rtlwifi/rtl8192ce/hw.c:796:6: warning: variable 'reg_r=
atr'=20
set but not used [-Wunused-but-set-variable]
drivers/net/wireless/rtlwifi/rtl8192ce/phy.c: In function=20
'rtl92c_phy_config_rf_with_headerfile':
drivers/net/wireless/rtlwifi/rtl8192ce/phy.c:693:7: warning: variable=20
'rtstatus' set but not used [-Wunused-but-set-variable]
drivers/net/wireless/rtlwifi/rtl8192ce/phy.c: In function=20
'_rtl92c_phy_iq_calibrate':
drivers/net/wireless/rtlwifi/rtl8192ce/phy.c:1718:6: warning: variable=20
'bbvalue' set but not used [-Wunused-but-set-variable]
drivers/net/wireless/rtlwifi/rtl8192ce/phy.c: In function=20
'rtl92c_phy_iq_calibrate':
drivers/net/wireless/rtlwifi/rtl8192ce/phy.c:2270:6: warning: variable=20
'reg_ecc' set but not used [-Wunused-but-set-variable]
drivers/net/wireless/rtlwifi/rtl8192ce/phy.c:2269:34: warning: variable=20
'reg_eac' set but not used [-Wunused-but-set-variable]
drivers/net/wireless/rtlwifi/rtl8192ce/rf.c: In function=20
'rtl92c_phy_rf6052_set_ofdm_txpower':
drivers/net/wireless/rtlwifi/rtl8192ce/rf.c:248:9: warning: 'chnlgroup' may=
 be=20
used uninitialized in this function [-Wuninitialized]
drivers/net/wireless/rtlwifi/rtl8192ce/rf.c:205:8: note: 'chnlgroup' was=20
declared here
drivers/net/wireless/rtlwifi/rtl8192ce/rf.c: In function=20
'rtl92c_phy_rf6052_config':
drivers/net/wireless/rtlwifi/rtl8192ce/../wifi.h:1487:54: warning: 'u4_regv=
alue'=20
may be used uninitialized in this function [-Wuninitialized]
drivers/net/wireless/rtlwifi/rtl8192ce/rf.c:450:6: note: 'u4_regvalue' was=
=20
declared here
drivers/net/wireless/rtlwifi/rtl8192ce/trx.c: In function=20
'_rtl92ce_translate_rx_signal_stuff':
drivers/net/wireless/rtlwifi/rtl8192ce/trx.c:619:6: warning: variable 'psad=
dr'=20
set but not used [-Wunused-but-set-variable]
drivers/net/wireless/rtlwifi/rtl8192ce/trx.c: In function=20
'rtl92ce_rx_query_desc':
drivers/net/wireless/rtlwifi/rtl8192ce/trx.c:479:31: warning: 'weighting' m=
ay=20
be used uninitialized in this function [-Wuninitialized]
drivers/net/wireless/rtlwifi/rtl8192ce/trx.c:466:6: note: 'weighting' was=20
declared here
drivers/net/wireless/rtlwifi/rtl8192ce/trx.c:346:15: warning: 'total_rssi' =
may=20
be used uninitialized in this function [-Wuninitialized]
drivers/net/wireless/rtlwifi/rtl8192ce/trx.c:257:12: note: 'total_rssi' was=
=20
declared here
drivers/net/wireless/rtlwifi/rtl8192ce/trx.c:341:14: warning: 'rf_rx_num' m=
ay=20
be used uninitialized in this function [-Wuninitialized]
drivers/net/wireless/rtlwifi/rtl8192ce/trx.c:255:5: note: 'rf_rx_num' was=20
declared here
WARNING: modpost: Found 5 section mismatch(es).
To see full details build your kernel with:
'make CONFIG_DEBUG_SECTION_MISMATCH=3Dy'


a build without the patch of course results in a non buildable kernel at all

Dennis

--nextPart18571376.RDN4idsxkx
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iEYEABECAAYFAk1oYtYACgkQkSxm47BaWfeXwgCeMM9k+jKbMCezV/Gr8mXTD1bi
vp8Ani4ET4sqZ3m787ihtXPrHej2/Dlc
=VNgm
-----END PGP SIGNATURE-----

--nextPart18571376.RDN4idsxkx--
