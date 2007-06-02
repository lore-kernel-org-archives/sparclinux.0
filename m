From: David Miller <davem@davemloft.net>
Date: Sat, 02 Jun 2007 21:02:20 +0000
Subject: Re: section mismatches from sun4v*_patch in trampoline.S
Message-Id: <20070602.140220.41650650.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20070602203206.GA13700@uranus.ravnborg.org>
In-Reply-To: <20070602203206.GA13700@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 2 Jun 2007 22:32:06 +0200

> The good news is that there is a nice pattern here. All sections that
> have the references end in _patch.
> So a simple solution is to teach modpost to not warn about references
> from a section named *_patch to .init.text
> 
> I have such a change queued to modpost but would like to know if
> you have any better ideas before pushing the change.

I think it would be great if we adopted a consistent naming
convention for these things across as many platforms as possible.

So if it makes things easier, I can change the naming pattern
I use on sparc64 for the patch sections to match what other
platforms do.

IA64 uses .data.patch.* for example.
