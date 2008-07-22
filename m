From: David Miller <davem@davemloft.net>
Date: Tue, 22 Jul 2008 04:54:57 +0000
Subject: Re: sparc tracehook
Message-Id: <20080721.215457.70832890.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080722044458.82E251541A5@magilla.localdomain>
In-Reply-To: <20080722044458.82E251541A5@magilla.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Roland McGrath <roland@redhat.com>
Date: Mon, 21 Jul 2008 21:44:58 -0700 (PDT)

> Hi!  I did a fresh rebase of the sparc64 tracehook patches, added another
> one, and fiddled a little.  I'd like to hand off worrying about the
> patches, fixing them and eventually merging them to you now.
> 
> The patch adding asm/syscall.h doesn't depend on anything else.
> So you could put that in your arch tree whenever you like.

Thanks I'll queue these up to Linus when the tracehook stuff
gets in there.
