From: David Miller <davem@davemloft.net>
Date: Thu, 18 Sep 2014 17:08:08 +0000
Subject: Re: [PATCH] sparc64: swapper_tsb and swapper_4m_tsb phys correction
Message-Id: <20140918.130808.70522200224958778.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1410886239-15774-1-git-send-email-bpicco@meloft.net>
In-Reply-To: <1410886239-15774-1-git-send-email-bpicco@meloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Bob Picco <bpicco@meloft.net>
Date: Thu, 18 Sep 2014 06:09:12 -0400

> The machine hung after remapping. It could have been my mistake. Please
> let me investigate.

I was hoping this would have been the simplest of the patches :-)

If you get stuck just print some debugging information with
prom_printf() (the physical address of the KTSB, and the final
instruction values after patching) then prom_halt() so it doesn't hang
and you can reset more quickly.

