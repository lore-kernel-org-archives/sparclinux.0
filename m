From: "David S. Miller" <davem@redhat.com>
Date: Mon, 12 Jul 2004 21:56:38 +0000
Subject: Re: [RFC PATCH] Allow larger than 1MB mappings on sparc64 sbus
Message-Id: <20040712145638.45446180.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1089341045.3100.38.camel@ori.thedillows.org>
In-Reply-To: <1089341045.3100.38.camel@ori.thedillows.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 09 Jul 2004 20:42:19 -0400
David Dillow <dave@thedillows.org> wrote:

> > Your patch looks fine.
> 
> Cool, at least I won't kill my machine. :)
> I'd like to see it go into mainline if possible, or at least a patch
> that catches attempts to map more than 1MB to avoid trashing memory.

I will look at your patch for inclusion when I get back next
week from conferences.  Sorry for the delay.
