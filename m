From: Nitin Gupta <nitin.m.gupta@oracle.com>
Date: Fri, 11 Aug 2017 23:04:51 +0000
Subject: Re: [sparc-next:master 2/7] arch/sparc/kernel/head_64.S:892: Warning: .space or .fill with negative 
Message-Id: <4bca1e76-e702-45de-ad89-e1840d9b6884@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <201708101410.4RM0mRyE%fengguang.wu@intel.com>
In-Reply-To: <201708101410.4RM0mRyE%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 8/10/17 9:09 PM, Anthony Yznaga wrote:
> 
>> On Aug 10, 2017, at 9:39 AM, David Miller <davem@davemloft.net> wrote:
>>
>> From: kbuild test robot <fengguang.wu@intel.com>
>> Date: Thu, 10 Aug 2017 14:16:16 +0800
>>
>>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc-next.git master
>>> head:   5389e239eba5ef0e1cad596dba4860890a3e6965
>>> commit: f10bb00790dd3cf550f7ae6991c4d1a128802c00 [2/7] sparc64: Add 16GB hugepage support
>>
>> Nitin, there's too much code now in head.S and the size of the initial
>> block of assembler trap handler overflows the allowed size before this
>> .skip directive which aligns things.
>>
>> Unfortunately, I'm going to revert your changes and you'll have to
>> find a way to fix this.  I did complain how huge the TSB miss page
>> table walk is getting, and I wasn't kidding ;-)
> 
> A big chunk of space can be freed up by moving the include of hvcall.S to after the trap table.
> 

Thanks Anthony for the tip. I will be merging the following patch with
16GB hugepage patch and resending for review. I hope following is okay:


diff --git a/arch/sparc/kernel/head_64.S b/arch/sparc/kernel/head_64.S
index 78e0211..6986d07 100644
--- a/arch/sparc/kernel/head_64.S
+++ b/arch/sparc/kernel/head_64.S
@@ -881,7 +881,6 @@ sparc64_boot_end:
 #include "misctrap.S"
 #include "syscalls.S"
 #include "helpers.S"
-#include "hvcalls.S"
 #include "sun4v_tlb_miss.S"
 #include "sun4v_ivec.S"
 #include "ktlb.S"
@@ -926,6 +925,7 @@ swapper_4m_tsb:

 ! 0x0000000000428000

+#include "hvcalls.S"
 #include "systbls_64.S"

        .data

