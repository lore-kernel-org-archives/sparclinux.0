From: David Miller <davem@davemloft.net>
Date: Sun, 08 May 2011 23:44:33 +0000
Subject: Re: [PATCH]SPARC32: Fixed unaligned memory copying in function
Message-Id: <20110508.164433.68139143.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1304845558.9492.14.camel@big>
In-Reply-To: <1304845558.9492.14.camel@big>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: kirill <tkhai@yandex.ru>
Date: Sun, 08 May 2011 13:05:58 +0400

> --- linux-2.6.38.5/arch/sparc/lib/checksum_32.S.orig	2011-05-06
> 22:54:25.000000000 +0400
> +++ linux-2.6.38.5/arch/sparc/lib/checksum_32.S	2011-05-08
> 11:43:35.000000000 +0400
> @@ -289,10 +289,16 @@ cc_end_cruft:

Your patch is corrupted, it has chopped up long lines.

Please fix this up, and send a test patch email to yourself.

Only when you can successfully apply the patch you receive in
that test email should you post your patch here to the list
again.

Because if you can't apply the patch, neither can I.

Thanks.
