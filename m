From: David Miller <davem@davemloft.net>
Date: Sun, 30 Sep 2007 23:50:07 +0000
Subject: Re: SPARC64 2.6.23-rc8 binfmt_aout32 error
Message-Id: <20070930.165007.63100942.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <470034EA.4060906@gmail.com>
In-Reply-To: <470034EA.4060906@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sunil Amitkumar Janki <devel.sjanki@gmail.com>
Date: Mon, 01 Oct 2007 01:44:42 +0200

> >   CC      arch/sparc64/kernel/binfmt_aout32.o
> > cc1: warnings being treated as errors
> > arch/sparc64/kernel/binfmt_aout32.c: In function 'create_aout32_tables':
> > arch/sparc64/kernel/binfmt_aout32.c:180: warning: cast from pointer to 
> > integer of different size
> > arch/sparc64/kernel/binfmt_aout32.c:180: warning: cast from pointer to 
> > integer of different size
> > arch/sparc64/kernel/binfmt_aout32.c:180: warning: cast from pointer to 
> > integer of different size
> > arch/sparc64/kernel/binfmt_aout32.c:180: warning: cast from pointer to 
> > integer of different size
> > arch/sparc64/kernel/binfmt_aout32.c:189: warning: cast from pointer to 
> > integer of different size
> > arch/sparc64/kernel/binfmt_aout32.c:189: warning: cast from pointer to 
> > integer of different size
> > arch/sparc64/kernel/binfmt_aout32.c:189: warning: cast from pointer to 
> > integer of different size
> > arch/sparc64/kernel/binfmt_aout32.c:189: warning: cast from pointer to 
> > integer of different size
> > make[1]: *** [arch/sparc64/kernel/binfmt_aout32.o] Error 1
> > make: *** [arch/sparc64/kernel] Error 2
> 
> I don't know what the solution is (I don't know much about
> kernel internals yet) but I hope this is enough to solve this
> particular error. Otherwise I could also send my kernel config.

Turn off BINFMT_AOUT32 is a quick way to get a successful build,
I wonder if considered that :-)

I've never seen this build failure before, but will try to
reproduce with some gcc-4.2 compiler setups I have here.

