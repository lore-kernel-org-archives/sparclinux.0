From: David Miller <davem@davemloft.net>
Date: Wed, 10 Sep 2014 18:39:59 +0000
Subject: Re: [PATCH] sparc64: sun4v TLB error power off events
Message-Id: <20140910.113959.1019322934399267183.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1410104858-22046-1-git-send-email-bpicco@meloft.net>
In-Reply-To: <1410104858-22046-1-git-send-email-bpicco@meloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Bob Picco <bpicco@meloft.net>
Date: Wed, 10 Sep 2014 10:18:22 -0400

> David Miller wrote:	[Tue Sep 09 2014, 05:52:46PM EDT]
>> From: Bob Picco <bob.picco@oracle.com>
>> Date: Tue, 9 Sep 2014 17:12:27 -0400
>> 
>> > I just ran a quick experiment on my T5-2 which is supported hardware. The
>> > kernel is 3.17-rc3 without any modification from me - well ixgbe. As root mmap
>> > of /dev/mem at address 0UL. It powered off:
>> 
>> Just out of curiosity what ixgbe patches do you need that aren't
>> upstream already?
> It is really Martin's (mkp) from last year. I ported it over to mainline.
> Basically the mac is acquired with:
>  addr = of_get_property(dp, "local-mac-address", &len);
> . I'll append at the end of this email what my local T5-2 is using. 

This really needs to: 1) get fixed to depend upon CONFIG_OF rather than
a specific architecture like SPARC and 2) get submitted and accepted
by the Intel ethernet driver maintainers.
