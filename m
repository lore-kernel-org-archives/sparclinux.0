From: "David S. Miller" <davem@davemloft.net>
Date: Wed, 23 Mar 2005 18:17:48 +0000
Subject: Re: sparc32: module with unresolved symbol causes oops in
Message-Id: <20050323101748.34b1231b.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.61.0503231549330.5000@math.ut.ee>
In-Reply-To: <Pine.SOC.4.61.0503231549330.5000@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, 23 Mar 2005 15:53:26 +0200 (EET)
Meelis Roos <mroos@linux.ee> wrote:

> floppy module in 2.6.12-rc1 has an unresolved symbol floppy_hardint.

Yes, this is known not to work.  The floppy driver can only
work non-modular on sparc systems.

What you're getting is another one of those tty_wakeup() OOPS's
from the serial console tasklet.  All of your OOPS's are because
of whatever problem that is.
