From: David Miller <davem@davemloft.net>
Date: Thu, 14 Nov 2019 00:21:57 +0000
Subject: Re: [PATCH] sparc: vdso: fix build error of vdso32
Message-Id: <20191113.162157.111707512627631395.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20190922113436.10396-1-yamada.masahiro@socionext.com>
        <201911131558.6B0778229@keescook>
In-Reply-To: <201911131558.6B0778229@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: keescook@chromium.org
Cc: yamada.masahiro@socionext.com, sparclinux@vger.kernel.org, matorola@gmail.com, gregkh@linuxfoundation.org, tglx@linutronix.de, linux-kernel@vger.kernel.org, ndesaulniers@google.com

From: Kees Cook <keescook@chromium.org>
Date: Wed, 13 Nov 2019 15:59:27 -0800

> On Sun, Sep 22, 2019 at 08:34:36PM +0900, Masahiro Yamada wrote:
>> Since commit 54b8ae66ae1a ("kbuild: change *FLAGS_<basetarget>.o to
>> take the path relative to $(obj)"), sparc allmodconfig fails to build
>> as follows:
>> 
>>   CC      arch/sparc/vdso/vdso32/vclock_gettime.o
>> unrecognized e_machine 18 arch/sparc/vdso/vdso32/vclock_gettime.o
>> arch/sparc/vdso/vdso32/vclock_gettime.o: failed
>> 
>> The cause of the breakage is that -pg flag not being dropped.
>> 
>> The vdso32 files are located in the vdso32/ subdirectory, but I missed
>> to update the Makefile.
>> 
>> Fixes: 54b8ae66ae1a ("kbuild: change *FLAGS_<basetarget>.o to take the path relative to $(obj)")
>> Reported-by: Anatoly Pugachev <matorola@gmail.com>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> 
> I've tripped over this as well. Since no one has picked this up, can you
> take it via your tree Masahiro?

Yes, please do.  Sorry, I haven't had a lot of time for Sparc work lately.

Acked-by: David S. Miller <davem@davemloft.net>
