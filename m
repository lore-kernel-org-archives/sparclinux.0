From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
Date: Mon, 07 May 2012 20:17:07 +0000
Subject: Re: sparc sun4c support - time to drop it?
Message-Id: <Pine.LNX.4.61.1205072111380.6676@mtfhpc.demon.co.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <20120505162104.GA14563@merkur.ravnborg.org>
In-Reply-To: <20120505162104.GA14563@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org



On Mon, 7 May 2012, Sam Ravnborg wrote:

> On Sat, May 05, 2012 at 06:21:04PM +0200, Sam Ravnborg wrote:
>> Is anyone having any sun4c boxes alive and running Linux?
>>
>> I have a nice box myself that does not boot - I do not know why.
>> But we are talking abot slow and old stuff here.
>>
>> Is it time to drop support for sun4c - or is anyone still
>> having an interest keeping that platform alive?
>>
>> Looking into recent history of the kernel only one person
>> (Mark - copied) seems to have contributed
>> solely for the purpose of getting a sun4c box working.
>>
>>
>> Sunstuff has a list of boxes based on sun4c here:
>> http://sunstuff.org/hardware/systems/sun4/sun4c/
>>
>> SPARCstation 1, SLC, IPC, 1+, 2, ELC, IPX
>> SPARCengine 1
>
> To summarize this thread...
>
> There are unsuprisingly some that for sentimental
> reasons would like to keep sun4c support in-kernel.
>
> But sun4c is outdated and if anyone want to run something
> on a sun4c box the *BSD variants has better performance.
>
> Also considering that sun4c support has been broken for
> some time and there is a few changes pending where sun4c
> does not make things simpler we will drop sun4c support.
>

Will Sun4c be dropped for 3.4 or 3.5 ?

(Just so that I can get my hands on a 'last supported' kernel to build 
when the network for my remote build host wakes up. :).)

> I already took a quick look at it and in the process
> I think I uncovered a bug in NMI handling for sun4m
> in UP mode. We would call the sun4c nmi trap despite
> being a sun4m box - this would not go well.
>
> When I have something tested I will forward my
> patches.
>
> 	Sam
> --
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
