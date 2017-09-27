From: David Miller <davem@davemloft.net>
Date: Wed, 27 Sep 2017 21:02:38 +0000
Subject: Re: [PATCH v2 2/2] sparc64: Use lzcnt instruction for fls and __fls
Message-Id: <20170927.140238.1798928470383448433.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1506540326-9604-1-git-send-email-vijay.ac.kumar@oracle.com>
        <1506540326-9604-3-git-send-email-vijay.ac.kumar@oracle.com>
        <20170927195637.GB15193@ravnborg.org>
In-Reply-To: <20170927195637.GB15193@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sam@ravnborg.org
Cc: vijay.ac.kumar@oracle.com, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, babu.moger@oracle.com, rob.gardner@oracle.com

From: Sam Ravnborg <sam@ravnborg.org>
Date: Wed, 27 Sep 2017 21:56:37 +0200

> Hi Vijay.
> 
> On Wed, Sep 27, 2017 at 01:25:26PM -0600, Vijay Kumar wrote:
>> For T4 and above, patch fls and __fls functions
>> at the boot time to use lzcnt instruction.
>> 
>> Signed-off-by: Vijay Kumar <vijay.ac.kumar@oracle.com>
>> Reviewed-by: Babu Moger <babu.moger@oracle.com>
>> ---
>>  arch/sparc/Makefile         |    1 +
>>  arch/sparc/kernel/head_64.S |    2 ++
>>  arch/sparc/lib/Makefile     |    3 +++
>>  arch/sparc/lib/NG4fls.S     |   30 ++++++++++++++++++++++++++++++
>>  arch/sparc/lib/NG4patch.S   |    9 +++++++++
>>  5 files changed, 45 insertions(+), 0 deletions(-)
>> 
>> diff --git a/arch/sparc/Makefile b/arch/sparc/Makefile
>> index 8496a07..0763cd8 100644
>> --- a/arch/sparc/Makefile
>> +++ b/arch/sparc/Makefile
>> @@ -48,6 +48,7 @@ KBUILD_CFLAGS += -ffixed-g4 -ffixed-g5 -fcall-used-g7 -Wno-sign-compare
>>  KBUILD_CFLAGS += -Wa,--undeclared-regs
>>  KBUILD_CFLAGS += $(call cc-option,-mtune=ultrasparc3)
>>  KBUILD_AFLAGS += -m64 -mcpu=ultrasparc -Wa,--undeclared-regs
>> +KBUILD_AFLAGS += -Wa,-Asparc4
> This change is not justified anywhere??

It also will likely break with older tools.
