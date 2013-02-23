From: David Miller <davem@davemloft.net>
Date: Sat, 23 Feb 2013 23:43:13 +0000
Subject: Re: Panic at sunsu driver
Message-Id: <20130223.184313.1036423366117757288.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <254051361624574@web1h.yandex.ru>
In-Reply-To: <254051361624574@web1h.yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Kirill Tkhai <tkhai@yandex.ru>
Date: Sat, 23 Feb 2013 17:02:54 +0400

> I played with sparc64 kernel on QEMU. It creates
> single sunsu port and cmdline "console=ttyS1" leads
> to kernel panic.
 ...
> I fixed sunsu driver a little bit to prevet this.
> 1)Is real hardware able to have less than 4 ports?
> 2)If a machine has 4 ports we'll still skip "console=ttyS1"
> because it's not registered at the time of the first
> call of sunsu_console_setup(the first call is with
> index=1), right?

Real hardware falls into two cases, either 2 ports or 4 ports.

With 2 ports they are both serial lines.

In the 4 port case, 1 is for the keyboard and 1 is for the mouse, and
the other 2 are serial lines.

The console setup gets invoked on every port that register_console()
thinks should act as a console, either based upon explicit requests
on the command line, or based upon defaults.

Also playing into this is what is specified in the OpenFirmware
property named output-device, this is partly handled via the
"of_console_device != dp" test in sunserial_console_match().

Your patch seems like a reasonable solution to this crash for now,
could you submit it formally with a proper Signed-off-by:?  And I
hope you will have qemu fixed as well? :-)

Thanks.
