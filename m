From: Chris Newport <crn@netunix.com>
Date: Wed, 23 Feb 2005 01:00:19 +0000
Subject: Re: Patch: SILO/first-isofs/isofs.c (Fix Sun4c)
Message-Id: <421BD5A3.7030705@netunix.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20050222162933.GA25092@internal>
In-Reply-To: <20050222162933.GA25092@internal>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I was getting too bogged down in the second/ code so I tried
simply using the second.b from older versions.

second.b from silo 1.2.6 works fine on all sun4c and sun4m
 but fails on sun4u
second.b from silo 1.4.5 and 2.4.8 both screw up on sun4c

So it looks like the sun4c / prom v0 support got broken between
1.2.6 and 1.4.5

Does this point to any smoking guns  ?.

Ben Collins wrote:

>Thanks. Committed to the repo. I'll try to get a new version out soon.
>
>As for the next error, it looks like it is trying to load it to the
>physical address of 0x0, which is a bad thing. That overwrites silo
>itself.
>
>So I guess there is an error in silo (not first-isofs). Check the
>memory_find() function in second/memory.c and see why it is using a
>physical address of 0x0.
>
>On Tue, Feb 22, 2005 at 04:55:10PM +0000, Chris Newport wrote:
>  
>
>>This small patch fixes silo-1.4.8/first-isofs/isofs.c
>>Copying an int into a string is not a good idea.
>>
>>Sun4c now loads second.b and the kernel, but still
>>barfs loading the initrd.
>>
>>boot:
>>Loaded kernel version 2.4.27
>>Loading initial ramdisk (905216 bytes at 0x0 phys, 0x300000 virt)...
>>Data Access ExceptionType b (boot), c(continue), or n (new command mode)
>>    
>>
>>Does anyone know what is wrong here ?
>>
>>    
>>

