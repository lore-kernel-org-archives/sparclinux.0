From: Frank Scheiner <frank.scheiner@web.de>
Date: Wed, 24 Feb 2021 12:43:34 +0000
Subject: Re: Newer kernels fail to boot on a U450?
Message-Id: <9508f25c-11a3-8601-aff3-cde3738ed884@web.de>
List-Id: <sparclinux.vger.kernel.org>
References: <6cb1a2ea-c228-abbf-7aa7-0046799eff1e@ilande.co.uk>
In-Reply-To: <6cb1a2ea-c228-abbf-7aa7-0046799eff1e@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi Adrian,

On 24.02.21 13:04, John Paul Adrian Glaubitz wrote:
> Hi Mark!
>
> On 2/24/21 12:14 PM, Mark Cave-Ayland wrote:
>> Do people still run newer kernels on older hardware? If there is interest,
>> I may be able to get some more diagnostic information. In particular I'd be
>> curious to know if Oracle do any routine testing of newer kernels on machines
>> such as the U450 and whether anyone there can reproduce the problem.
>
> I think this must be an issue specific to this machine or this model as I haven't
> seen such issues myself when testing on older machines.
>
> There is a stability issue on newer kernels on older hardware that is currently
> being debugged though [1].

Didn't know of that thread. I wonder if this could be the reason for the
crashes on my v480 and v490, though they happened already during kernel
boot.

>
> Adrian
>
>> [1] https://marc.info/?l=linux-sparc&m=161399891728083&w=2
>

Cheers,
Frank
