From: Julian Calaby <julian.calaby@gmail.com>
Date: Tue, 04 Aug 2015 13:42:09 +0000
Subject: Re: Build failure (sparc32:allmodconfig) in -next due to 'memcg: export struct mem_cgroup'
Message-Id: <CAGRGNgX4Y2P+Vo-DnHoudaP4Z7bNxamVepmUM+s6pwgWAN4kVw@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20150802030220.GA25165@roeck-us.net> <20150804121801.GA28571@dhcp22.suse.cz>
In-Reply-To: <20150804121801.GA28571@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michal Hocko <mhocko@kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>, Vladimir Davydov <vdavydov@parallels.com>, Andrew Morton <akpm@linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, sparclinux <sparclinux@vger.kernel.org>

Hi Michal,

On Tue, Aug 4, 2015 at 10:18 PM, Michal Hocko <mhocko@kernel.org> wrote:
> On Sat 01-08-15 20:02:20, Guenter Roeck wrote:
>> Hi,
>>
>> Commit b65390c6c2178f ("memcg: export struct mem_cgroup") causes several
>> build failures in -next (next-20150731) when trying to build
>> sparc32:allmodconfig.
>>
>> Below are some of the errors, as well as a bisect log.
>>
>> Guenter
>>
>> ---
>> In file included from include/linux/pid_namespace.h:6:0,
>>                  from include/linux/ptrace.h:8,
>>                  from include/linux/ftrace.h:13,
>>                  from include/linux/init_task.h:8,
>>                  from init/init_task.c:1:
>> include/linux/mm.h: At top level:
>> include/linux/mm.h:888:7: error: conflicting types for 'page_address'
>> ./arch/sparc/include/asm/highmem.h:59:10: note: previous implicit declaration of 'page_address' was here
>
> This is weird:
> * include/linux/mm.h:888
>
> #if defined(HASHED_PAGE_VIRTUAL)
> void *page_address(const struct page *page);
> void set_page_address(struct page *page, void *virtual);
> void page_address_init(void);
> #endif
>
> * arch/sparc/include/asm/highmem.h:59
> static inline void *kmap(struct page *page)
> {
>         BUG_ON(in_interrupt());
>         if (!PageHighMem(page))
>                 return page_address(page);
>         return kmap_high(page);
> }
>
> How come we have conflicting types here. page_address is clearly not
> a function declaration in sparc code. Maybe something expands to an
> incomplete c construct.
>
> I have tried to crosscompile with
> https://www.kernel.org/pub/tools/crosstool/files/bin/x86_64/4.6.3/ but
> failed with strange errors.
> $ PATH=/mnt/share/devel/miso/crosstool/sparc/gcc-4.6.3-nolibc/x86_64-linux/bin:$PATH CROSS_COMPILE=x86_64-linux- ARCH=sparc32 make allmodconfig
> warning: (USB_OTG_FSM && FSL_USB2_OTG && USB_MV_OTG) selects USB_OTG which has unmet direct dependencies (USB_SUPPORT && USB && PM)
> warning: (MFD_CROS_EC) selects CHROME_PLATFORMS which has unmet direct dependencies (X86 || ARM)
> warning: (SND_SOC_ROCKCHIP_MAX98090 && SND_SOC_ROCKCHIP_RT5645) selects SND_SOC_ROCKCHIP_I2S which has unmet direct dependencies (SOUND && !M68K && !UML && SND && SND_SOC && CLKDEV_LOOKUP && SND_SOC_ROCKCHIP)
> $ PATH=/mnt/share/devel/miso/crosstool/sparc/gcc-4.6.3-nolibc/x86_64-linux/bin:$PATH CROSS_COMPILE=x86_64-linux- ARCH=sparc32 make

It's failing because you're trying to compile sparc32 code with an
x86_64 compiler.

Try something like:
PATH=/mnt/share/devel/miso/crosstool/sparc/gcc-4.6.3-nolibc/x86_64-linux/bin:$PATH
CROSS_COMPILE=sparc-linux- ARCH=sparc32 make

Thanks,

-- 
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
