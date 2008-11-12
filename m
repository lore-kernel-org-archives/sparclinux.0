From: "Alexander Beregalov" <a.beregalov@gmail.com>
Date: Wed, 12 Nov 2008 00:09:54 +0000
Subject: Re: 2.6.28-rc4: BUG: spinlock lockup on CPU#0
Message-Id: <a4423d670811111609l37dcfe6bme277692b5206b5ec@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20081111233230.GC12456@orion>
	 <20081111.154902.11426409.davem@davemloft.net>
In-Reply-To: <20081111.154902.11426409.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, kernel-testers@vger.kernel.org, rjw@sisk.pl

2008/11/12 David Miller <davem@davemloft.net>:
> From: Alexander Beregalov <a.beregalov@gmail.com>
> Date: Wed, 12 Nov 2008 02:32:30 +0300
>
>> It is on sparc64 (Ultra 10). 2.6.28-rc4-00011-g3ad4f59
>>
>> BUG: spinlock lockup on CPU#0, metalog/1322, 00000000007f1430
>> Kernel panic - not syncing: Aiee, killing interrupt handler!
>>
>> It seems Sysrq does not work.
>>
>> David, how can I provide more info before I reboot it ?
>>
>> Full dmesg:
>
> Hmm, this BUG message should have given you a register dump and a
> backtrace.
>
> Can you give it a "Alt-SysRQ-p" and show the output?
No, sysrq does not work, even Stop-A does not work now.
How could it be.

>
> Actually, if you got this over a serial console or
> similar, you're not getting the register dump because
> the console loglevel is filtering them out.
Yes, I use netconsole.

>
> If that's what's happening, reboot with "ignore_loglevel"
> (I always boot with this option, by adding it to the
> default kernel command line options in /etc/silo.conf)
>
> Also, in situations where the system is already booted and
> you want to see things like the Alt-SysRQ-p register dumps
> on the console, you'll need to type something like
> "Alt-SysRQ-8" to bump the console log level.

Yes, I know, thanks.

Ok, I have rebooted it, let's hope this will happen again...

Hm, fsck says Superblock write time is in future.
But rtc-m48t59 works correctly now
