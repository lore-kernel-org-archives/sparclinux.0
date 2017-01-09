From: Shannon Nelson <shannon.lee.nelson@gmail.com>
Date: Mon, 09 Jan 2017 22:50:19 +0000
Subject: Re: console noise after commit c1e9b3b0eea
Message-Id: <CAP-MU4PhQoWsdCLX-D40Fi1Vs5win=SqYv16GJ_y+GSRMETL1w@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20160419223325.GA15852@oracle.com>
In-Reply-To: <20160419223325.GA15852@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

The real issue here is that a hardware feature was enabled but
probably only tested in the LDom, not on the actual hardware.  The
self-test code is only used when running in the primary LDom, or on
the bare hardware with no ldm running; the self-test code is not used
in the client LDom.  The newer hardware has a different register
layout, thus the self-test fails and reschedules itself to test again
in 2 seconds, and never gives up.

I'm cleaning up and testing a set of patches that disables the
self-test loop after a few failures to stop the logfile spewage, and
uses the correct register layout on the new hardware.

sln

On Sat, Jan 7, 2017 at 5:30 AM, Sowmini Varadhan
<sowmini.varadhan@oracle.com> wrote:
> On (01/07/17 15:51), Anatoly Pugachev wrote:
>> Sowmini ,
>>
>> what is your linux sysctl value for kernel.printk ?
>>
>> mine is :
>> kernel.printk = 7       4       1       7
>
> I also have that:
> # cat /proc/sys/kernel/printk
> 7       4       1       7
>
> But that's not the point- I have different levels of printks
> at various times to help me debug things at verious levels,
> (as our customers do) and this noise is a hindrance.
> We should really be getting to the bottom of this, and
> solving the real issue here.
>
> I think Shannon has made some good pregress with this, he
> should be sharing it on the list soon.
>
> (suppressing the printk is like asking me to remove the
> batteries from my fire-alarm- that's not the answer)
>
> --Sowmini
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
=======================
Mr. Shannon Nelson         Parents can't afford to be squeamish.
