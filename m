From: William Lee Irwin III <wli@holomorphy.com>
Date: Sun, 05 Dec 2004 05:07:36 +0000
Subject: Re: [PATCH]: Fix for sparc64 SMP boot failures
Message-Id: <20041205050736.GO2714@holomorphy.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20041204201211.33b4b0f9.davem@davemloft.net>
In-Reply-To: <20041204201211.33b4b0f9.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sat, Dec 04, 2004 at 08:12:11PM -0800, David S. Miller wrote:
> This bug has been around for quite some time, is present
> in both 2.4.x and 2.6.x, and only triggers sporadically.
> It depends upon the size of the kernel image and how the
> BSS section is layed out.  Specifically both of the following
> conditions must hold to hit the bug:
> 1) The kernel must be > 4MB in size.  You can check this via
>    looking at System.map for the kernel image and checking
>    if the final symbol "_end" is at an address >= 0x800000
> 2) The object "p1275buf" must cross a PAGE_SIZE (8K) boundary.
> If this is true, secondary cpus will not boot up and instead
> will hang in the kernel TLB miss handler.
> The attached patches for 2.4.x and 2.6.x fix the problem and I'll
> be pushing these upstream right after this email goes out.

I'll spin this up for a test. I'll try to beef up my .config for
the occasion.


-- wli
