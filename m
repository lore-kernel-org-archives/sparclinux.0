From: Laszlo Valko <valko@linux.karinthy.hu>
Date: Mon, 23 Nov 2009 20:52:08 +0000
Subject: Re: 2.6.31.6 freezes on v210
Message-Id: <20091123215208.A24079@linux.karinthy.hu>
List-Id: <sparclinux.vger.kernel.org>
References: <20091120210249.A20906@linux.karinthy.hu>
In-Reply-To: <20091120210249.A20906@linux.karinthy.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, Nov 23, 2009 at 03:23:28PM +0100, Josip Rodin wrote:
> Try just editing arch/sparc/kernel/pcr.c and in the pcr_arch_init()
> function make it not call return nmi_init() but just return 0.

Well, that's it.

This simple changed cured my 2.6.31.6 & my gentoo-hardened 2.6.31 kernel,
with SMP.

Regards,
Laszlo
