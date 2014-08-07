From: Andev <debiandev@gmail.com>
Date: Thu, 07 Aug 2014 02:00:39 +0000
Subject: Re: [3.13.y.z extended stable] Patch "locking/mutex: Disable optimistic spinning on some architectur
Message-Id: <CAJUuVQ4q8wN+iR84gkGgP-ax6pUY4oWFa83aH+LXwZFricgwXg@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1407358496-23094-1-git-send-email-kamal@canonical.com>
 <CAJUuVQ5OpNye8HAEw6x=owBB32pq-aLF7_Gqo493jDDHDahhRA@mail.gmail.com>
 <1407360614.3395.2.camel@buesod1.americas.hpqcorp.net>
 <1407376502.12474.64.camel@fourier>
In-Reply-To: <1407376502.12474.64.camel@fourier>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Aug 6, 2014 at 9:55 PM, Kamal Mostafa <kamal@canonical.com> wrote:
>
> On Wed, 2014-08-06 at 14:30 -0700, Davidlohr Bueso wrote:
>> Well 3.13.y.z isn't an Ubuntu kernel, its upstream, and those archs
>> *are* supported.
>
> Davidlohr's answer is correct: This is not an "Ubuntu kernel".
>
> 3.13.y.z is an "extended stable" kernel which follows the same rules as
> the kernel.org official stable kernels.  It contains no Ubuntu-specific
> patches, and supports the same arch's as mainline.
>
> More details about this and the other Canonical-funded-and-hosted
> "extended stable" kernel versions is available here:
>
>> For more information about the 3.13.y.z tree, see
>> https://wiki.ubuntu.com/Kernel/Dev/ExtendedStable

OK, thank you for clarification. I was unsure as this is not hosted on
kernel.org, I thought it was a Ubuntu specific kernel.

So we have the following stable kernels as of now:

3.10, 3.12, 3.13, 3.14, 3.15(for a few days), 3.16!

Interesting.
-- 
Andev
