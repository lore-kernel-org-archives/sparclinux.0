From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
Date: Sun, 12 Aug 2007 20:58:08 +0000
Subject: Re: Sun4c interrupt controller - Sun4d relevance
Message-Id: <Pine.LNX.4.61.0708122130190.1130@mtfhpc.demon.co.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <46BF2A25.9090900@netunix.com>
In-Reply-To: <46BF2A25.9090900@netunix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org



On Sun, 12 Aug 2007, Tom "spot" Callaway wrote:

>
> On Sun, 2007-08-12 at 20:23 +0100, Chris Newport wrote:
>
>> Last Solaris support for sun4d was Solaris 2.8 so all of the code will
>> be there in 2.6 somewhere. Maybe it is just a special case within sun4m
>> with a few extra drivers, or maybe the code has not been released.
>> The SS1000 is frustratingly similar to the SS20, most of the devices are
>> common.
>>
>> ISTR that Sun4d was a joint venture with Cray, so some code might
>> be encumbered. I have not seen code so I can only guess.
>
> I hate to be a bother here, but aren't there some legal concerns with
> looking at Solaris source code, then implementing code in Linux?
>
> Even on OpenSolaris, there is a grey area as to whether one can legally
> view CDDL licensed code, then reimplement it as GPL (CDDL is
> GPL-Incompatible) for Linux... but on old Solaris, that code should be
> proprietary, unless Sun opened it when I wasn't looking.
>

I do not know how much (if any) old solaris code was officially released. 
I just did a search on the web for the SunMMU as Sun don't apear to have 
any usefull documentation available (there was more when they supported 
sun4c) and LSI apear to have lost all their documentation on the chips 
used in my SS1/SS2.

> Mark, can you legally be doing this?
>

There are serveral points to make at this point.

1) I have not changed any Linux code based on Solaris or OpenSolaris 
source code, so no copyright issues there.

2) As I understand the numerous documents on the Sun web site, Sun do not 
support sun4c, sun4d or Sun4m so it is posible to argue that copyright is 
not very relevent to the architecture specific elements relating to these 
hardware architectures. They do not exist in OpenSolaris code anyway. 
Lawers may disagree :).

3) What I have been doing for sun4c is to compare what Linux is doing with 
what is going on in the Solaris/SunOS code in order to see if they shead 
light on why verious scenirious in Linux behave badly. So far all I have 
rearly managed to confirm is that the vast magority of the Linux low level 
code for sun4c is functionaly identical to Solaris/SunOS. I have not 
managed to explain why Linux fails in the verious ways it does and the 
Solaris Source code has not helped. I may be wrong but I can't see any 
copyright issues with doing this comparison.

4) There can't be any copyright against writing values into the sun4c MMU 
PTE registers/memory and reading values back to see what they contain. 
With the SunMMU.txt file, all I have done is merge the information from 
Linux source code. and the tests I have done, to provide a document that 
matches what I have found. This has then been checked to see if it is 
consistant with what is indicated in the Solaris code. Where there are 
some grey areas (where code operation is consistant but not identical) I 
have made a note to indicate that what is documented may not be correct 
or may vary from system to system. Is there an issue with this?

Regards
 	Mark.

