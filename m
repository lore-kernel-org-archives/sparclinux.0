From: David Miller <davem@davemloft.net>
Date: Thu, 14 May 2009 03:35:18 +0000
Subject: Re: Sun fire T2000,BUG: NMI Watchdog detected LOCKUP on CPU12
Message-Id: <20090513.203518.253854524.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <200905130300.12084.denys@visp.net.lb>
In-Reply-To: <200905130300.12084.denys@visp.net.lb>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Denys Fedoryschenko <denys@visp.net.lb>
Date: Wed, 13 May 2009 11:01:35 +0300

> I'm not sure, but maybe even 2.6.28.7, i had something similar.
> Kernel where hangs occuiring ,i forgot to tell, but it is visible in
> dmesg - 2.6.29.3. I will try meanwhile falling back to older kernels
> and to bisect by myself, if i will not become elder person while
> compiling kernel.

There must be something wrong with your machine if this happens.

arch/sparc/configs/sparc64_defconfig builds in about 5 or 6 minutes
at "-j32" on my Niagara-T1 based boxes.

My Niagara-T2 box at "-j64" can build that in just over a minute.
An allmodconfig takes ~22minutes, and almost half of that is the
single-threaded work of linking the final vmlinux image and running
modpost on thousands of modules.

