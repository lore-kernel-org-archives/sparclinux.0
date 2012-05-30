From: Sam Ravnborg <sam@ravnborg.org>
Date: Wed, 30 May 2012 10:39:14 +0000
Subject: Re: [sparc32]srmmu.c: BUG of srmmu_pte_clear optimization
Message-Id: <20120530103913.GA16231@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <418471338370032@web17g.yandex.ru>
In-Reply-To: <418471338370032@web17g.yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi Kirill.

On Wed, May 30, 2012 at 01:27:12PM +0400, Kirill Tkhai wrote:
> The function srmmu_pmd_clear() is optimized by the following line:
> 
> BTFIXUPSET_CALL(pmd_clear, srmmu_pmd_clear, BTFIXUPCALL_SWAPO0G0);
> 
> It's wrong, because srmmu_pmd_clear(pmd_t *pmdp) can contain up to 16 pmdp->pmdv pointers, which must be cleared,
> but BTFIXUPCALL_SWAPO0G0 clears only one of them.
> 
> So, it's necessary to use BTFIXUPCALL_NORM instruction.

Ilya Malakhov <ilmalakhovthefirst@gmail.com> already reported this the other day.
In upstream this is "fixed" because we got rid of all the btfixup stuff.

If we want this fixed in stable then one of you guys needs to submit a
tested patch so we can apply this to stable.

	Sam
