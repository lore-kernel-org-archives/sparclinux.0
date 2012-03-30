From: Paul Gortmaker <paul.gortmaker@windriver.com>
Date: Fri, 30 Mar 2012 21:56:46 +0000
Subject: Re: [PATCH] sparc: fix compile failure in kgdb_64.c
Message-Id: <4F762C1E.2040803@windriver.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1333135884-12815-1-git-send-email-paul.gortmaker@windriver.com>
In-Reply-To: <1333135884-12815-1-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 12-03-30 04:47 PM, David Miller wrote:
> From: Paul Gortmaker <paul.gortmaker@windriver.com>
> Date: Fri, 30 Mar 2012 15:31:24 -0400
> 
>> To fix:
>>
>>   CC      arch/sparc/kernel/kgdb_64.o
>>  arch/sparc/kernel/kgdb_64.c: In function 'smp_kgdb_capture_client':
>>  arch/sparc/kernel/kgdb_64.c:121: error: implicit declaration of function 'flushw_all'
>>  make[2]: *** [arch/sparc/kernel/kgdb_64.o] Error 1
>>
>> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> 
> I already pushed this fix to Linus last night.

Sorry for the noise.  One of those moment where you hit enter
and *then* realize that you forgot to check if it was already
reported/fixed.

P.
