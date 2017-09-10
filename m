From: David Miller <davem@davemloft.net>
Date: Sun, 10 Sep 2017 03:41:29 +0000
Subject: Re: [PATCH V3] vDSO for SPARC
Message-Id: <20170909.204129.1793399402262008115.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1502400887-281290-1-git-send-email-nagarathnam.muthusamy@oracle.com>
In-Reply-To: <1502400887-281290-1-git-send-email-nagarathnam.muthusamy@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Mon, 14 Aug 2017 22:35:53 -0700 (PDT)

> From: Nick Alcock <nick.alcock@oracle.com>
> Date: Fri, 11 Aug 2017 13:23:26 +0100
> 
>> unless you have a really serious linker bug,
> 
> Open your mind a little bit.

Looking at the actual details, how did this ever work for anyone?

The arch/sparc/vdso/vdso.lds file says:

vvar_start = . -(1 << 12);

And "1 << 12" is 4096, therefore a multiple of 4096 and not 8192.

So, as requested, the object built gets:

davem@patience:~/src/GIT/sparc-next$ nm -n arch/sparc/vdso/vdso64.so.dbg
fffffffffffff000 a vvar_data
fffffffffffff000 a vvar_start

So why is vdso2c requiring an 8192 byte aligned value for the address
of 'vvar_start'?

Nick, I will be honest and sat that I'm kinda irritated that I had to
track this down and the best you could come up with was blaming the
linker...  :-(
