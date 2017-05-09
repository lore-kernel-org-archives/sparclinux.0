From: Michael Chan <michael.chan@broadcom.com>
Date: Tue, 09 May 2017 21:05:14 +0000
Subject: Re: [PATCH net-next] bnxt: add dma mapping attributes
Message-Id: <CACKFLikw_oi4rHRC9P-23xuvuOJSaf9b2kUSeTMgbNW1WA__=w@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1494362253-270990-1-git-send-email-shannon.nelson@oracle.com>
In-Reply-To: <1494362253-270990-1-git-send-email-shannon.nelson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Shannon Nelson <shannon.nelson@oracle.com>
Cc: David Miller <davem@davemloft.net>, Netdev <netdev@vger.kernel.org>, sparclinux@vger.kernel.org

On Tue, May 9, 2017 at 1:37 PM, Shannon Nelson
<shannon.nelson@oracle.com> wrote:
> On the SPARC platform we need to use the DMA_ATTR_WEAK_ORDERING attribute
> in our Rx path dma mapping in order to get the expected performance out
> of the receive path.  Adding it to the Tx path has little effect, so
> that's not a part of this patch.
>
> Signed-off-by: Shannon Nelson <shannon.nelson@oracle.com>
> Reviewed-by: Tushar Dave <tushar.n.dave@oracle.com>
> Reviewed-by: Tom Saeger <tom.saeger@oracle.com>
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c |   61 ++++++++++++++++++----------
>  1 files changed, 39 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index 1f1e54b..771742c 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -66,6 +66,12 @@
>  MODULE_DESCRIPTION("Broadcom BCM573xx network driver");
>  MODULE_VERSION(DRV_MODULE_VERSION);
>
> +#ifdef CONFIG_SPARC
> +#define BNXT_DMA_ATTRS  DMA_ATTR_WEAK_ORDERING
> +#else
> +#define BNXT_DMA_ATTRS 0
> +#endif
> +

I think we can use the same attribute for all architectures.
Architectures that don't implement weak ordering will ignore the
attribute.
