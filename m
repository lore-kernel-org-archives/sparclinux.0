From: "David S. Miller" <davem@davemloft.net>
Date: Sat, 05 Feb 2005 06:07:33 +0000
Subject: Re: Badness in map_area_pte
Message-Id: <20050204220733.30080ed0.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <41E96A42.7090501@mc.net>
In-Reply-To: <41E96A42.7090501@mc.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, 04 Feb 2005 15:37:24 -0600
"Tom 'spot' Callaway" <tcallawa@redhat.com> wrote:

> On Sat, 2005-01-15 at 20:29 -0800, William Lee Irwin III wrote:
> 
> > I suspected the same. Perhaps time to brew up another BTFIXUP.
> 
> I tried to whip up a BTFIXUP patch for this, but it wouldn't work, since
> VMALLOC_START is in entry.S. Peter Jones took my patch and made a
> version that works. His patch to resolve this is attached.

That entry.S code is all for sun4c, so you can use VMALLOC_START_SUN4C
or whatever.
