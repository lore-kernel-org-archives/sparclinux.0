From: David Miller <davem@davemloft.net>
Date: Tue, 11 Oct 2011 18:38:58 +0000
Subject: Re: [PATCH 4/4] kernel,debug: SPARC KGDB stub strcpy fix
Message-Id: <20111011.143858.923549997692641372.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1317390450-5982-5-git-send-email-konrad@gaisler.com>
In-Reply-To: <1317390450-5982-5-git-send-email-konrad@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Konrad Eisele <konrad@gaisler.com>
Date: Tue, 11 Oct 2011 14:16:01 +0200

> It is a gcc optimization. strcpy(p,"string") is converted to memcpy(p,7).
> I could think of 2 ways:
> - fix memcpy() so that it returns the dest-pointer instead of 0. (However
>   there might be a reason that it returns 0 ...
> - keep the "kernel,debug: SPARC KGDB stub strcpy fix" patch but change the
>   summary of the patch to:
>     Works aroung the fact that strcpy with a constant string is
>     converted to memcpy by gcc and that  memcpy in SPARC returns 0.
> 
> I'll send the 2 possibilities as a reply in a moment.

I think memcpy() should be fixed to return the dest pointer.
