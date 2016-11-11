From: Thomas Tai <thomas.tai@oracle.com>
Date: Fri, 11 Nov 2016 14:00:31 +0000
Subject: Re: [sparc:master 1/2] WARNING: arch/sparc/built-in.o(.text.unlikely+0x2e4): Section mismatch in ref
Message-Id: <9f48ca25-251e-c295-fa39-1d3657f96187@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <201611111152.mFUqA94u%fengguang.wu@intel.com>
In-Reply-To: <201611111152.mFUqA94u%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org



On 11/10/2016 10:30 PM, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git master
> head:   07b5ab3f71d318e52c18cc3b73c1d44c908aacfa
> commit: 74a5ed5c4f692df2ff0a2313ea71e81243525519 [1/2] sparc64: Fix find_node warning if numa node cannot be found
> config: sparc64-allmodconfig (attached as .config)
> compiler: sparc64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
> reproduce:
>          wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          git checkout 74a5ed5c4f692df2ff0a2313ea71e81243525519
>          # save the attached .config to linux build tree
>          make.cross ARCH=sparc64
>
> All warnings (new ones prefixed by >>):
>
>>> WARNING: arch/sparc/built-in.o(.text.unlikely+0x2e4): Section mismatch in reference from the function find_node() to the function .init.text:find_mlgroup()
>     The function find_node() references
>     the function __init find_mlgroup().
>     This is often because find_node lacks a __init
>     annotation or the annotation of find_mlgroup is wrong.
Very sorry for the warning, I will submit a fix as soon as possible.
-Thomas

>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

