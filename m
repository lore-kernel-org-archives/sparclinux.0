From: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>
Date: Sun, 18 May 2014 17:45:52 +0000
Subject: Re: format string mismatch in arch/sparc/kernel/sysfs.c
Message-Id: <5378F1D0.1010704@gmx.de>
List-Id: <sparclinux.vger.kernel.org>
References: <5378BB37.2000402@gmx.de>
In-Reply-To: <5378BB37.2000402@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 05/18/2014 07:32 PM, Sam Ravnborg wrote:
> Hi Torlaf.
> 
>> I'm just wondering if the format mismatch error is intentionally left in the code or not :
>>
>> [arch/sparc/kernel/sysfs.c:154]: (warning) %ld in format string (no. 1) requires 'long *' but the argument type is 'unsigned long *'.
> 
> This is something we should fix.
patch will be send out soon.

> My gcc does not give this warning - how did you produce the warning above?
Well, I got it with cppcheck - a nifty tool for static code checkin. I
stumbled over it a while ago - it still under development ofc.

> Also we use -Werror on purpose to catch warnings so they get fixed - so
> your build should have errored out.
> 
great

> Do you care to send a patch so you get proper attribution.

> 
> 	Sam
> 


-- 
Toralf

