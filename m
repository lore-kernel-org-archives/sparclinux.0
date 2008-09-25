From: Robert Reif <reif@earthlink.net>
Date: Thu, 25 Sep 2008 01:27:40 +0000
Subject: sparc-next RTC BUG: sleeping function called from invalid context
Message-Id: <48DAE90C.7010608@earthlink.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I'm getting this repeatable BUG from sparc-next with almost all
kernel debugging options turned on shortly after booting:

Sep 24 21:19:45 ss20-1 kernel: BUG: sleeping function called from 
invalid context at kernel/mutex.c:88
Sep 24 21:19:45 ss20-1 kernel: in_atomic():1, irqs_disabled():1
Sep 24 21:19:45 ss20-1 kernel: [f015c2bc : rtc_class_open+0x1c/0x7c ] 
[f001b034 : timer_interrupt+0xc0/0x138 ] [f0017340 : 
handler_irq+0xdc/0x148 ] [f0014774 : patch_handler_irq+0x0/0x24 ] 
[f0018bb0 : cpu_idle+0x2c/0x38 ] [f001ddd8 : smp_do_cpu_idle+0x0/0x10 ] 
[00000000 : 0x0 ]
Sep 24 21:19:45 ss20-1 kernel: ------------[ cut here ]------------
Sep 24 21:19:45 ss20-1 kernel: WARNING: at kernel/mutex.c:135 
__mutex_lock_slowpath+0x44/0x238()
Sep 24 21:19:45 ss20-1 kernel: Modules linked in: ipv6 lp parport 
sunlance sunhme loop sermouse evdev ext3 jbd sg sr_mod sd_mod cdrom 
sun_esp esp_scsi scsi_transport_spi scsi_mod
Sep 24 21:19:45 ss20-1 kernel: [f0146710 : class_find_device+0x48/0xe8 ] 
[f015c2bc : rtc_class_open+0x1c/0x7c ] [f001b034 : 
timer_interrupt+0xc0/0x138 ] [f0017340 : handler_irq+0xdc/0x148 ] 
[f0014774 : patch_handler_irq+0x0/0x24 ] [f0018bb0 : cpu_idle+0x2c/0x38 
] [f001ddd8 : smp_do_cpu_idle+0x0/0x10 ] [00000000 : 0x0 ]
Sep 24 21:19:45 ss20-1 kernel: ---[ end trace 46346a150b775121 ]---

Let me know if you need more info.

