From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
Date: Wed, 18 Apr 2007 20:57:44 +0000
Subject: Re: Prom Watchdog Reset
Message-Id: <Pine.LNX.4.61.0704182152350.12193@mtfhpc.demon.co.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.61.0704181949500.12028@mtfhpc.demon.co.uk>
In-Reply-To: <Pine.LNX.4.61.0704181949500.12028@mtfhpc.demon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi Daniel,

In this case, it is not a SIMM module issue (I have replaced them all 
some tome ago in order to get more memory as 16M was a bit small).

The SunOS4.1.1 kernel does not have this problem. It must reset somthing 
early on in boot that prevents the issue from occouring.

Regards
 	Mark Fortescue.

On Wed, 18 Apr 2007, Daniel Smolik wrote:

> Mark Fortescue napsal(a):
>> Hi,
>> 
>> On my sun4c OPUSstation (Sparc 1 clone) I regularly get tripped back to the 
>> Prom during boot:
>> 
>> ...
>> ok boot vmlinuz -p
>> Booting from: sd(0,0,0)vmlinuz -p
>> root on sd0a fstype 4.2
>> Size: 2675008+0+142756 bytes
>> Booting Linux...
>> Watchdog reset
>> Window Underflow
>> ok
> I have the similar problem on SS5 and remove a put back SIMM modules solve 
> this problem.
>
> 			Dan
>
>
>
>> 
>> The boot prom is Revision 1.0. Is there a way of doing a full Prom reset as 
>> part of the boot sequence to try and remove this issue.
>> 
>> If I redo the boot or do a powerup reset boot, there is no issue at this 
>> point.
>> 
>> Regards
>>     Mark Fortescue.
>> 
>> -
>> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
> -- 
> Mydatex s r.o.
> http://www.mydatex.cz
> email: smolik@mydatex.cz
> mob: 604200362
> tel: 226210085
>
