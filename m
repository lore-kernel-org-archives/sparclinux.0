From: Christian Guggenberger
Date: Mon, 02 Feb 2004 16:17:40 +0000
Subject: Re: Oops with 2.6.2-rc3
Message-Id: <1075738659.744.5.camel@bonnie79>
List-Id: <sparclinux.vger.kernel.org>
References: <1075667365.2732.4.camel@bonnie79>
In-Reply-To: <1075667365.2732.4.camel@bonnie79>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, 2004-02-02 at 15:32, Ben Collins wrote:
> > well, there are no suspicious lines printed before the oops.
> > Sometimes I see 'request_module: runaway loop modprobe net-pf-10', but 
> > these are printed out hours later than the oops.
> > So, for now I have net-pf-10 aliased to off in modprobe.conf. To your info, 
> > right before booting 2.6.2-rc3 for the first time I upgraded 
> > module-init-tools from pre5 to pre9, cause I have been annoyed by these 
> > 'request_module: failed /sbin/modprobe -- net-pf-10. error = 256' messages.
> > 
> > IMHO this oops is somehow correlated to SMP, because for now it's running 
> > fine since 4 hours in UP mode.
> > (normally in SMP mode the oops occured within an hour of uptime - no 
> > special load, no one logged in, no X)
> > 
> > I'll let this machine run in UP mode for the next 5 hours and will then do 
> > tests in SMP with kmod off.
> > This is a SBUS 2way UltrasparcI.
> 
> My mistake. I assumed this occured at boot. The net-pf-10 is the ipv6
> module. Do you have 'alias net-pf-10 ipv6' in modules.conf? I suspect
> this is occuring when something is doing an AAAA DNS lookup (glibc does
> this on most calls for DNS lookups).
> 
> Not sure if that's the cause of the oops though, but it would make
> sense. request_module() uses vsnprintf, which would explain why we see
> small_digits in the backtrace. It also invokes call_usermodehelper()
> with the wait flag, and this is what the backtrace shows is happening.
> 
> If it's related to SMP, then try enabling the spinlock debug. See if
> that prints anything interesting.
Ben, 

this doesn't compile with CONFIG_DEBUG_SPINLOCK=y ... (linux-2.6.2-rc3,
uptodate debian/unstable)

  CC      arch/sparc64/kernel/chmc.o
  CC      arch/sparc64/kernel/smp.o
  AS      arch/sparc64/kernel/trampoline.o
  AS      arch/sparc64/kernel/sys32.o
  CC      arch/sparc64/kernel/sys_sparc32.o
In file included from include/linux/ip.h:84,
                 from include/linux/tcp.h:192,
                 from include/linux/ipv6.h:175,
                 from arch/sparc64/kernel/sys_sparc32.c:47:
include/net/sock.h: In function `sk_dst_set':
include/net/sock.h:827: warning: implicit declaration of function
`_raw_write_trylock'

any idea?

thanks,
Christian


