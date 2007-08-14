From: David Miller <davem@davemloft.net>
Date: Tue, 14 Aug 2007 21:03:12 +0000
Subject: Re: Physical cpu number on UltrasparcT1
Message-Id: <20070814.140312.88704550.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <a8e8903d0708131434j1c1e2b81m5f3fb6e9c6d1a0ab@mail.gmail.com>
In-Reply-To: <a8e8903d0708131434j1c1e2b81m5f3fb6e9c6d1a0ab@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "jiaqi zhang" <zation.busy@gmail.com>
Date: Wed, 15 Aug 2007 08:38:53 +1200

> I've checked the ALOM manual and found no useful clues there. If ALOM
> knows it, can I simply get the information from ALOM? Or should I have
> to ask hypervisor directly?

Check the component list from the ALOM prompt.

> Since my kernel is 2.6.20, which does not support your multi-core
> arrangement for sparc64 yet, it lacks the mdesc files.

Upgrade your kernel.
