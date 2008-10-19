From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Date: Sun, 19 Oct 2008 14:12:06 +0000
Subject: Re: [PATCH] rtc-m48t59: fix setting of a year on m48t08 and m48t02
Message-Id: <20081019161206.c3990ed4.krzysztof.h1@poczta.fm>
List-Id: <sparclinux.vger.kernel.org>
References: <20080904185704.e5c9d1fc.krzysztof.h1@poczta.fm>
In-Reply-To: <20080904185704.e5c9d1fc.krzysztof.h1@poczta.fm>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, 14 Oct 2008 02:12:54 +0400
"Alexander Beregalov" <a.beregalov@gmail.com> wrote:

> 2008/10/14 Krzysztof Helt <krzysztof.h1@poczta.fm>:
> > Hi Alexander,
> Hi
> >
> > Please try the patch below if it fixes your problem. You need to set
> > correct date (year) after the patched kernel is run.
> Unfortunatelly, it does not work for me.
> 
> I patch kernel and reboot.
> I set correct date and save it (hwclock --systohc (from
> util-linux-2.14)) and reboot.
> Kernel sets date to
> rtc-m48t59 rtc-m48t59.0: setting system clock to 2108-10-14 01:32:24
> UTC (84654248)
> Then I do not set correct date and reboot again, the kernel sets date to
> rtc-m48t59 rtc-m48t59.0: setting system clock to 1972-09-06 21:49:09
> UTC (84664149)
> 
> (these two dates (unixtime) are not in that order that I mentioned, I
> did reboot many times, these messages are from last sessions)
> 
> >
> > It is tested on Ultra60 but not tested on sparc32.
> Unfortunatelly, I have only sparc64.
> 
> The kernel is
> 2.6.27-03543-ga447c09-dirty
> 
> commit a447c0932445f92ce6f4c1bd020f62c5097a7842
> Author: Steven Whitehouse <swhiteho@redhat.com>
> Date:   Mon Oct 13 10:46:57 2008 +0100
> vfs: Use const for kernel parser table
> 

I am trying to reproduce your problem on Ultra60 and Ubuntu 7.10
with kernel from 17 October (commit: 0cfd81031a26717fe14380d18275f8e217571615) 
but I have failed so far. I'll do more test.

Regards,
Krzysztof

----------------------------------------------------------------------
Drinkomat - aplikacja na telefon!
Pobierz >> http://link.interia.pl/f1f38 

