From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 19 Dec 2020 21:40:54 +0000
Subject: Re: [RFC PATCH 0/13] sparc32: sunset sun4m and sun4d
Message-Id: <20201219214054.GB3132151@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20201218184347.2180772-1-sam@ravnborg.org>
In-Reply-To: <20201218184347.2180772-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David S Miller <davem@davemloft.net>, sparclinux@vger.kernel.org, Andreas Larsson <andreas@gaisler.com>, Arnd Bergmann <arnd@kernel.org>
Cc: Alexey Dobriyan <adobriyan@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Anshuman Khandual <anshuman.khandual@arm.com>, Arvind Sankar <nivedita@alum.mit.edu>, Christian Brauner <christian.brauner@ubuntu.com>, Denis Efremov <efremov@linux.com>, Dmitry Safonov <0x7f454c46@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ira Weiny <ira.weiny@intel.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, Mike Rapoport <rppt@kernel.org>, Pekka Enberg <penberg@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>, Willy Tarreau <w@1wt.eu>, linux-kernel@vger.kernel.org, debian-sparc@lists.debian.org, gentoo-sparc@lists.gentoo.org, info@temlib.org

Hi all,

On Fri, Dec 18, 2020 at 07:43:34PM +0100, Sam Ravnborg wrote:
> The sun4m and sun4d based SPARC machines was very popular in the
> 90'ties and was then replaced by the more powerful sparc64
> class of machines.

I have received a couple of mails in private.
One said it was better to sunset now when it is actually working,
so there is a working state to return to.
Another said that it would be a shame to sunset sun4m and sun4d because
there are so many machines around, and netbsd is also active on the
sparc32 area.


The second mail also re-reminded me of an interesting project
implementing SPARC V8 and the sun4m platform in VHDL.
See https://temlib.org - the author posted a new blog post a
few months ago.

temlib is, to my best knowledge, an impressive one-man project.
And this is not enough to keep sun4m around as this would
require real users that cannot just stay at their current kernel
but who need to follow upstream.

Please keep the inputs coming independent if you are pro or not
for the sunset of sun4m and sun4d.

	Sam
