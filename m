From: William Lee Irwin III <wli@holomorphy.com>
Date: Sun, 16 Jan 2005 04:29:45 +0000
Subject: Re: Badness in map_area_pte
Message-Id: <20050116042945.GM3474@holomorphy.com>
List-Id: <sparclinux.vger.kernel.org>
References: <41E96A42.7090501@mc.net>
In-Reply-To: <41E96A42.7090501@mc.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

William Lee Irwin III wrote:
>> This sounds like a real problem. What happens if you move VMALLOC_START
>> to where it was in 2.4.x?

On Sat, Jan 15, 2005 at 10:24:42PM -0600, Bob Breuer wrote:
> Yes, changing it back fixes my problem for now.
> The bitkeeper comments say it was changed 4 months ago to fix a framebuffer 
> on a SparcStation 2.  Looks like we need something more dynamic to cover 
> all the bases.

I suspected the same. Perhaps time to brew up another BTFIXUP.


-- wli
