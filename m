From: "David S. Miller" <davem@davemloft.net>
Date: Tue, 14 Sep 2004 20:34:50 +0000
Subject: Re: Legacy PC IO reservations on sparc64?
Message-Id: <20040914133450.540e20b5.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.GSO.4.44.0409141248500.8479-100000@math.ut.ee>
In-Reply-To: <Pine.GSO.4.44.0409141248500.8479-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, 14 Sep 2004 12:50:28 +0300 (EEST)
Meelis Roos <mroos@linux.ee> wrote:

> From /prco/iomem on a Sun Ultra 5, running 2.6.9-rc2:
> 
>   1ff000a0000-1ff000bffff : Video RAM area
>   1ff000c0000-1ff000c7fff : Video ROM
>   1ff000f0000-1ff000fffff : System ROM
> 
> Why are these here on sparc64?

We should never allocate them to real devices because
graphics cards will respond to I/O's in this area.
This is all legacy VGA stuff.
