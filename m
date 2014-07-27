From: Christopher Alexander Tobias Schulze <cat.schulze@alice-dsl.net>
Date: Sun, 27 Jul 2014 15:31:00 +0000
Subject: Segmentation faults and RSS counter errors: Possible hints for cause?
Message-Id: <201407271731.00668.cat.schulze@alice-dsl.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On the SunBlade 2000 system which was affected by the lockup bug as
discussed in my previous mail

	[PATCH] Installing invalid entries in TSB causes hard lockup on UltraSPARC III

we also experienced random segmentation faults in combination with
RSS counter warnings, which would show under similar circumstances
where the lockup bug hit (heavy disk I/O).

During testing the patch as described in my previous mail, I added
additional instrumentation to tsb_insert() to trigger in cases where
a TSB entry with PTE.VALID = 0 was to be installed. This instrumentation
dumped the TAG and PTE to the syslog, together with a stacktrace to show
the call chain, and was not included in the patch as presented in my previous
mail.

While the patch as presented in my previous mail works flawlessly (no more
lockups, no more segmentation faults and/or RSS counter errors, even under
heavy stress testing), we noticed that the instrumentation patch did not
prevent the segmentation fault and RSS counter error problems:

Jul 21 10:43:31 troi kernel: [  986.918478] sshd[4408]: segfault at 15fc ip 00000000f7453f7c (rpc 00000000f7453f18) sp 00000000fffc6760 error 30001 in libc-2.13.so[f7394000+172000]
Jul 21 10:43:31 troi kernel: [  987.291121] ------------[ cut here ]------------
Jul 21 10:43:31 troi kernel: [  987.352984] WARNING: CPU: 0 PID: 4408 at mm/mmap.c:2736 exit_mmap+0x138/0x160()
Jul 21 10:43:31 troi kernel: [  987.455605] Modules linked in: nfsd auth_rpcgss oid_registry nfs_acl nfs lockd fscache sunrpc loop snd_sun_cs4231 snd_pcm snd_page_alloc snd_timer snd soundcore ext4 crc16 mbcache 
Jul 21 10:43:31 troi kernel: [  987.977807] CPU: 0 PID: 4408 Comm: sshd Not tainted 3.13.10 #3
Jul 21 10:43:31 troi kernel: [  988.055697] Call Trace:
Jul 21 10:43:31 troi kernel: [  988.092701]  [0000000000521e58] exit_mmap+0x138/0x160
Jul 21 10:43:31 troi kernel: [  988.160972]  [000000000045be9c] mmput+0x5c/0x100
Jul 21 10:43:31 troi kernel: [  988.223853]  [000000000045fdbc] do_exit+0x21c/0x9a0
Jul 21 10:43:31 troi kernel: [  988.289832]  [00000000004605a4] do_group_exit+0x24/0xc0
Jul 21 10:43:31 troi kernel: [  988.359881]  [000000000046dc80] get_signal_to_deliver+0x220/0x560
Jul 21 10:43:31 troi kernel: [  988.440467]  [00000000004457f8] do_signal32+0x18/0xac0
Jul 21 10:43:31 troi kernel: [  988.509488]  [000000000042cc20] do_signal+0x2c0/0x520
Jul 21 10:43:31 troi kernel: [  988.577441]  [000000000042d680] do_notify_resume+0x40/0x60
Jul 21 10:43:31 troi kernel: [  988.650551]  [0000000000404ac4] __handle_signal+0xc/0x2c
Jul 21 10:43:31 troi kernel: [  988.721638] ---[ end trace 06eabdd105f65186 ]---
Jul 21 10:43:31 troi kernel: [  988.784414] BUG: Bad rss-counter state mm:fffffc003deae4a0 idx:1 val:3

The segmentation fault seems to occur in __fork() in GLIBC, shortly after the
fork syscall returned, and the value of 0x15fc seems to indicate that some registers
were corrupted (%g2 is set to the constant 0x15f8 in the two instructions preceding
the memory access that segfaults, and the code tries to fetch a value from
[%l7 + %g2], where %l7 was initialized before the fork syscall was performed). The
value of %rpc is also quite suspicious: It seems to be an address in __fork() itself,
where __fork() calls _IO_list_lock() (shortly before the fork syscall), so %rpc
seems to belong to the register window of _IO_list_lock() and not to the window that
_fork() should use.

The fact that this segmentation fault seems to be related to forking, that
installing TSB entries with VALID set to 0 was attempted in a code path
that involved forking, and the RSS count warning for the process where the
segfault occured makes me wonder whether this could be related to a
register window spill onto the userspace stack, perhaps causing a fault-in
of the stack page at a phase during forking where this might not be expected.

Note that dumping a stack trace also involves flushing all register windows
out to the stack, so the fact that we observed the segfault and RSS problem
only in combination with the instrumentation patch (but not with the patch
that just prevents invalid entries to be inserted into the TSB, with no further
actions) could also point in this direction.

Unfortunately, due to lack of direct access to an affected machine, I will not
be able to investigate any further. However, I hope that these observations might
help others to find and eliminate the cause of these segfaults and RSS counter
bugs, so that the affected UltraSPARC III system is usable again with newer
kernels. (Until then, my former colleague will be forced to run another SunBlade
under 2.6.24, which has been performing absolutely flawlessly, without any
such problems and with uptimes of > 1 year.)

Regards,
Alexander Schulze
