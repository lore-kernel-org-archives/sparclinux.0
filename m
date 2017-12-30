From: Anatoly Pugachev <matorola@gmail.com>
Date: Sat, 30 Dec 2017 12:00:07 +0000
Subject: Re: building debug version of klibc
Message-Id: <CADxRZqyfzYxPPCiZCwdwsDvjZbTDX-i1x4dedb+PDJ7-BGL_HA@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <CADxRZqz24hXaLZzSgn=4ZC-Mj53ecbq7J=AcwxVyypU6eNQVqA@mail.gmail.com>
	<20171230113002.GA10794@ravnborg.org>
In-Reply-To: <20171230113002.GA10794@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kernelnewbies@lists.kernelnewbies.org

On Sat, Dec 30, 2017 at 2:30 PM, Sam Ravnborg <sam@ravnborg.org> wrote:
> Hi Anatoly
>
> On Sat, Dec 30, 2017 at 01:54:05PM +0300, Anatoly Pugachev wrote:
>> Hello!
>>
>> Can someone please help me in building debug version of klibc ?
>>
>> I've cloned git://git.kernel.org/pub/scm/libs/klibc/klibc.git  , but
>> failed to build it with debug info
>>
>> added "-g" to HOSTCFLAGS in Makefile, but
>
> HOSTCFLAGS is used when building tools running on your build machine.
>
> Try something like this (untested, whitespace damaged):
>
> diff --git a/scripts/Kbuild.klibc b/scripts/Kbuild.klibc
> index f500d535..3e8124f7 100644
> --- a/scripts/Kbuild.klibc
> +++ b/scripts/Kbuild.klibc
> @@ -69,7 +69,7 @@ include $(srctree)/scripts/Kbuild.include
>  KLIBCREQFLAGS     := $(call cc-option, -fno-stack-protector, ) \
>                       $(call cc-option, -fwrapv, )
>  KLIBCARCHREQFLAGS :> -KLIBCOPTFLAGS     :> +KLIBCOPTFLAGS     := -g
>  KLIBCWARNFLAGS    := -W -Wall -Wno-sign-compare -Wno-unused-parameter
>  KLIBCSHAREDFLAGS  :>  KLIBCBITSIZE      :>
> If you use make V=1 then you should be able to see the
> full gcc command line, where -g should be included with
> theabove fix.


Sam, thanks!
I did notice that later as well, but I've changed KLIBCCFLAGS to
include "-g" and changed strip to echo:

mator@ttip:~/klibc$ git diff
diff --git a/scripts/Kbuild.klibc b/scripts/Kbuild.klibc
index f500d535..40cbfd60 100644
--- a/scripts/Kbuild.klibc
+++ b/scripts/Kbuild.klibc
@@ -74,7 +74,7 @@ KLIBCWARNFLAGS    := -W -Wall -Wno-sign-compare
-Wno-unused-parameter
 KLIBCSHAREDFLAGS  : KLIBCBITSIZE      : KLIBCLDFLAGS      :-KLIBCCFLAGS       :+KLIBCCFLAGS       := -g

 # Defaults for arch to override
 KLIBCARCHINCFLAGS = -I$(KLIBCKERNELOBJ)/arch/$(KLIBCARCH)/include
@@ -99,7 +99,7 @@ KLIBCAR          := $(AR)
 klibc-ar = $(KLIBCAR) $(if $(KBUILD_REPRODUCIBLE),$(2),$(1))

 KLIBCRANLIB      := $(call klibc-ar,s,Ds)
-KLIBCSTRIP       := $(STRIP)
+KLIBCSTRIP       := echo
 KLIBCNM          := $(NM)
 KLIBCOBJCOPY     := $(OBJCOPY)
 KLIBCOBJDUMP     := $(OBJDUMP)
@@ -126,7 +126,7 @@ KLIBCCPPFLAGS    += $(KLIBCDEFS)
 KLIBCCFLAGS      += $(KLIBCCPPFLAGS) $(KLIBCREQFLAGS) $(KLIBCARCHREQFLAGS)  \
                     $(KLIBCOPTFLAGS) $(KLIBCWARNFLAGS)
 KLIBCAFLAGS      += -D__ASSEMBLY__ $(KLIBCCFLAGS)
-KLIBCSTRIPFLAGS  += --strip-all -R .comment -R .note
+#KLIBCSTRIPFLAGS  += --strip-all -R .comment -R .note

 KLIBCLIBGCC_DEF  := $(shell $(KLIBCCC) $(KLIBCCFLAGS) --print-libgcc)
 KLIBCLIBGCC     ?= $(KLIBCLIBGCC_DEF)
mator@ttip:~/klibc$

this helped me to produce exec with debug info and stack trace:

(gdb) file ./usr/kinit/fstype/static/fstype
Reading symbols from ./usr/kinit/fstype/static/fstype...done.
(gdb) run
Starting program: /home/mator/klibc/usr/kinit/fstype/static/fstype

Program received signal SIGSEGV, Segmentation fault.
__syscall_common () at usr/klibc/arch/sparc64/syscall.S:15
15              st      %o0,[%g4]
(gdb) bt
#0  __syscall_common () at usr/klibc/arch/sparc64/syscall.S:15
#1  0x00000000001010d4 in identify_fs ()
#2  0x00000000001001f0 in main ()


PS: added sparclinux@vger , first thread message is
http://www.zytor.com/pipermail/klibc/2017-December/003962.html
