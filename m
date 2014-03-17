From: David Miller <davem@davemloft.net>
Date: Mon, 17 Mar 2014 19:51:28 +0000
Subject: Re: [PATCH] sparc: use %s for unaligned panic
Message-Id: <20140317.155128.1576479712298453623.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20140311202446.GA24531@www.outflux.net>
	<20140315080709.GA14405@ravnborg.org>
In-Reply-To: <20140315080709.GA14405@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sam@ravnborg.org
Cc: keescook@chromium.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 15 Mar 2014 09:07:09 +0100

> On Tue, Mar 11, 2014 at 01:24:46PM -0700, Kees Cook wrote:
>> Since unaligned_panic() takes a literal string, make sure it can never
>> accidentally be used as a format string.
>> 
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>> ---
>>  arch/sparc/kernel/unaligned_32.c |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/arch/sparc/kernel/unaligned_32.c b/arch/sparc/kernel/unaligned_32.c
>> index c0ec89786193..892e399414e0 100644
>> --- a/arch/sparc/kernel/unaligned_32.c
>> +++ b/arch/sparc/kernel/unaligned_32.c
>> @@ -162,7 +162,7 @@ unsigned long safe_compute_effective_address(struct pt_regs *regs,
>>  /* This is just to make gcc think panic does return... */
>>  static void unaligned_panic(char *str)
>>  {
>> -	panic(str);
>> +	panic("%s", str);
>>  }
>>  
>>  /* una_asm.S */
> 
> Another "fix" would be to align with sparc64 and call die_if_kernel()

Furthermore, this is a silly change because there are only two call sites, they
are both in this file, and they clearly do not pass format strings embedded
in the string.
