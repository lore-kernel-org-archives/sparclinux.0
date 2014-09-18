From: Bob Picco <bpicco@meloft.net>
Date: Thu, 18 Sep 2014 22:15:30 +0000
Subject: Re: [PATCH] sparc64: swapper_tsb and swapper_4m_tsb phys correction
Message-Id: <20140918221530.GU17331@zareason>
List-Id: <sparclinux.vger.kernel.org>
References: <1410886239-15774-1-git-send-email-bpicco@meloft.net>
In-Reply-To: <1410886239-15774-1-git-send-email-bpicco@meloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David Miller wrote:	[Thu Sep 18 2014, 03:43:12PM EDT]
> From: David Miller <davem@davemloft.net>
> Date: Wed, 17 Sep 2014 13:16:22 -0400 (EDT)
> 
> > [PATCH] sparc64: Adjust KTSB assembler to support larger physical addresses.
> 
> Bob, just a quick update.
> 
> I've adjusted this patch of mine to support arbitrary physical addresses,
> not just up to 54-bits.
> 
> With the other related changes being discussed, we will have no
> limitations to deal with wrt. physical addressing ever again and
> honestly I don't want to have to play with this area any more :)
Honestly, me too :) It boots fine on T5-2. I'll hopefully take it for
a test drive on M7-4 tomorrow.
