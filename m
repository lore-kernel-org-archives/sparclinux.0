From: Michel Lespinasse <walken@google.com>
Date: Tue, 06 Nov 2012 03:13:19 +0000
Subject: Re: [PATCH 15/16] mm: use vm_unmapped_area() on sparc32 architecture
Message-Id: <CANN689Gt2mG8xfkVkFtOHDFxkoZZAL-p-8yMSw=qvy5zaGs1ag@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1352155633-8648-1-git-send-email-walken@google.com>
 <1352155633-8648-16-git-send-email-walken@google.com>
 <20121105.202501.1246122770431623794.davem@davemloft.net>
In-Reply-To: <20121105.202501.1246122770431623794.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, Nov 5, 2012 at 5:25 PM, David Miller <davem@davemloft.net> wrote:
> From: Michel Lespinasse <walken@google.com>
> Date: Mon,  5 Nov 2012 14:47:12 -0800
>
>> Update the sparc32 arch_get_unmapped_area function to make use of
>> vm_unmapped_area() instead of implementing a brute force search.
>>
>> Signed-off-by: Michel Lespinasse <walken@google.com>
>
> Hmmm...
>
>> -     if (flags & MAP_SHARED)
>> -             addr = COLOUR_ALIGN(addr);
>> -     else
>> -             addr = PAGE_ALIGN(addr);
>
> What part of vm_unmapped_area() is going to duplicate this special
> aligning logic we need on sparc?

The idea there is that you can specify the desired alignment mask and
offset using info.align_mask and info.align_offset.

Now, I just noticed that the old code actually always uses an
alignment offset of 0 instead of basing it on pgoff. I'm not sure why
that is, but it looks like this may be an issue ?

-- 
Michel "Walken" Lespinasse
A program is never fully debugged until the last user dies.
