From: "David S. Miller" <davem@davemloft.net>
Date: Mon, 21 Feb 2005 23:21:57 +0000
Subject: Re: Who restores %g6 for trap/irq handlers?
Message-Id: <20050221152157.05a26a08.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <BAY12-F4108B6A30787FD6116E685FF600@phx.gbl>
In-Reply-To: <BAY12-F4108B6A30787FD6116E685FF600@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, 21 Feb 2005 19:56:51 +0100
"Blue Swirl" <blueswir1@hotmail.com> wrote:

> (SAVE_ALL and WRITE_PAUSE don't touch %g6)

Incorrect, look at what SAVE_ALL does.

It branches to "trap_setup" which is what sets
up %g6 via the LOAD_CURRENT() macro we discussed
earlier.
