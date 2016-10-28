From: Joe Perches <joe@perches.com>
Date: Fri, 28 Oct 2016 00:41:27 +0000
Subject: Re: [PATCH v2 5/6] sparc64: Enable sun4v dma ops to use IOMMU v2 APIs
Message-Id: <1477615287.1961.4.camel@perches.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1477614212-13466-1-git-send-email-tushar.n.dave@oracle.com>
         <1477614212-13466-6-git-send-email-tushar.n.dave@oracle.com>
In-Reply-To: <1477614212-13466-6-git-send-email-tushar.n.dave@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Tushar Dave <tushar.n.dave@oracle.com>, davem@davemloft.net, chris.hyser@oracle.com, sowmini.varadhan@oracle.com, vgupta@synopsys.com, jroedel@suse.de, egtvedt@samfundet.no, robin.murphy@arm.com, m.szyprowski@samsung.com, krzk@kernel.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 2016-10-27 at 17:23 -0700, Tushar Dave wrote:
> Add Hypervisor IOMMU v2 APIs pci_iotsb_map(), pci_iotsb_demap() and
> enable sun4v dma ops to use IOMMU v2 API for all PCIe devices with
> 64bit DMA mask.

trivia:

> diff --git a/arch/sparc/kernel/pci_sun4v.c b/arch/sparc/kernel/pci_sun4v.c
[]
> @@ -72,34 +72,55 @@ static inline void iommu_batch_start(struct device *d=
ev, unsigned long prot, uns
>  }
> =20
>  /* Interrupts must be disabled.  */
> -static long iommu_batch_flush(struct iommu_batch *p)
> +static long iommu_batch_flush(struct iommu_batch *p, u64 mask)
>  {
>=20
[]
> +			if (unlikely(num < 0)) {
> +				pr_err_ratelimited("iommu_batch_flush: IOMMU map of [%08lx:%08llx:%l=
x:%lx:%lx] failed with status %ld\n",
> +						   devhandle,
> +						   HV_PCI_TSBID(0, entry),
> +						   npages, prot, __pa(pglist),
> +						   num);
> +				return -1;
> +			}
> +		} else {
> +			index_count =3D HV_PCI_IOTSB_INDEX_COUNT(npages, entry),
> +			iotsb_num =3D pbm->iommu->atu->iotsb->iotsb_num;
> +			ret =3D pci_sun4v_iotsb_map(devhandle,
> +						  iotsb_num,
> +						  index_count,
> +						  prot,
> +						  __pa(pglist),
> +						  &num);
> +			if (unlikely(ret !=3D HV_EOK)) {
> +				pr_err_ratelimited("iommu_batch_flush: ATU map of [%08lx:%lx:%llx:%l=
x:%lx] failed with status %ld\n",
> +						   devhandle, iotsb_num,
> +						   index_count, prot,
> +						   __pa(pglist), ret);

Here and above, it's nicer to use %s, __func__ instead of
embedding the function name in the format in case the
code is ever refactored.

				pr_err_ratelimited("%s: ATU map of [%08lx:%lx:%llx:%lx:%lx] failed with=
 status %ld\n",
						=A0=A0=A0__func__,
						   devhandle, iotsb_num,
						=A0=A0=A0index_count, prot,
						=A0=A0=A0__pa(pglist), ret);

