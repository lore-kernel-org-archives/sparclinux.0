From: Denys Fedoryschenko <denys@visp.net.lb>
Date: Wed, 13 May 2009 08:01:35 +0000
Subject: Re: Sun fire T2000,BUG: NMI Watchdog detected LOCKUP on CPU12
Message-Id: <200905131101.35358.denys@visp.net.lb>
List-Id: <sparclinux.vger.kernel.org>
References: <200905130300.12084.denys@visp.net.lb>
In-Reply-To: <200905130300.12084.denys@visp.net.lb>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wednesday 13 May 2009 08:01:46 David Miller wrote:
> From: Denys Fedoryschenko <denys@visp.net.lb>
> Date: Wed, 13 May 2009 03:00:11 +0300
>
> > Hi
> >
> > Got recently lockups on T2000 machine. Machine is relatively new.
> > While compiling with crazy makeflags "-j17" getting such messages.
> > Process which was being compiled stuck, and i cannot terminate it.
>
> That's not "crazy", I use -j32 as a minumum for my builds. :-)
>
> I started seeing these hangs with 2.6.30-rcX and will try to
> bisect it down when I get back from my week long cruise.
>
> It's definitely a post 2.6.29 regression.
Well, buying this t2k was a mistake of management, but it is kind of useful 
for porting my "heavily bitfielded" userspace app for big-endian's. Other 
choice is only PS3 or emulators in this country :-(

Also this expensive Sun box is terribly slow... dunno if it is a bug of 
software/kernel or hardware, but it starts from latency while compiling 
single 100kbyte source, ending even time to make -j17 for a linux kernel 
source. With such price, at x86, i will see bytes popping from server like a 
popcorn, getting dizzy because of speed.
But seems linux support of both, kind of weak, i will try to fill 
bugreports/patches. 
PS3 also had problems with WPA2 + dhcp. Recent commits with maintainers 
changes shows that Sony guys handling this question (not only for games) and 
maybe it can be fixed.

Sorry for offtopic :-) Now back to main subject...

I'm not sure, but maybe even 2.6.28.7, i had something similar.
Kernel where hangs occuiring ,i forgot to tell, but it is visible in dmesg - 
2.6.29.3. I will try meanwhile falling back to older kernels and to bisect by 
myself, if i will not become elder person while compiling kernel.


