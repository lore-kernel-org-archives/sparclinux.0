From: David Ahern <david.ahern@oracle.com>
Date: Tue, 16 Jun 2015 00:27:17 +0000
Subject: Re: [PATCH 3/4] sparc64: perf: Add sanity checking on addresses in user stack
Message-Id: <557F6D65.2030903@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1434399346-21665-4-git-send-email-david.ahern@oracle.com>
In-Reply-To: <1434399346-21665-4-git-send-email-david.ahern@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 6/15/15 6:13 PM, Julian Calaby wrote:
> Hi David,
>
> On Tue, Jun 16, 2015 at 6:15 AM, David Ahern <david.ahern@oracle.com> wrote:
>> Processes are getting killed (sigbus or segv) while walking userspace
>> callchains when using perf. In some instances I have seen ufp = 0x7ff
>> which does not seem like a proper stack address.
>>
>> This patch adds a function to run validity checks against the address
>> before attempting the copy_from_user. The checks are copied from the
>> x86 version as a start point with the addition of a 4-byte alignment
>> check.
>>
>> Signed-off-by: David Ahern <david.ahern@oracle.com>
>> ---
>>   arch/sparc/include/asm/uaccess_64.h | 22 ++++++++++++++++++++++
>>   arch/sparc/kernel/perf_event.c      | 13 +++++++++++++
>>   2 files changed, 35 insertions(+)
>>
>> diff --git a/arch/sparc/include/asm/uaccess_64.h b/arch/sparc/include/asm/uaccess_64.h
>> index a35194b7dba0..ea6e9a20f3ff 100644
>> --- a/arch/sparc/include/asm/uaccess_64.h
>> +++ b/arch/sparc/include/asm/uaccess_64.h
>> @@ -49,6 +49,28 @@ do {                                                                         \
>>          __asm__ __volatile__ ("wr %%g0, %0, %%asi" : : "r" ((val).seg));        \
>>   } while(0)
>>
>> +/*
>> + * Test whether a block of memory is a valid user space address.
>> + * Returns 0 if the range is valid, nonzero otherwise.
>
> Do you mean true / false here?
>

Yes. I literally copied and pasted from x86 code.

