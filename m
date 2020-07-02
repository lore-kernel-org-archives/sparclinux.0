From: Julian Calaby <julian.calaby@gmail.com>
Date: Thu, 02 Jul 2020 13:27:29 +0000
Subject: Re: [PATCH] sparc: sparc64_defconfig: add necessary configs for qemu
Message-Id: <CAGRGNgWqSM9HKtykqUn1wC5N5mW+RRTbfE89pBP=e2t_geDUmg@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1593694973-34113-1-git-send-email-clabbe@baylibre.com>
In-Reply-To: <1593694973-34113-1-git-send-email-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Corentin Labbe <clabbe@baylibre.com>
Cc: "David S. Miller" <davem@davemloft.net>, LKML <linux-kernel@vger.kernel.org>, sparclinux <sparclinux@vger.kernel.org>

Hi Corentin,

On Thu, Jul 2, 2020 at 11:03 PM Corentin Labbe <clabbe@baylibre.com> wrote:
>
> The sparc64 qemu machines uses pcnet32 network hardware by default, so for
> simple boot testing using qemu, having PCNET32 is useful.
> Same for its storage which is a PATA_CMD64.
>
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>  arch/sparc/configs/sparc64_defconfig | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/sparc/configs/sparc64_defconfig b/arch/sparc/configs/sparc64_defconfig
> index bde4d21a8ac8..61073f48a7a1 100644
> --- a/arch/sparc/configs/sparc64_defconfig
> +++ b/arch/sparc/configs/sparc64_defconfig
> @@ -236,3 +236,6 @@ CONFIG_CRYPTO_TWOFISH=m
>  CONFIG_CRC16=m
>  CONFIG_LIBCRC32C=m
>  CONFIG_VCC=m
> +CONFIG_ATA=y
> +CONFIG_PATA_CMD64X=y
> +CONFIG_PCNET32=y

FWIW the CMD640 is the IDE controller used on the Ultra 5/10 machines.

Thanks,

-- 
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
