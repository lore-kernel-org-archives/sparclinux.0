From: "C.Newport" <crn@netunix.com>
Date: Thu, 09 Sep 2004 15:46:21 +0000
Subject: Sun4D SMP now works OK, serial console broken - was Re: More Sun4d tests
Message-Id: <200409091646.21205.crn@netunix.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


My SS1000E seems to be stable with 2.4.27 after fitting a frame
buffer and keyboard. It rebuilds a kernel OK in SMP mode.

Serial console is still broken, there seems to be a problem
with the sunzilog driver.

What other Sun machines use sunzilog.c as the serial console ?.
Is this problem really a sun4d issue or is it generic to sunzilog ?

On Saturday 21 August 2004 1:24 pm, C.Newport wrote:
> Another interesting result -
> Running 2.4.27 SMP on the SS1000E with only one system board
> fails in similar ways but much sooner. For example the serial
> console keyboard reading starts producing garbage almost
> immediately rather than after several minutes with 3 boards.
>
> I suspect a marginal timng issue of some kind.
>
> The Sun4d hardware adds latency issues because arbitration has
> to go via the XDBus to the control board and back, rather than
> being local as on the single board Sun4M systems.
> The local bus on a system board is therefore faster than that on
> (for example) the SS20 in order to reduce total latency with
> multiple boards.
>
> -
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

