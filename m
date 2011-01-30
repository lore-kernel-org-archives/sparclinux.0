From: David Miller <davem@davemloft.net>
Date: Sun, 30 Jan 2011 06:11:11 +0000
Subject: Re: [PATCH v2 0/8] sparc32: cleanup irq + smp files
Message-Id: <20110129.221111.189702284.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20110129080712.GA15903@merkur.ravnborg.org>
In-Reply-To: <20110129080712.GA15903@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 29 Jan 2011 09:07:12 +0100

> I am slowly working towards the goal of migrating
> sparc32 to genirq.
> PArt of the job is to understand the current code-base.
> While reading the code I was constantly distracted
> by all the minor issues in these.
> 
> So I cooked up a few patches to clean up the files.
> 
> In general I did like this:
> - Manually identified headers that was not needed
> - Added comments from an old patch from davem
> - Read through the file and fixed all the obvious stuff
> - Ran checkpatch on each file and fixed what I considered relevant
> 
> The files does not pass checkpatch with no warnings - this
> was not my goal.
> But the readability has increased which is good.
 ...
> Please consider applying.

All applied to sparc-next-2.6, thanks Sam.
