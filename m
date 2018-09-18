From: Firoz Khan <firoz.khan@linaro.org>
Date: Tue, 18 Sep 2018 11:49:16 +0000
Subject: Re: [PATCH 3/4] sparc: Add system call table generation support
Message-Id: <CALxhOnhRFEenKmC2MuudFU4NMdR3v9jGOXWfbxE96eZj+YetfQ@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1536036087-15260-1-git-send-email-firoz.khan@linaro.org>
 <1536036087-15260-4-git-send-email-firoz.khan@linaro.org> <CAK8P3a0cfk6MG2SBRhJZ41suHw4D-dyCYGhqV9YeD_1rSMrGqQ@mail.gmail.com>
In-Reply-To: <CAK8P3a0cfk6MG2SBRhJZ41suHw4D-dyCYGhqV9YeD_1rSMrGqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: David Miller <davem@davemloft.net>, sparclinux <sparclinux@vger.kernel.org>, gregkh <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Deepa Dinamani <deepa.kernel@gmail.com>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>

On 6 September 2018 at 21:02, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tue, Sep 4, 2018 at 6:42 AM Firoz Khan <firoz.khan@linaro.org> wrote:
>
>> The system call table generation script is added in
>> syscalls directory which contain the script to generate
>> both uapi header file system call table generation file
>> and syscall_32/64.tbl file which'll be the input for the
>> scripts.
>
> I would argue that for sparc we only want a single input
> table, since the 32/64 versions are similar enough that the
> differences can be addressed with 'abi' flag, rather than
> having everything marked as 'common'. Isn't that the
> purpose of the abi flag in the first place?
>
>           Arnd

Yes, we can do that way also. But few concerns I would
like to share with you.

I feel it add the complexity in the scripts. eg:-

108     32    setresuid32                     sys_setresuid
108     64    setresuid                         sys_setresuid
This case the script has to be smart enough to parse the
.tbl file properly. It need more logic in the scripts. This is
not common. So if you keep separate .tbl we can avoid
this.

ABI flag is serving *nothing* in all other architecture including
SPARC.

But as I told in the cover letter, I followed x86/arm/
s390 architecture's system table generation implementation.
They are keeping ABI flag. In our case we can delete this
flag completely from all architectures.

Most of the architecture these 32/64 similarity is absent.
So it would be better keep separate files to maintain a
generic script across all architecture.

One question here is; while invoking the script I'm passing
the abi flag. It is simply keeping in the .tbl file to make the
file similar to x86.  What I can do here?

- Firoz
