From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Date: Fri, 24 Nov 2006 19:13:23 +0000
Subject: Re: [PATCH 2.6.19-rc6] sparc: replace kmalloc+memset with kzalloc
Message-Id: <45674453.9040108@s5r6.in-berlin.de>
List-Id: <sparclinux.vger.kernel.org>
References: <4566DF0A.3050803@gmail.com> <45672D00.8060903@s5r6.in-berlin.de> <456741DD.6060103@gmail.com>
In-Reply-To: <456741DD.6060103@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yan Burman <burman.yan@gmail.com>
Cc: linux-kernel@vger.kernel.org, trivial@kernel.org, wli@holomorphy.com, sparclinux@vger.kernel.org

Yan Burman wrote:
> Stefan Richter wrote:
>> ...in this ^, the old code and your update don't check for NULL return.
> 
> Both of this parts are done at early stages, so it is probably:
> a) Impossible to recover from failure
> b) If you run out of memory at this stage, you are probably in very big
> trouble anyway
> 
> I could modify it to check and panic if the check fails.
> Would that be better?

I hope the domain experts answer this. (I have no recommendation but
wanted to point out a potential, although unlikely, cause for trouble.)
-- 
Stefan Richter
-===-=-=- =-= =---
http://arcgraph.de/sr/
