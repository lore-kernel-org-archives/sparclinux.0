From: "David S. Miller" <davem@davemloft.net>
Date: Fri, 01 Oct 2004 20:11:06 +0000
Subject: Re: sym2 on sparc
Message-Id: <20041001131106.47def4f4.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20041001182500.GJ16153@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20041001182500.GJ16153@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, 1 Oct 2004 19:25:00 +0100
Matthew Wilcox <matthew@wil.cx> wrote:

> Sorry, got the mailing address wrong for sparclinux the first time round.
> 
> Could someone with a symbios 53c8xx chip test this patch?  It works
> on non-sparc.  If I don't hear of any problems, it'll be in the next
> driver update.

Just print the IRQ out as an unsigned integer, it's not the
end of the world if you don't use the special sparc macros.
