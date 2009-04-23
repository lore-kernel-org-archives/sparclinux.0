From: David Miller <davem@davemloft.net>
Date: Thu, 23 Apr 2009 06:06:04 +0000
Subject: Re: inconsistent lock state in 2.6.29-rc6
Message-Id: <20090422.230604.46181489.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0903040949120.6557@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0903040949120.6557@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Wed, 22 Apr 2009 22:53:44 +0300 (EEST)

>> > This another problem from my 6-CPU E3000 - just got it while compiling 
>> > 2.6.29-rc7 but the compilation continues fine.
>> > 
>> > [  412.896568] ================>> > [  412.964373] [ INFO: inconsistent lock state ]
>> > [  413.016474] 2.6.29-rc6 #2
>> > [  413.047705] ---------------------------------
>> > [  413.099822] inconsistent {softirq-on-W} -> {in-softirq-W} usage.
>> > [  413.171717] cc1/2007 [HC0[0]:SC1[1]:HE0:SE0] takes:
>> > [  413.230048]  (call_function_lock){-+..}, at: [<000000000049003c>] generic_smp_call_function_interrupt+0x11c/0x1c0
>> > [  413.353010] {softirq-on-W} state was registered at:
>> 
>> Please try this patch:
> 
> It seems to work. When I got my E3000 hooked up to electricity again 
> four days ago, I compiled the latest git and found this patch already 
> included. It has seen some stress since, and a reboot into .30-rc3, aga 
> still seems to work fine. Thank you for taking care of it!

Thank you for testing.
