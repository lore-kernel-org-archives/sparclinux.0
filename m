From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 24 May 2020 02:09:19 +0000
Subject: Re: [PATCH] sparc32: use PUD rather than PGD to get PMD in srmmu_nocache_init()
Message-Id: <3bc16457-55d1-3d1f-6a78-fc3e95a1855f@roeck-us.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20200523224732.GA243603@roeck-us.net>
 <CAHk-=wjnwsRfE_RJLAV8SX465uEmpOOJxyqjsLRwoX-UPH0kQg@mail.gmail.com>
In-Reply-To: <CAHk-=wjnwsRfE_RJLAV8SX465uEmpOOJxyqjsLRwoX-UPH0kQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mike Rapoport <rppt@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Anatoly Pugachev <matorola@gmail.com>, sparclinux@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, stable <stable@vger.kernel.org>

On 5/23/20 5:15 PM, Linus Torvalds wrote:
> On Sat, May 23, 2020 at 3:47 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> This quite innocent looking patch crashes all my sparc32 boot tests.
>> Crash log and bisect results below. Reverting it fixes the problem.
> 
> It should also fixed by 0cfc8a8d70dc ("sparc32: fix page table
> traversal in srmmu_nocache_init()"). No?
> 

Yes, it is. Sorry for the noise. 0cfc8a8d70dc wasn't available
when I started the bisect, and I didn't re-check afterwards.

Guenter
