From: David Miller <davem@davemloft.net>
Date: Sat, 12 May 2007 17:48:24 +0000
Subject: Re: missing new syscalls
Message-Id: <20070512.104824.25476182.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0705121502010.4493@math>
In-Reply-To: <Pine.SOC.4.64.0705121502010.4493@math>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Sat, 12 May 2007 15:25:45 +0300 (EEST)

>   CALL    scripts/checksyscalls.sh
> <stdin>:1368:2: warning: #warning syscall signalfd not implemented
> <stdin>:1372:2: warning: #warning syscall timerfd not implemented
> <stdin>:1376:2: warning: #warning syscall eventfd not implemented

Already fixed in my sparc-2.6 GIT tree. :-)

