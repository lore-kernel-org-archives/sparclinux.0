From: "Art Haas" <ahaas@airmail.net>
Date: Tue, 06 Apr 2004 19:57:11 +0000
Subject: Re: [TEST THIS] sparc32 swap fix
Message-Id: <20040406195711.GA20850@artsapartment.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20040406044441.GB17154@foobazco.org>
In-Reply-To: <20040406044441.GB17154@foobazco.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, Apr 05, 2004 at 09:44:41PM -0700, Keith M Wesolowski wrote:
> This seems to work fine on sparc32; I can create up to 32 swaps and
> swapping actually works.
> 
> However, I need people with sun4c userland to test this.  Also, if you
> have a weird swap workload (lots of swaps or very big ones) you need
> to try this as well.
> 
> The current limits are 4GB per swapfile, 32 swapfiles max.  Have at
> it.  Thanks.
> 
> [ ... snip patch ...  ]

Hi.

Applied the patch, and now my SS20 is running 2.6.5 with swap space
working.

Was the cause of the swap space failures due to changes applied to the
kernel source between -rc releases and the final release? Enquiring
minds want to know and learn ...

Art Haas

-- 
Man once surrendering his reason, has no remaining guard against absurdities
the most monstrous, and like a ship without rudder, is the sport of every wind.

-Thomas Jefferson to James Smith, 1822
