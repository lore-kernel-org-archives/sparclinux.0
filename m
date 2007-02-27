From: "Daniel J. Priem" <daniel@flexserv.de>
Date: Tue, 27 Feb 2007 22:19:31 +0000
Subject: Re: Unaligned accesses in ip_rcv and ip_fast_csum
Message-Id: <87k5y3utu4.fsf@samuel.flexserv.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20070225200702.GA4451@droopy.oc.cox.net>
In-Reply-To: <20070225200702.GA4451@droopy.oc.cox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David Miller <davem@davemloft.net> writes:

> From: "Daniel J. Priem" <daniel@flexserv.de>
> Date: Tue, 27 Feb 2007 21:22:00 +0100
>
>> David Miller <davem@davemloft.net> writes:
>> 
>> > From: "Doug Nazar" <nazard@dragoninc.ca>
>> > Date: Tue, 27 Feb 2007 14:43:23 -0500
>> >
>> >> > We have a report (Debian bug #409313 [0]) of the following unaligned
>> >> > accesses, occuring every 5-6 seconds on Netra X1 and SunFire v100 with
>> >> > kernel 2.6.18 and newer:
>> 
>> This also occurs on netra t1 105  TI UltraSparc IIe (Hummingbird)
>> 
>> [93548.504961] Kernel unaligned access at TPC[6aa660]
>> aoenet_rcv+0xa8/0x1a0
>
> This is a different problem, it's totally unrelated.
>
> I fixed that particular issue in a seperate patch to the AOE driver
> which I posted yesterday, please test it out.

Yes it works perfect.
Thanks!

-- 
 .''`.
 : :' :      Daniel J. Priem
 `. `'       http://flexserv.de
   `-        

