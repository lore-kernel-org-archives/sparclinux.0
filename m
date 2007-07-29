From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
Date: Sun, 29 Jul 2007 08:29:33 +0000
Subject: Re: Sparc32 not working:2.6.23-rc1 (git commit
Message-Id: <Pine.LNX.4.61.0707290856330.30117@mtfhpc.demon.co.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.61.0707281903350.27869@mtfhpc.demon.co.uk>
In-Reply-To: <Pine.LNX.4.61.0707281903350.27869@mtfhpc.demon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org



On Sat, 28 Jul 2007, David Miller wrote:

> From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
> Date: Sat, 28 Jul 2007 19:18:50 +0100 (BST)
>
>> Do you have any Sparc32/generic Sparc patches that have not already been
>> pushded up to
>> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
>
> No.
>
>> I have just tried out the latest commit on my sun4c SS1 and have found it
>> to have a NULL pointer bug. I can't give any details as the serial console
>> support is broaken and on the cgthree console, the information scrolled of
>> the top of the console before I had a chance to read any of the key
>> details.
>>
>> In addition, enabling CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY killed the
>> kernel while starting up the cgthree (it just stopped - no messages).
>>
>> Looks like I am going to have to step through the changes from my
>> working v2.6.22 kernel slowly.
>
> Yes, basically expect sparc32 to break as long as there is not
> a maintainer that constantly pulls from upstream and tests things
> on a frequent basis as I do for sparc64.
>
> Feel free to step up and be "the one" :-)

The trouble is I by the time I have sorted out one bug, another 3 or more 
have been introduced :-(.

Are there any additional notes arround on being a maintainer?
Is there a linux distribution that you would recommend that has all the 
required tools?

If the rate of breakage can be reduced to somthing that can be dealt with 
over 1 to 2 days per week then I could try to keep things tested. If not 
then I will run out of time whenever I am earing a living.

I have tried to identify a NULL pointer bug that has crepped into the code 
that runs /sbin/init but git bisect only gave me a kernel that will not 
build because of DMA changes. I tries some random selections to try and 
find a buildable/working kernel but without any sucess.

Any sugestions as to how to track the issue down through the 2000+ commits 
since v2.6.22. At between 20 and 40min per build+test the time required to 
test each build untill I get one that works is excessive.

> -
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
