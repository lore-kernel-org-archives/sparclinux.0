From: Julian Calaby <julian.calaby@gmail.com>
Date: Mon, 25 Mar 2013 22:11:15 +0000
Subject: Re: [PATCH 2/3] sparc/iommu: use BITS_TO_LONGS() to calculate bitmap size
Message-Id: <CAGRGNgW=QvD_45ksd4dO9o_D4k+36CfgbDJk1OxG4m4WRWMQDw@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1364115306-17716-2-git-send-email-akinobu.mita@gmail.com>
In-Reply-To: <1364115306-17716-2-git-send-email-akinobu.mita@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi David,

I understand that you're not going to fix a non-bug like this, but:

On Sun, Mar 24, 2013 at 7:55 PM, Akinobu Mita <akinobu.mita@gmail.com> wrote:
> The size of bitmaps which is accessed by bitops must be a multiple of
> the sizeof(long).  So it would be better to use BITS_TO_LONGS() to
> calculate the bitmap size although IOMMU_NPTES is a multiple of
> BITS_PER_LONG.
>
> This also fixes typo in the comment for IOMMU_NPTES.
>
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: sparclinux@vger.kernel.org
> ---
>  arch/sparc/mm/iommu.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/arch/sparc/mm/iommu.c b/arch/sparc/mm/iommu.c
> index 0f4f719..f9027fd 100644
> --- a/arch/sparc/mm/iommu.c
> +++ b/arch/sparc/mm/iommu.c
> @@ -34,7 +34,7 @@
>  #define IOMMU_RNGE     IOMMU_RNGE_256MB
>  #define IOMMU_START    0xF0000000
>  #define IOMMU_WINSIZE  (256*1024*1024U)
> -#define IOMMU_NPTES    (IOMMU_WINSIZE/PAGE_SIZE)       /* 64K PTEs, 265KB */
> +#define IOMMU_NPTES    (IOMMU_WINSIZE/PAGE_SIZE)       /* 64K PTEs, 256KB */

Is this change worthwhile?

Thanks,

-- 
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
.Plan: http://sites.google.com/site/juliancalaby/
