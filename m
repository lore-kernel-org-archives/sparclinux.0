From: Krzysztof Helt <krzysztof.h1@wp.pl>
Date: Mon, 14 Feb 2005 18:05:04 +0000
Subject: Re: sparc32 SMP for 2.6
Message-Id: <4210E850.8020009@wp.pl>
List-Id: <sparclinux.vger.kernel.org>
References: <420F070B.8010000@mc.net>
In-Reply-To: <420F070B.8010000@mc.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Do not forget about the patch for FPU context switching in SMP I posted 
last month.

Without the patch,  I am able to reproduce unexpected FP exceptions in 
linker (ld) during the SMP compilation (make -j3 on 2-way SS20). With 
the patch they are gone. I found it in the 2.4 kernel, but the buggy 
code is the same in 2.4 and 2.6 so I suspect that 2.6 needs it too.

It is maybe not so critical now, but it definitely adds to stability of 
32-bit SPARC SMP.

Regards,
Krzysztof

