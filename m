From: David Miller <davem@davemloft.net>
Date: Tue, 15 May 2012 04:04:01 +0000
Subject: Re: [PATCH] sparc: Kill mmu_{un,}lockarea().
Message-Id: <20120515.000401.965386011845784393.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20120513.162832.471802901712883558.davem@davemloft.net>
In-Reply-To: <20120513.162832.471802901712883558.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Josip Rodin <joy@entuzijast.net>
Date: Mon, 14 May 2012 09:48:44 +0200

> On Sun, May 13, 2012 at 04:28:32PM -0400, David Miller wrote:
>> --- a/arch/sparc/include/asm/floppy_64.h
>> +++ b/arch/sparc/include/asm/floppy_64.h
>> @@ -194,7 +191,7 @@ static void sun_fd_set_dma_count(int length)
>>  
>>  static void sun_fd_enable_dma(void)
>>  {
>> -	pdma_vaddr = mmu_lockarea(pdma_vaddr, pdma_size);
>> +	pdma_vaddr = pdma_vaddr;
> 
>> -#define mmu_lockarea(vaddr, len)		(vaddr)
> 
> Drop the first changed line entirely? I see it was effectively there before,
> but still :)

Yeah that's pretty pointless, fixed thusly :-)

--------------------
[PATCH] sparc64: Remove pointless assignment in floppy support.

Reported-by: Josip Rodin <joy@entuzijast.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/floppy_64.h |    1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/sparc/include/asm/floppy_64.h b/arch/sparc/include/asm/floppy_64.h
index d534c27..e204f90 100644
--- a/arch/sparc/include/asm/floppy_64.h
+++ b/arch/sparc/include/asm/floppy_64.h
@@ -191,7 +191,6 @@ static void sun_fd_set_dma_count(int length)
 
 static void sun_fd_enable_dma(void)
 {
-	pdma_vaddr = pdma_vaddr;
 	pdma_base = pdma_vaddr;
 	pdma_areasize = pdma_size;
 }
-- 
1.7.10

