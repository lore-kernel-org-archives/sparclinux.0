From: William Lee Irwin III <wli@holomorphy.com>
Date: Sat, 06 Nov 2004 23:42:34 +0000
Subject: Re: sunzilog possible bug
Message-Id: <20041106234234.GI2890@holomorphy.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1099784090.10262.112.camel@gaston>
In-Reply-To: <1099784090.10262.112.camel@gaston>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, Nov 07, 2004 at 10:34:49AM +1100, Benjamin Herrenschmidt wrote:
> I found recently a bug in pmac_zilog, which originates from sunzilog
> who so might have the same problem. The "timeout" member of the port
> structure was never initialized, causing very long pauses to happen
> on port close, that is pretty much all the time when hitting userland.
> Quick untested patch (I don't have a sparc)

Thanks ben.

If those having trouble with serial ports could try this patch and report
success (or failure if that's the case) I would be much obliged.


-- wli
