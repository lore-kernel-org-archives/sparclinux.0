From: Jan Engelhardt <jengelh@linux01.gwdg.de>
Date: Fri, 18 May 2007 06:09:18 +0000
Subject: Re: How to load 2.6.22 kernel (image too large to fit ...)
Message-Id: <Pine.LNX.4.61.0705180805270.3231@yvahk01.tjqt.qr>
List-Id: <sparclinux.vger.kernel.org>
References: <464d3ea78cfe8@wp.pl>
In-Reply-To: <464d3ea78cfe8@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


On May 18 2007 07:50, Krzysztof Helt wrote:
>
>Hi,
>
>I have tried to load the latest 2.6.22-rc1 and failed miserably.
>I got 2.6MB kernel after modularization and famous "strip -R.
>note -R .commend" trick. Nevertheless, it is still too big.

08:05 sun:/boot # l
-rwxr-xr-x  1 root root 3655632 Mar 26 16:53 vmlinuz-2.6.20-1.2986.al3.3smp

No problems booting that on a E250. SILO is 1.4.13 too.

>I upgrades SILO to 1.4.13 and still no luck.
>Any hints? Are there any silo patches to allow bigger kernels.

`make bzImage` to build a kernel (rather than make zImage),
but I suppose you already have that :-/


	Jan
-- 
