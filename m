From: Andy Lutomirski <luto@amacapital.net>
Date: Tue, 26 Jan 2016 17:48:29 +0000
Subject: Re: [PATCH v2 02/16] sparc/compat: Provide an accurate in_compat_syscall implementation
Message-Id: <CALCETrVaOC2=CC0bDoc-g2o+wjwaFfj+LAB7umrRMCHYwsk+Bg@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1453759363.git.luto@kernel.org> <e520030f750b29d14486aa1e99c271a0fa18f19e.1453759363.git.luto@kernel.org>
 <20160126062951.GA17107@ravnborg.org> <20160125.225100.1932707129794761764.davem@davemloft.net>
 <20160126174441.GA18873@ravnborg.org>
In-Reply-To: <20160126174441.GA18873@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sam Ravnborg <sam@ravnborg.org>
Cc: David Miller <davem@davemloft.net>, Andrew Lutomirski <luto@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, X86 ML <x86@kernel.org>, linux-arch <linux-arch@vger.kernel.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Chris Metcalf <cmetcalf@ezchip.com>, linux-parisc@vger.kernel.org, Linux MIPS Mailing List <linux-mips@linux-mips.org>, sparclinux@vger.kernel.org

On Tue, Jan 26, 2016 at 9:44 AM, Sam Ravnborg <sam@ravnborg.org> wrote:
> On Mon, Jan 25, 2016 at 10:51:00PM -0800, David Miller wrote:
>> From: Sam Ravnborg <sam@ravnborg.org>
>> Date: Tue, 26 Jan 2016 07:29:51 +0100
>>
>> > Could you please add a comment about where 0x110 comes from.
>> > I at least failed to track this down.
>>
>> Frankly I'm fine with this.  Someone who understands sparc64 can look
>> at the trap table around entry 0x110 and see:
>>
>> tl0_resv10e:  BTRAP(0x10e) BTRAP(0x10f)
>> tl0_linux32:  LINUX_32BIT_SYSCALL_TRAP
>> tl0_oldlinux64:       LINUX_64BIT_SYSCALL_TRAP
>
> If one realise to look in the trap table in the first place - yes.
>
> Adding a short:
>
> /* Check if this is LINUX_32BIT_SYSCALL_TRAP */
> Would make wonders to readability.

I'll add a comment in v2.

--Andy
-- 
Andy Lutomirski
AMA Capital Management, LLC
