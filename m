From: David Miller <davem@davemloft.net>
Date: Sun, 06 Jul 2008 01:57:32 +0000
Subject: Re: [GIT PULL] unify sparc header files
Message-Id: <20080705.185732.120236188.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080628220235.GA3169@uranus.ravnborg.org>
In-Reply-To: <20080628220235.GA3169@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 3 Jul 2008 15:45:10 +0200

> Hmmm, I have a crosstool build sparc64 toolchain.
> And I did do a defconfig build for each patch applied for both
> sparc and spac64. But despite this something is obviously bad.
> I will look at it later this week as time permits.

As I mentioned in another reply, I think the cross tool
is the reason why you don't see the problem.

Natively, we use a bi-arch compiler which defaults to
32-bit output, whereas your cross compiler is outputting
64-bit by default.

So you won't see problems involving a lost "-m64" option
on the command line.
