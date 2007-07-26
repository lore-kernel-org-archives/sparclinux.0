From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
Date: Thu, 26 Jul 2007 21:11:09 +0000
Subject: Re: [PATCH] Sun/Solaris VTOC table corrections
Message-Id: <Pine.LNX.4.61.0707262137450.23486@mtfhpc.demon.co.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.61.0707251742000.20510@mtfhpc.demon.co.uk>
In-Reply-To: <Pine.LNX.4.61.0707251742000.20510@mtfhpc.demon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org



On Wed, 25 Jul 2007, David Miller wrote:

> From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
> Date: Thu, 26 Jul 2007 05:31:16 +0100 (BST)
>
>> This version alows the condition you indicated (VTOC sanity=0,version=0
>> and no_partitions=0) to work as before as long as what were the spare1/spare2
>> fields in the VTOC partition entries are zero.
>>
>> Can you try it out and see if it behaves correctly for fully set up VTOC
>> and also the previous Linux-Sun partition situation.
>>
>> This should at least prevent some posible problems with posible future
>> versions of VTOC. It may be desirable to to reject partitions if the
>> VTOC is not compatible (different sanity or version > 1). What is your view?
>>
>> The code will now also scan up to VTOC partitions when a validated VTOC
>> has been detected.
>
> It looks like it would work and I will give it some testing,
> thanks Mark.
>
> Why don't we want to try and use 16-partition x86 Solaris labels?
> Are those only found as sub-labels of MSDOS partitions?

Looking at some 2005 OpenSolaris code I have, it looks like there is a 
Solaris 16 partition disk label that uses an x86 Solaris style VTOC. If I 
understood the code, it is located at an offset of 512 bytes.

> -
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
