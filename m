From: Martin Habets <errandir_news@mph.eclipse.co.uk>
Date: Sat, 06 May 2006 09:12:54 +0000
Subject: Re: sparc: cannot load any modules with 2.6.17-rc3
Message-Id: <20060506091254.GA32212@palantir8>
List-Id: <sparclinux.vger.kernel.org>
References: <20060505113514.GA28863@palantir8>
In-Reply-To: <20060505113514.GA28863@palantir8>
To: sparclinux@vger.kernel.org

Hi Dave,

I thought you were too busy with Niagara? so I figured the LKML was
the best way to go.

On Fri, May 05, 2006 at 05:34:49PM -0700, David S. Miller wrote:
> From: Martin Habets <errandir_news@mph.eclipse.co.uk>
> Date: Fri, 5 May 2006 12:35:14 +0100
> 
> > When I try to boot 2.6.17-rc3 on my SS20 I get this error for every
> > module it tries to load:
> >   module crc32: Unknown relocation: 17
> > 
> > This worked okay on 2.6.16-rc2. Is anyone looking into this problem yet?
> > It's comming from a new type R_SPARC_PC22 in the ELF header. Any idea
> > what could be causing this? Is it intentional or a bug?
> > 
> > I've attached my dmesg output and the config. Please CC me as I'm not
> > subscribed to linux-kernel.
> 
> I don't see how that type of relocation can be emitted.
> Can you send me one of the smaller of the *.ko files that
> have this problem?  Thanks.

I've put crc32.ko and crc32.o at http://www.mph.eclipse.co.uk/pub/linux/

> I can add the relocation handling to the Sparc module support,
> but I don't think it should be necessary in the first place
> and looking at a sample module with the problem will help me
> figure this out.

I'm puzzled as well why this is happening. Must be something in the
kernel code, as I'm still building 2.6.16-rc2 fine on the same machine.
Below I've attached a verbose build output of this module.

Thanks,
-- 
Martin
----------------------------------------
Script started on Sat 06 May 2006 09:54:39 BST
]0;opendev@palantir9: /home/opendev/dev/linux/2.6.17-rc3opendev@palantir9:~/dev/linux/2.6.17-rc3$ make V=1 lib/crc32.ko
rm -f .kernelrelease
echo 2.6.17-rc3-mph3 > .kernelrelease
if test ! /home/opendev/src/linux/2.6.17-rc3 -ef /home/opendev/src/linux/2.6.17-rc3; then \
/bin/sh /home/opendev/src/linux/2.6.17-rc3/scripts/mkmakefile              \
    /home/opendev/src/linux/2.6.17-rc3 /home/opendev/src/linux/2.6.17-rc3 2 6         \
    > /home/opendev/src/linux/2.6.17-rc3/Makefile;                                 \
    echo '  GEN    /home/opendev/src/linux/2.6.17-rc3/Makefile';                   \
fi
set -e; echo '  CHK     include/linux/version.h'; mkdir -p include/linux/; 	if [ `echo -n "2.6.17-rc3-mph3" | wc -c ` -gt 64 ]; then echo '"2.6.17-rc3-mph3" exceeds 64 characters' >&2; exit 1; fi; (echo \#define UTS_RELEASE \"2.6.17-rc3-mph3\"; echo \#define LINUX_VERSION_CODE `expr 2 \\* 65536 + 6 \\* 256 + 17`; echo '#define KERNEL_VERSION(a,b,c) (((a) << 16) + ((b) << 8) + (c))'; ) < /home/opendev/src/linux/2.6.17-rc3/Makefile > include/linux/version.h.tmp; if [ -r include/linux/version.h ] && cmp -s include/linux/version.h include/linux/version.h.tmp; then rm -f include/linux/version.h.tmp; else echo '  UPD     include/linux/version.h'; mv -f include/linux/version.h.tmp include/linux/version.h; fi
  CHK     include/linux/version.h
make -f scripts/Makefile.build obj=scripts/basic
make -f scripts/Makefile.build obj=.
mkdir -p arch/sparc/kernel/
make -f scripts/Makefile.build obj=scripts
make -f scripts/Makefile.build obj=scripts/mod
make KBUILD_MODULES=1   \
-f scripts/Makefile.build obj=lib lib/crc32.o
  gcc -Wp,-MD,lib/.crc32.o.d  -nostdinc -isystem /usr/lib/gcc/sparc-linux/3.4.4/include -D__KERNEL__ -Iinclude  -include include/linux/autoconf.h -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -O2 -fomit-frame-pointer -fasynchronous-unwind-tables -m32 -pipe -mno-fpu -fcall-used-g5 -fcall-used-g7 -Wdeclaration-after-statement    -DMODULE -D"KBUILD_STR(s)=#s" -D"KBUILD_BASENAME=KBUILD_STR(crc32)"  -D"KBUILD_MODNAME=KBUILD_STR(crc32)" -c -o lib/crc32.o lib/crc32.c
make -rR -f /home/opendev/src/linux/2.6.17-rc3/scripts/Makefile.modpost
  scripts/mod/modpost   -o /home/opendev/src/linux/2.6.17-rc3/Module.symvers   vmlinux arch/sparc/kernel/led.o crypto/crc32c.o crypto/crypto_null.o crypto/deflate.o crypto/des.o crypto/md4.o crypto/md5.o crypto/sha1.o drivers/block/cryptoloop.o drivers/block/loop.o drivers/block/rd.o drivers/cdrom/cdrom.o drivers/input/serio/serio_raw.o drivers/input/serio/serport.o drivers/net/mii.o drivers/net/sunlance.o drivers/rtc/rtc-core.o drivers/rtc/rtc-dev.o drivers/rtc/rtc-lib.o drivers/rtc/rtc-proc.o drivers/rtc/rtc-sysfs.o drivers/sbus/char/openprom.o drivers/sbus/char/rtc.o drivers/scsi/ch.o drivers/scsi/iscsi_tcp.o drivers/scsi/qlogicpti.o drivers/scsi/scsi_transport_iscsi.o drivers/scsi/scsi_transport_spi.o drivers/scsi/sg.o drivers/scsi/sr_mod.o drivers/scsi/st.o fs/cramfs/cramfs.o fs/fat/fat.o fs/isofs/isofs.o fs/lockd/lockd.o fs/minix/minix.o fs/msdos/msdos.o fs/nfs/nfs.o fs/nls/nls_base.o fs/openpromfs/openpromfs.o fs/ufs/ufs.o fs/vfat/vfat.o lib/crc-ccitt.o lib/crc32.o lib/libcrc32c.o lib/zlib_deflate/zlib_deflate.o lib/zlib_inflate/zlib_inflate.o net/ipv4/ah4.o net/ipv4/esp4.o net/ipv4/inet_diag.o net/ipv4/ipcomp.o net/ipv4/tcp_diag.o net/ipv4/tunnel4.o net/ipv4/xfrm4_tunnel.o net/key/af_key.o net/sunrpc/sunrpc.o net/xfrm/xfrm_user.o sound/core/snd-page-alloc.o sound/core/snd-pcm.o sound/core/snd-timer.o sound/core/snd.o sound/soundcore.o sound/sparc/snd-sun-amd7930.o sound/sparc/snd-sun-cs4231.o sound/sparc/snd-sun-dbri.o
WARNING: vmlinux - Section mismatch: reference to .init.text:no_sun4u_here from .text between 'current_pc' (at offset 0x9040) and 'already_mapped'
WARNING: vmlinux - Section mismatch: reference to .init.text: from .text between 'go_to_highmem' (at offset 0x9280) and 'init_thread_union'
WARNING: vmlinux - Section mismatch: reference to .init.text: from .text between 'go_to_highmem' (at offset 0x9284) and 'init_thread_union'
WARNING: vmlinux - Section mismatch: reference to .init.text:spawn_ksoftirqd from .text between 'init' (at offset 0xc098) and 'try_name'
WARNING: vmlinux - Section mismatch: reference to .init.text:sched_init_smp from .text between 'init' (at offset 0xc0a0) and 'try_name'
WARNING: vmlinux - Section mismatch: reference to .init.text:populate_rootfs from .text between 'init' (at offset 0xc0a8) and 'try_name'
WARNING: vmlinux - Section mismatch: reference to .init.text:usermodehelper_init from .text between 'init' (at offset 0xc0b8) and 'try_name'
WARNING: vmlinux - Section mismatch: reference to .init.text:driver_init from .text between 'init' (at offset 0xc0c0) and 'try_name'
WARNING: vmlinux - Section mismatch: reference to .init.text:sysctl_init from .text between 'init' (at offset 0xc0c8) and 'try_name'
WARNING: vmlinux - Section mismatch: reference to .init.data:initcall_debug from .text between 'init' (at offset 0xc0e8) and 'try_name'
WARNING: vmlinux - Section mismatch: reference to .init.data:initcall_debug from .text between 'init' (at offset 0xc0ec) and 'try_name'
WARNING: vmlinux - Section mismatch: reference to .init.data:initcall_debug from .text between 'init' (at offset 0xc120) and 'try_name'
WARNING: vmlinux - Section mismatch: reference to .init.data:initcall_debug from .text between 'init' (at offset 0xc1b4) and 'try_name'
WARNING: vmlinux - Section mismatch: reference to .init.text:prepare_namespace from .text between 'init' (at offset 0xc2e0) and 'try_name'
WARNING: vmlinux - Section mismatch: reference to .init.data:boot_flags from .text between 'obp_system_intr' (at offset 0x12dc4) and 'show_cpuinfo'
WARNING: vmlinux - Section mismatch: reference to .init.data:boot_flags from .text between 'obp_system_intr' (at offset 0x12dc8) and 'show_cpuinfo'
WARNING: vmlinux - Section mismatch: reference to .init.text:__alloc_bootmem from .text between 'srmmu_nocache_init' (at offset 0x193bc) and 'srmmu_mmu_info'
WARNING: vmlinux - Section mismatch: reference to .init.text:__alloc_bootmem from .text between 'srmmu_nocache_init' (at offset 0x193dc) and 'srmmu_mmu_info'
WARNING: vmlinux - Section mismatch: reference to .init.text:srmmu_early_allocate_ptable_skeleton from .text between 'srmmu_nocache_init' (at offset 0x1944c) and 'srmmu_mmu_info'
WARNING: vmlinux - Section mismatch: reference to .init.data:tvec_base_done.0 from .text between 'timer_cpu_notify' (at offset 0x35964) and 'msleep_interruptible'
WARNING: vmlinux - Section mismatch: reference to .init.data:tvec_base_done.0 from .text between 'timer_cpu_notify' (at offset 0x35970) and 'msleep_interruptible'
WARNING: vmlinux - Section mismatch: reference to .init.data:tvec_base_done.0 from .text between 'timer_cpu_notify' (at offset 0x359a4) and 'msleep_interruptible'
WARNING: vmlinux - Section mismatch: reference to .init.text:_sinittext from .text between 'core_kernel_text' (at offset 0x3d5c4) and '__kernel_text_address'
WARNING: vmlinux - Section mismatch: reference to .init.text:_sinittext from .text between 'core_kernel_text' (at offset 0x3d5c8) and '__kernel_text_address'
WARNING: vmlinux - Section mismatch: reference to .init.text:_einittext from .text between 'core_kernel_text' (at offset 0x3d5e0) and '__kernel_text_address'
WARNING: vmlinux - Section mismatch: reference to .init.text:_einittext from .text between 'core_kernel_text' (at offset 0x3d5e4) and '__kernel_text_address'
WARNING: vmlinux - Section mismatch: reference to .init.text:_sinittext from .text between 'kallsyms_lookup' (at offset 0x48cac) and '__print_symbol'
WARNING: vmlinux - Section mismatch: reference to .init.text:_sinittext from .text between 'kallsyms_lookup' (at offset 0x48cb0) and '__print_symbol'
WARNING: vmlinux - Section mismatch: reference to .init.text:_einittext from .text between 'kallsyms_lookup' (at offset 0x48cbc) and '__print_symbol'
WARNING: vmlinux - Section mismatch: reference to .init.text:_sinittext from .text between 'kallsyms_lookup' (at offset 0x48d64) and '__print_symbol'
WARNING: vmlinux - Section mismatch: reference to .init.text:_sinittext from .text between 'kallsyms_lookup' (at offset 0x48d68) and '__print_symbol'
WARNING: vmlinux - Section mismatch: reference to .init.text:_einittext from .text between 'kallsyms_lookup' (at offset 0x48d78) and '__print_symbol'
WARNING: vmlinux - Section mismatch: reference to .init.text:_einittext from .text between 'kallsyms_lookup' (at offset 0x48d7c) and '__print_symbol'
WARNING: vmlinux - Section mismatch: reference to .init.text:_einittext from .text between 'kallsyms_lookup' (at offset 0x48dbc) and '__print_symbol'
WARNING: vmlinux - Section mismatch: reference to .init.text:_sinittext from .text between 'kallsyms_lookup' (at offset 0x48de4) and '__print_symbol'
WARNING: vmlinux - Section mismatch: reference to .init.text:sunzilog_console_setup from .data between 'sunzilog_console' (at offset 0x7b4c) and 'devices_subsys'
WARNING: vmlinux - Section mismatch: reference to .init.text:apc_probe from .initcall.init between '__initcall_apc_probe' (at offset 0x4c) and '__initcall_pmc_probe'
WARNING: vmlinux - Section mismatch: reference to .init.text:pmc_probe from .initcall.init between '__initcall_pmc_probe' (at offset 0x50) and '__initcall_create_proc_profile'
WARNING: vmlinux - Section mismatch: reference to .init.text:create_proc_profile from .initcall.init between '__initcall_create_proc_profile' (at offset 0x54) and '__initcall_ioresources_init'
WARNING: vmlinux - Section mismatch: reference to .init.text:ioresources_init from .initcall.init between '__initcall_ioresources_init' (at offset 0x58) and '__initcall_uid_cache_init'
WARNING: vmlinux - Section mismatch: reference to .init.text:uid_cache_init from .initcall.init between '__initcall_uid_cache_init' (at offset 0x5c) and '__initcall_param_sysfs_init'
WARNING: vmlinux - Section mismatch: reference to .init.text:param_sysfs_init from .initcall.init between '__initcall_param_sysfs_init' (at offset 0x60) and '__initcall_init_posix_timers'
WARNING: vmlinux - Section mismatch: reference to .init.text:init_posix_timers from .initcall.init between '__initcall_init_posix_timers' (at offset 0x64) and '__initcall_init_posix_cpu_timers'
WARNING: vmlinux - Section mismatch: reference to .init.text:init_posix_cpu_timers from .initcall.init between '__initcall_init_posix_cpu_timers' (at offset 0x68) and '__initcall_init'
WARNING: vmlinux - Section mismatch: reference to .init.text:init from .initcall.init between '__initcall_init' (at offset 0x6c) and '__initcall_proc_dma_init'
WARNING: vmlinux - Section mismatch: reference to .init.text:proc_dma_init from .initcall.init between '__initcall_proc_dma_init' (at offset 0x70) and '__initcall_kallsyms_init'
WARNING: vmlinux - Section mismatch: reference to .init.text:kallsyms_init from .initcall.init between '__initcall_kallsyms_init' (at offset 0x74) and '__initcall_init_per_zone_pages_min'
WARNING: vmlinux - Section mismatch: reference to .init.text:helper_init from .initcall.init between '__initcall_helper_init' (at offset 0x0) and '__initcall_ksysfs_init'
WARNING: vmlinux - Section mismatch: reference to .init.text:ksysfs_init from .initcall.init between '__initcall_ksysfs_init' (at offset 0x4) and '__initcall_filelock_init'
WARNING: vmlinux - Section mismatch: reference to .init.text:init_per_zone_pages_min from .initcall.init between '__initcall_init_per_zone_pages_min' (at offset 0x78) and '__initcall_pdflush_init'
WARNING: vmlinux - Section mismatch: reference to .init.text:pdflush_init from .initcall.init between '__initcall_pdflush_init' (at offset 0x7c) and '__initcall_kswapd_init'
WARNING: vmlinux - Section mismatch: reference to .init.text:kswapd_init from .initcall.init between '__initcall_kswapd_init' (at offset 0x80) and '__initcall_init_emergency_pool'
WARNING: vmlinux - Section mismatch: reference to .init.text:init_emergency_pool from .initcall.init between '__initcall_init_emergency_pool' (at offset 0x84) and '__initcall_procswaps_init'
WARNING: vmlinux - Section mismatch: reference to .init.text:procswaps_init from .initcall.init between '__initcall_procswaps_init' (at offset 0x88) and '__initcall_init_tmpfs'
WARNING: vmlinux - Section mismatch: reference to .init.text:init_tmpfs from .initcall.init between '__initcall_init_tmpfs' (at offset 0x8c) and '__initcall_fasync_init'
WARNING: vmlinux - Section mismatch: reference to .init.text:init_bio from .initcall.init between '__initcall_init_bio' (at offset 0x20) and '__initcall_genhd_device_init'
WARNING: vmlinux - Section mismatch: reference to .init.text:init_pipe_fs from .initcall.init between '__initcall_init_pipe_fs' (at offset 0x44) and '__initcall_chr_dev_init'
WARNING: vmlinux - Section mismatch: reference to .init.text:fasync_init from .initcall.init between '__initcall_fasync_init' (at offset 0x90) and '__initcall_aio_setup'
WARNING: vmlinux - Section mismatch: reference to .init.text:aio_setup from .initcall.init between '__initcall_aio_setup' (at offset 0x94) and '__initcall_eventpoll_init'
WARNING: vmlinux - Section mismatch: reference to .init.text:eventpoll_init from .initcall.init between '__initcall_eventpoll_init' (at offset 0x98) and '__initcall_init_devpts_fs'
WARNING: vmlinux - Section mismatch: reference to .init.text:init_devpts_fs from .initcall.init between '__initcall_init_devpts_fs' (at offset 0x9c) and '__initcall_init_ext3_fs'
WARNING: vmlinux - Section mismatch: reference to .init.text:init_ext3_fs from .initcall.init between '__initcall_init_ext3_fs' (at offset 0xa0) and '__initcall_journal_init'
WARNING: vmlinux - Section mismatch: reference to .init.text:journal_init from .initcall.init between '__initcall_journal_init' (at offset 0xa4) and '__initcall_init_ramfs_fs'
WARNING: vmlinux - Section mismatch: reference to .init.text:init_ramfs_fs from .initcall.init between '__initcall_init_ramfs_fs' (at offset 0xa8) and '__initcall_ipc_init'
WARNING: vmlinux - Section mismatch: reference to .init.text:filelock_init from .initcall.init between '__initcall_filelock_init' (at offset 0x8) and '__initcall_init_script_binfmt'
WARNING: vmlinux - Section mismatch: reference to .init.text:init_script_binfmt from .initcall.init between '__initcall_init_script_binfmt' (at offset 0xc) and '__initcall_init_elf_binfmt'
WARNING: vmlinux - Section mismatch: reference to .init.text:init_elf_binfmt from .initcall.init between '__initcall_init_elf_binfmt' (at offset 0x10) and '__initcall_sock_init'
WARNING: vmlinux - Section mismatch: reference to .init.text:ipc_init from .initcall.init between '__initcall_ipc_init' (at offset 0xac) and '__initcall_init_crypto'
WARNING: vmlinux - Section mismatch: reference to .init.text:init_crypto from .initcall.init between '__initcall_init_crypto' (at offset 0xb0) and '__initcall_noop_init'
WARNING: vmlinux - Section mismatch: reference to .init.text:genhd_device_init from .initcall.init between '__initcall_genhd_device_init' (at offset 0x24) and '__initcall_misc_init'
WARNING: vmlinux - Section mismatch: reference to .init.text:noop_init from .initcall.init between '__initcall_noop_init' (at offset 0xb4) and '__initcall_deadline_init'
WARNING: vmlinux - Section mismatch: reference to .init.text:deadline_init from .initcall.init between '__initcall_deadline_init' (at offset 0xb8) and '__initcall_rand_initialize'
WARNING: vmlinux - Section mismatch: reference to .init.text:chr_dev_init from .initcall.init between '__initcall_chr_dev_init' (at offset 0x48) and '__initcall_apc_probe'
WARNING: vmlinux - Section mismatch: reference to .init.text:seqgen_init from .initcall.init between '__initcall_seqgen_init' (at offset 0xf0) and '__initcall_net_random_reseed'
WARNING: vmlinux - Section mismatch: reference to .init.text:rand_initialize from .initcall.init between '__initcall_rand_initialize' (at offset 0xbc) and '__initcall_tty_init'
WARNING: vmlinux - Section mismatch: reference to .init.text:tty_init from .initcall.init between '__initcall_tty_init' (at offset 0xc0) and '__initcall_pty_init'
WARNING: vmlinux - Section mismatch: reference to .init.text:pty_init from .initcall.init between '__initcall_pty_init' (at offset 0xc4) and '__initcall_suncore_init'
WARNING: vmlinux - Section mismatch: reference to .init.text:suncore_init from .initcall.init between '__initcall_suncore_init' (at offset 0xc8) and '__initcall_sunzilog_init'
WARNING: vmlinux - Section mismatch: reference to .init.text:sunzilog_init from .initcall.init between '__initcall_sunzilog_init' (at offset 0xcc) and '__initcall_net_olddevs_init'
WARNING: vmlinux - Section mismatch: reference to .init.text:net_olddevs_init from .initcall.init between '__initcall_net_olddevs_init' (at offset 0xd0) and '__initcall_init_this_scsi_driver'
WARNING: vmlinux - Section mismatch: reference to .init.text:init_this_scsi_driver from .initcall.init between '__initcall_init_this_scsi_driver' (at offset 0xd4) and '__initcall_init_sd'
WARNING: vmlinux - Section mismatch: reference to .init.text:init_sd from .initcall.init between '__initcall_init_sd' (at offset 0xd8) and '__initcall_flow_cache_init'
WARNING: vmlinux - Section mismatch: reference to .init.text:tty_class_init from .initcall.init between '__initcall_tty_class_init' (at offset 0x1c) and '__initcall_init_bio'
WARNING: vmlinux - Section mismatch: reference to .init.text:misc_init from .initcall.init between '__initcall_misc_init' (at offset 0x28) and '__initcall_init_scsi'
WARNING: vmlinux - Section mismatch: reference to .init.text:init_scsi from .initcall.init between '__initcall_init_scsi' (at offset 0x2c) and '__initcall_sbus_init'
WARNING: vmlinux - Section mismatch: reference to .init.text:sbus_init from .initcall.init between '__initcall_sbus_init' (at offset 0x30) and '__initcall_serio_init'
WARNING: vmlinux - Section mismatch: reference to .init.text:serio_init from .initcall.init between '__initcall_serio_init' (at offset 0x34) and '__initcall_proto_init'
WARNING: vmlinux - Section mismatch: reference to .init.text:sock_init from .initcall.init between '__initcall_sock_init' (at offset 0x14) and '__initcall_netlink_proto_init'
WARNING: vmlinux - Section mismatch: reference to .init.text:netlink_proto_init from .initcall.init between '__initcall_netlink_proto_init' (at offset 0x18) and '__initcall_tty_class_init'
WARNING: vmlinux - Section mismatch: reference to .init.text:proto_init from .initcall.init between '__initcall_proto_init' (at offset 0x38) and '__initcall_net_dev_init'
WARNING: vmlinux - Section mismatch: reference to .init.text:net_dev_init from .initcall.init between '__initcall_net_dev_init' (at offset 0x3c) and '__initcall_genl_init'
WARNING: vmlinux - Section mismatch: reference to .init.text:genl_init from .initcall.init between '__initcall_genl_init' (at offset 0x40) and '__initcall_init_pipe_fs'
WARNING: vmlinux - Section mismatch: reference to .init.text:flow_cache_init from .initcall.init between '__initcall_flow_cache_init' (at offset 0xdc) and '__initcall_inet_init'
WARNING: vmlinux - Section mismatch: reference to .init.text:inet_init from .initcall.init between '__initcall_inet_init' (at offset 0xe0) and '__initcall_bictcp_register'
WARNING: vmlinux - Section mismatch: reference to .init.text:bictcp_register from .initcall.init between '__initcall_bictcp_register' (at offset 0xe4) and '__initcall_af_unix_init'
WARNING: vmlinux - Section mismatch: reference to .init.text:af_unix_init from .initcall.init between '__initcall_af_unix_init' (at offset 0xe8) and '__initcall_packet_init'
WARNING: vmlinux - Section mismatch: reference to .init.text:packet_init from .initcall.init between '__initcall_packet_init' (at offset 0xec) and '__initcall_seqgen_init'
WARNING: vmlinux - Section mismatch: reference to .init.text:set_preferred_console from .con_initcall.init after '__initcall_set_preferred_console' (at offset 0x0)
WARNING: drivers/rtc/rtc-sysfs.o - Section mismatch: reference to .init.text:rtc_sysfs_add_device from .data between 'rtc_sysfs_interface' (at offset 0xc) and 'rtc_attr_group'
WARNING: drivers/scsi/qlogicpti.o - Section mismatch: reference to .init.text: from .text between 'qlogicpti_release' (at offset 0x408) and 'qlogicpti_info'
  gcc -Wp,-MD,lib/.crc32.mod.o.d  -nostdinc -isystem /usr/lib/gcc/sparc-linux/3.4.4/include -D__KERNEL__ -Iinclude  -include include/linux/autoconf.h -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -O2 -fomit-frame-pointer -fasynchronous-unwind-tables -m32 -pipe -mno-fpu -fcall-used-g5 -fcall-used-g7 -Wdeclaration-after-statement     -D"KBUILD_STR(s)=#s" -D"KBUILD_BASENAME=KBUILD_STR(crc32)"  -D"KBUILD_MODNAME=KBUILD_STR(crc32)" -DMODULE -c -o lib/crc32.mod.o lib/crc32.mod.c
  ld -m elf32_sparc -r -o lib/crc32.ko lib/crc32.o lib/crc32.mod.o
]0;opendev@palantir9: /home/opendev/dev/linux/2.6.17-rc3opendev@palantir9:~/dev/linux/2.6.17-rc3$ exit

Script done on Sat 06 May 2006 09:56:20 BST
