From: William Lee Irwin III <wli@holomorphy.com>
Date: Tue, 27 Jul 2004 15:10:08 +0000
Subject: Re: slab corruption and stuck CPU under 2.6.8rc2
Message-Id: <20040727151008.GA2334@holomorphy.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20040727133947.GA12350@phunnypharm.org>
In-Reply-To: <20040727133947.GA12350@phunnypharm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, 27 Jul 2004, Ben Collins wrote:
>> Try looking up the 0x006fde40, 0x0045ae18 and 0x00451808 addresses in the
>> System.map for your kernel. See if we can find out where this is
>> occuring.

On Tue, Jul 27, 2004 at 10:43:29AM -0400, Chris Ricker wrote:
> 0x006fde40 is tasklist_lock:
[...]
> 0x0045ae18 doesnt match exactly:
[...]
> 0x00451808 doesn't match exactly:
[...]

Just for future reference, they don't need to match exactly. If you can
find the two symbols it goes between, it's generally the lower of those
two.


-- wli
