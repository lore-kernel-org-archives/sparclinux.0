From: Michael Chan <michael.chan@broadcom.com>
Date: Wed, 10 May 2017 02:16:37 +0000
Subject: Re: [PATCH v2 net-next] bnxt: add dma mapping attributes
Message-Id: <CACKFLimzVSgb92EmiZ44Xr7G=Xi8FD+wrs7dgY6jg8vdVMBOSA@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1494379812-282087-1-git-send-email-shannon.nelson@oracle.com>
In-Reply-To: <1494379812-282087-1-git-send-email-shannon.nelson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Shannon Nelson <shannon.nelson@oracle.com>
Cc: David Miller <davem@davemloft.net>, Netdev <netdev@vger.kernel.org>, sparclinux@vger.kernel.org

On Tue, May 9, 2017 at 6:30 PM, Shannon Nelson
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
> v2: simplify by getting rid of the driver-specific ifdef and define

Acked-by: Michael Chan <michael.chan@broadcom.com>
