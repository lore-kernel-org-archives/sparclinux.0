From: Jan Oravec <jan.oravec@6com.sk>
Date: Sat, 13 Nov 2004 21:35:57 +0000
Subject: 2.6 sparc64 crashing under high load
Message-Id: <20041113213557.GA20251@omega.6com.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="4Ckj6UjgE2iN1+kY"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,


I have two ultrasparc II boxes running kernel/user-space 64-bit.

I had no problems with running 2.4 kernel (uptime of one such box under
heavy load is 308 days now).

About a year ago I tried to upgrade both machines to 2.6.0-test10 kernel. One
of these machines (the more important one) was under high load and keeped
crashing, so I downgraded back to 2.4. The other one was just routing
packets and runned without any problem.

Today, I decided to upgrade it to vanilla 2.6.9.

After kernel upgrade, I compiled a few packages and while compiling
something, I deleted a huge directory hierarchy and the box crashed.

Unfortunatelly the box was booted without keyboard/monitor plugged in, so I
could not see OOPS message (if there was any). Also, the box is in a housing
facility where I do not have a good access so I could not provide a better
details.

The .config is attached. (I do not have the one from 2.6.9 because the box
is in crashed state now - this one is from 2.6.0-test10, but it is almost
same because only non-important things has been changed).

I think it could be related to concurrent disk access or something like
that, because the box crashed just a few seconds after running 'rm'.


Thanks,


Jan

--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=config

CONFIG_64BIT=y
CONFIG_MMU=y
CONFIG_EXPERIMENTAL=y
CONFIG_STANDALONE=y
CONFIG_BROKEN=y
CONFIG_BROKEN_ON_SMP=y
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_LOG_BUF_SHIFT=16
CONFIG_KALLSYMS=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
CONFIG_OBSOLETE_MODPARM=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
CONFIG_SPARC64=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_SBUS=y
CONFIG_SBUSCHAR=y
CONFIG_SUN_AUXIO=y
CONFIG_SUN_IO=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
CONFIG_RTC=y
CONFIG_SUN_OPENPROMFS=y
CONFIG_SPARC32_COMPAT=y
CONFIG_COMPAT=y
CONFIG_UID16=y
CONFIG_BINFMT_ELF32=y
CONFIG_BINFMT_ELF=y
CONFIG_PROM_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_SERIAL_SUNCORE=y
CONFIG_SERIAL_SUNSU=y
CONFIG_SERIAL_SUNSAB=y
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_SUN_OPENPROMIO=y
CONFIG_SUN_MOSTEK_RTC=y
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_NBD=m
CONFIG_SCSI=y
CONFIG_SCSI_PROC_FS=y
CONFIG_BLK_DEV_SD=y
CONFIG_CHR_DEV_ST=m
CONFIG_CHR_DEV_OSST=m
CONFIG_BLK_DEV_SR=m
CONFIG_CHR_DEV_SG=m
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_REPORT_LUNS=y
CONFIG_SCSI_SYM53C8XX_2=y
CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=0
CONFIG_SCSI_SYM53C8XX_DEFAULT_TAGS=16
CONFIG_SCSI_SYM53C8XX_MAX_TAGS=64
CONFIG_NET=y
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_NET_IPIP=m
CONFIG_IPV6=m
CONFIG_NETFILTER=y
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_LIMIT=m
CONFIG_IP_NF_MATCH_OWNER=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP6_NF_MATCH_LIMIT=m
CONFIG_IP6_NF_MATCH_OWNER=m
CONFIG_IP6_NF_FILTER=m
CONFIG_IP6_NF_TARGET_LOG=m
CONFIG_XFRM=y
CONFIG_IPV6_SCTP__=m
CONFIG_NETDEVICES=y
CONFIG_NET_ETHERNET=y
CONFIG_HAPPYMEAL=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_INPUT=y
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_EVDEV=y
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
CONFIG_SERIO_CT82C710=y
CONFIG_SERIO_PCIPS2=y
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_SUNKBD=y
CONFIG_EXT2_FS=y
CONFIG_EXT3_FS=y
CONFIG_JBD=y
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_DEVFS_FS=y
CONFIG_DEVFS_MOUNT=y
CONFIG_DEVPTS_FS=y
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_PARTITION_ADVANCED=y
CONFIG_MSDOS_PARTITION=y
CONFIG_SUN_PARTITION=y
CONFIG_SOFT_WATCHDOG=y
CONFIG_DEBUG_KERNEL=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_CRC32=y

--4Ckj6UjgE2iN1+kY--
