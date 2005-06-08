From: William Lee Irwin III <wli@holomorphy.com>
Date: Wed, 08 Jun 2005 19:19:43 +0000
Subject: Re: nuke string.h micro-optimizations from orbit
Message-Id: <20050608191943.GG2264@holomorphy.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20050607031302.GA2621@holomorphy.com>
In-Reply-To: <20050607031302.GA2621@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> From: William Lee Irwin III <wli@holomorphy.com>
> Date: Wed, 8 Jun 2005 04:52:28 -0700
>> Apart from "the tty layer is f***ed", not really. We should probably
>> take our findings to whoever's now working on the tty layer.

On Wed, Jun 08, 2005 at 12:06:18PM -0700, David S. Miller wrote:
> It is undoubtedly a sparc serial console issue, not one with
> the TTY layer.

I didn't see the driver in the backtrace so I got fooled.

... dare I ask if anyone can smoke out a line number on this one?


-- wli
