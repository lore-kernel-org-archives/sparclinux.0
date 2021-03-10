From: David Miller <davem@davemloft.net>
Date: Wed, 10 Mar 2021 01:15:40 +0000
Subject: Re: [GIT] SPARC
Message-Id: <20210309.171540.1612415953102779664.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20210309.110812.234617387417457658.davem@davemloft.net>
        <CAHk-=whgiPiFy9Ye_t=fV9J8VdqgZW5XQcb-1z8PgpQbVBWqCQ@mail.gmail.com>
        <20210309.162454.822491855062735992.davem@davemloft.net>
In-Reply-To: <20210309.162454.822491855062735992.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: glaubitz@physik.fu-berlin.de, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Tue, 09 Mar 2021 16:24:54 -0800 (PST)

> From: Linus Torvalds <torvalds@linux-foundation.org>
> Date: Tue, 9 Mar 2021 11:27:41 -0800
> 
>> On Tue, Mar 9, 2021 at 11:08 AM David Miller <davem@davemloft.net> wrote:
>> 
>> (And yes, I prefer lore.kernel.org over marc, although for single
>> patches it doesn't make much of a difference. For patch series, I find
>> 'b4' so convenient that I definitely want the patch to show up on
>> lore.kernel.org).
> 
> Sadly, lore does not archive sparclinux@vger.kernel.org, so there
> isn't much choice in this case.
>> 
>> I'll await your pull request or 'I have nothing else, take it from
>> xyz', this thread is otherwise archived for me as "done".
> 
> I added Rob's fix to the tree, here is a new pull request, thanks!
> 
> The following changes since commit 062c84fccc4444805738d76a2699c4d3c95184ec:
> 
>   Merge tag 'rproc-v5.12' of git://git.kernel.org/pub/scm/linux/kernel/git/andersson/remoteproc (2021-02-24 11:30:13 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org:/pub/scm/linux/kernel/git/davem/sparc.git 
> 

Somehow you pull didn't get commits:

commit 69264b4a43aff7307283e2bae29e9305ab6b7d47 (HEAD -> master, origin/master, origin/HEAD)
Author: Corentin Labbe <clabbe@baylibre.com>
Date:   Mon Mar 8 09:51:26 2021 +0000

    sparc: sparc64_defconfig: remove duplicate CONFIGs
    
    After my patch there is CONFIG_ATA defined twice.
    Remove the duplicate one.
    Same problem for CONFIG_HAPPYMEAL, except I added as builtin for boot
    test with NFS.
    
    Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
    Fixes: a57cdeb369ef ("sparc: sparc64_defconfig: add necessary configs for qemu")
    Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
    Signed-off-by: David S. Miller <davem@davemloft.net>

commit e5e8b80d352ec999d2bba3ea584f541c83f4ca3f
Author: Rob Gardner <rob.gardner@oracle.com>
Date:   Sun Feb 28 22:48:16 2021 -0700

    sparc64: Fix opcode filtering in handling of no fault loads
    
    is_no_fault_exception() has two bugs which were discovered via random
    opcode testing with stress-ng. Both are caused by improper filtering
    of opcodes.
    
    The first bug can be triggered by a floating point store with a no-fault
    ASI, for instance "sta %f0, [%g0] #ASI_PNF", opcode C1A01040.
    
    The code first tests op3[5] (0x1000000), which denotes a floating
    point instruction, and then tests op3[2] (0x200000), which denotes a
    store instruction. But these bits are not mutually exclusive, and the
    above mentioned opcode has both bits set. The intent is to filter out
    stores, so the test for stores must be done first in order to have
    any effect.
    
    The second bug can be triggered by a floating point load with one of
    the invalid ASI values 0x8e or 0x8f, which pass this check in
    is_no_fault_exception():
         if ((asi & 0xf2) = ASI_PNF)
    
    An example instruction is "ldqa [%l7 + %o7] #ASI 0x8f, %f38",
    opcode CF95D1EF. Asi values greater than 0x8b (ASI_SNFL) are fatal
    in handle_ldf_stq(), and is_no_fault_exception() must not allow these
    invalid asi values to make it that far.
    
    In both of these cases, handle_ldf_stq() reacts by calling
    sun4v_data_access_exception() or spitfire_data_access_exception(),
    which call is_no_fault_exception() and results in an infinite
    recursion.
    
    Signed-off-by: Rob Gardner <rob.gardner@oracle.com>
    Tested-by: Anatoly Pugachev <matorola@gmail.com>

Can you repull to get them, thanks.
