From: "David S. Miller" <davem@davemloft.net>
Date: Wed, 16 Feb 2005 03:15:45 +0000
Subject: Re: prom_getproperty cleanups
Message-Id: <20050215191545.0d3e54dd.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <4206F1AB.8080206@mc.net>
In-Reply-To: <4206F1AB.8080206@mc.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, 15 Feb 2005 20:37:23 -0600
Bob Breuer <breuerr@mc.net> wrote:

> Somehow everything I tested compiled fine without it.

Right, some other header is bringing it in indirectly.

> Updated patch is attached.  The patch only cleans up the 
> include/asm-sparc and arch/sparc directories.

Applied.  I made a minor modification, I retained the
"extern" in the oplib.h header declaration.  I don't know
why you removed it.

Thanks Bob.
