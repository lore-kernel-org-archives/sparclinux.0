From: tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Date: Sun, 15 Aug 2004 08:09:39 +0000
Subject: Re: Sun4d SMP wierdness
Message-Id: <20040815080939.GA16065@solo.franken.de>
List-Id: <sparclinux.vger.kernel.org>
References: <200408150157.12181.crn@netunix.com>
In-Reply-To: <200408150157.12181.crn@netunix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, Aug 15, 2004 at 01:57:12AM +0100, C.Newport wrote:
> 
> I am trying to track down why 2.4.27 (or any 2.4 series) does a watchdog 
> timeout very early in the boot sequence om Sun4d SMP.

SuperSparc I or II Cpu ?

IMHO SuperSparc II never worked for Sun4d. I've posted a patch against
2.4.something last year, which fixed that problem and I'm waiting
for spare time to bring it forward to 2.6 ...

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                 [ Alexander Viro on linux-kernel ]
