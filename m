From: David Miller <davem@davemloft.net>
Date: Sun, 27 Feb 2011 06:10:09 +0000
Subject: Re: [PATCH] sparc64: fix unused-but-set-variable warnings
Message-Id: <20110226.221009.183056205.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20110226085151.GA23117@merkur.ravnborg.org>
In-Reply-To: <20110226085151.GA23117@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Dennis Gilmore <dennis@ausil.us>
Date: Sat, 26 Feb 2011 20:08:00 -0600

> On Saturday, February 26, 2011 04:28:43 PM Sam Ravnborg wrote:
>> David - please do not apply this yet.
>> I need to go through it to convince myself that it is OK to ignore
>> the return resut in the cases where I blindly deleted it for now.
>> 
>> I will repost when I have done so.
>> 
>> Dennis - I would still like to know if this fixes all
>> sparc warnings so you no longer need to drop -Werror.
> 
> 
> arch/sparc/kernel/smp_64.c: In function 'flush_dcache_page_all':
> arch/sparc/kernel/smp_64.c:935:6: error: variable 'this_cpu' set but not used 
> [-Werror=unused-but-set-variable]
> cc1: all warnings being treated as errors
> make[1]: *** [arch/sparc/kernel/smp_64.o] Error 1
> 
> it fails to build still.  thanks Sam

Would have taken you like 5 seconds to look at the location that
warning is pointing to and try toss together a fix yourself for
us too look at?

Sam and I continue working on this, but I really expect a little bit
more effort on your part.
