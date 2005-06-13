From: "David S. Miller" <davem@davemloft.net>
Date: Mon, 13 Jun 2005 20:20:50 +0000
Subject: Re: Working config wanted for 2.6.11, Ultra 5, sparc64
Message-Id: <20050613.132050.78709146.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20050613195547.6BC1B42B25@bass.stat.ufl.edu>
In-Reply-To: <20050613195547.6BC1B42B25@bass.stat.ufl.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Brian Bartholomew <bb@stat.ufl.edu>
Date: Mon, 13 Jun 2005 15:55:47 -0400

> I just can't believe 2.6 is as broken on Ultra 5 as my experience with
> it has been.  Can someone offer me a 2.6.11 config file that's known
> to work on Ultra 5?  Or any Ultra 5 config for 2.6.anything?

If you enable CONFIG_SERIAL_SUNSU, CONFIG_SERIO, and
CONFIG_KEYBOARD_SUNKBD, you should get a working keyboard.

Do not load Sun keymaps at boot time, as only x86 style
keymaps work with 2.6.x kernels on all platforms now.

As for the ATI driver, I have problems with it as well, but
only on my SunBlade100 system.  It doesn't setup my Samsung
19" LCD properly.  Perhaps specifying a by-hand resolution
and sync rate on the kernel command line will help.
