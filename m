From: William Lee Irwin III <wli@holomorphy.com>
Date: Wed, 02 Feb 2005 22:40:19 +0000
Subject: Re: [PATCH] A BTFIXUP'd fix for pte_read()
Message-Id: <20050202224019.GC24805@holomorphy.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20050202200409.GA30839@artsapartment.org>
In-Reply-To: <20050202200409.GA30839@artsapartment.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, 2005-02-02 at 14:04 -0600, Art Haas wrote:
>> Here's my attempt at taking Bob Breuer's patch and adding in some of the
>> BTFIXUP magic that sparc32 needs. I'm running the current BK kernel with
>> this patch on my SS20, and things seem to work. The current kernel
>> complains during bootup and shutdown about accessing the system clock,
>> a problem I am guessing is related to changes elsewhere in the kernel.

On Wed, Feb 02, 2005 at 03:54:53PM -0600, Tom 'spot' Callaway wrote:
> This patch only covers sun4m. The attached patch covers all sparc32.
> Signed-off-by: Tom 'spot' Callaway <tcallawa@redhat.com>

Doing a quick doublecheck to be sure this actually applies before
shipping upstream. Sorry about the delay, folks.


-- wli
