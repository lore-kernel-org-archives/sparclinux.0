From: Palmer Dabbelt <palmer@dabbelt.com>
Date: Mon, 26 Jun 2017 20:27:55 +0000
Subject: Re: [PATCH] pci: Add and use PCI_GENERIC_SETUP Kconfig entry
Message-Id: <20170626202756.22220-1-palmer@dabbelt.com>
List-Id: <sparclinux.vger.kernel.org>
References: <CAMuHMdXSrfbSX2de2q35Hj6vQwi+sr23M1LEg82JL+FyLq4OJw@mail.gmail.com>
In-Reply-To: <CAMuHMdXSrfbSX2de2q35Hj6vQwi+sr23M1LEg82JL+FyLq4OJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: rth@twiddle.net

>On Mon, Jun 26, 2017 at 7:39 AM, kbuild test robot <lkp@intel.com> wrote:
>> [auto build test WARNING on linus/master]
>> [also build test WARNING on v4.12-rc6]
>> [cannot apply to next-20170623]
>> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>>
>> url:    https://github.com/0day-ci/linux/commits/Palmer-Dabbelt/pci-Add-and-use-PCI_GENERIC_SETUP-Kconfig-entry/20170626-043558
>> config: m68k-allnoconfig (attached as .config)
>> compiler: m68k-linux-gcc (GCC) 4.9.0
>> reproduce:
>>         wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>         chmod +x ~/bin/make.cross
>>         # save the attached .config to linux build tree
>>         make.cross ARCH=m68k
>>
>> All warnings (new ones prefixed by >>):
>>
>> warning: (M68K) selects PCI_GENERIC_SETUP which has unmet direct dependencies (MMU)
>
>I can't seem to find this dependency of PCI_GENERIC_SETUP on MMU?

It looks like M68K only includes the PCI Kconfig entry when MMU is enabled.  I
moved the select around a bit and it builds the config that was failing for me.

The updated patch is threaded.
