From: David Miller <davem@davemloft.net>
Date: Sun, 01 Feb 2009 10:05:09 +0000
Subject: Re: [PATCH 0/3]: NMI watchdog support for sparc64
Message-Id: <20090201.020509.41001177.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20090130.002549.12348127.davem@davemloft.net>
In-Reply-To: <20090130.002549.12348127.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Fri, 30 Jan 2009 00:25:49 -0800 (PST)

> As promised here is the patch set.
> 
> Most of the changes involve moving the existing perf
> counter NMI bits out of the oprofile code and into
> a shared area.
> 
> Then we build the NMI watchdog support on top of it.

FWIW, I've some good news and bad news about these patches.

The good news is that I got the new NMI watchdog to trigger
for the system hang case I've been trying to track down.
So I can try to debug that problem now :-)

The bad news is that the NMI watchdog can trigger spuriously
when using NOHZ and I have to figure out a way to fix that.
