From: Meelis Roos <mroos@linux.ee>
Date: Fri, 02 Jun 2006 13:17:29 +0000
Subject: Re: [PATCH]: Fix D-cache corruption in mremap() (was Re: 2.6.17-rc3+git
Message-Id: <Pine.SOC.4.61.0606021604240.1298@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <20060601.175258.41634623.davem@davemloft.net>
In-Reply-To: <20060601.175258.41634623.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> Anyways, give this patch below a test, it should fix things.
> It is against the current 2.6.17 tree.
>
> I'll also post a little reproducer program that can be used to
> accurately see if the patch really fixes the problem on your
> machine or not, which should help with the variability of the
> dpkg corruption case.
>
> Please test this, I need to know if this works for everyone
> or not.

Works on my Ulta 5 - without the patch I get the error at once and with 
the patch I get no error for half an hour.

-- 
Meelis Roos (mroos@linux.ee)
