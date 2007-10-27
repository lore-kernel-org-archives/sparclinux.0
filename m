From: Ming Zhang <blackmagic02881@gmail.com>
Date: Sat, 27 Oct 2007 21:13:24 +0000
Subject: Re: [BUG] Raid1/5 over iSCSI trouble
Message-Id: <1193519604.4060.10.camel@localhost.localdomain>
List-Id: <sparclinux.vger.kernel.org>
References: <4714BB92.7040701@systella.fr> <471864F8.9010209@systella.fr>
	 <1192809103.30976.11.camel@dwillia2-linux.ch.intel.com>
	 <4718DE66.8000905@tmr.com> <471916B5.6080709@systella.fr>
	 <47191855.4020402@systella.fr> <47191BCF.2000908@systella.fr>
	 <1192828331.30976.26.camel@dwillia2-linux.ch.intel.com>
	 <4719B6DE.9040403@systella.fr> <471EF07A.5040007@systella.fr>
	 <e9c3a7c20710241649qb26c36by5733a93cff394c40@mail.gmail.com>
	 <47233D37.6070409@systella.fr>
In-Reply-To: <47233D37.6070409@systella.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: BERTRAND =?ISO-8859-1?Q?Jo=EBl?= <joel.bertrand@systella.fr>
Cc: Dan Williams <dan.j.williams@intel.com>, Bill Davidsen <davidsen@tmr.com>, linux-raid@vger.kernel.org, sparclinux@vger.kernel.org, iscsitarget-devel@lists.sourceforge.net

off topic, could you resubmit the alignment issue patch to list and see
if tomof accept. he needs a patch inlined in email. it is found and
fixed by you, so had better you post it (instead of me). thx.


On Sat, 2007-10-27 at 15:29 +0200, BERTRAND Joël wrote:
> Dan Williams wrote:
> > On 10/24/07, BERTRAND Joël <joel.bertrand@systella.fr> wrote:
> >>         Hello,
> >>
> >>         Any news about this trouble ? Any idea ? I'm trying to fix it, but I
> >> don't see any specific interaction between raid5 and istd. Does anyone
> >> try to reproduce this bug on another arch than sparc64 ? I only use
> >> sparc32 and 64 servers and I cannot test on other archs. Of course, I
> >> have a laptop, but I cannot create a raid5 array on its internal HD to
> >> test this configuration ;-)
> >>
> > 
> > Can you collect some oprofile data, as Ming suggested, so we can maybe
> > see what md_d0_raid5 and istd1 are fighting about?  Hopefully it is as
> > painless to run on sparc as it is on IA:
> > 
> > opcontrol --start --vmlinux=/path/to/vmlinux
> > <wait>
> > opcontrol --stop
> > opreport --image-path=/lib/modules/`uname -r` -l
> 
> 	Done.
> 
> Profiling through timer interrupt
> samples  %        image name               app name 
> symbol name
> 20028038 92.9510  vmlinux-2.6.23           vmlinux-2.6.23           cpu_idle
> 1198566   5.5626  vmlinux-2.6.23           vmlinux-2.6.23           schedule
> 41558     0.1929  vmlinux-2.6.23           vmlinux-2.6.23           yield
> 34791     0.1615  vmlinux-2.6.23           vmlinux-2.6.23           NGmemcpy
> 18417     0.0855  vmlinux-2.6.23           vmlinux-2.6.23 
> xor_niagara_5

raid5 use these 2. forgot to ask if you met any memory pressure here.




> 17430     0.0809  raid456                  raid456                  (no 
> symbols)
> 15837     0.0735  vmlinux-2.6.23           vmlinux-2.6.23 
> sys_sched_yield
> 14860     0.0690  iscsi_trgt.ko            iscsi_trgt               istd

could you get a call graph from oprofile. the yield is called quite
frequently. iet has some place to call it when no memory available. not
sure if this is the case.

i remember there was a post (maybe in lwn.net?) about some issues
between tickless kernel and yield() lead to 100% cpu utilization, i just
could not recalled the place, anybody have a clue?

or sparc64 does not have tickless kernel yet? did not follow these
carefully these days.


> 12705     0.0590  nf_conntrack             nf_conntrack             (no 
> symbols)
> 9236      0.0429  libc-2.6.1.so            libc-2.6.1.so            (no 
> symbols)
> 9034      0.0419  vmlinux-2.6.23           vmlinux-2.6.23 
> xor_niagara_2
> 6534      0.0303  oprofiled                oprofiled                (no 
> symbols)
> 6149      0.0285  vmlinux-2.6.23           vmlinux-2.6.23 
> scsi_request_fn
> 5947      0.0276  ip_tables                ip_tables                (no 
> symbols)
> 4510      0.0209  vmlinux-2.6.23           vmlinux-2.6.23 
> dma_4v_map_single
> 3823      0.0177  vmlinux-2.6.23           vmlinux-2.6.23 
> __make_request
> 3326      0.0154  vmlinux-2.6.23           vmlinux-2.6.23           tg3_poll
> 3162      0.0147  iscsi_trgt.ko            iscsi_trgt 
> scsi_cmnd_exec
> 3091      0.0143  vmlinux-2.6.23           vmlinux-2.6.23 
> scsi_dispatch_cmd
> 2849      0.0132  vmlinux-2.6.23           vmlinux-2.6.23 
> tcp_v4_rcv
> 2811      0.0130  vmlinux-2.6.23           vmlinux-2.6.23 
> nf_iterate
> 2729      0.0127  vmlinux-2.6.23           vmlinux-2.6.23 
> _spin_lock_bh
> 2551      0.0118  vmlinux-2.6.23           vmlinux-2.6.23           kfree
> 2467      0.0114  vmlinux-2.6.23           vmlinux-2.6.23 
> kmem_cache_free
> 2314      0.0107  vmlinux-2.6.23           vmlinux-2.6.23 
> atomic_add
> 2065      0.0096  vmlinux-2.6.23           vmlinux-2.6.23 
> NGbzero_loop
> 1826      0.0085  vmlinux-2.6.23           vmlinux-2.6.23           ip_rcv
> 1823      0.0085  nf_conntrack_ipv4        nf_conntrack_ipv4        (no 
> symbols)
> 1822      0.0085  vmlinux-2.6.23           vmlinux-2.6.23 
> clear_bit
> 1767      0.0082  python2.4                python2.4                (no 
> symbols)
> 1734      0.0080  vmlinux-2.6.23           vmlinux-2.6.23 
> atomic_sub_ret
> 1694      0.0079  vmlinux-2.6.23           vmlinux-2.6.23 
> tcp_rcv_established
> 1673      0.0078  vmlinux-2.6.23           vmlinux-2.6.23 
> tcp_recvmsg
> 1670      0.0078  vmlinux-2.6.23           vmlinux-2.6.23 
> netif_receive_skb
> 1668      0.0077  vmlinux-2.6.23           vmlinux-2.6.23           set_bit
> 1545      0.0072  vmlinux-2.6.23           vmlinux-2.6.23 
> __kmalloc_track_caller
> 1526      0.0071  iptable_nat              iptable_nat              (no 
> symbols)
> 1526      0.0071  vmlinux-2.6.23           vmlinux-2.6.23 
> kmem_cache_alloc
> 1373      0.0064  vmlinux-2.6.23           vmlinux-2.6.23 
> generic_unplug_device
> ...
> 
> 	Is it enough ?
> 
> 	Regards,
> 
> 	JKB
-- 
Ming Zhang


@#$%^ purging memory... (*!%
http://blackmagic02881.wordpress.com/
http://www.linkedin.com/in/blackmagic02881
--------------------------------------------

