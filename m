From: Dave Kleikamp <dave.kleikamp@oracle.com>
Date: Wed, 23 Mar 2016 20:41:13 +0000
Subject: Re: [Crash-utility] [PATCH 0/2] sparc64 support for crash utility
Message-Id: <56F2FF69.1060809@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20160323.144039.1853321572894699789.davem@davemloft.net>
In-Reply-To: <20160323.144039.1853321572894699789.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 03/23/2016 03:06 PM, Dave Anderson wrote:
> 
> Hi Dave,
> 
> Welcome to the party after all these years.  
> 
> With any new architecture addition, one of the primary requirements
> for acceptance is that it in no way impacts any of the other architectures.
> This patchset was nicely done with that in mind, although there are two
> places in task.c where it does modify generic code:  
> 
> First, I prefer that the change in get_idle_threads() be segregated for 
> SPARC64 only.

I can do that.

> The second change to task_flags() looks reasonable, but I would prefer 
> that it be done differently.  The reason it reads the flags with ULONG()
> is because originally it was an unsigned long.  I'm not sure when the 
> kernel changed it to an unsigned int, but interestingly enough, it's never
> been reported as a problem.  In any case, to maintain backwards compatibility
> with older kernels, the read size should be based upon MEMBER_SIZE()
> instead of forcing it to use UINT() as you have done.

I thought about that, but it's been an unsigned int since 2.6.22.
Anyway, I'll make the change.

> And as far as sparc64.c, I did look at it, and it looks fine on paper,
> but I'll give you free reign as the sparc64 maintainer to do with it
> as you like.  You will be my go-to sparc64 maintainer, correct?

I'd be happy to, unless Dave Miller wants to add it to his roles.

> 
> Dave
> 
> 
> 
> ----- Original Message -----
>> These patches add support for the sparc64 architecture.
>>
>> This supports running against a live kernel. Diskdump support is
>> also here, but the crashdump support for the kernel, kexec-tools,
>> and makedumpfile is still pending.
>>
>> Initial work was done by Karl Volz with help from Bob Picco.
>>
>> Dave Kleikamp (2):
>>   sparc64 changes for gdb-7.6
>>   sparc64 changes
>>
>>  Makefile            |    9 +-
>>  configure.c         |   23 +
>>  defs.h              |  190 ++++++++-
>>  diskdump.c          |   36 ++-
>>  gdb-7.6.patch       |   37 ++
>>  lkcd_vmdump_v2_v3.h |    2 +-
>>  sparc64.c           | 1186
>>  +++++++++++++++++++++++++++++++++++++++++++++++++++
>>  symbols.c           |   10 +
>>  task.c              |   11 +-
>>  9 files changed, 1496 insertions(+), 8 deletions(-)
>>  create mode 100644 sparc64.c
>>
>> --
>> Crash-utility mailing list
>> Crash-utility@redhat.com
>> https://www.redhat.com/mailman/listinfo/crash-utility
>>
> 
> --
> Crash-utility mailing list
> Crash-utility@redhat.com
> https://www.redhat.com/mailman/listinfo/crash-utility
> 
