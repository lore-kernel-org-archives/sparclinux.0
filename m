From: David Miller <davem@davemloft.net>
Date: Mon, 03 Aug 2009 03:13:10 +0000
Subject: Re: sparc-leon patches round 5 (to follow) (right numbering)
Message-Id: <20090802.201310.258463093.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20090802.195140.26174602.davem@davemloft.net>
In-Reply-To: <20090802.195140.26174602.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Sun, 02 Aug 2009 19:51:40 -0700 (PDT)

> From: Konrad Eisele <konrad@gaisler.com>
> Date: Tue, 23 Jun 2009 11:11:42 +0200
> 
>> round 5 had wrong numbering, I'll repost.
> 
> I'm applying all of this to sparc-next-2.6 and will push it
> out to kernel.org after some build testing.

Ok, I had to revert all of this.

Are you even build testing what you're posting?

arch/sparc/kernel/built-in.o: In function `leon_node_init':
(.init.text+0x29c4): undefined reference to `_amba_init'

I can guess what happened, while respinning these patches you forgot
to do some "git add" commands and thus the file that contains the
amba_init() code is in your tree but not in any of the commits
and thus not in your patches.

When you fix this up and repost the series, do me another favor, try
to build the kernel successfully after each and every patch.  With
LEON enabled, the tree does not build after patch #3 because srmmu.c
doesn't include asm/leon.h yet and thus srmmu_swprobe() isn't declared.

Please walk through this patch set carefully, checking the build for
both LEON and non-LEON every step of the way, and after every commit
run "git status" to make sure there are not stray files not checked
into your tree.

Thanks.
