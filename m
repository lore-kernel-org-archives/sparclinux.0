From: David Miller <davem@davemloft.net>
Date: Sun, 03 Jun 2007 02:20:18 +0000
Subject: Re: section mismatches from sun4v*_patch in trampoline.S
Message-Id: <20070602.192018.30166035.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20070602203206.GA13700@uranus.ravnborg.org>
In-Reply-To: <20070602203206.GA13700@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 3 Jun 2007 01:00:50 +0200

> Btw I cannot see why ia64 does not give warnings with their use
> of .data.patch.*. It could be a modpost bug...

Keep in mind that if you prefix a section name with ".data.foo"
or ".text.foo" this might have meaning for a given platform
and ELF format.
