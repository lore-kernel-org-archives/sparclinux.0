From: David Miller <davem@davemloft.net>
Date: Sat, 18 Apr 2015 19:25:29 +0000
Subject: Re: sparc64: Build failure due to commit f1600e549b94 (sparc: Make sparc64 use scalable lib/iommu-co
Message-Id: <20150418.152529.1571902263621297887.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20150418054705.GA10746@roeck-us.net>
	<20150418120510.GB1587@oracle.com>
In-Reply-To: <20150418120510.GB1587@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sowmini.varadhan@oracle.com
Cc: linux@roeck-us.net, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Sat, 18 Apr 2015 08:05:10 -0400

> But when I clone 
>   git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git
> and do a git show of the commit-id above, I see deltas that
> dont make sense (they seem to be from a patchset from somewhere
> in the middle of the review chain from the thread). 
> 
> What am I missing? 

I am pretty sure I applied V10 of your IOMMU submission.

http://patchwork.ozlabs.org/patch/459804/
http://patchwork.ozlabs.org/patch/459803/
http://patchwork.ozlabs.org/patch/459802/

and follow-on parisc build fix:

http://patchwork.ozlabs.org/patch/461905/

if I somehow botched this up, wow that's impressive :-)

If you can sort out what I did wrong and send me a relative
fixup patch, I'd really appreciate it.
