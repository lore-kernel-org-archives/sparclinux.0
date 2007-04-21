From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
Date: Sat, 21 Apr 2007 19:33:25 +0000
Subject: Re: Soft Lockup on sun4c
Message-Id: <Pine.LNX.4.61.0704212027390.24708@mtfhpc.demon.co.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.61.0704201311280.15999@mtfhpc.demon.co.uk>
In-Reply-To: <Pine.LNX.4.61.0704201311280.15999@mtfhpc.demon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi Jan,

I will check that if I ever get far enough. The system locks up in 
kernel_exec of the initail process /sbin/bash.static 
(init=/sbin/bash.static).

Is there a setting to make L1-A enabled by default?

The last kernel that I have that gets further is 2.6.14.3.
I am about to test 2.16.15.6 to see if works but I would prefer to be 
running 2.6.20.7 + ESP2 as there have been lost of bug fixes etc.

Regards
 	Mark Fortescue.

On Sat, 21 Apr 2007, Jan Engelhardt wrote:

>
> On Apr 20 2007 13:22, Mark Fortescue wrote:
>> Hi,
>>
>> Can any one advise me on what boot options I can set to identify what is going
>> on during boot on my sun4c.
>>
>> The crash requires a power up reset (L1-A does not work).
>
> For this one: Make sure that /proc/sys/kernel/stop-a is enabled.
>
>
> Jan
> -- 
>
