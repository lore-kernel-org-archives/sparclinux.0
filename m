From: William Lee Irwin III <wli@holomorphy.com>
Date: Sun, 31 Oct 2004 02:16:52 +0000
Subject: Re: flush_dcache_page()/flush_icache_page() for larger page sizes
Message-Id: <20041031021652.GL12934@holomorphy.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20041029230347.GK12934@holomorphy.com>
In-Reply-To: <20041029230347.GK12934@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sat, Oct 30, 2004 at 06:50:31PM -0700, David S. Miller wrote:
> Actually, __flush_dcache_page() as written will handle any page size.
> It searches the entire 16K D-cache for the matching physical addresses.
> Everywhere I look there is code handling the various page sizes
> appropriately.  If you're asking for how to implement these
> flushes you must see some case which isn't handled, what might
> that be?

No, I presumed aliases could occur when they could not. The "totally
unnecessary" part for >= 16K page sizes part handles the whole of my
concerns.


-- wli
