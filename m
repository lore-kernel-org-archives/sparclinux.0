From: Christian Guggenberger
Date: Mon, 02 Feb 2004 14:59:25 +0000
Subject: Re: Oops with 2.6.2-rc3
Message-Id: <20040202155925.C714@pc9391.uni-regensburg.de>
List-Id: <sparclinux.vger.kernel.org>
References: <1075667365.2732.4.camel@bonnie79>
In-Reply-To: <1075667365.2732.4.camel@bonnie79>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

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

as I said before, I have 'alias net-pf-10 off' in modprobe.conf.
(although there's neither ipv6 enabled in kernel nor available as module)
Your DNS lookup theory may be right, cause from the timestamps in the kern 
logs the oops has always been at times when exim is run by cron. (and 
debian/unstable's exim3 is ipv6 capable, me thinks)

> Not sure if that's the cause of the oops though, but it would make
> sense. request_module() uses vsnprintf, which would explain why we see
> small_digits in the backtrace. It also invokes call_usermodehelper()
> with the wait flag, and this is what the backtrace shows is happening.
> 
> If it's related to SMP, then try enabling the spinlock debug. See if
> that prints anything interesting.
> 
> 
okay, will do so.

  - Christian

