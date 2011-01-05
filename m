From: David Miller <davem@davemloft.net>
Date: Wed, 05 Jan 2011 20:40:54 +0000
Subject: Re: [patch] use __devexit not __exit in n2_unregister_algs fixes
Message-Id: <20110105.124054.115931367.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20110105140510.3d0a8d29@athosian.ausil.us>
In-Reply-To: <20110105140510.3d0a8d29@athosian.ausil.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Dennis Gilmore <dennis@ausil.us>
Date: Wed, 5 Jan 2011 14:05:10 -0600

> Kernel builds on fedora have been failing with 
> 
> `.exit.text' referenced in section `.devexit.text' of drivers/built-in.o: defined in discarded section `.exit.text' of drivers/built-in.o
> + /usr/lib/rpm/debugedit -b /builddir/build/BUILD -d /usr/src/debug -i .tmp_vmlinux1
> Failed to open input file '.tmp_vmlinux1': No such file or directory
> 
> the attached patch fixes building.

Please read Documentation/SubmittingPatches to learn how to write a proper
commit message for your patch, in particular you need to add a proper
"Signed-off-by: " tag.

Also, this patch, as it's a crypto driver patch, needs to be sent to
linux-crypto@vger.kernel.org and Herber Xu (herbert@gondoa.apana.org.au)
the crypto layer maintainer.
