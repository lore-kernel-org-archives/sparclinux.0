From: Kirill Tkhai <tkhai@yandex.ru>
Date: Wed, 30 May 2012 09:27:12 +0000
Subject: [sparc32]srmmu.c: BUG of srmmu_pte_clear optimization
Message-Id: <418471338370032@web17g.yandex.ru>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

The function srmmu_pmd_clear() is optimized by the following line:

BTFIXUPSET_CALL(pmd_clear, srmmu_pmd_clear, BTFIXUPCALL_SWAPO0G0);

It's wrong, because srmmu_pmd_clear(pmd_t *pmdp) can contain up to 16 pmdp->pmdv pointers, which must be cleared,
but BTFIXUPCALL_SWAPO0G0 clears only one of them.

So, it's necessary to use BTFIXUPCALL_NORM instruction.

Regards,
Kirill
