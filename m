From: Julian Calaby <julian.calaby@gmail.com>
Date: Tue, 24 May 2011 22:47:41 +0000
Subject: Re: [PATCH 1/3 v3] sparc32: added CONFIG_PCIC_PCI Kconfig setting
Message-Id: <BANLkTi=CJaeFrCckGDivnLMV+EmPc-69Xg@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1306220688-8438-1-git-send-email-daniel@gaisler.com>
In-Reply-To: <1306220688-8438-1-git-send-email-daniel@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Daniel,

Minor nit, only if you end up re-spinning this again.

On Tue, May 24, 2011 at 17:04, Daniel Hellstrom <daniel@gaisler.com> wrote:
> Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
> ---
> =A0arch/sparc/Kconfig =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A05 +++++
> =A0arch/sparc/include/asm/pcic.h | =A0 =A02 +-
> =A0arch/sparc/kernel/Makefile =A0 =A0| =A0 =A02 +-
> =A0arch/sparc/kernel/entry.S =A0 =A0 | =A0 =A04 ++--
> =A04 files changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/arch/sparc/kernel/entry.S b/arch/sparc/kernel/entry.S
> index 8341963..6b9a321 100644
> --- a/arch/sparc/kernel/entry.S
> +++ b/arch/sparc/kernel/entry.S
> @@ -1650,7 +1650,7 @@ pcic_nmi_trap_patch:
> =A0 =A0 =A0 =A0 rd =A0 =A0 %psr, %l0
> =A0 =A0 =A0 =A0.word =A0 0
>
> -#endif /* CONFIG_PCI */
> +#endif /* CONFIG_PCI_PCIC */

This should be CONFIG_PCIC_PCI

Otherwise it looks good to me.

Thanks,

--=20
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
.Plan: http://sites.google.com/site/juliancalaby/
