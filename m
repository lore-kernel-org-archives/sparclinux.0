From: Keith M Wesolowski <wesolows@foobazco.org>
Date: Sun, 07 Mar 2004 18:25:20 +0000
Subject: Re: [PATCH 2.6] Fix parport_sunbpp so it compiles
Message-Id: <20040307182520.GA26157@foobazco.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1078676935.12295.31.camel@zorak>
In-Reply-To: <1078676935.12295.31.camel@zorak>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, Mar 07, 2004 at 10:28:55AM -0600, Tom 'spot' Callaway wrote:

> Given the history of this driver, I doubt this gets it into "working"
> state, but it should at least compile now.

Thanks Tom, but I beat you to it.  This went to Dave a couple days
ago.  I also fixed the warning about irqreturn_t.  Like you, I don't
know if the driver actually works because cables for this beast are
incredibly rare.

-- 
Keith M Wesolowski
