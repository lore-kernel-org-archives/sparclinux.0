From: Baurzhan Ismagulov <ibr@radix50.net>
Date: Sat, 10 Sep 2005 15:31:33 +0000
Subject: Re: ALSA - CS4231 on ultra2
Message-Id: <20050910153133.GB14205@radix50.net>
List-Id: <sparclinux.vger.kernel.org>
References: <4322D4DD.20609@triaton-webhosting.com>
In-Reply-To: <4322D4DD.20609@triaton-webhosting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hello Georg,

On Sat, Sep 10, 2005 at 02:43:09PM +0200, Georg Chini wrote:
> can anyone give me the status of the
> CS4231 ALSA driver on sparc64?

Doesn't work.


> Is it the wrong place to put the question?

Probably not.


> Can somebody give me a hint what I can do
> to solve the problem?

Fix the driver.

I found a spec at
ftp://gd.tuwien.ac.at/opsys/linux/alsa/datasheets/cirrus/4231a.pdf , but
I don't know whether it corresponds the chip.

You can use the working OSS driver from 2.4 to compare the chip state if
you are not sure.


With kind regards,
Baurzhan.
