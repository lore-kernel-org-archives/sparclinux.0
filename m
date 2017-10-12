From: Babu Moger <babu.moger@oracle.com>
Date: Thu, 12 Oct 2017 20:29:14 +0000
Subject: Re: [PATCH v4 0/5] sparc64: Optimize fls and __fls
Message-Id: <27c87a08-f4cc-cfe4-d944-25f8f703b664@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1507747806-10251-1-git-send-email-vijay.ac.kumar@oracle.com>
In-Reply-To: <1507747806-10251-1-git-send-email-vijay.ac.kumar@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vijay Kumar <vijay.ac.kumar@oracle.com>, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, rob.gardner@oracle.com, sam@ravnborg.org, anthony.yznaga@oracle.com

Looked at all the patches. Looks good to me.

Reviewed-by: Babu Moger <babu.moger@oracle.com>

On 10/11/2017 1:50 PM, Vijay Kumar wrote:
> SPARC provides lzcnt instruction (with VIS3) which can be used to
> optimize fls, __fls and fls64 functions. For the systems that supports
> lzcnt instruction, we now do boot time patching to use sparc
> optimized fls, __fls and fls64 functions.
>
> v3->v4:
>   -  Fixed a typo.
> v2->v3:
>   -  Using ENTRY(), ENDPROC() for assembler functions.
>   -  Removed BITS_PER_LONG from __fls.
>   -  Using generic fls64().
>   -  Replaced lzcnt instruction with .word directive.
> v1->v2:
>   - Fixed delay slot issue.
>
> Vijay Kumar (5):
>    sparc64: Define SPARC default fls function
>    sparc64: Define SPARC default __fls function
>    sparc64: SPARC optimized fls function
>    sparc64: SPARC optimized __fls function
>    sparc64: Use sparc optimized fls and __fls for T4 and above
>
>   arch/sparc/include/asm/bitops_64.h |    5 ++-
>   arch/sparc/kernel/head_64.S        |    2 +
>   arch/sparc/lib/Makefile            |    3 ++
>   arch/sparc/lib/NG4fls.S            |   30 ++++++++++++++++
>   arch/sparc/lib/NG4patch.S          |    9 +++++
>   arch/sparc/lib/fls.S               |   67 ++++++++++++++++++++++++++++++++++++
>   arch/sparc/lib/fls64.S             |   61 ++++++++++++++++++++++++++++++++
>   7 files changed, 175 insertions(+), 2 deletions(-)
>   create mode 100644 arch/sparc/lib/NG4fls.S
>   create mode 100644 arch/sparc/lib/fls.S
>   create mode 100644 arch/sparc/lib/fls64.S
>

