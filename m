From: "David S. Miller" <davem@redhat.com>
Date: Wed, 21 Jul 2004 23:25:46 +0000
Subject: Re: SPARCprinter
Message-Id: <20040721162546.5b4dbf52.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1090387203.4229.14.camel@ori.thedillows.org>
In-Reply-To: <1090387203.4229.14.camel@ori.thedillows.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 21 Jul 2004 01:20:03 -0400
David Dillow <dave@thedillows.org> wrote:

> It's ALPHA software, but should be pretty stable aside from some areas I
> haven't investigated yet (like is it possible to change DPI while
> printing, or do I need to idle the printer). Doing AIO makes it a bit
> more complex than I'd like, but it is the difference between doing 6
> pages per minute and 10 pages per minute, so I think it is worth it. :)

David, when Linus takes in the SBUS DMA fix (probably right after
OLS ends), send me a patch to add your driver to the tree.  It
cannot hurt to add it.

Thanks.

