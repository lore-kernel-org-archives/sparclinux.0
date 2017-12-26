From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Tue, 26 Dec 2017 10:23:15 +0000
Subject: Re: [PATCH v5 6/8] kernel/jump_label: abstract jump_entry member accessors
Message-Id: <CAKv+Gu_9L8LDe72FJDDhWVA4G9ZWcuxQnxWRtFMKgH=AhMOiZQ@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20171225205440.14575-7-ard.biesheuvel@linaro.org>
 <201712261806.hJg043uc%fengguang.wu@intel.com>
In-Reply-To: <201712261806.hJg043uc%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 26 December 2017 at 10:19, kbuild test robot <lkp@intel.com> wrote:
> Hi Ard,
>
> I love your patch! Yet something to improve:
>
> [auto build test ERROR on linus/master]
> [also build test ERROR on v4.15-rc5 next-20171222]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Ard-Biesheuvel/add-support-for-relative-references-in-special-sections/20171226-164147
> config: s390-allmodconfig (attached as .config)
> compiler: s390x-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=s390
>

I guess the diffstat gives it away:

>  arch/arm/include/asm/jump_label.h     | 27 ++++++++++++++
>  arch/arm64/include/asm/jump_label.h   | 27 ++++++++++++++
>  arch/mips/include/asm/jump_label.h    | 27 ++++++++++++++
>  arch/powerpc/include/asm/jump_label.h | 27 ++++++++++++++
>  arch/s390/include/asm/jump_label.h    | 20 +++++++++++
>  arch/sparc/include/asm/jump_label.h   | 27 ++++++++++++++
>  arch/tile/include/asm/jump_label.h    | 27 ++++++++++++++
>  arch/x86/include/asm/jump_label.h     | 27 ++++++++++++++

Will fix in the next revision.
