From: Jeffrey Merkey <jeffmerkey@gmail.com>
Date: Thu, 28 Jan 2016 21:35:22 +0000
Subject: Re: [PATCH 30/31] Add debugger entry points for SPARC
Message-Id: <CA+ekxPVuiJD2+BchBA5Sg+-7RbMS6m6hF8-LJZrRhO6YxNrcHQ@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1454010468-29651-1-git-send-email-jeffmerkey@gmail.com>
	<20160128213321.GA32054@ravnborg.org>
In-Reply-To: <20160128213321.GA32054@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-kernel@vger.kernel.org, davem@davemloft.net, linux.mdb@gmail.com, sparclinux@vger.kernel.org

On 1/28/16, Sam Ravnborg <sam@ravnborg.org> wrote:
> Hi Jeff.
>
>> +++ b/arch/sparc/include/asm/kdebug.h
>> @@ -5,4 +5,9 @@
>>  #else
>>  #include <asm/kdebug_32.h>
>>  #endif
>> +
>> +static inline void arch_breakpoint(void)
>> +{
>> +	asm("ta	$0x7d");
>> +}
>>  #endif
> There seems to be some debugger infrastructure present already for kgdb,
> but I assume this cannot be used.
> Anyway - trap 0x7d is a debugger trap in sparc32.
> If CONFIG_KGDB is not defined then 0x7d is just a regular BAD_TRAP.
>
> For sparc64 trap 0x7d is something different.
> I did not conclude what was the right choice for neither.
>
> 	Sam
>

I'll go research that one.  If I am unsure I'll no-op the function for
sparc and let you guys decide how architecturally you wish to handle
that.

:-)

Jeff
