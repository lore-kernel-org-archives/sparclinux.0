From: Marcel van Nies <morcles@gmail.com>
Date: Tue, 08 Mar 2011 21:30:07 +0000
Subject: Re: Status update on sparc32 genirq support
Message-Id: <AANLkTikozA=eo+hFmoigTj3GuoG0TRa3gh28tQ8di=__@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20110307.230120.226776255.davem@davemloft.net>
In-Reply-To: <20110307.230120.226776255.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Correction:
/sbin/fsck.ext3 is a link to e2fsck.
/sbin/e2fsck is there.

Is the link the problem ?
Let's see.

M

On Tue, Mar 8, 2011 at 10:27 PM, Marcel van Nies <morcles@gmail.com> wrote:
> Hi,
>
> /sbin/fsck.ext3 is there, it's used to check / in runlevel 1, i.e. every boot.
>
> I can happily boot anything 2.6.32.27 or earlier.
>
> Marcel
>
> On Tue, Mar 8, 2011 at 10:19 PM, David Miller <davem@davemloft.net> wrote:
>> From: Marcel van Nies <morcles@gmail.com>
>> Date: Tue, 8 Mar 2011 22:13:05 +0100
>>
>>> So, is this an ESP or EXT2 bug at all ?
>>
>> The error message is that the program "fsck.ext3" cannot be found.
>> Does that binary exist in the correct location so that fsck can
>> find it?
>>
>
