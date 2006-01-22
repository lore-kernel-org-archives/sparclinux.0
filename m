From: William Lee Irwin III <wli@holomorphy.com>
Date: Sun, 22 Jan 2006 21:34:17 +0000
Subject: Re: Kernel Bugzilla #2682: arch/sparc/kernel/sun4m_smp.c: [OPERA] potential error detected by an ana
Message-Id: <20060122213417.GA7655@holomorphy.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20060122175356.GF10003@stusta.de>
In-Reply-To: <20060122175356.GF10003@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, Jan 22, 2006 at 06:53:56PM +0100, Adrian Bunk wrote:
> Kernel Bugzilla #2682 [1] contains the following report by
> Zhenmin <lzmhome@yahoo.com>:
> <--  snip  -->
> The potential error is detected by a static analysis tool in
> /arch/sparc/kernel/sun4m_smp.c:227-228
> 225  if(cpu_callin_map[i]) {
> 226    /* Another "Red Snapper". */
> 227    __cpu_number_map[i] = i;
> 228    __cpu_logical_map[i] = i;
> 229  } else {
> Lines 227-228 may be changed to:
> 227    __cpu_number_map[i] = cpucount;
> 228    __cpu_logical_map[cpucount] = i;
> Can anyone confirm whether it is a bug or not?
> <--  snip  -->
> (the line numbers are wrong by a few lines in recent kernels, but
>  "Red Snapper" is easy to find in the file.
> AFAIR SMP is not working on sparc32 in kernel 2.6, but could you anyways 
> comment on this issue?

Bob Breuer's SMP patch does a drastic rearrangement that eliminates
that line along with many others surrounding it. It is a better idea to
take Bob's patch than to fiddle with things piecemeal.

It's not so much a bug as nonsensical.


-- wli
