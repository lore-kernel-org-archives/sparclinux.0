From: Meelis Roos <mroos@linux.ee>
Date: Thu, 15 Jun 2017 06:37:47 +0000
Subject: Re: Spontaneous reboots seem to have been fixed
Message-Id: <alpine.LRH.2.20.1706150931310.12045@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.20.1704231850570.29170@math.ut.ee>
In-Reply-To: <alpine.LRH.2.20.1704231850570.29170@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> On 06/08/2017 07:05 AM, Meelis Roos wrote:
> >> For a long time I have had a problem on some of my sparc64 kernel 
> >> machines during kernel module linking (creating .mod.o and/or .ko) with 
> >> make -j4 but usually not with plain make.
> >>  
> 
> I would try running similar workload on test machines I have with
> mainline and see if I hit something similar. Otherwise it could be a
> h/w issue which manifests under some load.

I am hitting the problem on at least 3 machines (V210, V240, E420R) and 
it seems to have started with some kernel change. On one of them I hava 
an old working kernel .config that is stable. However, bisecting the 
config has not been straightforward. When I get some more time, I will 
try again.

There were two rpbolem on bisecting: first, there is no clear test case 
so far. Just doing repeated make clean && make -j4 does not seem to 
trigger the problem. Doing git pull && make -j4 does not trigger for 
small amount of git changes but triggers for bigger amounts sometimes.

And second, pinpointing to single kernel config option failed for the 
first time, maybe because of the first problem but maybe not.

I should probably create a tarball of the current source tree state and 
try untarring that + git pull + make - should probably make it ieasier 
to trigger.

> > Unfortunately that was false positive report - the probem is still 
> > present and just showed up in 4.11-rc8 and 4.11.0 on V210 and V240.
> > 
> 
> Maybe try h/w memory check before anything else.

I started at the same time on 2 machines and spread to third when I 
copied the .config oveer to it, so at the moment I do not suspect the 
hardware but the kernel.

Will put more time to it but I do not know when.

-- 
Meelis Roos (mroos@linux.ee)
