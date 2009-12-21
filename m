From: Alexander Beregalov <a.beregalov@gmail.com>
Date: Mon, 21 Dec 2009 19:28:39 +0000
Subject: Re: [PATCH 1/2] sparc: us3_cpufreq.c: fix warnings/errors
Message-Id: <a4423d670912211128u2aa2f259gd4cfb7d1d46b2f05@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1261311396-609-1-git-send-email-a.beregalov@gmail.com>
In-Reply-To: <1261311396-609-1-git-send-email-a.beregalov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: sparclinux@vger.kernel.org

2009/12/21 Alexander Beregalov <a.beregalov@gmail.com>:
> 2009/12/21 Sam Ravnborg <sam@ravnborg.org>:
>> On Sun, Dec 20, 2009 at 03:16:35PM +0300, Alexander Beregalov wrote:
>>> Fix warnings which become build errors since -Werror is used.
>>> arch/sparc/kernel/us3_cpufreq.c:60: error: 'ret' may be used uninitialized in this function
>>> arch/sparc/kernel/us3_cpufreq.c:101: error: 'new_bits' may be used uninitialized in this function
>>
>> What config produces these warnings?
>> Do you have CONFIG_BUG_VERBOSE set?
>>
>> Also what gcc versio?
>>
Ah, this is it.

# CONFIG_BUG is not set

Is it sane config ?
>
> Hi
>
> I do not know what has changed.
> I have not tried these options before.
> I tested randconfig builds.
> Config is attached.
>
> gcc is 4.3.4
>
> sparc64-unknown-linux-gnu-gcc
> -Wp,-MD,arch/sparc/kernel/.us3_cpufreq.o.d  -nostdinc -isystem
> /usr/lib/gcc/sparc64-unknown-linux-gnu/4.3.4/include
> -I/home/alexb/src/linux-2.6/arch/sparc/include -Iinclude  -include
> include/generated/autoconf.h -D__KERNEL__ -Wall -Wundef
> -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common
> -Werror-implicit-function-declaration -Wno-format-security
> -fno-delete-null-pointer-checks -Os -m64 -pipe -mno-fpu
> -mcpu=ultrasparc -mcmodel=medlow -ffixed-g4 -ffixed-g5 -fcall-used-g7
> -Wno-sign-compare -Wa,--undeclared-regs -mtune=ultrasparc3 -pg
> -fno-stack-protector -fno-omit-frame-pointer
> -fno-optimize-sibling-calls -Wdeclaration-after-statement
> -Wno-pointer-sign -fno-strict-overflow -Werror -D"KBUILD_STR(s)=#s"
> -D"KBUILD_BASENAME=KBUILD_STR(us3_cpufreq)"
> -D"KBUILD_MODNAME=KBUILD_STR(us3_cpufreq)" -D"DEBUG_HASH"
> -D"DEBUG_HASH29" -c -o arch/sparc/kernel/.tmp_us3_cpufreq.o
> arch/sparc/kernel/us3_cpufreq.c
> cc1: warnings being treated as errors
> arch/sparc/kernel/us3_cpufreq.c: In function 'get_current_freq':
> arch/sparc/kernel/us3_cpufreq.c:60: error: 'ret' may be used
> uninitialized in this function
> arch/sparc/kernel/us3_cpufreq.c: In function 'us3_set_cpu_divider_index':
> arch/sparc/kernel/us3_cpufreq.c:101: error: 'new_bits' may be used
> uninitialized in this function
> make[1]: *** [arch/sparc/kernel/us3_cpufreq.o] Error 1
>
