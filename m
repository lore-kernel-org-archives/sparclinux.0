From: Richard Chan <rspchan@starhub.net.sg>
Date: Thu, 21 Oct 2004 14:49:04 +0000
Subject: Re: [2.6.9] headless SMP ultra2 has grave serial problem which lock
Message-Id: <4177CC60.9030904@starhub.net.sg>
List-Id: <sparclinux.vger.kernel.org>
References: <20041021111317.GB21579@outpost.ds9a.nl>
In-Reply-To: <20041021111317.GB21579@outpost.ds9a.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Is your system using the su driver by any chance? - I have a patch just 
posted to the list
that works around an irq problem - no doubt triggered by SMP because it 
ooopses
in synchronize_irq(). With my patch I still experienced one 
non-reproducible lockup but
by and large I can run agettys on both serial ports and login and out 
several times which is
the extent of my testing.

Richard Chan

bert hubert wrote:

>Hi,
>
>I've been given an Ultra 2 to develop PowerDNS on for use with UltraSparc
>processors but Linux is giving me some problems. The box is headless and has
>no display adapter at all.
>
>While 2.4.27 works well, 2.6.9 will only boot for me if I specify 'smp=no
>nosmp' on the SILO command line, and even then the machine often blocks.
>
>I can unblock it, when booted with 'smp=no nosmp', by sending a break and
>entering go. It does not block if there is no traffic over the serial port,
>so once booted and logged in with ssh things are fine.
>
>When truly blocked, which so far only happens when booting in SMP mode,
>sending a break does not bring up the 'ok' prompt anymore. The nosmp locks
>appear to be temporary and fixable with the break.
>
>When blocked, the entire machine is dead - not just the serial device!
>
>I've tried compiling with both gcc 3.3 and 3.4 (debian unstable, I think),
>both exhibit the same problem. I've compiled with both 'OpenBoot PROM
>serial' on or off and with Zilog serial on and off, oddly neither seem to
>help. 
>
>Anything I can do to help, let me know!
>
>Thanks.
>
>  
>

