From: Meelis Roos <mroos@linux.ee>
Date: Fri, 02 Apr 2004 12:20:20 +0000
Subject: Re: serial console confusion
Message-Id: <Pine.GSO.4.44.0404021513001.22261-100000@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.GSO.4.44.0404021400470.23192-100000@math.ut.ee>
In-Reply-To: <Pine.GSO.4.44.0404021400470.23192-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> On the Ultra-5 (or almost any other PCI Ultra), you should use
> CONFIG_SERIAL_SUNSAB. su is used for keyboard I/O on this plateform.

Thanks! This clears up the confusion. sunsab serial works fine, also as
a console.

sunsab.c gives a warning though. I looked at it but I don't know whether
prepending a (void) to the call to uart_handle_sysrq_char() would just
fix it or paper over a bug.

  CC      drivers/serial/sunsab.o
drivers/serial/sunsab.c: In function `receive_chars':
drivers/serial/sunsab.c:149: warning: statement with no effect

-- 
Meelis Roos (mroos@linux.ee)

