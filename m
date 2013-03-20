From: David Miller <davem@davemloft.net>
Date: Wed, 20 Mar 2013 14:11:02 +0000
Subject: Re: [PATCH -next] sparc32/sparc64: Provide cmpxchg64()
Message-Id: <20130320.101102.2237935685619866372.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1363290128-21247-1-git-send-email-geert@linux-m68k.org>
	<20130319.162000.1936616024625986095.davem@davemloft.net>
	<CAMuHMdXHuT16xuw3-5rwL2WY7ZRzfweB7jKVyoi-xnqT4B0pBg@mail.gmail.com>
In-Reply-To: <CAMuHMdXHuT16xuw3-5rwL2WY7ZRzfweB7jKVyoi-xnqT4B0pBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: geert@linux-m68k.org
Cc: sparclinux@vger.kernel.org, linux-next@vger.kernel.org

From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 20 Mar 2013 09:05:19 +0100

> The sparc64 part is still OK as it eventually calls __cmpxchg_u64(),
> isn't it?

Yes, that part is OK.

> Do you want me to send a new patch for that part only, or will you just
> remove the sparc32 part?

Please send a new patch, thank you.
