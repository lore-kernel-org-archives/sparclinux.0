From: David Miller <davem@davemloft.net>
Date: Fri, 30 Mar 2007 22:05:01 +0000
Subject: Re: unaligned access in ipt_ULOG
Message-Id: <20070330.150501.57156021.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20070330214857.GB24923@stardust.friedrich-kn.de>
In-Reply-To: <20070330214857.GB24923@stardust.friedrich-kn.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Joerg.Friedrich@friedrich-kn.de
Cc: kaber@trash.net, netfilter-devel@lists.netfilter.org, sparclinux@vger.kernel.org

From: Joerg Friedrich <Joerg.Friedrich@friedrich-kn.de>
Date: Fri, 30 Mar 2007 23:48:57 +0200

> I wanted to use the iptables ULOG target, but I ran into these error
> messages. can anyone explain howto read this messge.
> 
> Kernel unaligned access at TPC[1029e35c] ipt_ulog_packet+0x214/0x3fc [ipt_ULOG]

It just means that unaligned accesses are occuring in the ipt_ulog
module.  Things usually work fine when this happens, just very slowly,
which is why the warning is printed.

Patrick, this is on sparc64, it appears to be this code:

	pm->timestamp_sec = skb->tstamp.off_sec;
	pm->timestamp_usec = skb->tstamp.off_usec;

and the NLMSG_DATA() (and thus 'pm') is not 8-byte aligned.

I bet this is a 32-bit sparc binary, has the idea of a compat
layer for the ULOG bits ever been discussed?

Thanks.
