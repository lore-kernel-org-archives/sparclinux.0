From: Nick Alcock <nick.alcock@oracle.com>
Date: Fri, 11 Aug 2017 12:23:26 +0000
Subject: Re: [PATCH V3] vDSO for SPARC
Message-Id: <87inhu1ef5.fsf@esperi.org.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <1502400887-281290-1-git-send-email-nagarathnam.muthusamy@oracle.com>
In-Reply-To: <1502400887-281290-1-git-send-email-nagarathnam.muthusamy@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: sparclinux@vger.kernel.org

On 11 Aug 2017, Nagarathnam Muthusamy verbalised:

> On 08/10/2017 03:03 PM, David Miller wrote:
>> From: Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>
>> Date: Thu, 10 Aug 2017 17:34:47 -0400
>>
>>> Following patch is based on work done by Nick Alcock on 64-bit vDSO for sparc
>>> in Oracle linux. I have extended it to include support for 32-bit vDSO for sparc
>>> on 64-bit kernel.
>> This doesn't build:
>>
>> davem@patience:~/src/GIT/sparc-next$ make -s -j128
>> In file included from arch/sparc/vdso/vdso2c.c:141:0:
>> arch/sparc/vdso/vdso2c.h: In function ‘go64’:
>> arch/sparc/vdso/vdso2c.h:20:14: warning: variable ‘secstrings’ set but not used [-Wunused-but-set-variable]
>>    const char *secstrings;

secstrings and secstrings_hdr can be removed, or can be used in the
following loop to make it a bit less squirrelly: up to you. (However,
see below, because this may be a sign of the underlying problem.)

>>                ^~~~~~~~~~
>> In file included from arch/sparc/vdso/vdso2c.c:145:0:
>> arch/sparc/vdso/vdso2c.h: In function ‘go32’:
>> arch/sparc/vdso/vdso2c.h:20:14: warning: variable ‘secstrings’ set but not used [-Wunused-but-set-variable]
>>    const char *secstrings;
>>                ^~~~~~~~~~
>> Error: vvar_begin must be a multiple of 8192
>> make[2]: *** [arch/sparc/vdso/vdso-image-64.c] Error 1
>> make[2]: *** Waiting for unfinished jobs....
>> Error: vvar_begin must be a multiple of 8192
>> make[2]: *** [arch/sparc/vdso/vdso-image-32.c] Error 1
>> make[1]: *** [arch/sparc/vdso] Error 2
>>
>>
>> davem@patience:~/src/GIT/sparc-next$ gcc --version
>> gcc (GCC) 6.3.0
>> Copyright (C) 2016 Free Software Foundation, Inc.
>> This is free software; see the source for copying conditions.  There is NO
>> warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
>
> My gcc version is bit old (4.4.7) and the build passed in my system. I will reproduce the errors locally, fix them
> and send out an updated patch.

If this is any problem, it's a linker problem, or a problem with the
code in vdso2c around required_syms which sets up sym_vvar_start to be
equal to .vvar_start, since as you see here:

+	if (syms[sym_vvar_start] % 8192)
+		fail("vvar_begin must be a multiple of 8192\n");

and here:

--- /dev/null
+++ b/arch/sparc/vdso/vdso-layout.lds.S
@@ -0,0 +1,106 @@
[...]
+SECTIONS
+{
+	/*
+	 * User/kernel shared data is before the vDSO.  This may be a little
+	 * uglier than putting it after the vDSO, but it avoids issues with
+	 * non-allocatable things that dangle past the end of the PT_LOAD
+	 * segment.
+	 */
+
+	vvar_start = . -PAGE_SIZE;
+	vvar_data = vvar_start;
+
+	. = SIZEOF_HEADERS;

unless you have a really serious linker bug, there is no way vvar_start
could fail to be at a multiple of 8192 bytes, AFAICS, and sym_vvar_start
should have been set up by vdso2c to point right at it.

The set but not used variable stuff suggests you've been doing stuff
inside vdso2c, which I was just able to carry across unmodified from x86
and which worked fine when I did that. I bet some of that is somehow
broken and the various symbol references in the vdso2c output are
wrong somehow.

-- 
NULL && (void)
