From: William Lee Irwin III <wli@holomorphy.com>
Date: Thu, 09 Sep 2004 16:36:25 +0000
Subject: Re: Sun4D SMP now works OK, serial console broken - was Re: More Sun4d tests
Message-Id: <20040909163625.GT3106@holomorphy.com>
List-Id: <sparclinux.vger.kernel.org>
References: <200409091646.21205.crn@netunix.com>
In-Reply-To: <200409091646.21205.crn@netunix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, Sep 09, 2004 at 04:46:21PM +0100, C.Newport wrote:
> My SS1000E seems to be stable with 2.4.27 after fitting a frame
> buffer and keyboard. It rebuilds a kernel OK in SMP mode.
> Serial console is still broken, there seems to be a problem
> with the sunzilog driver.
> What other Sun machines use sunzilog.c as the serial console ?.
> Is this problem really a sun4d issue or is it generic to sunzilog ?

Unclear to me, but please do send whatever patches you used ASAP if
it's fully successful with the frame buffer in place.

Thanks.


-- wli
