From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Tue, 02 Dec 2014 14:58:11 +0000
Subject: Re: [PATCH 2/8 v2] sparc64: replace memset by memzero_explicit
Message-Id: <20141202145811.GB26301@gondor.apana.org.au>
List-Id: <sparclinux.vger.kernel.org>
References: <1417367029-32762-1-git-send-email-Julia.Lawall@lip6.fr>
 <1417367029-32762-3-git-send-email-Julia.Lawall@lip6.fr>
In-Reply-To: <1417367029-32762-3-git-send-email-Julia.Lawall@lip6.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: kernel-janitors@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, linux-crypto@vger.kernel.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, Nov 30, 2014 at 06:03:43PM +0100, Julia Lawall wrote:
> From: Julia Lawall <Julia.Lawall@lip6.fr>
> 
> Memset on a local variable may be removed when it is called just before the
> variable goes out of scope.  Using memzero_explicit defeats this
> optimization.  A simplified version of the semantic patch that makes this
> change is as follows: (http://coccinelle.lip6.fr/)
> 
> // <smpl>
> @@
> identifier x;
> type T;
> @@
> 
> {
> ... when any
> T x[...];
> ... when any
>     when exists
> - memset
> + memzero_explicit
>   (x,
> -0,
>   ...)
> ... when != x
>     when strict
> }
> // </smpl>
> 
> This change was suggested by Daniel Borkmann <dborkman@redhat.com>
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

Applied patches 2, 3, 6, 7.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
