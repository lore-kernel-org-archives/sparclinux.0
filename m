From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Date: Mon, 09 Apr 2018 16:03:49 +0000
Subject: Re: [PATCH 0/3] move __HAVE_ARCH_PTE_SPECIAL in Kconfig
Message-Id: <17b19aac-fed7-23a2-013c-43ca867152e9@synopsys.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1523282229-20731-1-git-send-email-ldufour@linux.vnet.ibm.com>
In-Reply-To: <1523282229-20731-1-git-send-email-ldufour@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 04/09/2018 06:57 AM, Laurent Dufour wrote:
> The per architecture __HAVE_ARCH_PTE_SPECIAL is defined statically in the
> per architecture header files. This doesn't allow to make other
> configuration dependent on it.

So I understand this series has more "readability" value and I'm fine with this 
change but I wonder if you really would want to make something depend on it or 
make this de-configurable. PTE special is really a fundamental construct - e.g. it 
is used for anon mapped pages where zero page has been wired up etc...

-Vineet

> This series is moving the __HAVE_ARCH_PTE_SPECIAL into the Kconfig files,
> setting it automatically when architectures was already setting it in
> header file.
>
> There is no functional change introduced by this series.

