From: David Miller <davem@davemloft.net>
Date: Tue, 26 Feb 2008 20:46:11 +0000
Subject: Re: [BUG] 2.6.25-rc3 hangs in early boot on Sun Ultra5
Message-Id: <20080226.124611.206089131.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <18371.10207.58819.188510@alkaid.it.uu.se>
In-Reply-To: <18371.10207.58819.188510@alkaid.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mikpe@it.uu.se
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Mikael Pettersson <mikpe@it.uu.se>
Date: Mon, 25 Feb 2008 21:41:03 +0100

> Another difference is that with rc2 the first few lines of kernel
> output while the console is still in OF mode either aren't shown
> or disappear quickly since the switch to the framebuffer occurs
> within a fraction of a second after the kernel has been loaded.
> With rc3 the kernel output (the text shown above) in the OF-mode
> console is very very slow.

Yes that's a new feature.  Until we switch over to the "real"
console we print the log messages using the firmware console
routines.

This way if an early crash or similar happens, you'll see it
and be able to report it instead of having to report with
"-p" on the command line.

I'll fire up my ultra5 and try to figure out what's wrong
with the atyfb framebuffer driver, that's where it's dying.
