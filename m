From: David Miller <davem@davemloft.net>
Date: Tue, 15 Jul 2008 05:58:06 +0000
Subject: Re: [GIT PULL] unify sparc header files
Message-Id: <20080714.225806.43081185.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080628220235.GA3169@uranus.ravnborg.org>
In-Reply-To: <20080628220235.GA3169@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Wed, 9 Jul 2008 06:27:59 +0200

> Dropping the top-most commit fixes it: ("sparc: join the remaining
> header files") The commit is almost 100% scripted so I can just
> re-ran it when we have the kbuild stuff merged and I combine the two
> header file sets under arch/sparc/include/..

I think I'll just leave it in there since your kbuild bits will
fix it up.

Thanks Sam.
