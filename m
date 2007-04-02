From: David Miller <davem@davemloft.net>
Date: Mon, 02 Apr 2007 03:13:39 +0000
Subject: Re: raid10 kernel panic on sparc64
Message-Id: <20070401.201339.108809035.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.61.0704020211380.1245@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0704020211380.1245@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: jengelh@linux01.gwdg.de
Cc: linux-raid@vger.kernel.org, sparclinux@vger.kernel.org

From: Jan Engelhardt <jengelh@linux01.gwdg.de>
Date: Mon, 2 Apr 2007 02:15:57 +0200 (MEST)

> just when I did
> # mdadm -C /dev/md2 -b internal -e 1.0 -l 10 -n 4 /dev/sd[cdef]4
> (created)
> # mdadm -D /dev/md2
> Killed
> 
> dmesg filled up with a kernel oops. A few seconds later, the box
> locked solid. Since I was only in by ssh and there is not (yet) any
> possibility to reset it remotely, this is all I can give right now,
> the last 80x25 screen:

Unfortunately the beginning of the OOPS is the most important part,
that says where exactly the kernel died, the rest of the log you
showed only gives half the registers and the rest of the call trace.

Please try to capture the whole thing.

Please also provide hardware type information as well, which you
should give in any bug report like this.
